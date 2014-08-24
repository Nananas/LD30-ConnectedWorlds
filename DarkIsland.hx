
package ;

class DarkIsland extends Island
{
	private var eyes : Eyes;

	public function new (X:Int, Y:Int)
	{
		super(X, Y);
		source = "graphics/darkIsland.png";
		type = "bad";
		init();
	}

	public override function init()
	{
		super.init();

		eyes = new Eyes(anchorPoint.x, anchorPoint.y);
	}

	public override function added()
	{
		super.added();

		scene.add(eyes);
	}

	public override function setDistanceTo(distance : Float)
	{
		super.setDistanceTo(distance);
		// show eyes
		//eyes.setFactor(factor);
	}

	public override function moveOneUp()
	{
		super.moveOneUp();

		eyes.anchorY = anchorPoint.y;
	}

	public override function moveOneDown()
	{
		super.moveOneDown();

		eyes.anchorY = anchorPoint.y;
	}

	public override function setDeathValue(a : Float)
	{
		eyes.setDeathValue(a);
	}

}