package
{
	import burge.paul.events.NavigationEvent;
	import burge.paul.screens.About;
	import burge.paul.screens.GameOver;
	import burge.paul.screens.Welcome;
	import burge.paul.screens.inGame;
	
	import flash.ui.Mouse;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		
		private var _welcomeScreen:Welcome;
		private var _gameScreen:inGame;
		private var _aboutScreen:About;
		private var _gameOverScreen:GameOver;
		
		public function Game()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{			
			this.addEventListener(burge.paul.events.NavigationEvent.CHANGE_SCREEN, onChange);
			
			_gameScreen = new inGame();
			this.addChild(_gameScreen);
			_gameScreen.tempHide();
			
			_welcomeScreen = new Welcome();
			this.addChild(_welcomeScreen);
			_welcomeScreen.init();
			
			_aboutScreen = new About();
			this.addChild(_aboutScreen);
			_aboutScreen.tempHide();
			
			_gameOverScreen = new GameOver();
			this.addChild(_gameOverScreen);
			_gameOverScreen.tempHide();
		}		
		
		private function onChange(e:NavigationEvent):void
		{
			switch(e.args.id){
				case "play":
					_gameScreen.init();
					_welcomeScreen.tempHide();
					_gameOverScreen.tempHide();
					
					trace("playing game.as");
					break;
			}
			switch(e.args.id){
				case "about":
					_welcomeScreen.tempHide();
					_aboutScreen.init();
					trace("about game.as");
			}
			switch(e.args.id){
				case "welcome":
					_gameOverScreen.tempHide();
					_aboutScreen.tempHide();
					_welcomeScreen.init();
					trace("welcome game.as");
			}
			switch(e.args.id){
				case "gameOver":
					
					_gameScreen.tempHide();
					_gameOverScreen.init();
					trace("gameover game.as");
					Mouse.show();
			}
		}
		
	}
}