package enet;

#if desktop
class ENetEvent extends BaseEvent
{
	/**
	 * The channel on which the event occured
	 */
	public var channel:Int; //-1 if null
	
	///**
	 //* The peer's IP, in int_32 format (decimal/long ip format, not dotted quad)
	 //*/
	//public var address:String = null;
	
	///**
	 //* The peer's port
	 //*/
	//public var port:Int;
	
	/**
	 * Internal, you shouldn't create instances of this out of the blue
	 */
	public function new(EventFromC:Dynamic):Void
	{
		super(0, 0);
		
		type = ENet.event_type(EventFromC);
		
		channel = ENet.event_channel(EventFromC);
		
		if (type > BaseEvent.E_NONE)
		{
			//Setting address and port
			//var _addbuff:String = ENet.event_peer(EventFromC);
			//var _addbuff2:Array<String> = _addbuff.split(":");
			//address = _addbuff2[0];
			//port = Std.parseInt(_addbuff2[1]);
			ID = ENet.event_peer(EventFromC);
			
			if (type == BaseEvent.E_RECEIVE)
			{
				message = ENet.event_message(EventFromC);
			}
			
			//ENet.event_destroy(EventFromC);
		}
		ENet.event_destroy(EventFromC);
	}
}
#else
class ENetEvent
{
	public function new()
	{
		
	}
}
#end