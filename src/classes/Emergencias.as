package classes  
{
	import flash.display.ShaderParameter;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class Emergencias extends PropriedadesTela
	{
		
		public var showDirection:String;
		public var hideDirection:String;
		
		public function Emergencias() 
		{
			var buttonArray:Array = new Array(policia, ambulancia, bombeiro);
			
			this.name = "emergencias";
			this.menu.addEventListener(MouseEvent.MOUSE_DOWN, dispatch);
			
			for (var i:int = 0; i < buttonArray.length; i++)
			{
				buttonArray[i].addEventListener(MouseEvent.MOUSE_DOWN, dispatch);
			}
			
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