package classes 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class FlechaMovieclip extends MovieClip
	{
		
		public function FlechaMovieclip() 
		{
			this.gotoAndStop(this.name);
			this.addEventListener(MouseEvent.MOUSE_DOWN, changeAppearance);
			this.addEventListener(MouseEvent.MOUSE_UP, changeAppearance);
		}
		
		private function changeAppearance($eventType:MouseEvent)
		{
			switch($eventType.type)
			{
				case MouseEvent.MOUSE_DOWN:
					this.gotoAndStop(this.name + "down");
					break;
				case MouseEvent.MOUSE_UP:
					this.gotoAndStop(this.name);
					break;
			}
		}
		
	}

}