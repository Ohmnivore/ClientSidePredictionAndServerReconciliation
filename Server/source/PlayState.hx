package;

import cpp.vm.Mutex;
import cpp.vm.Thread;
import enet.ENet;
import flixel.FlxG;
import flixel.FlxState;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var server:Server;
	public var player:Player;
	public var lastProcessedInput:Int = 0;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		Reg.state = this;
		FlxG.autoPause = false;
		FlxG.log.redirectTraces = true;
		FlxG.debugger.visible = true;
		
		Reg.m = new Mutex();
		ENet.init();
		server = new Server();
		Msg.init();
		Msg.addToBase(server);
		
		player = new Player(256, 128);
		add(player);
		
		Thread.create(updateServer);
	}
	
	private function updateServer():Void
	{
		while (true)
		{
			Reg.m.acquire();
			server.poll();
			Reg.m.release();
			Sys.sleep(0.001);
		}
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(Elapsed:Float):Void
	{
		Reg.m.acquire();
		server.poll();
		super.update(Elapsed);
		Reg.m.release();
		
		Msg.setPos.data.set("x", player.x);
		Msg.setPos.data.set("lastProcessedInput", lastProcessedInput);
		for (p in server.peers.keys())
			server.sendMsg(p, Msg.setPos.ID);
	}
}