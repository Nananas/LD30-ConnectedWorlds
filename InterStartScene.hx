
package ;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.tweens.misc.Alarm;

class InterStartScene extends Scene
{
	private var overlay : Image;
	private var endstate : Bool;

	public override function begin()
	{
		HXP.screen.color = 0x000000;
		endstate = false;
		overlay = Image.createRect(HXP.screen.width, HXP.screen.height, 0x000000);
		addGraphic(overlay, -9999);	 // WHAAAAA
		overlay.scrollX = 0;
		overlay.scrollY = 0;

		// blabla
		var d = new Dialog("One day, she didn't wake up...");
		add(d);
		var next = function(_)
		{
			var d = new Dialog("Her mind was trapped... They said.");
			add(d);
			var next = function(_)
			{
				var d = new Dialog("But I'm taking her back!");
				add(d);
				var next = function(_)
				{
					var d = new Dialog("The \"Dreamworld\" they call it\n--\nA connection between two minds.");
					add(d);
					var next = function(_)
					{
						var end = function(_)
						{
							HXP.scene = new MainScene();
						}
						var a = new Alarm(3,end);
						addTween(a);
						a.start();
						endstate = true;
					}
					var a = new Alarm(5,next);
					addTween(a);
					a.start();
				}
				var a = new Alarm(4,next);
				addTween(a);
				a.start();
			}
			var a = new Alarm(4,next);
			addTween(a);
			a.start();
		}
		var a = new Alarm(4,next);
		addTween(a);
		a.start();

		for (i in 0...20) {
			var f = new Flies(Math.random()*HXP.screen.width, Math.random()*HXP.screen.height);
			add(f);
		}
	}	

	public override function update()
	{
		if (!endstate)
			overlay.alpha -= HXP.elapsed/2;
		else
			overlay.alpha += HXP.elapsed/2;
		super.update();
	}

}