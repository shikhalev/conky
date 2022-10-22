# conky

Some Conky Stuff

## Lua Scripts

### `hwmon`

#### `conky_hwmon`

```Lua
function conky_hwmon(device, type, index)
```

Replacement for `{$hwmon ...}` statement with name of device instead number. Also NVME devices named with index: `nvme0`, `nvme1`, etc.

Usage Example:

```Conky
{$lua hwmon k10temp temp 1}
```
