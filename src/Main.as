package 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.StageVideo;
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
		
		private var video:StageVideo;
		
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
			
			stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, stage_stageVideoAvailability);
			
			var b:int;
			b = 7 << 2;
			b |= 0x1;
			trace(b);
			
			var c:int;
			c = b & 0x1;
			trace(c);
			
			var d:int;
			d = b >> 2;
			trace(d);
			
			var f:int;
			f = b ^ c;
			trace(f);
			
			var g:int;
			g = ~ c;
			trace(g);
		}
		
		private function stage_stageVideoAvailability(e:StageVideoAvailabilityEvent):void 
		{
			if(e.availability)
				video = stage.stageVideos[0];
				
			var camera:Camera = Camera.getCamera();
			if (video != null)
			{
				video.viewPort = new Rectangle(0, 0, 500, 600);
				video.attachCamera(camera);
			}
		}
		
		private function initStateManager():void 
		{
			stateManager = new StateManager();
			addChild(stateManager);
		}

	}

}