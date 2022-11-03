local cjson = require 'cjson'
-- require 'utils'
weather = {
    places = {}
}
package.path = package.path .. ';' .. os.getenv('HOME') .. '/.config/conky/?.lua'
require 'openweather_config'

local weather_url = 'http://api.openweathermap.org/data/2.5/forecast?'
local icons_url = 'http://openweathermap.org/img/w/%s.png'
local cache_path = os.getenv('HOME') .. '/.cache/openweather/'
local data_path = os.getenv('HOME') .. '/.local/conky/openweather/'

local default_update_interval = 60 * 60

if weather.config.icon_cache_path == nil then
    weather.config.icon_cache_path = cache_path .. 'icons/'
end
os.execute('mkdir -p ' .. weather.config.icon_cache_path)
if weather.config.data_path == nil then
    weather.config.data_path = data_path
end
os.execute('mkdir -p ' .. weather.config.data_path)

function conky_cjson_test()
    -- return 'XXX'
    return weather.config.api_key
end

local function load_place(place)
    local config = weather.config.places[place]
    if config == nil then
        error('Config ' .. place .. ' not found!')
    end
    
    -- check timing
    local update_interval = config.update_interval or weather.config.update_interval or default_update_interval
    local current_time = os.time()
    if config.updated and config.updated > current_time - update_interval then
        return weather.places[place]
    end

    local url = weather_url .. 'appid=' .. weather.config.api_key
    if weather.config.units then
        url = url .. '&units=' .. weather.config.units
    end
    if weather.config.lang then
        url = url .. '&lang=' .. weather.config.lang
    end
    if config.latitude then
        url = url .. '&lat=' .. config.latitude
    end
    if config.longitude then
        url = url .. '&lon=' .. config.longitude
    end
    if config.city_id then
        url = url .. '&id=' .. config.city_id
    end
    local datafile = weather.config.data_path .. place .. '-' .. current_time .. '.json'
    if download_file(url, datafile) then
        weather.places[place] = cjson.decode(readfile(datafile))
        weather.config.places[place].updated = current_time
    end
    return weather.places[place]
end

function conky_openweather_url(place)
    local config = weather.config.places[place]
    if config == nil then
        error('Config ' .. place .. ' not found!')
    end
    
    local url = weather_url .. 'appid=' .. weather.config.api_key
    if weather.config.units then
        url = url .. '&units=' .. weather.config.units
    end
    if weather.config.lang then
        url = url .. '&lang=' .. weather.config.lang
    end
    if config.latitude then
        url = url .. '&lat=' .. config.latitude
    end
    if config.longitude then
        url = url .. '&lon=' .. config.longitude
    end
    if config.city_id then
        url = url .. '&id=' .. config.city_id
    end
    return url
end

function conky_openweather_updated(place)
    return weather.config.places[place].updated
end

function conky_openweather_city_id(place)
    local data = load_place(place)
    return data.city.id
end

function conky_openweather_city_name(place)
    local data = load_place(place)
    return data.city.name
end

function conky_openweather_sunset(place, format)
    local data = load_place(place)
    local sunset = tonumber(data.city.sunset) + tonumber(data.city.timezone)
    return os.date(format, sunset)
end

function conky_openweather_sunrise(place, format)
    local data load_place(place)
    local sunrise = tonumber(data.city.sunrise) + tonumber(data.city.timezone)
    return os.date(format, sunrise)
end

function conky_openweather_count(place)
    local data = load_place(place)
    return data.cnt
end

function conky_openweather_weather_time(place, index, format)
    local data = load_place(place)
    local time = tonumber(data.list[tonumber(index)].dt) + tonumber(data.city.timezone)
    return os.date(format, time)
end

function conky_openweather_weather_temp(place, index)
    local data = load_place(place)
    return data.list[tonumber(index)].main.temp
end

function conky_openweather_weather_temp_min(place, index)
    local data = load_place(place)
    return data.list[tonumber(index)].main.temp_min
end

function conky_openweather_weather_temp_max(place, index)
    local data = load_place(place)
    return data.list[tonumber(index)].main.temp_max
end

function conky_openweather_weather_pressure(place, index)
    local data = load_place(place)
    return data.list[tonumber(index)].main.pressure
end

function conky_openweather_weather_humidity(place, index)
    local data = load_place(place)
    return data.list[tonumber(index)].main.humidity
end

function conky_openweather_weather_id(place, index)
    local data = load_place(place)
    return data.list[tonumber(index)].weather[1].id
end

function conky_openweather_weather_description(place, index)
    local data = load_place(place)
    return data.list[tonumber(index)].weather[1].description
end

function conky_openweather_weather_icon(place, index)
    local data = load_place(place)
    return data.list[tonumber(index)].weather[1].icon
end

function conky_openweather_weather_icon_filename(place, index)
    local icon = conky_openweather_weather_icon(place, index)
    local filename = weather.config.icon_cache_path .. icon .. ".png"
    if not fileexists(filename) then
        local url = string.format(icons_url, icon)
        if not download_file(url, filename) then
            return nil
        end
    end
    return filename
end
