package enet;

class BaseEvent
{
	/**
	 * E_NONE, E_CONNECT, E_DISCONNECT or E_RECEIVE
	 */
	public var type:Int;
	
	/**
	 * The sent content
	 */
	public var message:String = null;
	
	/**
	 * The ID of the peer who sent/connected/disconnected
	 */
	public var ID:Int;
	
	/**
	 * Nothing new here
	 */
	static public inline var E_NONE = 0;
	
	/**
	 * Someone has connected/you've succeeded to connect as a client
	 */
	static public inline var E_CONNECT = 1;
	
	/**
	 * A peer has disconnected/you've been disconnected from the server
	 */
	static public inline var E_DISCONNECT = 2;
	
	/**
	 * You've received a message!
	 */
	static public inline var E_RECEIVE = 3;
	
	public function new(_type:Int, _ID:Int, _msg:String = null)
	{
		type = _type;
		ID = _ID;
		message = _msg;
	}
}