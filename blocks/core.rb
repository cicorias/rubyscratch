
def run_block(&blk)
  blk.call "from block"
end

def run_yield
  yield "from yield"
end

