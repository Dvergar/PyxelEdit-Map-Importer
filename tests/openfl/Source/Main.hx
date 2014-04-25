package;

import flash.display.Sprite;
import openfl.Assets;

import pmi.PyxelMapImporter;
import pmi.OpenflHelper;

class Main extends Sprite
{
    public function new ()
    {
        super ();
        var pyxelMap = new PyxelMapImporter(Assets.getText("assets/map.xml"));
        var background = pyxelMap.getDatasFromLayer("background");
        var walls = pyxelMap.getDatasFromLayer("walls");
        var objects = pyxelMap.getDatasFromLayer("objects");
        var tilemapBackground = OpenflHelper.getTilesheetArray(background);
        var tilemapWalls = OpenflHelper.getTilesheetArray(walls);
        var tilemapObjects = OpenflHelper.getTilesheetArray(objects);
        var tilesheet = OpenflHelper.getTilesheet("assets/map.png");

        tilesheet.drawTiles(flash.Lib.current.graphics, tilemapBackground);
        tilesheet.drawTiles(flash.Lib.current.graphics, tilemapWalls);
        tilesheet.drawTiles(flash.Lib.current.graphics, tilemapObjects);
    }
}