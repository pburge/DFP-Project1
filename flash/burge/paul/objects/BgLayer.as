package burge.paul.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class BgLayer extends Sprite
	{
		private var _image1:Image;
		private var _image2:Image;
		
		private var _layer:int;
		private var _bgLoop:Number;
		
		public function BgLayer(layer:int)
		{
			super();
			this._layer = layer;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			if(_layer == 1){
				_image1 = new Image(Assets.getTexture("BgLayer" + _layer));
				_image2 = new Image(Assets.getTexture("BgLayer" + _layer));
			}
			else{
				_image1 = new Image(Assets.getAtlas().getTexture("bgLayer" + _layer));
				_image2 = new Image(Assets.getAtlas().getTexture("bgLayer" + _layer));
			}
			
			_image1.x = 0;
			_image1.y = stage.stageHeight - _image1.height;
			
			_image2.x = _image2.width;
			_image2.y = _image1.y;
			
			this.addChild(_image1);
			this.addChild(_image2);
		}
		
		public function get bgLoop():Number
		{
			return _bgLoop;
		}

		public function set bgLoop(value:Number):void
		{
			_bgLoop = value;
			
		}

	}
}