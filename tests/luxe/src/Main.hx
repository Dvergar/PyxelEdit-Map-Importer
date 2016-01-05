import pmi.PyxelMapImporter;
import pmi.LuxeHelper;


class Main extends luxe.Game {

    override function config(config:luxe.AppConfig) {

        config.preload.texts.push({ id:'assets/map-paid.xml' });
        config.preload.texts.push({ id:'assets/map-free.xml' });
        config.preload.textures.push({ id:'assets/tileset.png' });

        return config;
        
    } //config

    override function ready()
    {
        // Use --d paid to switch tests
        #if paid
            trace("TESTING PAID VERSION");
            var pyxelMap = new PyxelMapImporter(Luxe.resources.text('assets/map-paid.xml').asset.text);
        #else
            trace("TESTING FREE VERSION");
            var pyxelMap = new PyxelMapImporter(Luxe.resources.text('assets/map-free.xml').asset.text);
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
