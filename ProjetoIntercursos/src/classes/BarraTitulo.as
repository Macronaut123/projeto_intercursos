package classes 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class BarraTitulo extends PropriedadesTela
	{
	
		private var localFade:MovieClip = new Fade();
		private var openBlock:Boolean;
		private var openInfo:Boolean;
		private var openIcon:Boolean;
		private var openKeyboard:Boolean;
		
		public function BarraTitulo($x:int,$y:int) 
		{
			x = $x;
			y = $y;
			
			this.menu.addEventListener(MouseEvent.MOUSE_DOWN, dispatch);
			
			localFade.alpha = 0.0;
			
			setInfo();
		}
		
		public function iconStart():void
		{
			this.iconInfo.closeBTN.gotoAndStop("up");
			setPieces();
			this.iconInfo.alpha = 1.0;
			openBlock = true;
			openIcon = true;
			addChildAt(localFade,0);
			TweenLite.to(localFade, 1.0, { alpha:0.8 } );
			TweenLite.to(iconInfo, 1.0, { width:400, height:300, ease:Back.easeOut } );
		}
		
		private function setInfo():void
		{			
			this.info.alpha = 0.0;
			this.type.alpha = 0.0;
			this.keyboardImage.alpha = 0.0;
			
			this.iconInfo.width = 0.0;
			this.iconInfo.height = 0.0;
			this.iconInfo.closeBTN.addEventListener(MouseEvent.MOUSE_DOWN, closeIcon);
			
			setPieces();
			
			this.infomenu.addEventListener(MouseEvent.MOUSE_DOWN, infoTrigger);
			this.keyboard.addEventListener(MouseEvent.MOUSE_DOWN, typeTrigger);
		}
		
		private function closeIcon($eventType:MouseEvent)
		{
			this.iconInfo.closeBTN.gotoAndStop("down");
			openIcon = false;
			openBlock = false;
			TweenLite.to ( localFade, 1.0, { alpha: 0.0, onComplete:removeFade });
			TweenLite.to(this.iconInfo, 1.0, { alpha: 0.0 } );
			dispatchEvent(new Event("resetMapIcons"));
		}
		
		private function setPieces():void
		{
			this.type.enabled = false;
			this.type.visible = false;
			this.type.mouseChildren = false;
			this.type.mouseEnabled = false;
			
			this.info.enabled = false;
			this.info.visible = false;
			this.info.mouseChildren = false;
			this.info.mouseEnabled = false;
			
			this.keyboardImage.enabled = false;
			this.keyboardImage.visible = false;
			this.keyboardImage.mouseChildren = false;
			this.keyboardImage.mouseEnabled = false;
		}
		
		private function resetKeyboard():void
		{
			this.type.enabled = true;
			this.type.visible = true;
			this.type.mouseChildren = true;
			this.type.mouseEnabled = true;
			
			this.type.txt.htmlText = "";
			
			this.keyboardImage.enabled = true;
			this.keyboardImage.visible = true;
			this.keyboardImage.mouseChildren = true;
			this.keyboardImage.mouseEnabled = true;
		}
		
		private function resetInfo():void
		{
			this.info.enabled = true;
			this.info.visible = true;
			this.info.mouseChildren = true;
			this.info.mouseEnabled = true;
		}
		
		private function infoTrigger($eventType:MouseEvent = null):void
		{
			if (!openKeyboard && !openIcon)
			{
				if (info.alpha == 0.0 && !openBlock && !openIcon)
				{
					$eventType.target.gotoAndStop("down");
					resetInfo();
					openInfo = true;
					openBlock = true;
					addChildAt(localFade,0);
					TweenLite.to(localFade, 1.0, { alpha:0.8 } );
					TweenLite.to(this.info, 1.0, { alpha: 1.0, ease:Back.easeOut } );
				}
				else
				{
					$eventType.target.gotoAndStop("up");
					openInfo = false;
					openBlock = false;
					TweenLite.to ( localFade, 1.0, { alpha: 0.0, onComplete:removeFade });
					TweenLite.to(this.info, 1.0, { alpha: 0.0, ease:Back.easeOut  } );
				}
			}
		}
		
		private function typeTrigger($eventType:MouseEvent = null):void
		{
			if (!openInfo && !openIcon)
			{
				if (type.alpha <= 0.0)
				{
					$eventType.target.gotoAndStop("down");
					resetKeyboard();
					openKeyboard = true;
					openBlock = true;
					addChildAt(localFade,0);
					
					TweenLite.to(localFade, 1.0, { alpha:0.8 } );
					TweenLite.to(this.type, 1.0, { alpha: 1.0 } );
					TweenLite.to(this.keyboardImage, 1.0, { alpha: 1.0 } );
				}
				else
				{
					$eventType.target.gotoAndStop("up");
					openKeyboard = false;
					openBlock = false;
					
					TweenLite.to ( localFade, 1.0, { alpha: 0.0, onComplete:removeFade });
					TweenLite.to(this.type, 1.0, { alpha: 0.0 } );
					TweenLite.to(this.keyboardImage, 1.0, { alpha: 0.0 } );
				}
			}
		}
		
		private function removeFade()
		{
			setPieces();
			removeChild(localFade);
			this.iconInfo.width = 0.0;
			this.iconInfo.height = 0.0;
		}
		
		private function dispatch($eventType:MouseEvent)
		{
			if (GerenciaTelas.currentScreenGlobal != "menu" && !PropriedadesTela.transition && !openBlock)
			{
			targetName = $eventType.target.name;
			dispatchEvent(new Event("changeScreen"));
			}
		}
		
	}

}