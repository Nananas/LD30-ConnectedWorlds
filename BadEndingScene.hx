
package ;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;


class BadEndingScene extends Scene
{
	public var timer : Float;

	public override function begin()
	{
		var d = new Dialog("Damn, lets try that again...");
		add(d);

		timer = 0;
	}

	public override function update()
	{
		timer += HXP.elapsed;
		if (timer > 4)
			HXP.scene = new MainScene();
		super.update();
	}

}