package ;
import enet.inter.INetBase;
import enet.Message;

/**
 * ...
 * @author Ohmnivore
 */
class Msg
{
	static public var keyState:Message;
	static public var setPos:Message;
	
	static public function init():Void
	{
		keyState = new Message(5, ["left", "right", "sequenceNumber"]);
		setPos = new Message(6, ["x", "lastProcessedInput"], true);
	}
	
	static public function addToBase(I:INetBase):Void
	{
		I.addMessage(keyState);
		I.addMessage(setPos);
	}
}