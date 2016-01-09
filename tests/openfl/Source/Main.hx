import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.Tilesheet;

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

        tilesheet.drawTiles(openfl.Lib.current.graphics, tilemapBackground, false, Tilesheet.TILE_TRANS_2x2);
        tilesheet.drawTiles(openfl.Lib.current.graphics, tilemapWalls, false, Tilesheet.TILE_TRANS_2x2);
        tilesheet.drawTiles(openfl.Lib.current.graphics, tilemapObjects, false, Tilesheet.TILE_TRANS_2x2);
    }
}