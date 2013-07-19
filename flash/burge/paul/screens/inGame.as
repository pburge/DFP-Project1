package burge.paul.screens
{
	import burge.paul.events.NavigationEvent;
	import burge.paul.objects.Enemy;
	import burge.paul.objects.GameBackground;
	import burge.paul.objects.Player;
	import burge.paul.score.Score;
	
	import flash.display3D.IndexBuffer3D;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.utils.getTimer;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	
	public class inGame extends Sprite
	{
		private var _hero:Player;
		private var _newMines:Enemy;
		private var _minesArray:Array;
		private var _numMine:int = 0;
		private var _bg:GameBackground;
		private var _touch:Touch;
		private var _moveX:Number;
		private var _moveY:Number;
		
		private var _timePrev:Number;
		private var _timeCurrent:Number;
		private var _timePassed:Number;
		
		private var _gameState:String;
		private var _startBtn:Button;
		
		private var _shipSpeed:Number;
		private var _hitObstacle:Number = 0;
		
		private const MIN_SPEED:Number = 650;
		
		private var _scoreDistance:int = 0;
		private var _obstacleGapCount:int;
				
		private var _bcUpdate:int = 0;
		private var _score:Score;
		private var _scoreUpdate:int;
		private var _tf:TextField;
		private var _lives:Image;
		private var _livesArray:Array;
		private var _hits:int = 4;
		
		public var _tryAgain:int = 0;

		private var _gameOver:GameOver;
		
		public function inGame()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			drawGame();
			_tryAgain = 1;
		}
		
		public function drawGame():void
		{
			
			_minesArray = [];
			_livesArray = [];
			
			_bg = new GameBackground();
			this.addChild(_bg);
			
			_hero = new Player();
			this.addChild(_hero);
			_hero.x = stage.stageWidth/2;
			_hero.y = stage.stageHeight/2;
			
			_score = new Score;
			this.addChild(_score);
			_score.x = 0;
			_score.y = 0;
			
			for(var i:int=0;i<5;i++){
				_lives = new Image(Assets.getAtlas().getTexture("LifeStar"));
				this.addChild(_lives);
				_lives.x = 95 + (_lives.width * i);
				_lives.y = 70;
				_livesArray.push(_lives);
			}
			
			_tf = new TextField(100,35,"0");
			_tf.fontName = "Red October";
			_tf.fontSize = 20;
			_tf.x = 105;
			_tf.y = 15;
			this.addChild(_tf);
			
			_startBtn = new Button(Assets.getAtlas().getTexture("WelcomePlayBtn"));
			_startBtn.x = stage.stageWidth * .5 - _startBtn.width * .5;
			_startBtn.y = stage.stageHeight * .5 - _startBtn.height * .5;
			this.addChild(_startBtn);
			
			_gameOver = new GameOver();
			this.addChild(_gameOver);
			_gameOver.tempHide();
						
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if (touch){
				_moveX = touch.globalX;
				_moveY = touch.globalY;
				_hero.x = _moveX;
				_hero.y = _moveY;
			}
		}
		
		
		private function onStartBtnClick(e:Event):void
		{
			_startBtn.visible = false;
			_startBtn.removeEventListener(Event.TRIGGERED, onStartBtnClick);

			Mouse.hide();
			launchHero();
			
		}
		
		private function launchHero():void{
			this.addEventListener(Event.ENTER_FRAME, onFrame);
			stage.addEventListener(TouchEvent.TOUCH,onTouch);

		}
		
		private function onFrame(e:Event):void
		{
			onTick();
			update();
		}
		
		private function onTick():void
		{
			switch(_gameState){
				case "idle":
					if(_hero.x < stage.stageWidth * 0.5 * 0.5){
						_hero.x += ((stage.stageWidth * 0.5 * 0.5) - _hero.x) *.05;
						_hero.y = stage.stageHeight * 0.5;
						
						_shipSpeed += (MIN_SPEED - _shipSpeed) * 0.05;
						_bg.speed = _shipSpeed * _timePassed;
					}else{
						_gameState = "flying";
					}
					
					break;
				case "flying":
					
					_shipSpeed -= (_shipSpeed - MIN_SPEED) * 0.01;
					_bg.speed = _shipSpeed * _timePassed;
					
					_scoreDistance += _shipSpeed * _timePassed * 0.1;
										
					break;
				case "gameOver":
					
					tempHide();
					_gameOver.init();
					Mouse.show();
					
					gameOver();
					
					this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "gameOver"}, true));

					this.removeEventListener(Event.ENTER_FRAME, onFrame);
					this.removeEventListener(Event.ENTER_FRAME, checkFrames);
					break;
			}
				
		}
		
		private function gameOver():void
		{
			_gameOver.visible = false;
		}
		
		private function update():void
		{
			_numMine++;
			_scoreUpdate++;
			
			if(_numMine/2 == 100){
				_newMines = new Enemy();
				addChild(_newMines);
				_newMines.x = Math.floor(Math.random()+810);
				_newMines.y = Math.floor(Math.random()*600);
				_minesArray.push(_newMines);
				_numMine = 0;
				_bcUpdate++;
			}
						
			
			for each(var block:Enemy in _minesArray){
				block.move();
				
				var radius : int = block.getRadius();
				var xDiff : int = _hero.x - block.x;
				var yDiff : int = _hero.y - block.y;
				
				var a : int = xDiff * xDiff;
				var b : int = yDiff * yDiff;
				var ab : int = a+b;
				var c : Number = Math.sqrt(ab);
				
				if (c < 32)
				{
					if(_livesArray.length > 0)
					{
						this.removeChild(_livesArray.pop());
						removeChild(block);
						_minesArray.splice(_minesArray.indexOf(block), 1);
					}
				}
			}
			
			_tf.text = _scoreUpdate.toString();
			
			if(_livesArray.length <= 0){
				_gameState = "gameOver";
			}
		}
		
		public function tempHide():void{
			this.visible = false;
		}
		
		public function init():void{
			this.visible = true;
			this.addEventListener(Event.ENTER_FRAME, checkFrames);
			
			_hero.x = -stage.stageWidth;
			_hero.y = stage.stageHeight * .5;
			
			_gameState = "idle";
			
			trace("ingame.as", _gameState);

			
			_shipSpeed = 0;
			_hitObstacle = 0;
			
			_startBtn.addEventListener(Event.TRIGGERED, onStartBtnClick);

			_bg.speed = 0;
			_obstacleGapCount = 0;
			
			_gameOver.tempHide();
						
		}
		
		private function checkFrames(e:Event):void
		{
			_timePrev = _timeCurrent;
			_timeCurrent = getTimer();
			
			_timePassed = (_timeCurrent - _timePrev) * 0.001;
			
		}
		
		
	}
}	