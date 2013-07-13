package classes 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class Descanso extends PropriedadesTela
	{
		public var showDirection:String;
		public var hideDirection:String;
		
		public function Descanso() 
		{
			this.name = "descanso";
			this.addEventListener(MouseEvent.MOUSE_DOWN, dispatch);
			
			this.showDirection = "right";
			this.hideDirection = "left";
		}
		
		private function dispatch($eventType:MouseEvent)
		{
			dispatchEvent(new Event("removeRest"));
		}
	}

}