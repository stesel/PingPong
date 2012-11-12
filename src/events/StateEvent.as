package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class StateEvent extends Event 
	{
		static public const STATE_CHANGED:String = "stateChanged";
		
		public var onState:String;
		
		
		public function StateEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, onState:String = "empty") 
		{
			super(type, bubbles, cancelable);
			this.onState = onState;
		}
		
		override public function clone():Event
		{
			return new StateEvent(type, bubbles, cancelable, onState);
		}
		
		override public function toString():String
		{
			return formatToString("PromptEvent", "type", "bubbles", "cancelable", "eventPhase", "onState");
		}
		
	}

}