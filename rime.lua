function PriorityCandidate(type, start, _end, text, comment, quality)
    local cand = Candidate(type, start, _end, text, comment)
    cand.quality = quality or 999
    return cand
end

-- https://github.com/hchunhui/librime-lua/blob/master/sample/lua/number.lua
number = require("number")

-- https://github.com/hchunhui/librime-lua/issues/14
thousand = require("thousand")

-- https://github.com/yanhuacuo/98wubi-tables
lunar = require("lunar")
jieqi = require("jieqi")
ganzhi = require("ganzhi")

-- https://github.com/lei4519/rime-ice/blob/main/lua/vim_mode.lua
vim_mode = require("vim_mode")

time = require("time")
