
package ;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;


class BadEndingScene extends Scene
{
	public var timer : Float;
	private var overlay : Image;

	public override function begin()
	{
		HXP.screen.color = 0x000000;

		var d = new Dialog("Damn, lets try that again...");
		add(d);

		for (i in 0...20) {
			var f = new Flies(Math.random()*HXP.screen.width, Math.random()*HXP.screen.height);
			add(f);
		}

		timer = 0;

		overlay = Image.createRect(HXP.screen.width, HXP.screen.height, 0x000000);
		addGraphic(overlay, -9999);	 // WHAAAAA
		overlay.scrollX = 0;
		overlay.scrollY = 0;
	}

	public override function update()
	{
		timer += HXP.elapsed;
		if (timer > 4)
		{
			var s = new MainScene();
			s.skip();
			HXP.scene = s;

		}

		overlay.alpha -= HXP.elapsed;
		super.update();
	}

}