
package ;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.tweens.misc.Alarm;

class Dialog extends Entity
{
	private var text : Text;
	private var me : Bool;

	public function new (txt : String, me : Bool = true)
	{
		text = new Text(txt);
		
		text.scrollX = 0;
		text.scrollY = 0;
		text.size = 24;
		text.color = 0xffffff;

		if (!me)
		{
			super(50, HXP.height - 60);
			var background = Image.createRect(HXP.screen.width, 60, 0x888888);
			//background.originY = 10;
			background.alpha = 0.6;
			background.scrollX = 0;
			background.scrollY = 0;
			
			addGraphic(background);
			text.originX = 0;
			text.align = flash.text.TextFormatAlign.LEFT;

		}
		else
		{
			super(400,50);
			text.originX = text.textWidth/2;
			text.align = flash.text.TextFormatAlign.CENTER;
		}
		
		layer = - 1000;
		

		graphic = text;
		addGraphic(text);

		var delete  = function(_)
		{
			scene.remove(this);
		}
		var end = new Alarm(4, delete);
		addTween(end);
		end.start();

		this.me = me;
	}

	override public function update()
	{
		if (me)
			y -= HXP.elapsed*5;
		text.alpha *= 0.99;
	}

}