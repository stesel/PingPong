package events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class ButtonEvent extends Event 
	{
		static public const BUTTON_PRESSED:String = "ButtonPressed";
		
		public var label:String;
		
		public function ButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, label:String = "empty") 
		{
			super(type, bubbles, cancelable);
			this.label = label;
		}
		
		override public function clone():Event
		{
			return new ButtonEvent(type, bubbles, cancelable, label);
		}
		
		override public function toString():String
		{
			return formatToString("ButtonEvent", "type", "bubbles", "cancelable", "eventPhase", "label");
		}
	}

}