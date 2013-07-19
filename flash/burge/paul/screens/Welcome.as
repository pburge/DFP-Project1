package burge.paul.screens
{
	import burge.paul.events.NavigationEvent;
	
	import com.greensock.TweenLite;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Welcome extends Sprite
	{
		private var _bg:Image;
		private var _ship:Image;
		
		private var _playBtn:Button;
		private var _aboutBtn:Button;
		
		private var _gameScreen:inGame;
		
		
		public function Welcome()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);			
			drawScreen();
		}
		
		private function drawScreen():void
		{
			_bg = new Image(Assets.getTexture("WelcomeBackground"));
			this.addChild(_bg);
			
			_ship = new Image(Assets.getAtlas().getTexture("welcomePlayerShip"));
			this.addChild(_ship);
			_ship.x = -_ship.width;
			
			_playBtn = new Button(Assets.getAtlas().getTexture("WelcomePlayBtn"));
			this.addChild(_playBtn);
			_playBtn.x = 500;
			_playBtn.y = 100;
			
			_aboutBtn = new Button(Assets.getAtlas().getTexture("WelcomeAboutBtn"));
			this.addChild(_aboutBtn);
			_aboutBtn.x = 590;
			_aboutBtn.y = 258;
			
			this.addEventListener(Event.TRIGGERED, onMainClick);
		}
		
		private function onMainClick(e:Event):void
		{
			var onPlayClick:Button = e.target as Button;
			if((onPlayClick as Button) == _playBtn){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			}
			
			var onAboutClick:Button = e.target as Button;
			if((onAboutClick as Button) == _aboutBtn){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "about"}, true));
			}
		}
		
		public function init():void{
			this.visible = true;
			_ship.x = -_ship.width;
			
			TweenLite.to(_ship,2,{x: 0});
			
			this.addEventListener(Event.ENTER_FRAME, shipAnimation);
		}
		
		private function shipAnimation():void
		{
			var currentDate:Date = new Date();
			_ship.y = 50 + (Math.cos(currentDate.getTime() * 0.002) * 25);
			_playBtn.y = 120 + (Math.cos(currentDate.getTime() * 0.002) * 10); //100
			_aboutBtn.y = 300 + (Math.cos(currentDate.getTime() * 0.002) * 10);

		}
		
		public function tempHide():void{
			if(this.hasEventListener(Event.ENTER_FRAME)){
				this.removeEventListener(Event.ENTER_FRAME, shipAnimation);
			}
			
			this.visible = false;
		}
	}
}