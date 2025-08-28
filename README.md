# MT Fake plates
Simple qbox fake plates script

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
