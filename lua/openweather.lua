package.path = package.path .. ';' .. os.getenv('HOME') .. '/.config/conky/?.lua'
local cjson = require 'cjson'
weather = {}
require 'openweather_config'

function conky_cjson_test()
    -- return 'XXX'
    return weather.config.api_key
end

local function load_place(place)
    -- TODO: implement
end

function conky_openweather_updated(place)
    load_place(place)
    return weather.places[place].updated
end

function conky_openweather_city_id(place)
    load_place(place)
    return weather.places[place].city.id
end

function conky_openweather_city_name(place)
    load_place(place)
    return weather.places[place].city.name
end

function conky_openweather_sunset(place, format)
    load_place(place)
    local sunset = tonumber(weather.places[place].city.sunset) + tonumber(weather.places[place].city.timezone)
    return os.date(format, sunset)
end

function conky_openweather_sunrise(place, format)
    load_place(place)
    local sunrise = tonumber(weather.places[place].city.sunrise) + tonumber(weather.places[place].city.timezone)
    return os.date(format, sunrise)
end

function conky_openweather_count(place)
    load_place(place)
    return weather.places[place].cnt
end

function conky_openweather_weather_time(place, index, format)
    load_place(place)
    local time = tonumber(weather.places[place].list[index].dt) + tonumber(weather.places[place].city.timezone)
    return os.date(format, time)
end

function conky_openweather_weather_temp(place, index)
    load_place(place)
    return weather.places[place].list[index].main.temp
end

function conky_openweather_weather_temp_min(place, index)
    load_place(place)
    return weather.places[place].list[index].main.temp_min
end

function conky_openweather_weather_temp_max(place, index)
    load_place(place)
    return weather.places[place].list[index].main.temp_max
end

function conky_openweather_weather_pressure(place, index)
    load_place(place)
    return weather.places[place].list[index].main.pressure
end

function conky_openweather_weather_humidity(place, index)
    load_place(place)
    return weather.places[place].list[index].main.humidity
end

function conky_openweather_weather_id(place, index)
    load_place(place)
    return weather.places[place].list[index].weather.id
end

function conky_openweather_weather_description(place, index)
    load_place(place)
    return weather.places[place].list[index].weather.description
end

function conky_openweather_weather_icon(place, index)
    load_place(place)
    return weather.places[place].list[index].weather.icon
end

function conky_openweather_weather_icon_file(place, index)
    load_place(place)
    -- TODO: load with cache
end
