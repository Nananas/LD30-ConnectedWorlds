
package ;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Polygon;
import com.haxepunk.math.Vector;
import com.haxepunk.graphics.Emitter;
import flash.geom.Point;


class Item extends Entity
{

	private var image : Image;
	private var emitter : Emitter;
	public var info : String;
	public var correct : Bool;

	public function new (X:Float, Y:Float, t : Int)
	{
		super(X,Y);
		type = "item";
		var source : String;
		var particleSource : String;
		correct = false;

		switch(t)
		{
			case 0:
				correct = true;
				source = "graphics/Hat.png";
				particleSource = "graphics/bikeParticle.png";
				info = "Alright, A High Hat! This will look good on him...";
			case 1:
				source = "graphics/Bike.png";
				particleSource = "graphics/bikeParticle.png";
				info = "Euh, that's a bike, right?";
			case 2:
				source = "graphics/Pot.png";
				particleSource = "graphics/teapotParticle.png";
				info = "Hmm, a Teapot...";
			case 3:
				source = "graphics/Chair.png";
				particleSource = "graphics/bikeParticle.png";
				info = "Oh, what a cute chair.";
			default:
				source = "graphics/Bike.png";
				particleSource = "graphics/bikeParticle.png";
				info = "Euh, that's a bike, right?";
		}

		image = new Image(source);
		var ox : Int = Std.int((image.width)/2);
		var oy : Int = Std.int(ox / 2);
		var dy : Int = image.height - oy;
 
		mask = new Polygon([new Vector(-ox,0), new Vector(0,-oy), new Vector(ox,0), new Vector(0,oy)],new Point(0,0));
		originX = ox;
		originY = oy;
		image.originX = ox;
		image.originY = dy;
		graphic = image;

		emitter = new Emitter(particleSource,12,14);
		emitter.newType("a", [0]);
		emitter.newType("b", [1]);
		emitter.newType("c", [2]);
		emitter.newType("d", [3]);
		emitter.newType("e", [4]);
		emitter.newType("f", [5]);
		emitter.setMotion("a", 0,70,1,360, 0.5);
		emitter.setMotion("b", 0,70,1,360, 0.5);
		emitter.setMotion("c", 0,70,1,360, 0.5);
		emitter.setMotion("d", 0,70,1,360, 0.5);
		emitter.setMotion("e", 0,70,1,360, 0.5);
		emitter.setMotion("f", 0,70,1,360, 0.5);
		emitter.setAlpha("a");
		emitter.setAlpha("b");
		emitter.setAlpha("c");
		emitter.setAlpha("d");
		emitter.setAlpha("e");
		emitter.setAlpha("f");

	}

	public function setAlpha(value : Float)
	{
		image.alpha = value;
	}

	public function emit()
	{
		scene.addGraphic(emitter,-600-1,0,0);
		for (i in 0...10) {
			var a = Std.random(6);
			switch (a) {
				case 0: emitter.emit("a",x,y);
				case 1: emitter.emit("b",x,y);
				case 2: emitter.emit("c",x,y);
				case 3: emitter.emit("d",x,y);
				case 4: emitter.emit("e",x,y);
				case 5: emitter.emit("f",x,y);
				default: emitter.emit("f",x,y);
			}
		}
	}

}