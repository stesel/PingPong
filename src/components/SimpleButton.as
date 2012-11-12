package components 
{
	import events.ButtonEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.GradientGlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class SimpleButton extends Sprite 
	{
		private var format:TextFormat;									//Text Format					
		private var buttonText:TextField;								//Text Field
		private var strokeGlow:GradientGlowFilter;						//Gradient Glow for stroke of text
		private var gradientGlow:GradientGlowFilter;					//Gradient Glow for CLICK 
		private var blurFilter:BlurFilter;								//Blur for text
		private var filterArray:Array;									//Filter Array
		private var glowFlag:Boolean;									//Glow Flag
		private var intervalId:uint;									//Interval ID for Gradient Glow switch
		private var delay:int = 300;									//Filter Delay 
		private var label:String;
		/**
		 * 
		 * @param	text - Button Name
		 * Constructor
		 */
		public function SimpleButton(text:String = "empty") 
		{
			
			label = text;
				
			//Text Format Initialization
            var format:TextFormat = new TextFormat();
            format.font = "Times New Roman";
            format.color = 0xffffff;
            format.size = 35;
			format.align = "center";
			format.bold = true;
			
			//Text Field Initialization
			buttonText = new TextField();
			buttonText.defaultTextFormat = format;
			buttonText.selectable = false;
			buttonText.multiline = true;
			buttonText.antiAliasType = AntiAliasType.ADVANCED;
			buttonText.htmlText = text;
			
			//Stroke Glow Initialization
			strokeGlow = new GradientGlowFilter(); 
			strokeGlow.distance = 0; 
			strokeGlow.angle = 45; 
			strokeGlow.colors = [0x000000, 0x000000];
			strokeGlow.alphas = [0, 1]; 
			strokeGlow.ratios = [0, 255]; 
			strokeGlow.blurX = 2; 
			strokeGlow.blurY = 2; 
			strokeGlow.strength = 3;
			strokeGlow.quality = BitmapFilterQuality.HIGH;
			strokeGlow.type = BitmapFilterType.OUTER;
			
			//Gradient Glow Initialization
			gradientGlow = new GradientGlowFilter(); 
			gradientGlow.distance = 0; 
			gradientGlow.angle = 45; 
			gradientGlow.colors = [0x000000, 0xffd21e];
			gradientGlow.alphas = [0, 1]; 
			gradientGlow.ratios = [0, 255]; 
			gradientGlow.blurX = 5; 
			gradientGlow.blurY = 5; 
			gradientGlow.strength = 2;
			gradientGlow.quality = BitmapFilterQuality.HIGH;
			gradientGlow.type = BitmapFilterType.OUTER;
			
			//Blur Initialization
			blurFilter = new BlurFilter(1, 1, 2);
			
			//Filter Array Initialization
			filterArray = new Array(blurFilter, strokeGlow);
			
			//Add Filter Array to Text
			buttonText.filters = filterArray;
				
			//Text Position	
			buttonText.x = - buttonText.textWidth / 2;
			buttonText.y = - buttonText.textHeight / 2;
			buttonText.width = buttonText.textWidth + 5;
			buttonText.height = buttonText.textHeight + 5;
			
			this.addChild(buttonText);
			
			//Draw Round Background
			this.graphics.lineStyle(2, 0xffd21e);
			this.graphics.beginFill(0xffffff,0.8);
			this.graphics.drawRoundRect(buttonText.x - 5, buttonText.y - 3, buttonText.textWidth + 13, buttonText.textHeight + 9, 15);
			
			//Set Button Mode
			this.buttonMode = true;
			this.mouseChildren = false;
			
			
			//Add Listener
			this.addEventListener(MouseEvent.CLICK, this_click);
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Methods
//
//-------------------------------------------------------------------------------------------------
		
		/**
		 *Add Glow 
		 */
		public function onGlow(): void 
		{
			this.filters = [gradientGlow];
			glowFlag = true;
		}
		
		/**
		 *Remove Glow
		 */
		public function offGlow(): void 
		{
			dispatchEvent(new ButtonEvent(ButtonEvent.BUTTON_PRESSED,false, false, label));
			
			this.filters = null;
			glowFlag = false;
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Events handlers
//
//-------------------------------------------------------------------------------------------------
		
		/**
		 * 
		 * @param	e Mouse Event
		 *  Click Handler
		 */
		private function this_click(e:MouseEvent):void 
		{	
			if(!glowFlag)
				onGlow();
			else
				clearTimeout(intervalId);
				
			intervalId = setTimeout(offGlow, delay);
		}
		
		
	}

}