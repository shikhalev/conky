# conky

Some Conky Stuff

## Lua Scripts

### `utils.lua`

#### `conky_format()`

```Lua
function conky_format(format, number)
```

Usage example:

```Conky
${lua format %3s ${cpu cpu1}}
```

#### Micro utils

```Lua
function round(value)
```

```Lua
function trim(value)
```

```Lua
function readlink(path)
```

### `hwmon.lua`

#### `conky_hwmon()`

```Lua
function conky_hwmon(device, type, index)
```

Replacement for `${hwmon ...}` statement with name of device instead number. Also NVME devices named with index: `nvme0`, `nvme1`, etc.

Usage example:

```Conky
${lua hwmon k10temp temp 1}
```

#### `conky_hwmon_index()`

```Lua
function conky_hwmon_index(device)
```

Return index of named device.

Usage example:

```Conky
${lua hwmon_index k10temp}
```

### `apcups.lua`

Get data from `apcupsd` service by `apcaccess`.

#### `conky_apcups_get()`

```Lua
function conky_apcups_get(hostport, property, update)
```

Get some property. Set `update` to `true` for one (first) property of device.

Usage example:

```Conky
${lua apcups_get localhost:3551 model true}
${lua apcups_get localhost:3551 bcharge}
```

#### `conky_apcups_load()`

```Lua
function conky_apcups_load(hostport)
```

Reload data for device.

Usage example:

```Conky
${lua apcups_load localhost:3551}${lua apcups_get localhost:3551 model}
```
