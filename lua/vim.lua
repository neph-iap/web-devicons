local public = {}

local function tbl_isarray(tbl)
  local max = 0
  for k, _ in pairs(tbl) do
    if type(k) ~= "number" then
      return false
    elseif k > max then
      max = k
    end
  end
  return max == #tbl
end

--- We only merge empty tables or tables that are not an array (indexed by integers)
local function can_merge(v)
  return type(v) == "table" and (v == {} or not tbl_isarray(v))
end

function public.if_nil(a, b)
  if a == nil then
    return b
  end
  return a
end

function public.tbl_extend(behavior, deep_extend, ...)
  if behavior ~= "error" and behavior ~= "keep" and behavior ~= "force" then
    error('invalid "behavior": ' .. tostring(behavior))
  end

  if select("#", ...) < 2 then
    error("wrong number of arguments (given " .. tostring(1 + select("#", ...)) .. ", expected at least 3)")
  end

  local ret = {}

  for i = 1, select("#", ...) do
    local tbl = select(i, ...)
    if tbl then
      for k, v in pairs(tbl) do
        if deep_extend and can_merge(v) and can_merge(ret[k]) then
          ret[k] = public.tbl_extend(behavior, true, ret[k], v)
        elseif behavior ~= "force" and ret[k] ~= nil then
          if behavior == "error" then
            error("key found in more than one map: " .. k)
          end -- Else behavior is "keep".
        else
          ret[k] = v
        end
      end
    end
  end
  return ret
end

return public
