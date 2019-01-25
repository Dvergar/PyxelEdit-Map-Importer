import pmi.PyxelMapImporter;
import pmi.HeapsHelper;


class Main extends hxd.App
{
    override function init()
    {
        // Use --d paid to switch tests
        #if paid
            trace("TESTING PAID VERSION");
            var pyxelMap = new PyxelMapImporter(hxd.Res.loader.load("map_paid.xml").toText());
        #else
            trace("TESTING FREE VERSION");
            var pyxelMap = new PyxelMapImporter(hxd.Res.loader.load("map_free.xml").toText());
        #end

        var tileSet = HeapsHelper.getTileSet("tileset.png");

        var background = pyxelMap.getDatasFromLayer("background");
        var walls = pyxelMap.getDatasFromLayer("walls");
        var objects = pyxelMap.getDatasFromLayer("objects");

        var backgroundTileGroup = HeapsHelper.getTileGroup(background, tileSet);
        var wallsTileGroup = HeapsHelper.getTileGroup(walls, tileSet);
        var objectsTileGroup = HeapsHelper.getTileGroup(objects, tileSet);

        s2d.addChild(backgroundTileGroup);
        s2d.addChild(wallsTileGroup);
        s2d.addChild(objectsTileGroup);
    }

    public static function main()
    {
        hxd.Res.initEmbed();
        new Main();
    }
}