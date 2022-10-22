# conky

Some Conky Stuff

## Lua Scripts

### `hwmon`

#### Declaration

```Lua
function conky_hwmon(device, type, index)
```
#### Usage Example

```Conky
{$lua hwmon k10temp temp 1}
```
