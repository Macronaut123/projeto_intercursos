package classes
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class Mapas extends PropriedadesTela
	{
		
		public var showDirection:String;
		public var hideDirection:String;
		
		public function Mapas() 
		{
			var buttonArray:Array = new Array(local, arredor);
			
			for (var i:int = 0; i < buttonArray.length; i++)
			{
				buttonArray[i].addEventListener(MouseEvent.MOUSE_DOWN, dispatch);
			}
			
			this.name = "mapas";
			this.menu.addEventListener(MouseEvent.MOUSE_DOWN, dispatch);
			
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