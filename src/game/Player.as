package game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class Player extends Sprite implements IGameElement
	{
		private var x0:Number = 0;					//Previous X
		private var dX:Number;						//Delta X
		
		private var minX:Number;					//Min X
		private var maxX:Number;					//Max X
		
		private var player:Player_graphic;			//Player Graphic
		private var ball:Ball;						//Ball reference
		
		public function Player(ball:Ball = null) 
		{
			this.ball = ball;
			if (stage)	
				init(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			player = new Player_graphic();
			addChild(player);
			
			minX = this.width / 2;
			maxX = this.stage.stageWidth - this.width / 2;
		}
//-------------------------------------------------------------------------------------------------
//
//  Interface methods
//
//-------------------------------------------------------------------------------------------------
		
		public function update():void
		{
			this.x = stage.mouseX;
			
			//Restriction
			if (this.x < minX)
				this.x = minX;
				
			if (this.x > maxX)
				this.x = maxX;
				
			//delta X
			dX = (this.x - x0) * 0.5;
			x0 = this.x;
			
			checkCollision();
		}
		
		public function setPosition(x:int = 0, y:int = 0):void 
		{
			this.x = x;
			this.y = y;
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Methods
//
//-------------------------------------------------------------------------------------------------	
		
		private function checkCollision():void 
		{
			if (this.hitTestObject(ball) && ball.speedY > 0)
			{
				ball.setDX(dX);
			}
		}
		
	}

}