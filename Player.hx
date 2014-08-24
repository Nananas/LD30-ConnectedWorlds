
package ;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.masks.Polygon;
import com.haxepunk.math.Vector;
import flash.geom.Point;

class Player extends Entity
{
	public var image : Spritemap;

	private var dirx : Int;
	private var diry : Int;

	private var vx : Float;
	private var vy : Float;

	private var maxv : Float = 100;

	public var imageHeight : Int;

	public var emitter : Emitter;
	private var emitterTimer : Float;

	public var DEAD : Bool;
	public var talking : Bool;

	public var hasItem : Bool;

	public function new (X:Int, Y:Int)
	{
		DEAD = false;
		super(X,Y);
		layer = -910;
		init();
		talking = false;
		hasItem = false;
	}
	

	private function init()
	{
		image = new Spritemap("graphics/player_v2.png", 45, 120);
		
		image.add("play",[0,1,2,3], 8);
		image.play("play");
		imageHeight = image.height;
		//image.angle = 0.1;	// if too shaky
		graphic = image;
		image.smooth = true;
		dirx = 0;
		diry = 0;

		vx = 0;
		vy = 0;

		var ox : Int = Std.int((image.width)/2);
		var oy : Int = Std.int(ox / 2);
		var dy : Int = image.height - oy;
		mask = new Polygon([new Vector(-ox,0), new Vector(0,-oy), new Vector(ox,0), new Vector(0,oy)],new Point(0,0));
		originX = ox;
		originY = oy;
		image.originX = ox;
		image.originY = dy;


		emitter = new Emitter("graphics/trail_particle.png",7,8);
		emitter.newType("a",[0]);
		emitter.setMotion("a", 0,0,1,0,0,0.5);
		emitter.setAlpha("a");
		emitter.newType("b",[1]);
		emitter.setMotion("b", 0,0,1,0,0,0.5);
		emitter.setAlpha("b");
		emitterTimer = 0;


		/*Input.define("up", [Key.UP, Key.Z]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("left", [Key.LEFT, Key.Q]);
		Input.define("right", [Key.RIGHT, Key.D]);
*/
		Input.define("up", [Key.UP, Key.W]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
	}

	public override function added()
	{
		scene.addGraphic(emitter, -500);
	}

	public override function update()
	{
		if (!DEAD)
		{
			
			// SMOOTH INPUT
			{
				if (Input.pressed("up"))
					diry = -1;
				if (Input.pressed("down"))
					diry = 1;
				if (Input.pressed("right"))
				{
					dirx = 1;
					image.flipped = false;
				}
				if (Input.pressed("left"))
				{
					image.flipped = true;
					dirx = -1;
				}

				if (Input.released("up"))
				{
					if (Input.check("down"))
						diry = 1;
					else
						diry = 0;
				}
				if (Input.released("down"))
				{
					if (Input.check("up"))
						diry = -1;
					else
						diry = 0;
				}
				if (Input.released("right"))
				{
					if (Input.check("left"))
					{
						dirx = -1;
						image.flipped = true;
					}
					else
						dirx = 0;
				}
				if (Input.released("left"))
				{
					if (Input.check("right"))
					{
						dirx = 1;
						image.flipped = false;
					}
					else
						dirx = 0;
				}
			} //---SMOOTH INPUT

			if (!talking)
			{
				vx *= 0.98;
				vy *= 0.98;
				if (Math.abs(vx) + Math.abs(vy) > 3)
				{
					image.angle = 0.1;
				}
				else
				{
					image.angle = 0;
					vx = 0;
					vy = 0;
				}

				vx += dirx * 200 * HXP.elapsed;
				vy += diry * 200 * HXP.elapsed;

				vx = HXP.clamp(vx,-maxv, maxv);
				vy = HXP.clamp(vy, -maxv, maxv);
				x += vx * HXP.elapsed;
				y += vy * HXP.elapsed;
			}


			layer = Std.int(-910-y);

			if (emitterTimer < 0)
			{
				emitterTimer = Math.random()*0.2;
				if (Math.abs(vx)>0.1)
				{
					if (Math.random()>=0.5)
						emitter.emit("a", x,y-Math.random()*imageHeight/2);
					else
						emitter.emit("b", x,y - Math.random()*imageHeight/2);
				}
			}
			else
				emitterTimer -= HXP.elapsed;

			super.update();
		}
	}

	public function stop()
	{
		talking = true;
		vx = 0;
		vy = 0;
	}
}