package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import states.StateManager;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	[SWF(backgroundColor = "#003264", frameRate = "60", width = "500", height = "600")]
	[Frame(factoryClass = "Preloader")]
		
	public class Main extends Sprite 
	{
		
		private var stateManager:StateManager;				 		//State Manager
		
		public function Main():void 
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initStateManager();
			
		}
		
		private function initStateManager():void 
		{
			stateManager = new StateManager();
			addChild(stateManager);
		}

	}

}