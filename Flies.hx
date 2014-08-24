
package ;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import flash.geom.Point;

class Flies extends Entity
{

	private var anchorX : Float;
	private var anchorY : Float;
	private var alphaAnchor:Float;
	
	private var roamPoint : Point;
	private var roamVel : Point;
	private var roamAlpha : Float;

	private var image : Image;

	public function new(X:Float, Y:Float)
	{
		super(X,Y);
		anchorX = X;
		anchorY = Y;

		image = new Image("graphics/fly.png");
		image.alpha = alphaAnchor = 0.5;
		image.centerOrigin();
		graphic = image;

		roamAlpha = 0;

		roamPoint = new Point(0,0);
		roamVel = new Point(0,0);

		layer = -1200;
	}

	public override function update()
	{
		roamVel.x += (Math.random()*50-25)*HXP.elapsed;
		roamVel.y += (Math.random()*50-25)*HXP.elapsed;

		roamPoint.x += roamVel.x * HXP.elapsed;
		roamPoint.y += roamVel.y * HXP.elapsed;

		x = anchorX + roamPoint.x;
		y = anchorY + roamPoint.y;

		roamAlpha = HXP.clamp(roamAlpha + (-Math.random()*10+5)*HXP.elapsed, 0,0.5);
		image.alpha = alphaAnchor + roamAlpha;

		super.update();
	}

}