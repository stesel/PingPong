package components 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ... Play sounds
	 * @author Leonid Trofimchuk
	 */
	public class Sounds extends	EventDispatcher
	{
		[Embed(source = "../../lib/sounds/SoundCollision.mp3")]		//Embed Collision Sound file	
		static private const sCollision:Class;	
		
		private var soundCollision: Sound;							//Collision Sound
		private var sCollisionChannel: SoundChannel;				//Collision Sound Channel
		
		//Constructor
		public function Sounds() 
		{
			soundCollision = new sCollision as Sound;
			//ActivateSound
			sCollisionChannel = soundCollision.play(0, 0, new SoundTransform(0));
			sCollisionChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
//-------------------------------------------------------------------------------------------------
//
//	Methods Definition
//
//-------------------------------------------------------------------------------------------------		
		
		public function onCollision():void
		{
			sCollisionChannel = soundCollision.play(0, 0);
			sCollisionChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
//-------------------------------------------------------------------------------------------------
//
//	Event Handlers
//
//-------------------------------------------------------------------------------------------------	
		
		private function onSoundComplete(e:Event):void 
		{
			var channel:SoundChannel;
			channel = e.target as SoundChannel;
			channel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			channel = null;
		}

	}

}