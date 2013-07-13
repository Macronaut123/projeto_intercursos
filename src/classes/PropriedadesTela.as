package classes
{
	import fl.video.FLVPlayback;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.greensock.TweenLite;
	import com.junkbyte.console.Cc;
	
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class PropriedadesTela extends MovieClip
	{
		public var infoName:String;
		public var targetName:String;
		public static var transition:Boolean;
		
		public function PropriedadesTela() 
		{
			
		}
		
		public function enableVideo($targetScreen:MovieClip):void
		{
			if ($targetScreen.name == "ambulancia" || $targetScreen.name == "policia" || $targetScreen.name == "bombeiro")
			{
				var videoCall = new FLVPlayback();
				videoCall.x = 350; 
				videoCall.y = 137; 
				addChild(videoCall); 
				videoCall.skin = "../assets/skins/MinimaSilverAll.swf" 
				videoCall.source = "../assets/videos/" + $targetScreen.name + ".flv";
			}
		}
		
		public function disableVideo():void
		{
			var targetElement:DisplayObject;
			
			for (var i:uint = 0; i < this.numChildren; i++)
			{
				targetElement = this.getChildAt(i);
				
				if (targetElement is FLVPlayback)
				{
					removeChild(targetElement);
				}
			}
			
		}
		
		public function defaultButtons($targetScreen:MovieClip):void
		{
			var targetElement:DisplayObject;
			
			for (var i:int = 0; i < $targetScreen.numChildren; i++)
			{
				targetElement = $targetScreen.getChildAt(i);
				
				if (targetElement is ArteButton)
				{
					MovieClip(targetElement).gotoAndStop(targetElement.name);
				}
				
				if (targetElement is VoltarButton)
				{
					MovieClip(targetElement).gotoAndStop("up");
				}
			}
		}
		
		public function setElement($targetElement:MovieClip, $x:int, $y:int, $sizeW:int, $sizeH:int, $function:Function = null):void
		{
			$targetElement.x = $x;
			$targetElement.y = $y;
			$targetElement.width = $sizeW;
			$targetElement.height = $sizeH;
			
			if ($function != null)
			$function();
		}
		
		public function tweenListen($tweenTarget:MovieClip, $animationTime:Number):void
		{
			$tweenTarget.addEventListener(MouseEvent.MOUSE_DOWN, tweenObject); // LEMBRE QUE O COMO O TIPO DE EVENTO ESTÁ SENDO DECLARADO POR UM EVENT LISTENER, NÃO HÁ NECESSIDADE DE PASSAR
			$tweenTarget.addEventListener(MouseEvent.MOUSE_UP, tweenObject); // UM PARÂMETRO QUE DIGA QUAL TIPO DE EVENTO DE MOUSE É, ISSO JÁ FOI DECLARADO ANTES PELA PRÓPRIA FUNÇÃO.
			
			$tweenTarget.defaultWidth = $tweenTarget.width; // CRIANDO PARÂMETRO PARA UM MOVIECLIP, DEFAULTWIDTH E DEFAULTHEIGHT NÃO EXISTEM
			$tweenTarget.defaultHeight = $tweenTarget.height; // É UMA VARIÁVEL QUE GANHOU TIPO QUANDO FOI COMPARADA COM UM NUMBER (WIDTH,HEIGHT)
			
			$tweenTarget.animationTime = $animationTime; 
			
			// O PARÂMETRO CRIADO DENTRO DE TODOS OS OUTROS QUE JÁ SÃO PADRÃO DO MOVIECLIP NÃO PRECISAM SER TIPOS (INT,STRING,ETC), ISSO SERÁ COBRADO EVENTUALMENTE
			// QUANDO A FUNÇÃO CHAMÁ-LO OU PEDIR UM VALOR, A FUNÇÃO EM SI JÁ SABE QUAL O TIPO (UINT,NUMBER) E ELA SÓ PEDE UM VALOR, PORTANTO O PARÂMETRO DEIXA DE SER 
			// UM TIPO PARA SER APENAS UM VALOR QUE PODE SER UTILIZADO EM QUALQUER MOMENTO NECESSÁRIO.
		}
		
		public function hideScreen($tweenDirection:String = null):void
		{
			if ($tweenDirection != null)
			{
				switch($tweenDirection)
				{
					case "right":
						TweenLite.to(this, 1.0, { x:AcessoStage.stageCurrent.stageWidth, onComplete:disableScreen, onCompleteParams:[this] } );
						break;
					case "left":
						TweenLite.to(this, 1.0, { x:0 - this.width, onComplete:disableScreen, onCompleteParams:[this] } )
						break;
				}
			}
		}
		
		public function showScreen($targetScreen:MovieClip, $tweenDirection:String = null ):void
		{
			transition = true;
			if ($tweenDirection != null)
			{
				switch($tweenDirection)
				{
					case "right":
					$targetScreen.visible = true;
					$targetScreen.x = AcessoStage.stageCurrent.stageWidth;
					TweenLite.to($targetScreen, 1.0, { x:0, onComplete:enableScreen, onCompleteParams:[this]  } );
					break;
					
					case "left":
					$targetScreen.visible = true;
					$targetScreen.x = 0 - $targetScreen.width;
					TweenLite.to($targetScreen, 1.0, { x:0, onComplete:enableScreen, onCompleteParams:[this] } );
					break;
				}
			}
		}
		
		public function disableScreen($disableTarget:MovieClip):void
		{
			defaultButtons($disableTarget);
			$disableTarget.enabled = false;
			$disableTarget.visible = false;
			$disableTarget.mouseChildren = false;
			$disableTarget.mouseEnabled = false;
		}
		
		public function enableScreen($enableTarget:MovieClip):void
		{
			transition = false;
			$enableTarget.enabled = true;
			$enableTarget.visible = true;
			$enableTarget.mouseChildren = true;
			$enableTarget.mouseEnabled = true;
		}
		
		public function resetScreenPos():void
		{
			this.x = 0;
			this.y = 0;
		}
		
		public function fadeScreen($fadeType:String, $fadeTime:Number, $fadeColor:uint, $functionRun:Function = null):void
		{
			var fadeSprite:Sprite = new Sprite();
			addChild(fadeSprite);
			fadeSprite.graphics.beginFill($fadeColor);
			fadeSprite.graphics.drawRect(0, 0, AcessoStage.stageCurrent.stageWidth, AcessoStage.stageCurrent.stageHeight);
			fadeSprite.graphics.endFill();
			fadeSprite.x = 0;
			fadeSprite.y = 0;
			
			switch($fadeType)
			{
				case "fadeIn":
					fadeSprite.alpha = 0.0;
					TweenLite.to(fadeSprite, $fadeTime, { alpha:0.5, onComplete:removeFade, onCompleteParams:[fadeSprite] } );					
					break;
					
				case "fadeOut":
					fadeSprite.alpha = 1.0;
					TweenLite.to(fadeSprite, $fadeTime, { alpha:0.0, onComplete:removeFade, onCompleteParams:[fadeSprite]  } );
					break;
			}
		}
		
		private function removeFade($fadeSprite:Sprite):void
		{
			this.removeChild($fadeSprite);
		}
		
		private function tweenObject($eventType:MouseEvent):void
		{	
			var defaultWidth:Number = $eventType.currentTarget.defaultWidth; // CHAMANDO O PARÂMETRO CRIADO LOGO ACIMA
			var defaultHeight:Number = $eventType.currentTarget.defaultHeight; // COMPARANDO-O COM VARIÁVEIS LOCAIS DA FUNÇÃO PRIVADA
			
			switch($eventType.type) // TESTANDO O TIPO DO EVENTO (STRING) DÊ UM TRACE SE QUISER AVALIAR TODOS OS PARÂMETROS DO EVENTO (CARACTERÍSTICAS E PROPRIEDADES)
			{
				case "mouseDown": // SE FOR DO TIPO MOUSEOVER
				TweenLite.to($eventType.target, $eventType.target.animationTime, { width:defaultWidth * 1.25, height:defaultWidth * 1.25 } );
					break;
				case "mouseUp": // SE FOR DO TIPO MOUSEOUT
				TweenLite.to($eventType.target, $eventType.target.animationTime, { width:defaultHeight, height:defaultHeight} );
					break;
			}
			
			// COMO FOI OBSERVADO ACIMA PRA RESSALTAR MAIS AINDA QUE NÃO PRECISEI PASSAR O PARÂMETRO, TESTEI O TIPO DE EVENTO COM O QUAL ESTOU LIDANDO PARA EXECUTAR MINHAS AÇÕES
		}
	}

}