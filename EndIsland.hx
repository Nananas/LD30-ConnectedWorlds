
package ;

import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;

class EndIsland extends Island
{
	private var girlE : Entity;

	public function new (X : Int, Y : Int)
	{
		super(X, Y);
		source = "graphics/happyIsland.png";
		init();
	}

	override public function added()
	{
		// a tree
		var tree = new Image("graphics/tree.png");
		tree.originX = Std.int(tree.width/2);
		tree.originY = tree.height - 10;
		scene.addGraphic(tree,-700,x,y-120).layer = layer-1;
	}



	override public function setDistanceTo(d:Float)
	{}


}