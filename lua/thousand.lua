local function formatnumberthousands(n)
   local r = string.sub(n, -3, -1)  -- 从后向前取三位
   local n = string.sub(n, 1, -4)  -- 剩下的数字

   -- 每次循环从后向前取三位，拼接到结果前面
   -- 直到剩下数字为空
   while string.len(n) > 0 do
      r = string.sub(n, -3, -1) .. "," .. r
      n = string.sub(n, 1, -4)
   end

   -- 返回结果
   return r
end

function formatnumberthousands_translator(input, seg)
   if string.sub(input, 1, 1) == "/" then -- 取引导符
      local n = string.sub(input, 2, -1) -- 取参数
      if tonumber(n) ~= nil then -- 参数是数字
         local result = formatnumberthousands(n) --- 调用算法
         --[[ 用 `yield` 产生一个候选项
              候选项的构造函数是 `Candidate`，它有五个参数：
              - type: 字符串，表示候选项的类型（可随意取）
              - start: 候选项对应的输入串的起始位置
              - _end:  候选项对应的输入串的结束位置
              - text:  候选项的文本
              - comment: 候选项的注释
         --]]
         yield(Candidate("number", seg.start, seg._end, result, "千位數標示"))
      end
   end
end

return formatnumberthousands_translator
