package ;

/**
 * ...
 * @author Ohmnivore
 */
class KeyState
{
	public var left:Bool = false;
	public var right:Bool = false;
	public var sequenceNumber:Int = 0;
	
	public function new()
	{
		
	}
	
	public function copyFrom(K:KeyState):Void
	{
		left = K.left;
		right = K.right;
		sequenceNumber = K.sequenceNumber;
	}
}