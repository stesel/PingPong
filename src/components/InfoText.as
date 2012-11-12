package components 
{
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.GradientGlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...Text Field
	 * @author Leonid Trofimchuk
	 */
	public class InfoText extends TextField 
	{
		private var format:TextFormat;
		private var gradientGlow:GradientGlowFilter;
		
		public function InfoText(size:int = 20, color:uint = 0xffd21e, bold:Boolean = false) 
		{
			format = new TextFormat();
			format.font = "Arial";
            format.color = color;
            format.size = size;
			format.align = "left";
			format.bold = bold;
			
			this.defaultTextFormat = format;
			this.selectable = false;
			this.multiline = true;
			this.antiAliasType = AntiAliasType.ADVANCED;
			this.autoSize = TextFieldAutoSize.LEFT;
			
			gradientGlow = new GradientGlowFilter();
			gradientGlow.distance = 0; 
			gradientGlow.angle = 45; 
			gradientGlow.colors = [0xfff201, 0x000000];
			gradientGlow.alphas = [0, 1]; 
			gradientGlow.ratios = [0, 255]; 
			gradientGlow.blurX = 2; 
			gradientGlow.blurY = 2; 
			gradientGlow.strength = 3;
			gradientGlow.quality = BitmapFilterQuality.HIGH;
			gradientGlow.type = BitmapFilterType.OUTER;
			this.filters = [gradientGlow];
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Methods
//
//-------------------------------------------------------------------------------------------------
		
		public function setText(text:String = null):void
		{
			this.text = text;
		}
		
	}

}