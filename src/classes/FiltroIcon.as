package classes 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class FiltroIcon extends MovieClip
	{
		
		public function FiltroIcon() 
		{
			var stringControl:RegExp = /[\d]/;
			
			this.gotoAndStop(this.name.replace(stringControl, ""));
			this.addEventListener(MouseEvent.MOUSE_DOWN, changeAppearance);
			this.addEventListener(MouseEvent.MOUSE_UP, changeAppearance);
		}
		
		private function changeAppearance($eventType:MouseEvent)
		{
			var stringControl:RegExp = /[\d]/;
			
			switch($eventType.type)
			{
				case MouseEvent.MOUSE_DOWN:
				this.gotoAndStop(this.name.replace(stringControl, "") + "down");
					break;
			}
		}
		
	}

}