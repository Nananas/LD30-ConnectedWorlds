
package ;

import com.haxepunk.Entity;

import com.haxepunk.masks.Polygon;
import com.haxepunk.math.Vector;
import flash.geom.Point;
import com.haxepunk.graphics.Image;


class BoatMan extends Entity
{
	private var image : Image;

	public function new (X:Int, Y:Int)
	{
		super(X,Y);
		init();
		type = "boatman";
	}
	

	private function init()
	{
		image = new Image("graphics/boatman.png");
		graphic = image;

		var ox : Int = Std.int((image.width)/2);
		var oy : Int = Std.int(ox / 2);
		var dy : Int = image.height - oy;
		mask = new Polygon([new Vector(-ox,0), new Vector(0,-oy), new Vector(ox+10,0), new Vector(0,oy+10)],new Point(0,0));
		originX = ox;
		originY = oy;
		image.originX = ox;
		image.originY = dy;

		layer = Std.int(-911-y);

		
	}

}