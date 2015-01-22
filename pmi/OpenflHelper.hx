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

    static inline public function getTilesheetArray(layerDatas:Array<Map<String, String>>)
                                                            				 :Array<Float>
    {
        var tileArray:Array<Float> = new Array();
        for(tile in layerDatas) {
            var index = Std.parseInt(tile.get("index"));
            if(index != -1) {
                tileArray.push(Std.parseInt(
                                tile.get("x")) * PyxelMapImporter.TILE_WIDTH);
                tileArray.push(Std.parseInt(
                                tile.get("y")) * PyxelMapImporter.TILE_HEIGHT);
                tileArray.push(Std.parseInt(tile.get("index")));

                // TILE_TRANS_2x2
                // tileArray.push(1);
                // tileArray.push(0);
                // tileArray.push(0);
                // tileArray.push(1);
            }
        }
        return tileArray;
    }
}