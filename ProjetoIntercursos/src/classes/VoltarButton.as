package classes 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class VoltarButton extends MovieClip
	{
		
		public function VoltarButton() 
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, changeAppearance);
		}
		
		private function changeAppearance($eventType:MouseEvent)
		{
			this.gotoAndStop("down");
		}
	}

}