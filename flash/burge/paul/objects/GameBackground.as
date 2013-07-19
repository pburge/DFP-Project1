package burge.paul.objects
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameBackground extends Sprite
	{
		private var _bgLayer1:BgLayer;
		private var _bgLayer2:BgLayer;
		
		private var _speed:Number = 0
		
		public function GameBackground()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		protected function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_bgLayer1 = new BgLayer(1);
			_bgLayer1.bgLoop = 0.5;
			this.addChild(_bgLayer1);
						
			_bgLayer2 = new BgLayer(2);
			_bgLayer2.bgLoop = 1;
			this.addChild(_bgLayer2);
			
			this.addEventListener(Event.ENTER_FRAME, layerScroll);
		}
		
		protected function layerScroll(e:starling.events.Event):void
		{
			_bgLayer1.x -= Math.ceil(_speed * _bgLayer1.bgLoop);
			
			if(_bgLayer1.x < -stage.stageWidth){
				_bgLayer1.x = 0;
			}
			
			_bgLayer2.x -= Math.ceil(_speed * _bgLayer2.bgLoop);

			if(_bgLayer2.x < -stage.stageWidth){
				_bgLayer2.x = 0;
			}
		}
		
		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
		}

	}
}