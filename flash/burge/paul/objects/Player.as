package burge.paul.objects
{
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Player extends Sprite
	{
		private var _newPlayerShip:Image;
		
		public function Player()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createHeroArt();
		}
		
		private function createHeroArt():void
		{
			_newPlayerShip = new Image(Assets.getTexture("Player"));	
				
			this.addChild(_newPlayerShip);
		}
		
		public function update() : void
		{
			trace(this.x, this.y)
		}
	}
}