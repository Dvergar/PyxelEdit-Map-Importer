PyxelEdit-Map-Importer
======================

Map importer for Pyxel Edit (free version 0.2.22c)

# Usage

* Export your map *File > Export tilemap as XML...*
* Export your tileset *File > Export tileset...*

make use of the PyxelEdit-Map-Importer tools with `import pmi.PyxelMapImporter`

## Loading the map
Assuming you're not necessarily using any graphical framework (server for example) :

`var pyxelMap = new PyxelMapImporter(sys.io.File.getContent("map.xml"));` will load the xml pyxel map. The argument is the xml content as `String`.

## Extracting layer datas
`var background = pyxelMap.getDatasFromLayer("background");`

* `"background"` is the name of the layer in PyxelEdit.
* `background` (the variable) is an array of `Map<String, String>`.

Each item of the array contain the keys : `x`, `y`, `index`,`rot` & `flipX` as it is in the XML, those datas are exposed in an cleaner way than the XML file and let you use some of the parameters i'm not using in the other methods.

## Make those layers a tile array
`var backgroundArray = pyxelMap.getLayerArray(background)` will return an map array of type `Array<Array<Int>>` allowing you to check the tile ID with `backgroundArray[x][y]`.

You can also use it to get a collision map. If you name PyxelEdit layer "collision" and dedicate a red tile for collisions, you can then extract that layer and check if there is a collision with a simple `collisionArray[x][y]`.

## IDs assignation
IDs are assigned in order of appearance in your Pyxel Edit tileset window :

![Tileset IDs](http://i.imgur.com/XGdo6w7.png)

So let's say your collision red tile is at the rank 5, to check a collision you'll have to check if `collisionArray[x][y] == 5`: This is not a 0/1 collision map.

Unused tiles are defaulted to `-1`.
