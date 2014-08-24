import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.tweens.misc.Alarm;
import flash.geom.Point;

class MainScene extends Scene
{
	private var player : Player;
	private var cameraFollower : Point;
	private var islandList : Array<Island>;
	private var happyIslandList : Array<HappyIsland>;

	private var deathCountdownTimer : Float;
	private var deathTime : Int = 3;
	private var DEAD : Bool;

	private var screenShaking : Bool;
	private var shakeAmount:Float;

	private var overlay : Image;

	private var mouth : Mouth;

	private var firstEncounter : Bool;
	private var firstDarkness : Bool;

	private var endState : Bool;

	private var skipIntro : Bool = false;

	private var canTalk : Bool = true;

	public override function begin()
	{
		// background
		HXP.screen.color = 0x000000;
		DEAD = false;
		firstEncounter = true;
		firstDarkness = true;
		deathCountdownTimer = deathTime;
		endState = false;

		islandList = new Array<Island>();
		happyIslandList = new Array<HappyIsland>();

		for (i in 0...5) {
			for (j in 0...5) {

				var island : Island;

				if (i>-1 && j > -1)
				{
					if (i == 3 && j == 3)
					{
						island = new HappyIsland(-250+i*500-250*(j%2),-100, 0);
						happyIslandList.push(cast(island, HappyIsland));
					}
					else
					{
						if (Math.random()<0.5)
							island = new Island(-250+i*500-250*(j%2),-100);
						else if (Math.random() > 0.8)
							island = new DarkIsland(-250+i*500-250*(j%2),-100);
						else
						{
							island = new HappyIsland(-250+i*500-250*(j%2),-100);
							happyIslandList.push(cast(island,HappyIsland));
						}						
					}


					for (k in 0...j) {
						island.moveOneDown();
					}

				}
				else
				{
					
					island = new DarkIsland(-250+i*500-250*(j%2),-100);
					if (j == -1)
					{
						island.moveOneUp();
					}

				}

				islandList.push(island);

				add(island);
			}
		}

		var i = new Island(-250-500,-100);
		//i.moveOneDown();
		add(i);
		islandList.push(i);

		player = new Player(Std.int(i.anchorPoint.x),Std.int(i.anchorPoint.y));
		add(player);
		player.stop();


		var i = new EndIsland(-250-500 + 250, -100);
		i.moveOneUp();
		add(i);
		//islandList.push(i);

		var boatman = new BoatMan(Std.int(i.anchorPoint.x),Std.int(i.anchorPoint.y));
		add(boatman);

		var boat = new Boat(Std.int(boatman.x + 250),Std.int(boatman.y-100));
		add(boat);

		for (i in 0...50) {
			var f = new Flies(Math.random()*2000-800, Math.random()*1000-200);
			add(f);
		}

		var fog = new Image("graphics/Fog.png");
		fog.scrollX = 0;
		fog.scrollY = 0;
		addGraphic(fog,-600,0,0);


		overlay = Image.createRect(HXP.screen.width, HXP.screen.height, 0x000000);
		addGraphic(overlay, -900);
		overlay.scrollX = 0;
		overlay.scrollY = 0;

		var endfunc = function()
		{

			// goto end state
			HXP.scene = new BadEndingScene();
		}
		mouth = new Mouth(endfunc);
		add(mouth);
		
		cameraFollower = new Point(player.x, player.y);

		// start of dialogs:
		// There's probably a better way to do this -.-'
		if (!skipIntro)
		{

			var firstText = function(_)
			{
				var dialog = new Dialog("Alright... I'm... Euh... Somewhere...");
				add(dialog);
				var nextText = function(_)
				{
					var dialog = new Dialog("\"...Jack, remember, you're in the Dreamworld...\nTry not to touch anything if you don't have to...\"",false);
					add(dialog);
					var thirdText = function(_)
					{
						var dialog = new Dialog("Don't worry, I won't fail! I mustn't!");
						add(dialog);
						player.talking = false;
						var forthtext = function(_)
						{
							var fifthText = function(_)
							{
								var dialog = new Dialog("A'ight... lets find my girl!");
								add(dialog);
							}
							var a = new Alarm(1.5,fifthText);
							addTween(a);
							a.start();		
						}
						var a = new Alarm(3,forthtext);
						addTween(a);
						a.start();					
					}
					var d = new Alarm(5, thirdText);
					addTween(d);
					d.start();
				}
				var dd = new Alarm(3, nextText);
				addTween(dd);
				dd.start();
			}
			var d = new Alarm(1, firstText);
			addTween(d);
			d.start();
		}
		else
		{
			player.talking = false;
		}
	}


	public override function update()
	{
		if (!DEAD)
		{
			//cameraFollower.
			cameraFollower.x += (player.x - cameraFollower.x)*HXP.elapsed;
			cameraFollower.y += (player.y - cameraFollower.y)*HXP.elapsed;
			
			camera.x = cameraFollower.x - HXP.screen.width/2;
			camera.y = cameraFollower.y - Std.int(player.imageHeight / 2) - HXP.screen.height/2;

			for (i in islandList) {
				i.setDistanceTo(Math.abs(HXP.distance(player.x, player.y, i.anchorPoint.x, i.anchorPoint.y)));
			}

			if (player.collide("boatman", player.x, player.y) != null)
			{
				if (firstEncounter && canTalk)
				{
					canTalk = false;
					player.stop();

					// first dialog
					var d = new Dialog("You don't seem to belong here...", false);
					add(d);
					var response = function(_)
					{
						var d = new Dialog("I don't plan to stay long.\nI'm only looking for someone...");
						add(d);
						var response2 = function(_)
						{
							var d = new Dialog("I shall bring you to her...\nBut I will need something in return...",false);
							add(d);
							var response3 = function(_)
							{
								var d = new Dialog("And what might that be?");
								add(d);
								var end = function(_)
								{
									var d = new Dialog("Something to cover this bald head of mine\nwould be nice...",false);
									add(d);
									player.talking = false;
									firstEncounter = false;
									var can = function(_)
									{
										canTalk = true;
									}
									var a = new Alarm(3, can);
									addTween(a);
									a.start();
								}

								var a = new Alarm(3, end);
								addTween(a);
								a.start();


							}
							var a = new Alarm(4, response3);
							addTween(a);
							a.start();

						}
						var a = new Alarm(4, response2);
						addTween(a);
						a.start();
					}
					var a = new Alarm(2,response);
					addTween(a);
					a.start();
				}
				else if (canTalk)
				{
					// check if correct item
					if (player.hasItem)
					{
						player.stop();
						var d = new Dialog("Oh my, that is some fine headwear...\nThis will do...", false);
						add(d);
						var toboatscene = function(_)
						{
							HXP.scene = new BoatScene();
						}
						var a = new Alarm(2, toboatscene);
						addTween(a);
						a.start();

						endState = true;

					}
					else
					{
						var d = new Dialog("So... Nothing yet?", false);
						add(d);
					}

					canTalk = false;
					var backtotalking = function(_)
					{
						canTalk = true;
					}
					var a = new Alarm(5,backtotalking);
					addTween(a);
					a.start();
				}
			}

			if (!firstEncounter)
			{
				if (player.collide("item", player.x, player.y ) != null )
				{
					var island = cast(player.collide("good", player.x, player.y ) , HappyIsland);
					var item = cast(player.collide("item",player.x, player.y), Item);
					if (item.correct) player.hasItem = true;
					// remove this item
					var infotxt = island.removeItem();
					var dialog = new Dialog(infotxt);
					add(dialog);
					var end = function(_)
					{

						happyIslandList.remove(island);
						remove(island);
						var bad = island.change();
						add(bad);
						islandList.push(bad);
						screenShaking = false;
						HXP.screen.x = 0;
						HXP.screen.y = 0;
					}
					screenShaking = true;
					shakeAmount = 0;

					var alarm = new Alarm(1, end, com.haxepunk.Tween.TweenType.OneShot);
					addTween(alarm);
					alarm.start();
				}
			}
			
			if (screenShaking)
			{
				shakeAmount += HXP.elapsed * 15;
				HXP.screen.x = 0;
				HXP.screen.y = 0;
				HXP.screen.x += Std.int(shakeAmount*Math.random());
				HXP.screen.y += Std.int(shakeAmount*Math.random());

			}
			if (!skipIntro)
			{
				if (firstDarkness && player.collide("bad",player.x, player.y) != null)
				{
					firstDarkness = false;
					var dialog = new Dialog("Oh and, Jack, watch out for the darkness!", false);
					add(dialog);
					var urg = function(_) // those function names...
					{
						var dialog = new Dialog("Uh... Thanks for the info...");
						add(dialog);
					}
					var a = new Alarm(2,urg);
					addTween(a);
					a.start();
				}
			}
			
			if (player.collide("good", player.x, player.y) == null)
			{
				if (firstDarkness)
				{
					firstDarkness = false;
					var dialog = new Dialog("Oh and, Jack, watch out for the darkness!", false);
					add(dialog);
					var urg = function(_) // those function names...
					{
						var dialog = new Dialog("Uh... Thanks for the info...");
						add(dialog);
					}
					var a = new Alarm(2,urg);
					addTween(a);
					a.start();
				}

				deathCountdownTimer -= HXP.elapsed;

				var a = deathCountdownTimer / deathTime;

				for (i in islandList) {
					i.setDeathValue(a);
				}

				overlay.alpha = 1-a;

				if (deathCountdownTimer < 0)
				{
					DEAD = true;
					player.DEAD = true;
					mouth.hap(player.x, player.y);
					trace(player.x);
					trace(player.y);
				}
				// DIE state:
				// Everything becomes black, player can't move
				// then also player dissappears slowly (alpha)
				// then some end text
			}
			else
			{
				deathCountdownTimer = deathTime;
				for (i in islandList) {
					i.setDeathValue(1);
				}

				if (endState)
					overlay.alpha = HXP.clamp(overlay.alpha + HXP.elapsed, 0,1);
				else
					overlay.alpha = HXP.clamp(overlay.alpha - HXP.elapsed, 0,1);
			}
		}
		super.update();
	}

	public function skip()
	{
		skipIntro = true;
	}
}