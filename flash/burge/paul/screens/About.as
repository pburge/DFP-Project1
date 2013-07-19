package burge.paul.screens
{
	import burge.paul.events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class About extends Sprite
	{
		private var _bg:Image;
		
		private var _back:Button;
		
		public function About()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			trace("about added");

			drawScreen();
		}
		
		private function drawScreen():void
		{
			_bg = new Image(Assets.getAtlas().getTexture("AboutScreen"));
			this.addChild(_bg);
			
			_back = new Button(Assets.getAtlas().getTexture("AboutBack"));
			this.addChild(_back);
			_back.x = 340;
			_back.y = 480;
		}
		
		private function onBackClick(e:Event):void
		{
			var onBack:Button = e.target as Button;
			if((onBack as Button) == _back){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
			}
		}
		
		public function init():void{
			this.visible = true;
			
			this.addEventListener(Event.TRIGGERED, onBackClick);
		}
		
		public function tempHide():void{
			this.removeEventListener(Event.TRIGGERED, onBackClick);
			
			this.visible = false;
		}
	}
}