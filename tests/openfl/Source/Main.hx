package;

import flash.display.Sprite;
import openfl.Assets;

import pmi.PyxelMapImporter;
import pmi.OpenflHelper;

class Main extends Sprite
{
    public function new ()
    {
        super();
        #if paid
            trace("TESTING PAID VERSION");
            var pyxelMap = new PyxelMapImporter(Assets.getText("assets/map-paid.xml"));
        #else
            trace("TESTING FREE VERSION");
            var pyxelMap = new PyxelMapImporter(Assets.getText("assets/map-free.xml"));
        #end
        var background = pyxelMap.getDatasFromLayer("background");
        var walls = pyxelMap.getDatasFromLayer("walls");
        var objects = pyxelMap.getDatasFromLayer("objects");
        var tilemapBackground = OpenflHelper.getTilesheetArray(background);
        var tilemapWalls = OpenflHelper.getTilesheetArray(walls);
        var tilemapObjects = OpenflHelper.getTilesheetArray(objects);
        var tilesheet = OpenflHelper.getTilesheet("assets/tileset.png");

        tilesheet.drawTiles(flash.Lib.current.graphics, tilemapBackground, false, openfl.display.Tilesheet.TILE_TRANS_2x2);
        tilesheet.drawTiles(flash.Lib.current.graphics, tilemapWalls, false, openfl.display.Tilesheet.TILE_TRANS_2x2);
        tilesheet.drawTiles(flash.Lib.current.graphics, tilemapObjects, false, openfl.display.Tilesheet.TILE_TRANS_2x2);
    }
}