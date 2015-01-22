package pmi;


class PyxelMapImporter
{
    public static var TILE_WIDTH:Int;
    public static var TILE_HEIGHT:Int;
    public static var TILES_WIDE:Int;
    public static var TILES_HIGH:Int;
    private var mapDatas:Array<Map<String, String>>;
    private var pyxelMap:haxe.xml.Fast;

    public function new(xmlDatas:String)
    {
        var xml = Xml.parse(xmlDatas);
        pyxelMap = new haxe.xml.Fast(xml.firstElement());
        TILE_WIDTH = Std.parseInt(pyxelMap.att.tilewidth);
        TILE_HEIGHT = Std.parseInt(pyxelMap.att.tileheight);
        TILES_WIDE = Std.parseInt(pyxelMap.att.tileswide);
        TILES_HIGH = Std.parseInt(pyxelMap.att.tileshigh);
    }

    public function getDatasFromLayer(layerName:String)
                            :Array<Map<String, String>>
    {
        var foundLayer = false;
        var layers = pyxelMap.nodes.layer;
        var layerDatas = new Array();
        for(layer in layers)
        {
            if(layer.att.name == layerName)
            {
                foundLayer = true;
                for(tile in layer.nodes.tile)
                {
                    var t:Map<String, String> = new Map();
                    t.set("x", tile.att.x);
                    t.set("y", tile.att.y);
                    t.set("index", tile.att.index);
                    t.set("rot", tile.att.rot);
                    t.set("flipX", tile.att.flipX);
                    layerDatas.push(t);
                }
            }
        }

        if(!foundLayer) throw 'Layer $layerName not found!';

        return layerDatas;
    }

    public function getLayerArray(layerDatas:Array<Map<String, String>>)
                                                  :Array<Array<Int>>
    {
        var newMap:Array<Array<Int>> = new Array();

        for(posx in 0...TILES_WIDE)
        {
            var row = [];

            for(posy in 0...TILES_HIGH)
                row.push(-1);

            newMap.push(row);
        }

        for(tile in layerDatas)
        {
            var index = Std.parseInt(tile.get("index"));

            if(index != -1)
            {
                var posx = Std.parseInt(tile.get("x"));
                var posy = Std.parseInt(tile.get("y"));
                var id = Std.parseInt(tile.get("index"));
                newMap[posx][posy] = id;
            }
        }

        return newMap;
    }
}