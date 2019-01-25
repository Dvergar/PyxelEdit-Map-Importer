package pmi;

import h2d.Tile;
import h2d.TileGroup;

import pmi.PyxelMapImporter.Layer;


typedef TileSet = {tiles:Array<Tile>, main:Tile};


class HeapsHelper
{
    // Can't make Tile.autocut work :(
    static inline public function getTileSet(imagePath:String):TileSet
    {
        var tileSetMain = hxd.Res.loader.load(imagePath).toTile();

		var tw = PyxelMapImporter.TILE_WIDTH;
		var th = PyxelMapImporter.TILE_HEIGHT;

        var tiles = [
                    for(y in 0 ... Std.int(tileSetMain.height / th))
                    for(x in 0 ... Std.int(tileSetMain.width / tw))
                    tileSetMain.sub(x * tw, y * th, tw, th)
                ];
		
        return {main:tileSetMain, tiles:tiles};
    }

	static inline public function getTileGroup(layer:Layer, tileSet:TileSet):TileGroup
	{
        for(tile in tileSet.tiles) tile.setCenterRatio(0.5, 0.5);
        var group = new h2d.TileGroup(tileSet.main);

        for(tile in layer.tiles)
        {
            if(tile.index != -1)
            {
                group.addTransform(tile.x * PyxelMapImporter.TILE_WIDTH,
                                   tile.y * PyxelMapImporter.TILE_HEIGHT,
                                   (if(tile.flipX) -1 else 1), 1, (tile.rot * 90) * Math.PI / 180, tileSet.tiles[tile.index]);
            }
        }

        return group;
    }
}