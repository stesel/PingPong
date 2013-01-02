package states
{
	import events.GameEvent;
	import events.ModelEvent;
    import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import game.Controller;
	import game.Model;
	import game.View;
		
	/**
	 * ...Game State
	 * @author Leonid Trofimchuk
	 */
	public class Game extends Sprite implements IState
	{

		private var controller:Controller;
		private var model:Model;
		private var view:View;
		private var _result:Object;
		private var blur:BlurFilter;
		
		private var _withSound:Boolean;
		
		public function Game(result:Object = null) 
		{
			_result = result;
			enterState();
			initBlur();
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Interface Methods definition
//
//-------------------------------------------------------------------------------------------------
		
		public function enterState():void 
		{
            model = new Model(_result);
			controller = new Controller(model);
			view = new View(model, controller);
			view.withSound = _withSound;
			addChild(view);
			model.addEventListener(ModelEvent.SCORE_GHANGED, model_scoreGhanged);
			controller.addEventListener(GameEvent.CALL_MENU, controller_callMenu);
		}
		
		public function leaveState():void 
		{
			controller.stopGame();
			removeGame();
			removeChild(view);
			model.removeEventListener(ModelEvent.SCORE_GHANGED, model_scoreGhanged);
			controller.removeEventListener(GameEvent.CALL_MENU, controller_callMenu);
			model = null;
			controller = null;
			view = null;
		}
		
//-------------------------------------------------------------------------------------------------
//
//	Methods definition
//
//-------------------------------------------------------------------------------------------------
		
		private function initBlur():void 
		{
			blur = new BlurFilter(); 
			blur.blurX = 6; 
			blur.blurY = 6; 
			blur.quality = BitmapFilterQuality.LOW;
		}
		public function activateGame():void
		{
			view.initListeners();
			view.filters = null;
		}
		
		public function deactivateGame():void
		{
			view.removeListeners();
			view.filters = [blur];
		}
		
		private function removeGame():void
		{
			view.removeAll();
		}

//-------------------------------------------------------------------------------------------------
//
//  Events handlers
//
//-------------------------------------------------------------------------------------------------
		
		private function controller_callMenu(e:GameEvent):void 
		{
			this.dispatchEvent(new GameEvent(GameEvent.CALL_MENU));
		}
		
		private function model_scoreGhanged(e:ModelEvent):void 
		{
			dispatchEvent(e);
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Getters and Setters
//
//-------------------------------------------------------------------------------------------------
		
		public function get withSound():Boolean
		{
			return _withSound;
		}
		
		public function set withSound(value:Boolean):void
		{
			_withSound = value;
			view.withSound = _withSound;
		}
		
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