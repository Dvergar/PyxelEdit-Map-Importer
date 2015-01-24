import pmi.PyxelMapImporter;
import pmi.LuxeHelper;


class Main extends luxe.Game
{
    override function ready()
    {
        #if paid
            trace("TESTING PAID VERSION");
            var pyxelMap = new PyxelMapImporter(Luxe.loadText("assets/map-paid.xml", null, false).text);
        #else
            trace("TESTING FREE VERSION");
            var pyxelMap = new PyxelMapImporter(Luxe.loadText("assets/map-free.xml", null, false).text);
        #end

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
