
package ;

import com.haxepunk.tweens.misc.Alarm;

class EndScene extends StartScene
{

	public override function begin()
	{
		super.begin();

		var txt = new Dialog("Thanks for playing!");
		add(txt);

		var next = function(_)
		{
			var txt = new Dialog("Made by Nananas for LD30-48h");
			add(txt);
		}

		var a = new Alarm(4,next);
		addTween(a);
		a.start();
	}

}