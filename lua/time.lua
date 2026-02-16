--[[
date_translator: 将 `date` 翻译为当前日期

translator 的功能是将分好段的输入串翻译为一系列候选项。

欲定义的 translator 包含三个输入参数：
 - input: 待翻译的字符串
 - seg: 包含 `start` 和 `_end` 两个属性，分别表示当前串在输入框中的起始和结束位置
 - env: 可选参数，表示 translator 所处的环境（本例没有体现）

候选项的构造函数是 `Candidate`，它有五个参数：
 - type: 字符串，表示候选项的类型
 - start: 候选项对应的输入串的起始位置
 - _end:  候选项对应的输入串的结束位置
 - text:  候选项的文本
 - comment: 候选项的注释

translator 的输出是若干候选项。
与通常的函数使用 `return` 返回不同，translator 要求您使用 `yield` 产生候选项。

`yield` 每次只能产生一个候选项。有多个候选时，可以多次使用 `yield` 。

请看如下示例：
--]]

require("jieqi")

local function translator(input, seg)
  if (not (input == "time" or input == "shijian" or
      input == "sj" or input == "date" or input == "week")) then
    return
  end


  local jq = JQNow(os.date("%Y%m%d"))
  jq = jq ~= "" and "〔" .. jq .. "〕" or ""

  local time = os.date("%H:%M:%S")

  local WEEKS = { '日', '一', '二', '三', '四', '五', '六' }
  local week = '星期' .. WEEKS[tonumber(os.date("%w") + 1)]

  local date = os.date("%Y-%m-%d")

  if (input == "time" or input == "shijian" or input == "sj") then
    local fullTime = date .. " " .. time .. " " .. week
    fullTime = jq ~= "" and fullTime .. " " .. jq or fullTime

    yield(PriorityCandidate("time", seg.start, seg._end, time, ""))
    yield(PriorityCandidate("time", seg.start, seg._end, fullTime, ""))
  end

  if (input == "date") then
    yield(PriorityCandidate("date", seg.start, seg._end, date, jq))
  end

  if (input == "week") then
    yield(PriorityCandidate("week", seg.start, seg._end, week, ""))
  end
end

return translator
