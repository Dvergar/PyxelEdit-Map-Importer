package pmi;

import luxe.tilemaps.Tilemap;
import pmi.PyxelMapImporter.Layer;

class LuxeHelper
{
    static inline public function getTilemap(imgPath:String):Tilemap
    {
		var tilesetTexture = Luxe.loadTexture(imgPath, null, false);
        var tilemap = new Tilemap({
            x           : 0,
            y           : 0,
            w           : PyxelMapImporter.TILES_WIDE,
            h           : PyxelMapImporter.TILES_HIGH,
            tile_width  : PyxelMapImporter.TILE_WIDTH,
            tile_height : PyxelMapImporter.TILE_HEIGHT,
            orientation : TilemapOrientation.ortho,
        });

        tilemap.add_tileset({
            name:'tiles',
            texture:tilesetTexture,
            tile_width: PyxelMapImporter.TILE_WIDTH,
            tile_height: PyxelMapImporter.TILE_HEIGHT
        });

        return tilemap;
    }

    static inline public function fillLayer(tilemap:Tilemap, layer:Layer)
    {
    	tilemap.add_layer({name: layer.name, layer: layer.number});
    	tilemap.add_tiles_fill_by_id(layer.name, 0);
        for(tile in layer.tiles)
        {
            if(tile.index != -1)
            {
            	tilemap.tile_at(layer.name, tile.x, tile.y).id = tile.index + 1;
            }
        }
    }
}