# conky

Some Conky Stuff

## Lua Scripts

### `hwmon`

#### `conky_hwmon`

```Lua
function conky_hwmon(device, type, index)
```
Usage Example:

```Conky
{$lua hwmon k10temp temp 1}
```
