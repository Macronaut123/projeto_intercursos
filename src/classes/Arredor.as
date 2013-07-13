package classes 
{
	import com.greensock.easing.Back;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import com.junkbyte.console.Cc;
	
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class Arredor extends PropriedadesTela
	{
		private var buttonArray:Array;
		
		private var up:Boolean;
		private var right:Boolean;
		private var left:Boolean;
		private var down:Boolean;
		
		private var movableXR:Boolean;
		private var movableXL:Boolean;
		
		private var movableYU:Boolean;
		private var movableYD:Boolean;
		
		public var showDirection:String;
		public var hideDirection:String;
		
		private var scrollmoveRight:Boolean;
		private var scrollmoveLeft:Boolean;
		
		private var scrollSystem:ScrollBar;
			
		private var iconArray:Array;
		
		private var allowChange:Boolean = true;

		public function Arredor() 
		{
			this.name = "arredor";
			this.mapas.addEventListener(MouseEvent.MOUSE_DOWN, dispatch);
			
			buttonArray = new Array(upButton, downButton, leftButton, rightButton);
			
			iconArray = new Array("educacao", "esporte", "alimentacao", "cultura", "financeira", "taxi", "onibus", "metro", "posto", "estacionamento", "trem");
			
			for (var i:int = 0; i < buttonArray.length; i++)
			{
				buttonArray[i].addEventListener(MouseEvent.MOUSE_DOWN, buttonSystem);
				buttonArray[i].addEventListener(MouseEvent.MOUSE_UP, buttonSystem);
			}
			
			addEventListener(Event.ENTER_FRAME, movementControl);
			addEventListener(Event.ENTER_FRAME, movementConditions);
			addEventListener(Event.ENTER_FRAME, moveScroll);
			
			this.leftScroll.addEventListener(MouseEvent.MOUSE_DOWN, moveConditions);
			this.rightScroll.addEventListener(MouseEvent.MOUSE_DOWN, moveConditions);
			this.leftScroll.addEventListener(MouseEvent.MOUSE_UP, moveConditions);
			this.rightScroll.addEventListener(MouseEvent.MOUSE_UP, moveConditions);
			
			this.showDirection = "right";
			this.hideDirection = "left";
			
			scrollSystem = new ScrollBar(0,this.leftScroll.y);
			addChild(scrollSystem);
			var distanceX:int = rightScroll.x - leftScroll.x;
			
			for (var o:int = 0; o < iconArray.length; o++)
			{
				var scrollItem:IconeScroll = new IconeScroll(iconArray[o]);
				scrollSystem.addChild(scrollItem);		
				scrollItem.y = -7;
				scrollItem.x = o * (scrollItem.width + 12);
				scrollItem.gotoAndStop(scrollItem.name);
				scrollItem.addEventListener(MouseEvent.MOUSE_DOWN, changeAppearance);
				//colocando o evento para pegar o tipo de filtro que este botão tem
				scrollItem.addEventListener(MouseEvent.MOUSE_DOWN, getFilterType);
			}
			
			this.setChildIndex(leftScroll, numChildren-1);
			this.setChildIndex(rightScroll, numChildren - 1);
			scrollSystem.mask = scrollMask;
			setIcons();
		}
		
		public function resetIcons():void
		{
			var targetElement:DisplayObject;
			var stringControl:RegExp = /[\d]/;
			
			for (var i:int = 0; i < mapa.numChildren; i++)
			{
				targetElement = mapa.getChildAt(i);
				
				if (targetElement is FiltroIcon)
				{
					MovieClip(targetElement).gotoAndStop(targetElement.name.replace(stringControl, ""));
				}
			}
		}
		
		private function setIcons():void
		{
			var targetElement:DisplayObject;
			
			for (var i:int = 0; i < mapa.numChildren; i++)
			{
				targetElement = mapa.getChildAt(i);
				
				if (targetElement.name.indexOf("instance") == -1) // SE O NOME DO ELEMENTO NÃO TIVER INSTANCE --> VALOR -1 COMPARA COMO FALSO
				{
					targetElement.addEventListener(MouseEvent.MOUSE_DOWN, dispatchIcon);
					targetElement.width = 0;
					targetElement.height = 0;
				}
			}
		}
		
		private function getFilterType($eventType:MouseEvent):void 
		{
			var item:DisplayObject;
			var filtro:String = $eventType.target.name;
			var stringControl:RegExp = /[\d]/;
			
			if (allowChange)
			{
				for (var i:int = 0; i < mapa.numChildren; i++)
				{
					item = mapa.getChildAt(i);
					
					if (filtro)
					{
						if (item is FiltroIcon)
						{
							if (item.name.indexOf(filtro) != -1)
							{
									if (item.width < 1 && item.height < 1)
									{
										TweenLite.to(item, 0.5, { width:8, height: 16, onComplete: setChange,  ease:Back.easeOut  } );
									}else if (item.width > 0 && item.height > 0 )
									{
										TweenLite.to(item, 0.5, { width:0.0, height: 0.0, onComplete: setChange,  ease:Back.easeOut   } );
									}
									
								allowChange = false;
							}
						}
					}
				}
			}
		}
		
		private function changeAppearance($evenType:MouseEvent)
		{
			if (allowChange)
			{
				if ($evenType.target.currentFrameLabel != ($evenType.target.name + "down"))
				{
					$evenType.target.gotoAndStop($evenType.target.name + "down");
				}
				else if($evenType.target.currentFrameLabel == ($evenType.target.name + "down"))
				{
					$evenType.target.gotoAndStop($evenType.target.name);
				}
			}
		}
		
		private function setChange():void
		{
			allowChange = true;
		}
		
		private function moveConditions($eventType:MouseEvent)
		{
			if ($eventType.type == "mouseDown")
			{
				switch($eventType.target.name)
				{
					case "rightScroll":
						scrollmoveRight = true;
						break;
					case "leftScroll":
						scrollmoveLeft = true;
						break;
				}
			}
							
			if ($eventType.type == "mouseUp")
			{
				switch($eventType.target.name)
				{
					case "rightScroll":
						scrollmoveRight = false;
						break;
					case "leftScroll":
						scrollmoveLeft = false;
						break;
				}
			}
		}
		
		private function moveScroll($eventType:Event)
		{	
			if (scrollmoveLeft && scrollSystem.x < (rightScroll.x - 30))
			{
				this.leftScroll.gotoAndStop("down");
				this.rightScroll.gotoAndStop("up");
				scrollSystem.x += 5;
			}
			
			if (scrollmoveRight && (scrollSystem.x + scrollSystem.width) > (leftScroll.x + leftScroll.width + 30))
			{
				this.leftScroll.gotoAndStop("up");
				this.rightScroll.gotoAndStop("down");
				scrollSystem.x -= 5;
			}
			
			if (!scrollmoveRight && !scrollmoveLeft)
			{
				this.leftScroll.gotoAndStop("up");
				this.rightScroll.gotoAndStop("up");
			}
		}
		
		private function buttonSystem($eventType:MouseEvent)
		{
			var targetName:String = $eventType.target.name.replace("Button", "");
			
			switch($eventType.type)
			{
				case "mouseDown":
					this[targetName] = true;
					break;
				case "mouseUp":
					this[targetName] = false;
					break
			}
		}
		
		private function movementControl($eventType:Event)
		{	
			if (up && movableYD)
			{
				this.mapa.y += 5;
				dispatchEvent(new Event("moveTimer"));
			}
			
			if (down && movableYU)
			{
				this.mapa.y -= 5;
				dispatchEvent(new Event("moveTimer"));
			}
			
			if (right && movableXR)
			{
				this.mapa.x -= 5;
				dispatchEvent(new Event("moveTimer"));
			}
			
			if (left && movableXL)
			{
				this.mapa.x += 5;
				dispatchEvent(new Event("moveTimer"));
			}
		}
		
		private function movementConditions($eventType:Event)
		{			
			if (this.mapa.x >= this.maskObject.x)
			{
				this.mapa.x = this.maskObject.x;
				movableXL = false;
			}
			else
			{
				movableXL = true;
			}
			
			if ((this.mapa.x + this.mapa.width - 6) <= (this.maskObject.x + this.maskObject.width))
			{
				this.mapa.x = ((this.maskObject.x + this.maskObject.width) - (this.mapa.width - 6));
				movableXR = false;
			}
			else
			{
				movableXR = true;
			}
			
			if (this.mapa.y >= this.maskObject.y)
			{
				this.mapa.y = this.maskObject.y;
				movableYD = false;
			}
			else
			{
				movableYD = true;
			}
			
			if ((this.mapa.height + this.mapa.y) < (this.maskObject.y + this.maskObject.height))
			{
				this.mapa.y = ((this.maskObject.y + this.maskObject.height) - (this.mapa.height - 4));
				movableYU = false;
			}
			else
			{
				movableYU = true;
			}
		}
		
		private function dispatch($eventType:MouseEvent)
		{
			targetName = $eventType.target.name;
			setElement(scrollSystem, 0, leftScroll.y, scrollSystem.width, scrollSystem.height);
			setElement(this.mapa, 0, 0, 1024, 600);
			dispatchEvent(new Event("changeScreen"));
		}
			
		private function dispatchIcon($eventType:MouseEvent):void
		{
			infoName = $eventType.target.name;
			dispatchEvent(new Event("changeInfo"));
		}	
	}

}