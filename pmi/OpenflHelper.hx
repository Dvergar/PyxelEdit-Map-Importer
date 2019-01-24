package pmi;

import openfl.display.Tileset;
import openfl.display.Tilemap;
import openfl.display.Tile;
import openfl.geom.Rectangle;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.Lib;


class OpenflHelper
{
	static inline public function getTileset(imgPath:String):Tileset
	{
        var bd = openfl.Assets.getBitmapData(imgPath);

        var tileset = new Tileset(bd);
        var tilesWide = Std.int(bd.width / PyxelMapImporter.TILE_WIDTH);
        var tilesHigh = Std.int(bd.height / PyxelMapImporter.TILE_HEIGHT);

        for(posy in 0...tilesHigh)
        {
            for(posx in 0...tilesWide)
            {
                var rect = new Rectangle(posx * PyxelMapImporter.TILE_WIDTH,
                                         posy * PyxelMapImporter.TILE_HEIGHT,
                                         PyxelMapImporter.TILE_WIDTH,
                                         PyxelMapImporter.TILE_HEIGHT);

                tileset.addRect(rect);
            }
        }

        return tileset;
    }

    static inline public function getTilemap(layer:pmi.PyxelMapImporter.Layer, tileset:Tileset):Tilemap
    {
		var tilemap = new Tilemap(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight, tileset);
		tilemap.smoothing = false;

        for(tile in layer.tiles)
        {
            if(tile.index != -1)
            {
                var openflTile = new Tile(tile.index);
                openflTile.x = tile.x * PyxelMapImporter.TILE_WIDTH;
                openflTile.y = tile.y * PyxelMapImporter.TILE_HEIGHT;
                openflTile.originX = PyxelMapImporter.TILE_WIDTH / 2;
                openflTile.originY = PyxelMapImporter.TILE_WIDTH / 2;

                if(tile.flipX) openflTile.scaleX = -1;
                openflTile.rotation = tile.rot * 90;

                tilemap.addTile(openflTile);
            }
        }
        return tilemap;
    }
}