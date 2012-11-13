package game 
{
	import events.GameEvent;
	import events.ModelEvent;
    import flash.events.EventDispatcher;
	 /**
     * ...Model component of MVC
     * @author Leonid Trofimchuk
     */
    public class Model extends EventDispatcher 
	{
		private var _result: Object;					//Game Scores
		
		public function Model(result:Object = null) 
		{
			this._result = result;
            init();
        }
		
//-------------------------------------------------------------------------------------------------
//
//  Methods
//
//-------------------------------------------------------------------------------------------------
		
		private function init():void 
		{
			if (_result == null)
			{
				_result = { };
				_result["player"] = 0;
				_result["cpu"] = 0;
			}
			dispatchEvent(new ModelEvent(ModelEvent.SCORE_GHANGED, false, false, result));
		}
		
		
		public function onBallMissed(title:String):void 
		{
			switch (title)
			{
				case GameEvent.PLAYER_MISS:
					_result["cpu"] ++;
					break;
				case GameEvent.CPU_MISS:
					_result["player"] ++;
					break;
			}
			
			dispatchEvent(new ModelEvent(ModelEvent.SCORE_GHANGED, false, false, result));
		}
		
//--------------------------------------------------------------------------
//
//  Getters
//
//--------------------------------------------------------------------------
		
		public function get result():Object
		{
			return _result;
		}
		
		public function set result(value:Object):void
		{
			_result = value;
		}
    }

}