package ;
import enet.ENetEvent;

/**
 * ...
 * @author Ohmnivore
 */
class Server extends enet.Server
{
	public function new(IP:String = "localhost", Port:Int = 1337) 
	{
		trace("Server listening at " + IP + ":" + Port);
		super(IP, Port, 2, 32);
	}
	
	override public function onPeerConnect(e:ENetEvent):Void 
	{
		trace("Peer connected: " + e.ID);
		peers.set(e.ID, null);
		super.onPeerConnect(e);
	}
	
	override public function onPeerDisonnect(e:ENetEvent):Void 
	{
		trace("Peer disconnected: " + e.ID);
		peers.remove(e.ID);
		super.onPeerDisonnect(e);
	}
	
	override public function onReceive(MsgID:Int, E:ENetEvent):Void 
	{
		super.onReceive(MsgID, E);
		
		if (MsgID == Msg.keyState.ID)
		{
			var left:Bool = Msg.keyState.data.get("left");
			var right:Bool = Msg.keyState.data.get("right");
			var sequenceNumber:Int = Msg.keyState.data.get("sequenceNumber");
			
			var k:KeyState = new KeyState();
			k.left = left;
			k.right = right;
			k.sequenceNumber = sequenceNumber;
			Reg.state.player.interpretKeyState(k);
			Reg.state.lastProcessedInput = sequenceNumber;
		}
	}
}