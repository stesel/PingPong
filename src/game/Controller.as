package game 
{
	import events.GameEvent;
	import events.ModelEvent;
	import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;
	import flash.display.Sprite;
    /**
	 * ...Controller component of MVC
	 * @author Leonid Trofimchuk
	 */
	public class Controller extends EventDispatcher 
	{
		private var _model:Model;
		
		public function Controller(model:Model = null) 
		{
			this._model = model;
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Methods
//
//-------------------------------------------------------------------------------------------------
		
		public function stopGame():void 
		{
			this._model = null;
		}
		
		public function menuKeyPressed():void 
		{
			this.dispatchEvent(new GameEvent(GameEvent.CALL_MENU));
		}
		
		public function onBallMissed(title:String):void 
		{
			_model.onBallMissed(title);
		}
		
		
//-------------------------------------------------------------------------------------------------
//
//  Event handlers
//
//-------------------------------------------------------------------------------------------------
		
		
    }
 
}