#!/usr/bin/env ruby
# coding: utf-8

#base classes
require 'thread'
require 'em-websocket'
require 'json'

#fluentd specific
require 'fluent/plugin/input'

#local files
require "#{File.dirname(__FILE__)}/log_helper"
require "#{File.dirname(__FILE__)}/json_helper"

# The module and class
module Ethereum
  class Ethstats
    #include Object.const_get("LocalLogger")
    include LocalLogger
    include Enumerable

    def initialize (message, &blk)
      logInfo "ethstats initalized called."
      logInfo message
      @thinkToCall = blk
    end

    def run
      logInfo 'initialized...'
      logInfo 'about to call EM.run...'

      @thr = Thread.new { 
        EM.run {
          # trap("TERM") { stop "TERM" }
          #trap("INT")  { stop "INT" }
          # trap("SIGINT") { stop "SIGINT" }

          EM.add_periodic_timer(5) do 
            logInfo "timer fired #####"
          end
          
          EM::WebSocket.run(:host => "0.0.0.0", :port => 8080, :debug => false) do |ws|
            logInfo  'Starting server'
            ws.onopen { |handshake|
              logInfo "WebSocket opened #{{
                :path => handshake.path,
                :query => handshake.query,
                :origin => handshake.origin,
              }}"
            }

            ws.onmessage do |msg|
              logInfo  "Received message: #{msg}"
              msgParsed = parseMessage(msg)
              debug "msgParsed: #{msgParsed.inspect}"
              action = msgParsed[0]

              if !( nil == action ) then
                logInfo "processing action #{action}"
                telemetry = processMessage(ws, action, msgParsed)
                emitData(telemetry)
                #ws.send JSON.generate(telemetry)     # TODO: handle sends as events perhaps         
              end

            end
            
            ws.onclose {
              logInfo  'WebSocket closed'
            }

            ws.onerror { |e|
              logError  "Error: #{e.message}"
            }

          end

          def parseMessage (message)
            # TODO: clean this sh*t up.
            logInfo 'parsing message'
            begin
              rv = JSON.parse(message)
              # TODO: check if array has length =1
              action = rv['emit'][0]
              debug "action: #{action.inspect}"
              # TODO: check if array has length =2
              actionMsg = rv['emit'][1]
              debug "actionMsg: #{actionMsg.inspect}"
            rescue JSON::ParserError => e
              logError 'bad json received'
              action = actionMsg = nil
            ensure
              return action, actionMsg
            end
            
          end

          def processMessage (ws, action, message_json)
            debug "process message #{message_json}"
            case action
              when "hello"
                debug "got a hello"
                response = {'emit' => ['ready']}
                debug "hello response is #{response.inspect}"
                ws.send '{"emit":["ready"]}' # TODO: externalize and constant
              when "node-ping"
                debug "got a ping"
                time = Time.now.getutc
                response = {'emit' => ['node-pong', {'clientTime' => time, 'serverTime' => time }]}
                # h = {'a' => 'foo', 'b' => [{'c' => 'bar', 'd' => ['baz']}]}
                debug "ping response is: #{response.inspect}"
                ws.send JSON.generate(response)
              else
                logWarn "unhandled action: #{action}"
            end
            rv = message_json.flatten_with_path("geth")
            #debug "message json flat: #{rv}"
            # do something
            rv
          end

          def emitData (telemetry)
            debug  "telemetry to log: #{JSON.generate(telemetry)}"

          end

          def stop kind
            logInfo  "Attempt to terminate WebSocket and EM Server with #{kind}"
            EM::WebSocket.stop
            logInfo  'Terminating EM Server'
          end
        }

        logInfo  'done with EM.run'
      }  
    end

  end
end


