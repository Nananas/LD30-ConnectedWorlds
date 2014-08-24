
package ;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.tweens.motion.LinearMotion;
import com.haxepunk.tweens.misc.Alarm;
import flash.geom.Point;

class GoodEndingScene extends Scene
{
	private var overlay : Image;
	private var cameraFollower : Point;
	private var player : Player;
	private var girlE : Entity;
	private var collider : Entity;
	private var motion : LinearMotion;
	private var endState : Bool;

	public override function begin()
	{
		endState = false;

		var end = new EndIsland(400,200);
		add(end);

		var girl = new Image("graphics/girl.png");
		girl.originX = Std.int(girl.width/2);
		girl.originY = girl.height - 10;
		girlE = addGraphic(girl,-910,end.x+35,end.y+130);
		girlE.layer = Std.int(-910 - girlE.y);

		var x = 620;
		var y = -20;
		var boat = new Boat(x,y+100);
			add(boat);
		var boatman = new BoatMan(x+50,y+1);
			add(boatman);
		player = new Player(400 + 80, 200-80);
			add(player);
		// player.stop();
		player.image.flipped = true;
		var thanks = function(_)
		{
			var dialog = new Dialog("You have my thanks, Boatman");
			add(dialog);
		}
		var a = new com.haxepunk.tweens.misc.Alarm(1,thanks);
		addTween(a);
		a.start();

		var fog = new Image("graphics/Fog.png");
		fog.scrollX = 0;
		fog.scrollY = 0;
		addGraphic(fog,-600,0,0);

		overlay = Image.createRect(HXP.screen.width, HXP.screen.height, 0x000000);
		addGraphic(overlay, -9999);	 // WHAAAAA
		overlay.scrollX = 0;
		overlay.scrollY = 0;

		cameraFollower = new Point(player.x, player.y);

		collider = new Entity(girlE.x - 50, girlE.y-50);
		collider.setHitbox(100,100);
		collider.type ="girl";
		add(collider);
	}


	override public function update()
	{
		if (motion != null)
			trace(motion.x);
		if (player.collide("girl", player.x, player.y) != null && motion == null)
		{
			var endGame = function(_)
			{
				trace("FIN");
			}
			motion = new LinearMotion(endGame);
			trace(player.x);
			trace(girlE.x);
			motion.setMotion(player.x, player.y, girlE.x-40, girlE.y-40, 2);
			addTween(motion);
			motion.start();

			player.stop();

			var d = new Dialog("I'm sorry you had to wait so long");
			add(d);
			var next = function(_)
			{
				var d = new Dialog("I'm glad you came for me...",false);
				add(d);
				var next = function(_)
				{
					var d = new Dialog("... Ofcourse I would. Lets go home...");
					add(d);
					endState = true;
					var end = function(_)
					{
						HXP.scene = new StartScene();	// need a better end scene
					}
					var a = new Alarm(7,end);
					addTween(a);
					a.start();
				}
				var a = new Alarm(2,next);
				addTween(a);
				a.start();
			}
			var a = new Alarm(2,next);
			addTween(a);
			a.start();
		}

		if (motion != null)
		{
			player.x = motion.x;
			player.y = motion.y;
		}

		cameraFollower.x += (player.x - cameraFollower.x)*HXP.elapsed;
		cameraFollower.y += (player.y - cameraFollower.y)*HXP.elapsed;
		
		camera.x = cameraFollower.x - HXP.screen.width/2;
		camera.y = cameraFollower.y - Std.int(player.imageHeight / 2) - HXP.screen.height/2;
		
		if (!endState)
			overlay.alpha -= HXP.elapsed;
		else
			overlay.alpha += HXP.elapsed/5;


		super.update();
	}
}