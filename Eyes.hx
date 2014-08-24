
package ;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.tweens.misc.VarTween;
import flash.geom.Point;

class Eyes extends Entity
{
	private static var maxYOffset : Int = 100;
	private var image : Image;
	public var anchorX : Float;
	public var anchorY : Float;

	private var winkTimer : Float;
	private var winking : Bool;

	private var roamPoint : Point;
	private var roamVel : Point;

	private var factor : Float;

	public function new (X:Float, Y:Float)
	{
		super(X,Y);
		anchorY = Y+40;
		anchorX = X;
		init();

		//setFactor(0);

		if (Math.random()>0.5)
		{
			image.flipped = true;
			image.originX -= 40;
		}
	}

	private function init()
	{
		image = new Image("graphics/eyes.png");
		image.angle = 1;
		image.alpha = 0;
		image.centerOrigin();
		image.originX += 20;
		centerOrigin();
		graphic = image;
		layer = -910;

		winkTimer = 0;
		winking = false;

		roamPoint = new Point(0,0);
		roamVel = new Point(0,0);

		factor = 0;

	}

	public override function update()
	{
		winkTimer -= HXP.elapsed;

		if (!winking && winkTimer < 0)
		{
			winking = true;
			winkTimer = Math.random()*10;
			// wink
			image.alpha = 0;
			var lala = function(_)
			{
				winking = false;
			}
			var t = new VarTween(lala);
			t.tween(image, "alpha", 0.5, 1);
			addTween(t);
		}


		roamVel.x += (Math.random()*200-100)*HXP.elapsed;
		roamVel.y += (Math.random()*200-100)*HXP.elapsed;

		roamPoint.x += roamVel.x * HXP.elapsed;
		roamPoint.y += roamVel.y * HXP.elapsed;

		if (roamPoint.x > 50 || roamPoint.x < -50 || roamPoint.y > 50 || roamPoint.y < -50)
		{
			roamVel.x = 0;
			roamVel.y = 0;
		}

		roamPoint.x = HXP.clamp(roamPoint.x, -50,50);
		roamPoint.y = HXP.clamp(roamPoint.y, -50,50);

		x = anchorX + roamPoint.x;
		y = anchorY + roamPoint.y + (1-factor)*maxYOffset;

		super.update();
	}

	/*public function setFactor(value : Float)
	{
		if (!winking)
			image.alpha = value/2;
		factor = value;
		//y = anchorY + (1-value)*maxYOffset;
		image.scale = value/2;
	}*/

	public function setDeathValue(s : Float)
	{
		factor = 1-s;
		image.scale = 1-s;
	}
}