package game 
{
	import com.greensock.TweenMax;
	import components.InfoText;
	import events.GameEvent;
	import events.ModelEvent;
	import flash.display.Sprite;
    import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
    /**
	 * ... View component of MVC
	 * @author Leonid Trofimchuk
	 */
	public class View extends Sprite 
	{
		
		private var _model:Model;           						// Model
		private var _controller:Controller;         				// Controller
		
		private var _withSound:Boolean;								//Sound availible
		private var ball:Ball;										//Ball 
		private var player:Player;									//Player 
		private var cpu:CPU;										//CPU
		
		private var playerScore:InfoText;							//Player points
		private var cpuScore:InfoText;								//cpu points
		private var result:Object;									//Game results
		
        public function View(model:Model, controller:Controller)
		{
			this._model = model;									// Reference to the model
			this._controller = controller;							// Reference to the model
			
			if (stage)
				init(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initBall();
			initPlayer();
			initCPU();
			initResults();
			initListeners();
		}
		
//-------------------------------------------------------------------------------------------------
//
//  Methods
//
//-------------------------------------------------------------------------------------------------
		
		private function initBall():void 
		{
			ball = new Ball();
			ball.withSound = _withSound;
			ball.setPosition(stage.stageWidth / 2, stage.stageHeight / 2);
			addChild(ball);
		}
		
		private function initPlayer():void 
		{
			player = new Player(ball);
			addChild(player);
			player.setPosition(stage.stageWidth / 2, stage.stageHeight -  player.height / 2);
		}
		
		
		private function initCPU():void 
		{
			cpu = new CPU(ball);
			addChild(cpu);
			cpu.setPosition(stage.stageWidth / 2, player.height / 2);
		}
		
		private function initResults():void 
		{
			result = _model.result;
			//Player
			playerScore = new InfoText(30);
			playerScore.text = result["player"].toString();
			playerScore.x = 0;
			playerScore.y = stage.stageHeight - 2 * playerScore.height;
			addChild(playerScore);
			
			//CPU
			cpuScore = new InfoText(30);
			cpuScore.text = result["cpu"].toString();
			cpuScore.x = 0;
			cpuScore.y = cpuScore.height;
			addChild(cpuScore);
		}
		
		public function initListeners():void 
		{
			stage.addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_model.addEventListener(ModelEvent.SCORE_GHANGED, scoreGhanged);
			ball.addEventListener(GameEvent.BALL_MISSED, ball_ballMissed);
			Mouse.hide();
		}
		
		public function removeListeners():void 
		{
			stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_model.addEventListener(ModelEvent.SCORE_GHANGED, scoreGhanged);
			ball.removeEventListener(GameEvent.BALL_MISSED, ball_ballMissed);
			Mouse.show();
		}
		
		public function removeAll():void
		{
			removeListeners();
			while (this.numChildren > 0)
				removeChildAt(0);
			ball = null;
			playerScore = null;
			cpuScore = null;
		}
		
//--------------------------------------------------------------------------
//
//  Event handlers
//
//--------------------------------------------------------------------------
		
		private function enterFrame(e:Event):void 
		{
			ball.update();
			player.update();
			cpu.update();
		}	
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				removeListeners();
				_controller.dispatchEvent(new GameEvent(GameEvent.CALL_MENU));	
			}
		}
		
		private function scoreGhanged(e:ModelEvent):void 
		{
			result = e.result;
			playerScore.text = result["player"].toString();
			cpuScore.text = result["cpu"].toString();
		}
		
		private function ball_ballMissed(e:GameEvent):void 
		{
			_controller.onBallMissed(e.title);
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
			if (ball)
				ball.withSound = _withSound;
		}
		
    }

}