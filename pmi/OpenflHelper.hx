package pmi;

import openfl.display.Tilesheet;
import flash.geom.Rectangle;

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
                tilesheet.addTileRect(rect);
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
                tileArray.push(tile.x * PyxelMapImporter.TILE_WIDTH);
                tileArray.push(tile.y * PyxelMapImporter.TILE_HEIGHT);
                tileArray.push(tile.index);

                // ROTATION
                // Note : Needs to add x & y offset + flipX since this formula
                // doesn't take the center as the anchor.
                // Other issue is alignment/bleeding "issue" !? when using
                // the TILE_TRANS_2x2 flag.

                // var rot = Std.parseInt(tile.get("rot"));
                // var rotation = rot * 90 * (Math.PI/180);
                // var cos = Math.cos(-rotation);
                // var sin = Math.sin(-rotation);
                // tileArray.push(cos);
                // tileArray.push(sin);
                // tileArray.push(-1 * sin);
                // tileArray.push(cos);
            }
        }
        return tileArray;
    }
}