package pmi;

import openfl.display.Tilesheet;
import openfl.geom.Rectangle;
import openfl.geom.Matrix;
import openfl.geom.Point;


class OpenflHelper
{
	static inline public function getTilesheet(imgPath:String):Tilesheet
	{
        var bd = openfl.Assets.getBitmapData(imgPath);

        var tilesheet = new Tilesheet(bd);
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

                tilesheet.addTileRect(rect, new Point(PyxelMapImporter.TILE_WIDTH / 2 , PyxelMapImporter.TILE_HEIGHT / 2));
            }
        }

        return tilesheet;
    }

    static inline public function getTilesheetArray(layer:pmi.PyxelMapImporter.Layer):Array<Float>
    {
        var tileArray:Array<Float> = new Array();
        for(tile in layer.tiles)
        {
            if(tile.index != -1)
            {
                var matrix = new Matrix();
                matrix.rotate( tile.rot * 90 * (Math.PI / 180) * (if(tile.flipX) -1 else 1) );
                if(tile.flipX) matrix.scale(-1, 1);

                tileArray.push(tile.x * PyxelMapImporter.TILE_WIDTH + matrix.tx);
                tileArray.push(tile.y * PyxelMapImporter.TILE_HEIGHT + matrix.ty);
                tileArray.push(tile.index);
                tileArray.push(matrix.a);
                tileArray.push(matrix.b);
                tileArray.push(matrix.c);
                tileArray.push(matrix.d);
            }
        }
        return tileArray;
    }
}