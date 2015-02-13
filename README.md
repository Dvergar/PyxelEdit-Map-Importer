PyxelEdit-Map-Importer
======================

Haxe map importer for **Pyxel Edit** for the free & paid version. With OpenFL and Luxe helpers.

![Pyxel Edit + flash version](http://i.imgur.com/SSux3u6.png)

# Usage

* Export your map *File > Export tilemap as XML...*
* Export your tileset *File > Export tileset...*

Make use of the PyxelEdit-Map-Importer tools with `import pmi.PyxelMapImporter`

## Loading the map
Assuming you're not necessarily using any graphical framework (server for example) :

`var pyxelMap = new PyxelMapImporter(sys.io.File.getContent("map.xml"));` will load the xml pyxel map. The argument is the xml content as `String`.

## Extracting layer datas
![Pyxel Edit layer view](http://i.imgur.com/ZLklAAP.png)

`var background = pyxelMap.getDatasFromLayer("background");`

* `"background"` is the name of the layer in PyxelEdit.
* `background` (the variable) is an object of type `Layer`.

`Layer.tiles` is an `Array<Tile>` where you can access fields : `x`, `y`, `index`,`rot` & `flipX` as it is in the XML, those datas are exposed in an cleaner way than the XML file and let you use some of the parameters i'm not using in the other methods.

## Make those layers a tile array
`var backgroundArray = pyxelMap.getLayerArray(background)` will return an map array of type `Array<Array<Int>>` allowing you to check the tile ID with `backgroundArray[x][y]`.

You can also use it to get a collision map. If, for example, you name a PyxelEdit layer "collision" and dedicate a red tile for collisions, you can then extract that layer and check if there is a collision with a simple `collisionArray[x][y]`.

## IDs assignation
IDs are assigned in order of appearance in your Pyxel Edit tileset window :

![Tileset IDs](http://i.imgur.com/XGdo6w7.png)

So let's say your collision red tile is at the rank 5, to check a collision you'll have to check if `collisionArray[x][y] == 5`: This is not a 0/1 collision map.

`-1` refers to "no tile".

## Example
```Haxe
import pmi.PyxelMapImporter;

class Main extends Sprite
{
    public function new()
    {
        super();
        var pyxelMap = new PyxelMapImporter(sys.io.File.getContent("map.xml"));
        var background = pyxelMap.getDatasFromLayer("background");
        var backgroundArray = pyxelMap.getLayerArray(background);
    }
}
```

# OpenFL helper

You can make use of `pmi.OpenflHelper` to get a tilesheet object and a tile array easily.

* `var tilemapBackground = OpenflHelper.getTilesheetArray(background);` will return an `Array<Float>`.
* `var tilesheet = OpenflHelper.getTilesheet("assets/tileset.png");` will return a tilesheet object.

and that's all you need.

_**Note** that to load an openFL asset (the pyxel xml map) you would need `new PyxelMapImporter(Assets.getText("assets/map.xml"));` here._

## Example

It will load three different layers and will draw them on screen.

```Haxe
import flash.display.Sprite;
import openfl.Assets;

import pmi.PyxelMapImporter;
import pmi.OpenflHelper;


class Main extends Sprite
{
    public function new()
    {
        super();
        var pyxelMap = new PyxelMapImporter(Assets.getText("assets/map.xml"));
        var background = pyxelMap.getDatasFromLayer("background");
        var walls = pyxelMap.getDatasFromLayer("walls");
        var objects = pyxelMap.getDatasFromLayer("objects");
        var tilemapBackground = OpenflHelper.getTilesheetArray(background);
        var tilemapWalls = OpenflHelper.getTilesheetArray(walls);
        var tilemapObjects = OpenflHelper.getTilesheetArray(objects);
        var tilesheet = OpenflHelper.getTilesheet("assets/tileset.png");

        tilesheet.drawTiles(flash.Lib.current.graphics, tilemapBackground);
        tilesheet.drawTiles(flash.Lib.current.graphics, tilemapWalls);
        tilesheet.drawTiles(flash.Lib.current.graphics, tilemapObjects);
    }
}
```

# Luxe helper

You can make use of `pmi.LuxeHelper` to get a tilemap object and and fill the tilelayers easily.

* `var tilemap = LuxeHelper.getTilemap('assets/tileset.png');` will return a `Tilemap` object.
* `LuxeHelper.fillLayer(tilemap, background);` will add the appropriate tilelayer to the tilemap.

and that's all you need.

_**Note** that to load a luxe asset (the pyxel xml map) you would need `new PyxelMapImporter(Luxe.loadText("assets/map.xml", null, false).text);` here._

## Example

It will load three different layers and draw them on screen.

```Haxe
import pmi.PyxelMapImporter;
import pmi.LuxeHelper;


class Main extends luxe.Game
{
    override function ready()
    {
        var pyxelMap = new PyxelMapImporter(Luxe.loadText("assets/map.xml", null, false).text);
        var tilemap = LuxeHelper.getTilemap('assets/tileset.png');
        var background = pyxelMap.getDatasFromLayer("background");
        var walls = pyxelMap.getDatasFromLayer("walls");
        var objects = pyxelMap.getDatasFromLayer("objects");

        LuxeHelper.fillLayer(tilemap, background);
        LuxeHelper.fillLayer(tilemap, walls);
        LuxeHelper.fillLayer(tilemap, objects);

        tilemap.display({});
    }
}
```
