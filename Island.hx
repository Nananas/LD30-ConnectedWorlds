
package ;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import flash.geom.Point;
import com.haxepunk.masks.Polygon;
import com.haxepunk.math.Vector;


class Island extends Entity
{
	private static var maxVertOffset : Float = 400;
	private static var minVertOffset : Float = 250;

	private var factor : Float;

	private var source : String = "graphics/startIsland.png";

	public var image : Image;
	private var vertOffset : Float;

	public var anchorPoint : Point;

	public var halfwidth : Int;
	public var halfheight : Float;

	public var objects : Array<Entity>;

	public function new (X : Int, Y : Int)
	{
		super(X,Y);
		anchorPoint = new Point(X,Y);
		layer = -Y;
		type = "good";
		init();
	}

	private function init()
	{
		image = new Image(source);
		var ox = image.originX = Std.int(image.width/2); // center surface
		var oy = image.originY = Std.int((image.height-28)/2);

		graphic = image;

		mask = new Polygon([new Vector(-ox,0), new Vector(0,-oy), new Vector(ox,0), new Vector(0,oy)],new Point(0,0));
		originX = halfwidth = Std.int(ox);
		originY =  Std.int(oy);
		halfheight = oy;
		factor = 0;
	}


	public function setDistanceTo(distance : Float)
	{
		if (distance < minVertOffset)
		{
			vertOffset = 0;
		}
		else
		{
			distance -= minVertOffset;
			vertOffset = HXP.clamp(distance,0,maxVertOffset - minVertOffset);
		}

		y = anchorPoint.y + vertOffset;
		//layer = Std.int(-y);

		// darken color
		factor = ((maxVertOffset - minVertOffset) - vertOffset) / (maxVertOffset - minVertOffset);
		var a = Std.int(factor * 255);
		var b = a & 0xFF;
		var c = 0x000000;
		
		c |= (b << 16);
		c |= (b << 8);
		c |= b;

		//c <<=a;
		//c <<=a;
		image.color = c;
	}

	public function moveOneDown()
	{
		anchorPoint.y += halfheight;
		y = anchorPoint.y;
		layer = Std.int(-y);
	}

	public function moveOneUp()
	{
		anchorPoint.y -= halfheight;
		y = anchorPoint.y;
		layer = Std.int(-y);
	}

	public function setDeathValue(a : Float)
	{
	}
}