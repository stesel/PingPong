package states
{
	import events.GameEvent;
	import events.StateEvent;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.fscommand;
	import flash.utils.setTimeout;
	/**
	 * ...	State Manager
	 * @author Leonid Trofimchuk
	 */
	public class StateManager extends Sprite
	{
		
		private var gameSound:Boolean = true;	//Sound in game
		private var resume:Boolean = false;		//Resume in menu
		
		private var _game:Game;					//Game State
		private var _menu:Menu;					//Menu State 
		private var result:String;							
		
		public function StateManager() 
		{
			if (stage)
				init(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initMenu();
		}
			
//-------------------------------------------------------------------------------------------------
//
//	Methods Definition
//
//-------------------------------------------------------------------------------------------------	
			
		private function initMenu():void 
		{
			_menu = new Menu(gameSound, resume);
			_menu.addEventListener(StateEvent.STATE_CHANGED, menu_stateChanged);
			addChild(_menu);
		}
			
		private function removeMenu():void
		{
			_menu.removeEventListener(StateEvent.STATE_CHANGED, menu_stateChanged);
			removeChild(_menu);
			_menu = null;
		}
			
		private function setSound():void
		{
			gameSound = !gameSound;
			if (_game != null)
				_game.withSound = gameSound;
		}
		
		private function leaveGame():void
		{
			if (_game != null)
			{
				_game.leaveState();
				removeChild(_game);
				_game = null;
			}
		}
		
		private function initGame():void
		{	
			leaveGame();
			_game = new Game();
			addChild(_game);
			_game.addEventListener(GameEvent.CALL_MENU, game_callMenu);
			_game.withSound = gameSound;
		}
			
		private function closeApp():void 
		{
			fscommand("quit");
		}
		
//-------------------------------------------------------------------------------------------------
//
//	Event Handlers Definition
//
//-------------------------------------------------------------------------------------------------	
		
		private function game_callMenu(e:GameEvent):void 
		{
			if (_menu != null)
				return;
			_game.deactivateGame();
			resume = true;
			initMenu();
		}
			
		private function menu_stateChanged(e:StateEvent):void 
		{
			switch (e.onState)
			{
				case "RESUME":
					_game.activateGame();
					removeMenu();
					break;
				case "NEW GAME":
					initGame();
					removeMenu();
					break;
				case "EXIT":
					closeApp();
				case "soundSwitch":
					setSound();
					break;
				default:
					closeApp();
			}
		}
		
	}

}