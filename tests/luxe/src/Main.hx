import pmi.PyxelMapImporter;
import pmi.LuxeHelper;


class Main extends luxe.Game
{
    override function ready()
    {
    	var pyxelMap = new PyxelMapImporter(Luxe.loadText("assets/map-free.xml", null, false).text);
    	var tilemap = LuxeHelper.getTilemap('assets/tileset.png');
        var background = pyxelMap.getDatasFromLayer("background");
        var walls = pyxelMap.getDatasFromLayer("walls");
        var objects = pyxelMap.getDatasFromLayer("objects");

        LuxeHelper.fillLayer(tilemap, background, 0);
        LuxeHelper.fillLayer(tilemap, walls, 1);
        LuxeHelper.fillLayer(tilemap, objects, 2);

        tilemap.display({});
    }
}
