package enet.tcp;

import anette.Connection;
import enet.Message;
import enet.inter.INetBase;

/**
 * ...
 * @author Ohmnivore
 */
class TCPNetBase implements INetBase
{
	private var _sock:anette.BaseHandler;
	
	public var isServer:Bool = false;
	public var peers:Map<Int, Dynamic>;
	private var _peers:Map<Int, Connection>;
	private var peerIDCounter:Int = 0;
	private var messages:Map<Int, Message>;
	
	public function new()
    {
        _sock.onData = _onReceive;
        _sock.onConnection = _onPeerConnect;
        _sock.onDisconnection = _onPeerDisonnect;
        _sock.protocol = new anette.Protocol.Prefixed();
        _sock.timeout = 10;
		
		_peers = new Map<Int, Connection>();
		messages = new Map<Int, Message>();
    }
	
	public function addMessage(M:Message):Void
	{
		messages.set(M.ID, M);
	}
	private function separateMessage(Str:String):Array<Dynamic>
	{
		var _res:Array<Dynamic> = [];
		
		var sep:Int = Str.indexOf(".");
		
		_res.push(Std.parseInt(Str.substr(0, sep)));
		
		_res.push(Str.substr(sep + 1));
		
		return _res;
	}
	
	public function poll(Timeout:Float = 0)
    {
		
    }
	
	private function _sendMsg(c:Connection, s:String):Void
	{
		c.output.writeInt32(s.length);
        c.output.writeString(s);
	}
	public function sendMsg(ID:Int, MsgID:Int):Void
	{
		_sendMsg(_peers.get(ID), messages.get(MsgID).serialize());
	}
	
	private function _onReceive(c:Connection):Void
	{
		var theid:Int = -1;
		
		for (id in _peers.keys())
		{
			if (_peers.get(id) == c)
			{
				theid = id;
			}
		}
		
		var msgLength:Int = c.input.readInt32();
        var msg = c.input.readString(msgLength);
		
		try
		{
			var e:TCPEvent = new TCPEvent(BaseEvent.E_RECEIVE, theid, msg);
			
			var res:Array<Dynamic> = separateMessage(msg);
			
			var m:Message = messages.get(res[0]);
			
			if (isServer && m.isServerSideOnly)
			{
				//don't allow this message's content to be set by an incoming packet
			}
			else
			{
				m.unserialize(res[1]);
			}
			
			onReceive(res[0], e);
		}
		catch (e:Dynamic)
		{
			trace("Error receiving message, content: ", e);
		}
	}
	public function onReceive(MsgID:Int, E:TCPEvent):Void
	{
		
	}
	
	public function _onPeerConnect(c:Connection):Void
	{
		_peers.set(peerIDCounter, c);
		peerIDCounter++;
		
		onPeerConnect(new TCPEvent(BaseEvent.E_CONNECT, peerIDCounter - 1));
	}
	public function onPeerConnect(e:TCPEvent):Void
	{
		
	}
	
	private function _onPeerDisonnect(c:Connection):Void
	{
		var theid:Int = -1;
		
		for (id in _peers.keys())
		{
			if (_peers.get(id) == c)
			{
				_peers.remove(id);
				theid = id;
			}
		}
		
		onPeerDisonnect(new TCPEvent(BaseEvent.E_DISCONNECT, theid));
	}
	public function onPeerDisonnect(e:TCPEvent):Void
	{
		
	}
	
	public function peerDisconnect(ID:Int):Void
	{
		_peers.get(ID).disconnect();
	}
}