#!/usr/bin/env bash

echo #run 'fluentd --setup ./_fconfig/' prior to this
fluentd -c ./_fconfig/fluent.conf -I ./lib -v