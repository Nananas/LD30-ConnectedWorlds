
package ;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

// literally a scene ;)
class BoatScene extends Scene
{
	private var overlay : Image;
	private var timer : Float;

	private var eyesList : Array<Eyes>;

	public override function begin()
	{
		timer = 0;
		HXP.screen.color = 0x000000;

		var x =  Std.int(HXP.screen.width/2);
		var y =  Std.int(HXP.screen.height/2);

		var boat = new Boat(x,y+100);
			add(boat);
		var boatman = new BoatMan(x+50,y);
			add(boatman);
		var player = new Player(x-50,y+90);
			add(player);
		player.stop();
		player.image.flipped = true;

		var fog = new Image("graphics/Fog.png");
		fog.scrollX = 0;
		fog.scrollY = 0;
		addGraphic(fog,-600,0,0);

		overlay = Image.createRect(HXP.screen.width, HXP.screen.height, 0x000000);
		addGraphic(overlay, -9999);	 // WHAAAAA
		
		for (i in 0...10) {
			var f = new Flies(Math.random()*HXP.screen.width, Math.random()*HXP.screen.height);
			add(f);
		}

		// some monsters
		eyesList = new Array<Eyes>();

		for (i in 0...12) {
			var eyes = new Eyes(Math.random()*(HXP.screen.width - 100), Math.random()*HXP.height);
			eyes.setDeathValue(Math.random()*0.6);
			add(eyes);
			eyesList.push(eyes);
		}
	}

	public override function update()
	{
		timer += HXP.elapsed;

		if (timer > 4)
		{
			overlay.alpha += HXP.elapsed;
			if (overlay.alpha > 0.9)
				HXP.scene = new GoodEndingScene();
		}
		else
			overlay.alpha -= HXP.elapsed;

		for (e in eyesList) {
			e.anchorX += HXP.elapsed * 70;
			e.anchorY -= HXP.elapsed * 70;
		}

		super.update();
	}

}