------------------------------------
------wirting by 98wubi Group-------
------http://98wb.ys168.com/--------
------------------------------------

--十进制转二进制
function Dec2bin(n)
  local t, t1, t2
  local tables = { "" }
  t = tonumber(n)
  while math.floor(t / 2) >= 1 do
    t1 = math.fmod(t, 2)
    if t1 > 0 then
      if #tables > 0 then
        table.insert(tables, 1, 1)
      else
        tables[1] = 1
      end
    else
      if #tables > 0 then
        table.insert(tables, 1, 0)
      else
        tables[1] = 0
      end
    end
    t = math.floor(t / 2)
    if t == 1 then
      if #tables > 0 then
        table.insert(tables, 1, 1)
      else
        tables[1] = 1
      end
    end
  end
  return string.gsub(table.concat(tables), "^[0]+", "")
end

--2/10/16进制互转
local function system(x, inPuttype, outputtype)
  local r
  if (tonumber(inPuttype) == 2) then
    if (tonumber(outputtype) == 10) then --2进制-->10进制
      r = tonumber(tostring(x), 2)
    elseif (tonumber(outputtype) == 16) then --2进制-->16进制
      r = bin2hex(tostring(x))
    end
  elseif (tonumber(inPuttype) == 10) then
    if (tonumber(outputtype) == 2) then --10进制-->2进制
      r = Dec2bin(tonumber(x))
    elseif (tonumber(outputtype) == 16) then --10进制-->16进制
      r = string.format("%x", x)
    end
  elseif (tonumber(inPuttype) == 16) then
    if (tonumber(outputtype) == 2) then --16进制-->2进制
      r = Dec2bin(tonumber(tostring(x), 16))
    elseif (tonumber(outputtype) == 10) then --16进制-->10进制
      r = tonumber(tostring(x), 16)
    end
  end
  return r
end

--农历16进制数据分解
local function Analyze(Data)
  local rtn1, rtn2, rtn3, rtn4
  rtn1 = system(string.sub(Data, 1, 3), 16, 2)
  if string.len(rtn1) < 12 then
    rtn1 = "0" .. rtn1
  end
  rtn2 = string.sub(Data, 4, 4)
  rtn3 = system(string.sub(Data, 5, 5), 16, 10)
  rtn4 = system(string.sub(Data, -2, -1), 16, 10)
  if string.len(rtn4) == 3 then
    rtn4 = "0" .. system(string.sub(Data, -2, -1), 16, 10)
  end
  --string.gsub(rtn1, "^[0]*", "")
  return { rtn1, rtn2, rtn3, rtn4 }
end

--年天数判断
local function IsLeap(y)
  local year = tonumber(y)
  if math.fmod(year, 400) ~= 0 and math.fmod(year, 4) == 0 or math.fmod(year, 400) == 0 then
    return 366
  else
    return 365
  end
end

--计算日期差，两个8位数日期之间相隔的天数，date2>date1
function diffDate(date1, date2)
  local t1, t2, n, total
  total = 0
  date1 = tostring(date1)
  date2 = tostring(date2)
  if tonumber(date2) > tonumber(date1) then
    n = tonumber(string.sub(date2, 1, 4)) - tonumber(string.sub(date1, 1, 4))
    if n > 1 then
      for i = 1, n - 1 do
        total = total + IsLeap(tonumber(string.sub(date1, 1, 4)) + i)
      end
      total = total + leaveDate(tonumber(string.sub(date2, 1, 8))) + IsLeap(tonumber(string.sub(date1, 1, 4))) -
          leaveDate(tonumber(string.sub(date1, 1, 8)))
    elseif n == 1 then
      total = IsLeap(tonumber(string.sub(date1, 1, 4))) - leaveDate(tonumber(string.sub(date1, 1, 8))) +
          leaveDate(tonumber(string.sub(date2, 1, 8)))
    else
      total = leaveDate(tonumber(string.sub(date2, 1, 8))) - leaveDate(tonumber(string.sub(date1, 1, 8)))
    end
  elseif tonumber(date2) == tonumber(date1) then
    return 0
  else
    return -1
  end
  return total
end

--返回当年过了多少天
function leaveDate(y)
  local day, total
  total = 0
  if IsLeap(tonumber(string.sub(y, 1, 4))) > 365 then
    day = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
  else
    day = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
  end
  if tonumber(string.sub(y, 5, 6)) > 1 then
    for i = 1, tonumber(string.sub(y, 5, 6)) - 1 do
      total = total + day[i]
    end
    total = total + tonumber(string.sub(y, 7, 8))
  else
    return tonumber(string.sub(y, 7, 8))
  end
  return tonumber(total)
end

--公历转农历，支持转化范围公元1900-2100年
--公历日期 Gregorian:格式 YYYYMMDD
--<返回值>农历日期 中文 天干地支属相
function Date2LunarDate(Gregorian)
  --天干名称
  local cTianGan = { "甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸" }
  --地支名称
  local cDiZhi = { "子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥" }
  --属相名称
  local cShuXiang = { "鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪" }
  --农历日期名
  local cDayName = { "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
    "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一",
    "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十" }
  --农历月份名
  local cMonName = { "正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月",
    "冬月", "腊月" }

  -- 农历数据
  local wNongliData = { "AB500D2", "4BD0883", "4AE00DB", "A5700D0", "54D0581", "D2600D8", "D9500CC", "655147D",
    "56A00D5", "9AD00CA", "55D027A", "4AE00D2", "A5B0682", "A4D00DA", "D2500CE", "D25157E", "B5500D6", "56A00CC",
    "ADA027B", "95B00D3", "49717C9", "49B00DC", "A4B00D0", "B4B0580", "6A500D8", "6D400CD", "AB5147C", "2B600D5",
    "95700CA", "52F027B", "49700D2", "6560682", "D4A00D9", "EA500CE", "6A9157E", "5AD00D6", "2B600CC", "86E137C",
    "92E00D3", "C8D1783", "C9500DB", "D4A00D0", "D8A167F", "B5500D7", "56A00CD", "A5B147D", "25D00D5", "92D00CA",
    "D2B027A", "A9500D2", "B550781", "6CA00D9", "B5500CE", "535157F", "4DA00D6", "A5B00CB", "457037C", "52B00D4",
    "A9A0883", "E9500DA", "6AA00D0", "AEA0680", "AB500D7", "4B600CD", "AAE047D", "A5700D5", "52600CA", "F260379",
    "D9500D1", "5B50782", "56A00D9", "96D00CE", "4DD057F", "4AD00D7", "A4D00CB", "D4D047B", "D2500D3", "D550883",
    "B5400DA", "B6A00CF", "95A1680", "95B00D8", "49B00CD", "A97047D", "A4B00D5", "B270ACA", "6A500DC", "6D400D1",
    "AF40681", "AB600D9", "93700CE", "4AF057F", "49700D7", "64B00CC", "74A037B", "EA500D2", "6B50883", "5AC00DB",
    "AB600CF", "96D0580", "92E00D8", "C9600CD", "D95047C", "D4A00D4", "DA500C9", "755027A", "56A00D1", "ABB0781",
    "25D00DA", "92D00CF", "CAB057E", "A9500D6", "B4A00CB", "BAA047B", "AD500D2", "55D0983", "4BA00DB", "A5B00D0",
    "5171680", "52B00D8", "A9300CD", "795047D", "6AA00D4", "AD500C9", "5B5027A", "4B600D2", "96E0681", "A4E00D9",
    "D2600CE", "EA6057E", "D5300D5", "5AA00CB", "76A037B", "96D00D3", "4AB0B83", "4AD00DB", "A4D00D0", "D0B1680",
    "D2500D7", "D5200CC", "DD4057C", "B5A00D4", "56D00C9", "55B027A", "49B00D2", "A570782", "A4B00D9", "AA500CE",
    "B25157E", "6D200D6", "ADA00CA", "4B6137B", "93700D3", "49F08C9", "49700DB", "64B00D0", "68A1680", "EA500D7",
    "6AA00CC", "A6C147C", "AAE00D4", "92E00CA", "D2E0379", "C9600D1", "D550781", "D4A00D9", "DA400CD", "5D5057E",
    "56A00D6", "A6C00CB", "55D047B", "52D00D3", "A9B0883", "A9500DB", "B4A00CF", "B6A067F", "AD500D7", "55A00CD",
    "ABA047C", "A5A00D4", "52B00CA", "B27037A", "69300D1", "7330781", "6AA00D9", "AD500CE", "4B5157E", "4B600D6",
    "A5700CB", "54E047C", "D1600D2", "E960882", "D5200DA", "DAA00CF", "6AA167F", "56D00D7", "4AE00CD", "A9D047D",
    "A2D00D4", "D1500C9", "F250279", "D5200D1"
  }

  Gregorian = tostring(Gregorian)
  local Year, Month, Day, Pos, Data0, Data1, MonthInfo, LeapInfo, Leap, Newyear, Data2, Data3, LYear, thisMonthInfo
  Year = tonumber(Gregorian.sub(Gregorian, 1, 4))
  Month = tonumber(Gregorian.sub(Gregorian, 5, 6))
  Day = tonumber(Gregorian.sub(Gregorian, 7, 8))
  if (Year > 2100 or Year < 1899 or Month > 12 or Month < 1 or Day < 1 or Day > 31 or string.len(Gregorian) < 8) then
    return "无效日期"
  end
  --获取两百年内的农历数据
  Pos = Year - 1900 + 2
  Data0 = wNongliData[Pos - 1]
  Data1 = wNongliData[Pos]
  --判断农历年份
  local tb1 = Analyze(Data1)
  MonthInfo = tb1[1]
  LeapInfo = tb1[2]
  Leap = tb1[3]
  Newyear = tb1[4]
  Date1 = Year .. Newyear
  Date2 = Gregorian
  Date3 = diffDate(Date1, Date2) --和当年农历新年相差的天数
  if (Date3 < 0) then
    tb1 = Analyze(Data0)
    Year = Year - 1
    MonthInfo = tb1[1]
    LeapInfo = tb1[2]
    Leap = tb1[3]
    Newyear = tb1[4]
    Date1 = Year .. Newyear
    Date2 = Gregorian
    Date3 = diffDate(Date1, Date2)
  end
  Date3 = Date3 + 1
  LYear = Year --农历年份，就是上面计算后的值
  if Leap > 0 then --有闰月
    thisMonthInfo = string.sub(MonthInfo, 1, Leap) .. LeapInfo .. string.sub(MonthInfo, Leap + 1)
  else
    thisMonthInfo = MonthInfo
  end
  local thisMonth, thisDays, LDay, Isleap, LunarYear, LunarMonth
  for i = 1, 13 do
    thisMonth = string.sub(thisMonthInfo, i, i)
    thisDays = 29 + thisMonth
    if (Date3 > thisDays) then
      Date3 = Date3 - thisDays
    else
      if (Leap > 0) then
        if (Leap >= i) then
          LMonth = i
          Isleap = 0
        else
          LMonth = i - 1
          if i - Leap == 1 then
            Isleap = 1
          else
            Isleap = 0
          end
        end
      else
        LMonth = i
        Isleap = 0
      end
      LDay = math.floor(Date3)
      break
    end
  end
  if Isleap > 0 then
    LunarMonth = "闰" .. cMonName[LMonth]
  else
    LunarMonth = cMonName[LMonth]
  end

  -- LunarYear = cTianGan[math.fmod(LYear - 4, 10) + 1] ..
  --     cDiZhi[math.fmod(LYear - 4, 12) + 1] ..
  --     "年(" .. cShuXiang[math.fmod(LYear - 4, 12) + 1] .. ")" .. LunarMonth .. cDayName[LDay]
  LunarYear = cShuXiang[math.fmod(LYear - 4, 12) + 1] .. "(" ..
      cTianGan[math.fmod(LYear - 4, 10) + 1] ..
      cDiZhi[math.fmod(LYear - 4, 12) + 1] .. ")年" .. LunarMonth .. cDayName[LDay]
  return LunarYear
end

--Date日期参数格式YYMMDD，dayCount累加的天数
--返回值：公历日期
local function GettotalDay(Date, dayCount)
  local Year, Month, Day, days, total, t
  Date = tostring(Date)
  Year = tonumber(Date.sub(Date, 1, 4))
  Month = tonumber(Date.sub(Date, 5, 6))
  Day = tonumber(Date.sub(Date, 7, 8))
  if IsLeap(Year) > 365 then
    days = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
  else
    days = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
  end
  if dayCount > days[Month] - Day then
    total = dayCount - days[Month] + Day
    Month = Month + 1
    if Month > 12 then
      Month = Month - 12
      Year = Year + 1
    end
    for i = Month, 12 + Month do
      if IsLeap(Year) > 365 then
        days = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
      else
        days = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
      end
      if i > 11 then
        t = i - 12
      else
        t = i
      end
      if (total > days[t + 1]) then
        total = total - days[Month]
        Month = Month + 1
        if Month > 12 then
          Month = Month - 12
          Year = Year + 1
        end
      else
        break
      end
    end
  else
    total = Day + dayCount
  end
  --if string.len(Month)==1 then Month="0"..Month end
  --if string.len(total)==1 then total="0"..total end
  return Year .. "年" .. Month .. "月" .. total .. "日"
end

--农历转公历
--农历 Gregorian:数字格式 YYYYMMDD
--<返回值>公历日期 格式YYYY年MM月DD日
--农历日期月份为闰月需指定参数IsLeap为1，非闰月需指定参数IsLeap为0
function LunarDate2Date(Gregorian, IsLeap)
  LunarData = { "AB500D2", "4BD0883",
    "4AE00DB", "A5700D0", "54D0581", "D2600D8", "D9500CC", "655147D", "56A00D5", "9AD00CA", "55D027A", "4AE00D2",
    "A5B0682", "A4D00DA", "D2500CE", "D25157E", "B5500D6", "56A00CC", "ADA027B", "95B00D3", "49717C9", "49B00DC",
    "A4B00D0", "B4B0580", "6A500D8", "6D400CD", "AB5147C", "2B600D5", "95700CA", "52F027B", "49700D2", "6560682",
    "D4A00D9", "EA500CE", "6A9157E", "5AD00D6", "2B600CC", "86E137C", "92E00D3", "C8D1783", "C9500DB", "D4A00D0",
    "D8A167F", "B5500D7", "56A00CD", "A5B147D", "25D00D5", "92D00CA", "D2B027A", "A9500D2", "B550781", "6CA00D9",
    "B5500CE", "535157F", "4DA00D6", "A5B00CB", "457037C", "52B00D4", "A9A0883", "E9500DA", "6AA00D0", "AEA0680",
    "AB500D7", "4B600CD", "AAE047D", "A5700D5", "52600CA", "F260379", "D9500D1", "5B50782", "56A00D9", "96D00CE",
    "4DD057F", "4AD00D7", "A4D00CB", "D4D047B", "D2500D3", "D550883", "B5400DA", "B6A00CF", "95A1680", "95B00D8",
    "49B00CD", "A97047D", "A4B00D5", "B270ACA", "6A500DC", "6D400D1", "AF40681", "AB600D9", "93700CE", "4AF057F",
    "49700D7", "64B00CC", "74A037B", "EA500D2", "6B50883", "5AC00DB", "AB600CF", "96D0580", "92E00D8", "C9600CD",
    "D95047C", "D4A00D4", "DA500C9", "755027A", "56A00D1", "ABB0781", "25D00DA", "92D00CF", "CAB057E", "A9500D6",
    "B4A00CB", "BAA047B", "AD500D2", "55D0983", "4BA00DB", "A5B00D0", "5171680", "52B00D8", "A9300CD", "795047D",
    "6AA00D4", "AD500C9", "5B5027A", "4B600D2", "96E0681", "A4E00D9", "D2600CE", "EA6057E", "D5300D5", "5AA00CB",
    "76A037B", "96D00D3", "4AB0B83", "4AD00DB", "A4D00D0", "D0B1680", "D2500D7", "D5200CC", "DD4057C", "B5A00D4",
    "56D00C9", "55B027A", "49B00D2", "A570782", "A4B00D9", "AA500CE", "B25157E", "6D200D6", "ADA00CA", "4B6137B",
    "93700D3", "49F08C9", "49700DB", "64B00D0", "68A1680", "EA500D7", "6AA00CC", "A6C147C", "AAE00D4", "92E00CA",
    "D2E0379", "C9600D1", "D550781", "D4A00D9", "DA400CD", "5D5057E", "56A00D6", "A6C00CB", "55D047B", "52D00D3",
    "A9B0883", "A9500DB", "B4A00CF", "B6A067F", "AD500D7", "55A00CD", "ABA047C", "A5A00D4", "52B00CA", "B27037A",
    "69300D1", "7330781", "6AA00D9", "AD500CE", "4B5157E", "4B600D6", "A5700CB", "54E047C", "D1600D2", "E960882",
    "D5200DA", "DAA00CF", "6AA167F", "56D00D7", "4AE00CD", "A9D047D", "A2D00D4", "D1500C9", "F250279", "D5200D1"
  }
  Gregorian = tostring(Gregorian)
  local Year, Month, Day, Pos, Data, MonthInfo, LeapInfo, Leap, Newyear, Sum, thisMonthInfo, GDate
  Year = tonumber(Gregorian.sub(Gregorian, 1, 4))
  Month = tonumber(Gregorian.sub(Gregorian, 5, 6))
  Day = tonumber(Gregorian.sub(Gregorian, 7, 8))
  if (Year > 2100 or Year < 1900 or Month > 12 or Month < 1 or Day > 30 or Day < 1 or string.len(Gregorian) < 8) then
    return "无效日期"
  end

  --获取当年农历数据
  Pos = (Year - 1899) + 1
  Data = LunarData[Pos]
  --判断公历日期
  local tb1 = Analyze(Data)
  MonthInfo = tb1[1]
  LeapInfo = tb1[2]
  Leap = tb1[3]
  Newyear = tb1[4]
  --计算到当天到当年农历新年的天数
  Sum = 0

  if Leap > 0 then --有闰月
    thisMonthInfo = string.sub(MonthInfo, 1, Leap) .. LeapInfo .. string.sub(MonthInfo, Leap + 1)
    if (Leap ~= Month and tonumber(IsLeap) == 1) then
      return "该月不是闰月！"
    end
    if (Month <= Leap and tonumber(IsLeap) == 0) then
      for i = 1, Month - 1 do
        Sum = Sum + 29 + string.sub(thisMonthInfo, i, i)
      end
    else
      for i = 1, Month do
        Sum = Sum + 29 + string.sub(thisMonthInfo, i, i)
      end
    end
  else
    if (tonumber(IsLeap) == 1) then
      return "该年没有闰月！"
    end
    for i = 1, Month - 1 do
      thisMonthInfo = MonthInfo
      Sum = Sum + 29 + string.sub(thisMonthInfo, i, i)
    end
  end
  Sum = math.floor(Sum + Day - 1)
  GDate = Year .. Newyear
  GDate = GettotalDay(GDate, Sum)

  return GDate
end

-- print(LunarDate2Date(20210101, 0))
-- print(19660808 .. "-" .. Date2LunarDate(19660808))
-- print(20001218 .. "-" .. Date2LunarDate(20001218))
-- print(20220105 .. "-" .. Date2LunarDate(20220105))
-- print(20350129 .. "-" .. Date2LunarDate(20350129))
-- print(20200525 .. "-" .. Date2LunarDate(20200525))
-- print(os.date("%Y%m%d") .. "-" .. Date2LunarDate(os.date("%Y%m%d")))

local function translator(input, seg)
  if (input == "lunar" or input == "nongli" or input == "nl") then
    date = Date2LunarDate(os.date("%Y%m%d"))
    yield(Candidate("lunar", seg.start, seg._end, date, "〔农历〕"))
  end
end

return translator
