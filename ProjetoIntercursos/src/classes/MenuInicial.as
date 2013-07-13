package classes
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.junkbyte.console.Cc;
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class MenuInicial extends PropriedadesTela
	{
		private var buttonArray:Array;
		
		public var hideDirection:String;
		public var showDirection:String;
		
		public function MenuInicial() 
		{
			this.name = "menu";
			
			var buttonArray:Array = new Array(mapas, emergencias);
			
			for (var i:int = 0; i < buttonArray.length; i++) {	
				buttonArray[i].addEventListener(MouseEvent.MOUSE_DOWN, dispatch);	
			}
			
			hideDirection = "left";
			showDirection = "right";
		}	
		
		private function dispatch($eventType:MouseEvent)
		{
			targetName = $eventType.target.name;
			dispatchEvent(new Event("changeScreen"));
		}
	}

}