
package ;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

class StartScene extends Scene
{
	private var startbutton : Image;

	public override function begin()
	{
		var back = new Image("graphics/TitleScreen.png");
		addGraphic(back,0,0,-30);
		startbutton = new Image("graphics/startbutton.png");
		startbutton.alpha = 0;
		addGraphic(startbutton, -1, 293,270);
	}

	public override function update()
	{
		if (mouseX > 300 && mouseX < 520 && mouseY > 300)
			startbutton.alpha = 1;
		else
			startbutton.alpha = 0;

		if (Input.mousePressed)
		{
			if (mouseX > 300 && mouseX < 520 && mouseY > 300)
			{
				// start
				
			}
			else
				startbutton.alpha = 0;
				
		}
	}

}