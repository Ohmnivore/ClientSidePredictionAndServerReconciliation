package enet.inter;

import enet.Message;

/**
 * ...
 * @author Ohmnivore
 */
interface INetBase
{
	public var isServer:Bool;
	public var peers:Map<Int, Dynamic>;
	private var messages:Map<Int, Message>;
	
	public function addMessage(M:Message):Void;
	private function separateMessage(Str:String):Array<Dynamic>;
	public function poll(Timeout:Float = 0):Void;
}