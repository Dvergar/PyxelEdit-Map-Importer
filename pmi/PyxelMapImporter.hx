package pmi;


class Layer
{
    public var name:String;
    public var number:Int;
    public var tiles:Array<Tile> = new Array();

    public function new(name:String)
    {
        this.name = name;
    }
}


class Tile
{
    public var index:Int;
    public var x:Int;
    public var y:Int;
    public var rot:Int;
    public var flipX:Bool;

    public function new() {}
}


class PyxelMapImporter
{
    public static var TILE_WIDTH:Int;
    public static var TILE_HEIGHT:Int;
    public static var TILES_WIDE:Int;
    public static var TILES_HIGH:Int;
    private var mapDatas:Array<Map<String, String>>;
    private var pyxelMap:haxe.xml.Fast;

    public function new(xmlDatas:String, ?scale=1)
    {
        var xml = Xml.parse(xmlDatas);
        pyxelMap = new haxe.xml.Fast(xml.firstElement());
        TILE_WIDTH = Std.parseInt(pyxelMap.att.tilewidth) * scale;
        TILE_HEIGHT = Std.parseInt(pyxelMap.att.tileheight) * scale;
        TILES_WIDE = Std.parseInt(pyxelMap.att.tileswide);
        TILES_HIGH = Std.parseInt(pyxelMap.att.tileshigh);
    }

    public function getDatasFromLayer(layerName:String):Layer
    {
        var layer = new Layer(layerName);

        var foundLayer = false;
        var layers = pyxelMap.nodes.layer;
        for(xmlLayer in layers)
        {
            if(xmlLayer.att.name == layerName)
            {
                layer.number = Std.parseInt(xmlLayer.att.number);
                foundLayer = true;
                for(xmlTile in xmlLayer.nodes.tile)
                {
                    var tile = new Tile();
                    tile.x = Std.parseInt(xmlTile.att.x);
                    tile.y = Std.parseInt(xmlTile.att.y);
                    tile.rot = Std.parseInt(xmlTile.att.rot);
                    tile.flipX = if(xmlTile.att.flipX == "true") true else false;

                    if(xmlTile.has.index)  // FREE VERSION
                        tile.index = Std.parseInt(xmlTile.att.index);
                    else  // PAID VERSION
                        tile.index = Std.parseInt(xmlTile.att.tile);

                    layer.tiles.push(tile);
                }
            }
        }

        if(!foundLayer) throw 'Layer $layerName not found!';

        return layer;
    }

    public function getLayerArray(layer:Layer):Array<Array<Int>>
    {
        var newMap:Array<Array<Int>> = new Array();

        for(posx in 0...TILES_WIDE)
        {
            var row = [];

            for(posy in 0...TILES_HIGH)
                row.push(-1);

            newMap.push(row);
        }

        for(tile in layer.tiles)
        {
            if(tile.index != -1)
                newMap[tile.x][tile.y] = tile.index;
        }

        return newMap;
    }
}