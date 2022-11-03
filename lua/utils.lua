local posix_stat = require 'posix.sys.stat'
local http = require 'socket.http'

function round(value)
    return math.floor(value + 0.5)
end

function round1(value)
    return round(value * 10) / 10
end

function conky_format(format, number)
    return string.format(format, conky_parse(number))
end

function trim(value)
    return value:match('^%s*(.-)%s*$')
end

function readlink(path)
    local handle = io.popen('readlink ' .. path)
    local result = handle:read('*a'):gsub('\n', '')
    handle:close()
    return result
end

function readfile(path)
    local handle = io.open(path, 'r')
    local result = handle:read('*a')
    handle:close()
    return result
end

function fileexists(path)
    local stat = posix_stat.stat(path)
    return not (stat == nil or type(stat) == 'string' or type(stat) == 'number')
end

function download_file(url, filename)
    local body, code = http.request(url)
    if not body then
        error(code)
    end
    local handle, err = io.open(filename, 'wb')
    if not handle then
        error(err)
    end
    handle:write(body)
    handle:close()
    return filename
end
