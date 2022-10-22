require 'utils'

local hwmon_detected = false
local hwmon_indices = {}
local function hwmon_detect()
    if hwmon_detected then
        return
    end
    local idx = 0
    while true do
        local path = '/sys/class/hwmon/hwmon' .. idx
        local file = io.open(path .. '/name', 'r')
        if file == nil then 
            break
        end
        local name = file:read("*a"):gsub('\n', '')
        file:close()
        if name == 'nvme' then
             name = readlink(path):match('nvme%d+')
        end
        hwmon_indices[name] = idx
        idx = idx + 1
    end
    hwmon_detected = true
end

function conky_hwmon_index(device)
    hwmon_detect()
    return hwmon_indices[device]
end

function conky_hwmon(device, type, index)
    hwmon_detect()
    return conky_parse('${hwmon ' .. hwmon_indices[device] .. ' ' .. type .. ' ' .. index .. '}')
end
