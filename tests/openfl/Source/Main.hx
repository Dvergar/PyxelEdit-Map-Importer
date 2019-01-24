import openfl.Assets;
import openfl.display.Sprite;

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

        var tileset = OpenflHelper.getTileset("assets/tileset.png");

        var tilemapBackground = OpenflHelper.getTilemap(background, tileset);
        var tilemapWalls = OpenflHelper.getTilemap(walls, tileset);
        var tilemapObjects = OpenflHelper.getTilemap(objects, tileset);

        addChild(tilemapBackground);
        addChild(tilemapWalls);
        addChild(tilemapObjects);
    }
}