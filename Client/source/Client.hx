package ;
import enet.ENetEvent;
import flixel.FlxG;

/**
 * ...
 * @author Ohmnivore
 */
class Client extends enet.Client
{
	public var pendingInputs:Array<KeyState> = [];
	
	public function new(IP:String = "localhost", Port:Int = 1337)
	{
		trace("Client connecting to " + IP + ":" + Port);
		super(IP, Port);
	}
	
	override public function onPeerConnect(e:ENetEvent):Void 
	{
		trace("Peer connected " + e.ID);
		peers.set(e.ID, null);
		super.onPeerConnect(e);
	}
	
	override public function onPeerDisonnect(e:ENetEvent):Void 
	{
		trace("Peer disconnected " + e.ID);
		peers.remove(e.ID);
		super.onPeerDisonnect(e);
	}
	
	override public function onReceive(MsgID:Int, E:ENetEvent):Void 
	{
		super.onReceive(MsgID, E);
		
		if (MsgID == Msg.setPos.ID)
		{
			var x:Float = Msg.setPos.data.get("x");
			var lastProcessedInput:Int = Msg.setPos.data.get("lastProcessedInput");
			
			Reg.state.player.x = x;
			
			//trace("lastprocessed: " + lastProcessedInput);
			//trace("pending: " + pendingInputs.length);
			var j:Int = 0;
			while (j < pendingInputs.length)
			{
				var input:KeyState = pendingInputs[j];
				if (input.sequenceNumber <= lastProcessedInput) // recvd from server
				{
					pendingInputs.splice(j, 1);
				}
				else
				{
					//trace("interpreting: " + j);
					Reg.state.player.interpretKeyState(input);
					Reg.state.player.update(FlxG.elapsed);
					j++;
				}
			}
		}
	}
}