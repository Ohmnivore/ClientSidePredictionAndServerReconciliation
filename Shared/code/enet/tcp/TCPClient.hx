package enet.tcp;

import anette.Client;
import enet.inter.INetBase;

/**
 * ...
 * @author Ohmnivore
 */
class TCPClient extends TCPNetBase
{
	private var _client:anette.Client;
	
	public function new()
    {
        _client = new anette.Client();
		_sock = _client;
		super();
    }
	
	public function connect(IP:String, Port:Int)
	{
		_client.connect(IP, Port);
	}
	
	override public function poll(Timeout:Float = 0) 
	{
		_client.pump();
		_client.flush();
	}
}