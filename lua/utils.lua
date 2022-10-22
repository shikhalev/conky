
function round(value)
    return math.floor(value + 0.5)
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
