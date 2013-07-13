package classes 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class ConfirmaAmbulancia extends PropriedadesTela
	{
		
		public var showDirection:String;
		public var hideDirection:String;
		
		public function ConfirmaAmbulancia() 
		{
			this.name = "c_ambulancia";
			this.emergencias.addEventListener(MouseEvent.MOUSE_DOWN, dispatch);
			
			this.showDirection = "right";
			this.hideDirection = "left";
		}
		
		private function dispatch($eventType:MouseEvent)
		{
			targetName = $eventType.target.name;
			dispatchEvent(new Event("changeScreen"));
		}
		
	}

}