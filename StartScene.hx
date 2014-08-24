
package ;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import com.haxepunk.tweens.misc.Alarm;

class StartScene extends Scene
{
	private var startbutton : Image;
	private var overlay : Image;
	private var endstate : Bool;

	public override function begin()
	{
		endstate = false;
		var back = new Image("graphics/Titlescreenxcf.png");
		addGraphic(back,0,0,0);

		for (i in 0...20) {
			var f = new Flies(Math.random()*HXP.screen.width, Math.random()*HXP.screen.height);
			add(f);
		}

		overlay = Image.createRect(HXP.screen.width, HXP.screen.height, 0x000000);
		addGraphic(overlay, -9999);	 // WHAAAAA
		overlay.scrollX = 0;
		overlay.scrollY = 0;
	}

	public override function update()
	{
		if (Input.pressed(Key.ANY) || Input.mousePressed)
		{
			var end = function(_)
			{
				HXP.scene = new InterStartScene();
			}
			var a = new Alarm(3,end);
			addTween(a);
			a.start();
			endstate = true;
		}

		if (!endstate)
			overlay.alpha -= HXP.elapsed/2;
		else
			overlay.alpha += HXP.elapsed/2;

		super.update();

	}

}