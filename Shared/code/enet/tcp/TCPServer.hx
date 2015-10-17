package enet.tcp;

import anette.*;
import enet.inter.INetBase;

/**
 * ...
 * @author Ohmnivore
 */
class TCPServer extends TCPNetBase
{
	private var _server:anette.Server;
	
	public var ip:String;
	public var port:Int;
	
	public function new(IP:String, Port:Int)
    {
        _server = new anette.Server(IP, Port);
		_sock = _server;
		super();
		isServer = true;
		
		ip = IP;
		port = Port;
    }
	
	override public function poll(Timeout:Float = 0) 
	{
		_server.pump();
		_server.flush();
	}
}