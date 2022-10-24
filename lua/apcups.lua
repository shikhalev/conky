
local apcups = {}

local function apcups_load(hostport)
    hostport = (hostport or 'localhost:3551'):lower()
    local result = {}
    local command = 'apcaccess -h ' .. hostport .. ' -u'
    local handle = io.popen(command)
    if handle == nil then
        return nil
    end
    local found = false
    for line in handle:lines() do
        local key = line:match('^(.-)%s*:')
        local value = line:match(':%s*(.-)%s*$')
        if key ~= nil and key:len() ~= 0 then
            result[key:lower()] = value
            found = true
        end
    end
    handle:close()
    if not found then
        return nil
    end
    apcups[hostport] = result
    return result
end

function conky_apcups_load(hostport)
    apcups_load(hostport)
    return ''
end

function conky_apcups_get(hostport, property, update)
    local data = apcups[hostport]
    if update or data == nil then
        data = apcups_load(hostport)
    end
    if data == nil then
        return 'N/A'
    end
    return data[property]
end
