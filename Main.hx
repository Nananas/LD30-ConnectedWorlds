import com.haxepunk.Engine;
import com.haxepunk.HXP;

class Main extends Engine
{

	override public function init()
	{
#if debug
		//HXP.console.enable();
#end
		HXP.scene = new MainScene();
		HXP.screen.smoothing = true;
		//HXP.screen.angle = 1;
	}

	public static function main() { new Main(); }

}