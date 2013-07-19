package
{
	import flash.display.Sprite;
		
	import starling.core.Starling;

	[SWF(width="800",height="600",frameRate="60",backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		private var _myStarling:Starling;
		
		public function Main()
		{	
			_myStarling = new Starling(Game,stage);
			_myStarling.antiAliasing = 1;
			_myStarling.start();
		}
		
	}
}