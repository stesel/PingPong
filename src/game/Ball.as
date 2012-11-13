package game 
{
	import components.Sounds;
	import events.GameEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...This class discribes a Ball in the game
	 * @author Leonid Trofimchuk
	 */
	public class Ball extends Sprite implements IGameElement
	{
		private static const SPEED:int = 5; 		//Ball Speed
		private static const SPEED_MAX:int = 10; 	//Ball Max Speed
		static private const START_OFFSET:int = 30;	//Offset on Start
		
		private var _speedX:Number = 0;				//Speed X
		private var _speedY:Number = 0;				//Speed Y
		
		private var minX:Number;					//Min X
		private var minY:Number;					//Min Y
		private var maxX:Number;					//Max X
		private var maxY:Number;					//Max Y
		
		private var ball:Ball_graphic;				//Ball Graphic
		private var sounds:Sounds;					//Sound
		private var _withSound:Boolean;				//Sound Available
		
		public function Ball() 
		{
			if (stage)	
				init(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			ball = new Ball_graphic();
			addChild(ball);
			
			minX = this.width / 2;
			minY = this.height / 2;
			maxX = this.stage.stageWidth - this.width / 2;
			maxY = this.stage.stageHeight - this.height / 2;
			
			_speedY = SPEED;
			
			sounds = new Sounds();
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Interface Methods
//
//-------------------------------------------------------------------------------------------------
		
		public function update():void
		{
			//Change Position
			this.x += _speedX;
			this.y += _speedY;
			
			//Bounce
			if (this.x < minX && _speedX < 0)
			{
				_speedX = - _speedX;
				onSound();
			}
			
			//Bounce	
			if (this.x > maxX && _speedX > 0)
			{
				_speedX = - _speedX;
				onSound();
			}
			
			//CPU Missing	
			if (this.y < minY)
			{
				this.x = stage.stageWidth / 2;
				this.y = this.height / 2 + START_OFFSET;
				_speedX = 0;
				_speedY = SPEED;
				dispatchEvent(new GameEvent(GameEvent.BALL_MISSED, false, false, GameEvent.CPU_MISS));
			}
			
			//Player Missing	
			if (this.y > maxY)
			{
				this.x = stage.stageWidth / 2;
				this.y = stage.stageHeight - this.height / 2 - START_OFFSET;
				_speedX = 0;
				_speedY = - SPEED;
				dispatchEvent(new GameEvent(GameEvent.BALL_MISSED, false, false, GameEvent.PLAYER_MISS));
			}
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
		
		public function setDX(dx:Number = 0):void 
		{
			_speedX += dx;
			if (_speedX > SPEED_MAX)
				_speedX = SPEED_MAX;
			if (_speedX < - SPEED_MAX)
				_speedX = - SPEED_MAX;
			_speedY = - _speedY;
			onSound();
		}
		
		private function onSound():void
		{
			if(_withSound)
			sounds.onCollision();
		}
		
//--------------------------------------------------------------------------
//
//  Getters and Setters
//
//--------------------------------------------------------------------------
		
		public function get withSound():Boolean
		{
			return _withSound;
		}
		
		public function set withSound(value:Boolean):void
		{
			_withSound = value;
		}
		
		public function get speedX():Number
		{
			return _speedX;
		}
		
		public function set speedX(value:Number):void
		{
			_speedX = value;
		}
		
		public function get speedY():Number
		{
			return _speedY;
		}
		
		public function set speedY(value:Number):void
		{
			_speedY = value;
		}
		
	}

}