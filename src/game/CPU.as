package game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class CPU extends Sprite implements IGameElement 
	{
		private static const SPEED:int = 4; 		//CPU Speed
		private static const CPU_SENS:int = 30; 	//CPU Sensitivity
		private static const CPU_FREEZE:int = 30; 	//CPU Freeze Value
		private var speedX:Number = 0;				//Speed X
		private var x0:Number = 0;					//Previous X
		private var dX:Number;						//Delta X
		private var minX:Number;					//Min X
		private var maxX:Number;					//Max X
		
		private var cpu:CPU_graphic;				//CPU Graphic
		private var ball:Ball;						//Ball reference
		
		public function CPU(ball:Ball = null) 
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
			
			cpu = new CPU_graphic();
			addChild(cpu);
			
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
			if ((this.x ) < (ball.x - CPU_SENS))
				speedX = SPEED;
			if ((this.x ) > (ball.x + CPU_SENS))
				speedX = - SPEED;
			if (Math.abs(this.x - ball.x) < 4)
				speedX = 0;
				
			this.x += speedX;	
				
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
			if (this.hitTestObject(ball) && ball.speedY < 0)
			{
				ball.setDX(dX);
			}
		}
		
	}

}