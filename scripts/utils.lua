function has(item, amount)
	local count = Tracker:ProviderCountForCode(item)
	amount = tonumber(amount)
	if not amount then
		return count > 0
	else
		return count >= amount
	end
end

function toggle_item(code)
    local active = Tracker:FindObjectForCode(code).Active
    code = code .. "_hosted"
    local object = Tracker:FindObjectForCode(code)
    if object then
        object.Active = active
    else
        if ENABLE_DEBUG_LOG then
            print(string.format("toggle_item: could not find object for code %s", code))
        end
    end
end

function has_value (t, val)
    for i, v in ipairs(t) do
        if v == val then return 1 end
    end
    return 0
end

function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('	'):rep(depth)
        local tabs2 = ('	'):rep(depth + 1)
        local s = '{'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ','
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

function toggle_hosted_item(code)
    local active = Tracker:FindObjectForCode(code).Active
    code = code:gsub("_hosted", "")
    local object = Tracker:FindObjectForCode(code)
    if object then
        object.Active = active
    else
        if ENABLE_DEBUG_LOG then
            print(string.format("toggle_hosted_item: could not find object for code %s", code))
        end
    end
end