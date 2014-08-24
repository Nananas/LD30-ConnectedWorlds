
package ;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Boat extends Entity
{
	private var image : Image;

	private var front : Entity;

	public function new (X:Int, Y:Int)
	{
		super(X,Y);
		init();
	}

	private function init()
	{
		image = new Image("graphics/boatBack.png");
		graphic = image;
		image.scale = 0.5;
		layer = -611 - Std.int(y);

		image.originX = image.width / 2;
		image.originY = image.height - 100;

		var frontImage = new Image("graphics/boatFront.png");
		frontImage.scale = 0.5;
		frontImage.originX = 320;
		frontImage.originY = 245;
		front = new Entity(x,y,frontImage);
		front.layer = -912;


	}

	override public function added()
	{
		scene.add(front);
	}

}