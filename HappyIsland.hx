
package ;

class HappyIsland extends Island
{
	public var item : Item;
	private var s : Int;

	public function new (X:Int, Y:Int, ?s : Int)
	{
		super(X, Y);
		source = "graphics/happyIsland.png";
		init();
		
		this.s = s;
		if (s == null)
			this.s = Math.round(Math.random()*2) + 1;
	}

	override public function added()
	{
		item = new Item(anchorPoint.x, anchorPoint.y, s);
		item.layer = layer-1;
		scene.add(item);

	}

	override public function setDistanceTo(d:Float)
	{
		super.setDistanceTo(d);
		if (item != null)
			item.y = y;
		item.setAlpha(factor);
	}

	// public override function update()
	// {

	// 	super.update();
	// }

	public function removeItem() : String
	{
		if (item != null)
		{
			item.emit();
			scene.remove(item);
			
		}

		return item.info;
		
	}

	public function change():DarkIsland
	{
		var bad = new DarkIsland(Std.int(anchorPoint.x),Std.int(anchorPoint.y));
		return bad;

		
	}
}