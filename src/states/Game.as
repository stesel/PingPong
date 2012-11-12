package states
{
	import events.GameEvent;
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
	public class Game extends Sprite implements IState{

		private var controller:Controller;
		private var model:Model;
		private var view:View;
		private var _result:String;
		private var blur:BlurFilter;
		
		private var _withSound:Boolean;
		
		public function Game() 
		{
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
            model = new Model();
			controller = new Controller(model);
			view = new View(model, controller);
			view.withSound = _withSound;
			addChild(view);
			controller.addEventListener(GameEvent.CALL_MENU, controller_callMenu);
		}
		
		public function leaveState():void 
		{
			controller.stopGame();
			removeGame();
			removeChild(view);
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
		
		public function get result():String
		{
			return _result;
		}
	}

}