package classes 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class ArteButton extends MovieClip
	{
		
		public function ArteButton() 
		{
			this.gotoAndStop(this.name);
			this.addEventListener(MouseEvent.MOUSE_DOWN, changeAppearance);
		}
		
		private function changeAppearance($eventType:MouseEvent)
		{
			this.gotoAndStop(this.name + "down");
		}
		
		public function resetAppearance():void
		{
			this.gotoAndStop(this.name);
		}
		
	}

}