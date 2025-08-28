# MT Fake plates
Just a simple fake plate script for qbox

# Preview
https://youtu.be/k0nTzOh5TFo

# Installation
Add ox_inventory items:
```lua
['fakeplate'] = {
    label = 'Vehicle plate',
    weight = 1000,
    client = {
      export = 'mt_fakeplates.useFakeplate'
    }
},
['screwdriver'] = {
    label = 'Screwdriver',
    weight = 1000,
    client = {
      export = 'mt_fakeplates.removeFakeplate'
    }
},
```
