package burge.paul.score
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Score extends Sprite
	{
		private var _score:Image;
		
		public function Score()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawScore();
		}
		
		private function drawScore():void
		{
			_score = new Image(Assets.getAtlas().getTexture("PlayerScore"));
			this.addChild(_score);
		}
		
		public function init():void{
			this.visible = true;
		}
		
		public function hideTemp():void{
			this.visible = false;
		}
	}
}