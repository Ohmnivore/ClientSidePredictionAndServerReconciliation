package ;
import flixel.FlxSprite;

/**
 * ...
 * @author Ohmnivore
 */
class Player extends FlxSprite
{
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		makeGraphic(16, 16, 0xff00ff00);
	}
	
	public function interpretKeyState(K:KeyState):Void
	{
		velocity.x = 0;
		if (K.left)
			velocity.x = -128;
		else if (K.right)
			velocity.x = 128;
	}
}