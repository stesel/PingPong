package states
{
	import events.GameEvent;
	import events.ModelEvent;
	import events.StateEvent;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.system.fscommand;
	import flash.utils.setTimeout;
	/**
	 * ...	State Manager
	 * @author Leonid Trofimchuk
	 */
	public class StateManager extends Sprite
	{
		private var localData:SharedObject;		//Local Data with Score Proggres
		private var gameSound:Boolean = true;	//Sound in game
		private var resume:Boolean = true;		//Resume in menu
		
		private var _game:Game;					//Game State
		private var _menu:Menu;					//Menu State 
		private var result:Object;							
		
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
			
			result = { };
			
			localData = SharedObject.getLocal("result");
			
			if ((!localData.data.player && !localData.data.cpu) || (localData.data.player == 0 && localData.data.cpu == 0))
			{
				localData.data.player = 0;
				localData.data.cpu = 0;
				resume = false;
			}
			else 
				gameSound = localData.data.sound;
			result["player"] = localData.data.player;
			result["cpu"] = localData.data.cpu;
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
				
			localData.data.sound = gameSound;
			localData.flush();
		}
		
		private function leaveGame():void
		{
			if (_game != null)
			{
				_game.removeEventListener(ModelEvent.SCORE_GHANGED, game_scoreGhanged);
				_game.removeEventListener(GameEvent.CALL_MENU, game_callMenu);
				_game.leaveState();
				removeChild(_game);
				_game = null;
			}
		}
		
		private function initGame():void
		{	
			leaveGame();
			_game = new Game(result);
			addChild(_game);
			_game.addEventListener(ModelEvent.SCORE_GHANGED, game_scoreGhanged);
			_game.addEventListener(GameEvent.CALL_MENU, game_callMenu);
			_game.withSound = gameSound;
		}
			
		private function resetProgres():void 
		{
			result["player"] = 0;
			result["cpu"] = 0;
			localData.data.player = result["player"];
			localData.data.cpu = result["cpu"];
			localData.flush();
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
					if(_game != null)
						_game.activateGame();
					else
						initGame();
					removeMenu();
					break;
				case "NEW GAME":
					resetProgres();
					initGame();
					removeMenu();
					break;
				case "EXIT":
					closeApp();
					break;
				case "soundSwitch":
					setSound();
					break;
				default:
					closeApp();
			}
		}
		
		private function game_scoreGhanged(e:ModelEvent):void 
		{
			result = e.result;
			localData.data.player = result["player"];
			localData.data.cpu = result["cpu"];
			localData.flush();
		}
		
	}

}