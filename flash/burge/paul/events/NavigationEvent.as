package burge.paul.events
{
	import starling.events.Event;
	
	public class NavigationEvent extends Event
	{
		
		public static const CHANGE_SCREEN:String = "changeScreen";
		public var args:Object;
		
		public function NavigationEvent(type:String, _args:Object = null, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
			this.args = _args;
		}
	}
}