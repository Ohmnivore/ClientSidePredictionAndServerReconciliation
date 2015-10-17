package;

import cpp.vm.Thread;
import enet.ENet;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var player:Player;
	public var client:Client;
	public var sequenceNumber:Int = 0;
	
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
		
		ENet.init();
		client = new Client();
		
		Msg.init();
		Msg.addToBase(client);
		
		player = new Player(128, 128);
		add(player);
		
		//Thread.create(updateClient);
	}
	
	private function updateClient():Void
	{
		while (true)
		{
			client.poll();
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
		client.poll();
		
		var k:KeyState = getKeyState();
		player.interpretKeyState(k);
		client.pendingInputs.push(k);
		
		Msg.keyState.data.set("left", k.left);
		Msg.keyState.data.set("right", k.right);
		Msg.keyState.data.set("sequenceNumber", k.sequenceNumber);
		for (p in client.peers.keys())
			client.sendMsg(p, Msg.keyState.ID);
		
		super.update(Elapsed);
	}
	
	private function getKeyState():KeyState
	{
		var k:KeyState = new KeyState();
		k.left = FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT;
		k.right = FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT;
		k.sequenceNumber = sequenceNumber++;
		return k;
	}
}