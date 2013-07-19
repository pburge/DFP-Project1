package burge.paul.screens
{
	import burge.paul.events.NavigationEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameOver extends Sprite
	{
		private var _go:Image;
		
		private var _play:Button;
		private var _quit:Button;
		
		private var _gameScreen:inGame;
		
		public function GameOver()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawScreen();
		}
		
		private function drawScreen():void
		{
			_go = new Image(Assets.getAtlas().getTexture("GameOver"));
			this.addChild(_go);
			
			_play = new Button(Assets.getAtlas().getTexture("GameOverYes"));
			this.addChild(_play);
			_play.x = 400;
			_play.y = 450;
			
			_quit = new Button(Assets.getAtlas().getTexture("GameOverQuit"));
			this.addChild(_quit);
			_quit.x = 400;
			_quit.y = 520;
			
			_gameScreen = new inGame();
			
		}
		
		private function onClick(e:Event):void
		{
			var onPlay:Button = e.target as Button;
			if((onPlay as Button) == _play){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			
			var onQuit:Button = e.target as Button;
			if((onPlay as Button) == _quit){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "welcome"}, true));
			}
		}
		
		public function init():void{
			this.visible = true;
			this.addEventListener(Event.TRIGGERED, onClick);
		}
		
		public function tempHide():void{
			this.visible = false;
			trace("gameOver hidden");
			this.removeEventListener(Event.TRIGGERED, onClick);
		}
	}
}