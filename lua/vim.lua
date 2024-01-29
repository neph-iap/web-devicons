local public = {}

function public.if_nil(a, b)
  if a == nil then
    return b
  end
  return a
end

function public.tbl_extend(behavior, ...)
  if behavior ~= "error" and behavior ~= "keep" and behavior ~= "force" then
    error('invalid "behavior": ' .. tostring(behavior))
  end

  local tables = { ... }

  if behavior == "force" then
    local initial = {}
    for _, table in ipairs(tables) do
      for k, v in pairs(table) do
        if type(v) == "table" then
          initial[k] = public.tbl_extend("force", public.if_nil(initial[k], {}), v)
        else
          initial[k] = v
        end
      end
    end

    return initial
  elseif behavior == "keep" then
    local initial = {}
    for _, table in ipairs(tables) do
      for k, v in pairs(table) do
        if type(v) == "table" then
          initial[k] = public.tbl_extend("keep", public.if_nil(initial[k], {}), v)
        else
          initial[k] = public.if_nil(initial[k], v)
        end
      end
    end

    return initial
  elseif behavior == "error" then
    local initial = {}
    for _, table in ipairs(tables) do
      for k, v in pairs(table) do
        if type(v) == "table" then
          initial[k] = public.tbl_extend("error", public.if_nil(initial[k], {}), v)
        else
          if initial[k] ~= nil then
            error("key " .. tostring(k) .. " already exists with value " .. tostring(initial[k]))
          end
          initial[k] = v
        end
      end
    end

    return initial
  end
end

return public
