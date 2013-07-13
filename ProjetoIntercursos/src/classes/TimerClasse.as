package classes 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class TimerClasse extends PropriedadesTela
	{
		
		public var TimerControl:Timer;
		
		public function TimerClasse() 
		{
		}
		
		public function setTimer():void
		{
			TimerControl.addEventListener(TimerEvent.TIMER_COMPLETE, restMode);
			TimerControl.start();
		}
		
		private function restMode($eventType:TimerEvent):void
		{
			dispatchEvent(new Event("restEnable"));
			TimerControl.stop();
		}
		
		public function resetTimer():void
		{
			TimerControl.reset();
			TimerControl.start();
		}
				
		public function newTimer(RepeatCount:int)
		{
			TimerControl = new Timer(1000, RepeatCount);
		}
		
	}

}