package burge.paul.objects
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Life extends Sprite
	{
		
		public function Life()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			drawLives();
		}
		
		private function drawLives():void
		{
			this.visible = true;
			
		}
	}
}