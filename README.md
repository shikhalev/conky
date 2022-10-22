# conky

Some Conky Stuff

## Lua Scripts

### `utils`

#### `conky_format`

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

### `hwmon`

#### `conky_hwmon`

```Lua
function conky_hwmon(device, type, index)
```

Replacement for `${hwmon ...}` statement with name of device instead number. Also NVME devices named with index: `nvme0`, `nvme1`, etc.

Usage example:

```Conky
${lua hwmon k10temp temp 1}
```

#### `conky_hwmon_index`

```Lua
function conky_hwmon_index(device)
```

Return index of named device.

Usage example:

```Conky
${lua hwmon_index k10temp}
```
