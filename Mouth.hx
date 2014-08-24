
package ;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;

class Mouth extends Entity
{

	private var image : Spritemap;
	private var end : Void -> Void;
	public function new (end : Void->Void)
	{
		super(0,0);

		image = new Spritemap("graphics/Mouth.png", 151, 320);
		image.add("hap", [0,1,2,2], 7, false);
		image.centerOrigin();

		graphic = image;
		//image.scrollX = 0;
		//image.scrollY = 0;

		layer = - 910;
		this.end = end;

		active = false;
		visible = false;
	}

	public function hap(X:Float, Y:Float)
	{
		image.alpha = 0;
		active = true;
		visible = true;
		x=X;
		y=Y - 100;
		image.play("hap");
	}

	public override function update()
	{
		image.alpha += HXP.elapsed * 30/4; // more guess pls...

		if (image.complete)
			end();
		super.update();
	}
}