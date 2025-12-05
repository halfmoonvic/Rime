-- https://github.com/hchunhui/librime-lua/wiki/Scripting
-- https://github.com/hchunhui/librime-lua/blob/master/sample/rime.lua
-- https://github.com/hchunhui/librime-lua/issues/294

-- 是否在中文模式的情况下被此程序切换为了英文模式，默认为 false，表示不需要重新切换到中文模式
local prev_is_cn_mode = false
-- 是否处于普通模式中
local in_normal_mode = false

-- 自定义切换 vim mode 的逻辑，
-- 可以自动切换回中文模式
local function vim_mode(key, env)
  local vmode = env.engine.context:get_option("vmode")

  -- macos
  -- os.execute("osascript -e 'display notification \"" .. vmode .. '" with title "Title"\'')
  -- linux hyprland
  -- os.execute("notify-send '" .. vmode .. "'")

  -- 只有在 app_options 中配置了 vmode 才会进入切换模式
  if vmode then
    -- 当前是否处于英文模式
    local is_ascii_mode = env.engine.context:get_option("ascii_mode")

    if in_normal_mode then
      if is_ascii_mode then
        -- 105, -- i
        -- 97, -- a
        -- 111, -- o
        -- 99 -- c
        if key.keycode == 105 or key.keycode == 97 or key.keycode == 111 or key.keycode == 99 then
          in_normal_mode = false

          -- 如果之前是中文模式，并且将要进入 insert mode，切换到中文模式
          if prev_is_cn_mode then
            env.engine.context:set_option("ascii_mode", false)
            return 1
          end
        end
      end
    end

    -- 按了 esc 键
    if key.keycode == 65307 then
      -- 按了 esc 就认为进入了 normal mode
      in_normal_mode = true

      if is_ascii_mode then
        -- 如果当前退出时已经是英文模式，后面插入式就不需要切换为中文模式了
        prev_is_cn_mode = false
      else
        -- 如果当前是中文模式，就需要切换为英文模式
        -- 并且当重新进入 insert mode 时，需要切换回中文模式
        prev_is_cn_mode = true
        env.engine.context:set_option("ascii_mode", true)
      end
    end
  end

  return 2
end

return vim_mode
