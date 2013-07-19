package burge.paul.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Enemy extends Sprite
	{
		private var _enemyShip:Image;
		private var _speedX:Number = 0;
//		private var _radius : Number = 0;
		
		public function Enemy()
		{
			super();
			position();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			createEnemies();
		}
		
		private function createEnemies():void
		{
			_enemyShip = new Image(Assets.getTexture("Enemy"));
			
//			_enemyShip.x = Math.ceil(-_enemyShip.width/2);
//			_enemyShip.y = Math.ceil(-_enemyShip.height/2);
			
			this.addChild(_enemyShip);
		}
		
		private function position():void
		{
			_speedX = 10;
			
			this.x = 820;
			this.y = Math.floor(Math.random()*600);
		}
		
		public function move():void
		{
			this.x -= _speedX;
			
			if(this.x < -5)	{ goBack(); }
		}
		
		public function goBack():void
		{
			position();
		}
		
		public function getRadius() : int
		{
			return this.width*0.5;
		}
	}
}