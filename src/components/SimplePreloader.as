package components {
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 * This class makes preloader
	 */
	
	public class SimplePreloader extends Sprite
	{
		private static const PRELOADER_WIDTH:int = 82;	//Preloader WIDTH
		private static const PRELOADER_HEIGHT:int = 15;	//Preloader HEIGHT
		private static const BAR_WIDTH:int = 80;		//Bar WIDTH
		private static const BAR_HEIGHT:int = 13;		//Bar WIDTH
		private static const BAR_X_OFFSET:int = 1;		//Bar X offset
		private static const BAR_Y_OFFSET:Number = 1.5;	//Bar Y offset
		private var preloader:Sprite;					//Preloader Sprite
		private var bar:Sprite;							//Progress Bar
		
		public function SimplePreloader() 
		{
			
			initPreloader();
		}
		
		/**
		 * Initialization
		 */
		private function initPreloader():void
		{
			//Preloader Sprite Initialization
			preloader = new Sprite();
			preloader.graphics.clear();
			preloader.graphics.lineStyle(1, 0xffdc16);
			preloader.graphics.beginFill(0xff1616, 0.9);
			preloader.graphics.drawRect(0, 0, PRELOADER_WIDTH, PRELOADER_HEIGHT);
			preloader.graphics.endFill();
			addChild(preloader);
			preloader.height
			//Progress Bar Initialization
			bar = new Sprite();
			bar.graphics.clear();
			bar.x = BAR_X_OFFSET;
			bar.y = BAR_Y_OFFSET;
			preloader.addChild(bar);
		}
		
		public function setBar(value:Number):void
		{
			var _width:Number = value * BAR_WIDTH;
			bar.graphics.clear();
			bar.graphics.beginFill(0x05FF9F, 1);
			bar.graphics.drawRect(0, 0, _width, BAR_HEIGHT);
			bar.graphics.endFill();
		}
		
	}

}