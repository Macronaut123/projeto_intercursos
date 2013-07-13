package 
{
	import classes.Ambulancia;
	import classes.Arredor;
	import classes.Bombeiro;
	import classes.Local;
	import classes.Policia;
	import classes.TimerClasse;
	import classes.Descanso;
	import classes.Emergencias;
	import classes.Mapas;
	import classes.MenuInicial;
	import classes.AcessoStage;
	import classes.PropriedadesTela;
	import classes.ConfirmaAmbulancia;
	import classes.ConfirmaPolicia;
	import classes.ConfirmaBombeiro;
	import classes.BarraTitulo;
	import classes.historyButton;
	
	import com.greensock.easing.Back;
	import com.junkbyte.console.Cc;
	import com.greensock.TweenLite;
	import com.sound.SoundManager;
	import com.junkbyte.console.Cc;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	
	[Frame(factoryClass='Carregador')]
	[SWF(width = 1024, height= 600)]
	
	public class GerenciaTelas extends Sprite 
	{
		private var menuClasse:MenuInicial;
		private var descansoClasse:Descanso;
		private var timerGerencia:TimerClasse;
		
		private var emergenciasClasse:Emergencias;
		private var ambulanciaClasse:Ambulancia;
		private var policiaClasse:Policia;
		private var bombeiroClasse:Bombeiro;
		
		private var confirmaAmbulancia:ConfirmaAmbulancia;
		private var confirmaPolicia:ConfirmaPolicia;
		private var confirmaBombeiro:ConfirmaBombeiro;
		
		private var mapasClasse:Mapas;
		private var localClasse:Local;
		private var arredorClasse:Arredor;
		
		private var telasArray:Array;
		
		private var currentScreen:String = "menu";
		
		private var barraTitulo:BarraTitulo;
		
		private var soundControl:SoundManager = SoundManager.getInstance();
		
		public static var currentScreenGlobal:String;
		
		public var historyScreen:historyButton;
		
		public function GerenciaTelas():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function setScreen(e:Event):void
		{	
			currentScreen = e.target.targetName;
			changeScreen();
		}

		private function init(e:Event = null):void 
		{	
			AcessoStage.defineStage(stage);
			
			menuClasse = new MenuInicial();
			descansoClasse = new Descanso();
			timerGerencia = new TimerClasse();
			
			emergenciasClasse = new Emergencias();
			policiaClasse = new Policia();
			ambulanciaClasse = new Ambulancia();
			bombeiroClasse = new Bombeiro();
			
			confirmaAmbulancia = new ConfirmaAmbulancia();
			confirmaBombeiro = new ConfirmaBombeiro();
			confirmaPolicia = new ConfirmaPolicia();
			
			mapasClasse = new Mapas();
			localClasse = new Local();
			arredorClasse = new Arredor();
			
			barraTitulo = new BarraTitulo(0,0);
			
			telasArray = new Array(menuClasse, mapasClasse, descansoClasse, emergenciasClasse, policiaClasse, ambulanciaClasse, bombeiroClasse, localClasse, arredorClasse, confirmaBombeiro, confirmaAmbulancia, confirmaPolicia);
			
			historyScreen = new historyButton();
			
			Cc.startOnStage(AcessoStage.stageCurrent, "console");
			
			barraTitulo.addEventListener("changeScreen", setScreen);
			
			for (var i:int = 0; i < telasArray.length; i++)
			{
				if (telasArray[i].name != "descanso")
				{
				telasArray[i].addEventListener("changeScreen", setScreen);
				}
				else
				{
				telasArray[i].addEventListener("removeRest", removeRest);
				}
			}
			
			currentScreenGlobal = currentScreen;
			
			addTimer();
			addSounds();
			addScreens();
			
			addEventListener(Event.ENTER_FRAME, homeButton);
		}
		
		private function homeButton($eventType:Event):void
		{
			if (PropriedadesTela.transition && currentScreenGlobal == "menu")
			{
				barraTitulo.menu.gotoAndStop("down");
			}
			else
			{
				barraTitulo.menu.gotoAndStop("up");
			}
		}
		
		private function addSounds():void
		{
			soundControl.addExternalSound("../assets/sounds/BeepCancel.mp3", "cancel");
			soundControl.addExternalSound("../assets/sounds/BeepConfirm.mp3","confirm");
		}
		
		private function addTimer():void
		{		
			addChild(timerGerencia);
			timerGerencia.newTimer(120);
			timerGerencia.addEventListener("restEnable", restEnable);
			timerGerencia.setTimer();
		}
		
		private function removeRest($eventType:Event):void
		{
			timerGerencia.resetTimer();
			
			for (var i:int = 0; i < telasArray.length; i++)
			{
				if (telasArray[i].name == "menu")
				{
					telasArray[i].enableScreen(telasArray[i]);
					telasArray[i].resetScreenPos();
				}
			}
			
			$eventType.target.disableScreen($eventType.target);
		}
		
		private function restEnable($eventType:Event):void
		{
			for (var i:int = 0; i < telasArray.length; i++)
			{
				if (telasArray[i].name != "descanso")
				{
					telasArray[i].disableScreen(telasArray[i]);
				}
				else
				{
					setChildIndex(telasArray[i], this.numChildren - 1);
					telasArray[i].enableScreen(telasArray[i]);
					telasArray[i].resetScreenPos();
				}
			}
		}
		
		private function addScreens():void
		{	
			for (var i:int = 0; i < telasArray.length; i++)
			{
				this.addChild(telasArray[i]);
				
				if (telasArray[i].name != "local" && telasArray[i].name != "arredor")
				{
					telasArray[i].height = AcessoStage.stageCurrent.stageHeight + 0.5;
					telasArray[i].width = AcessoStage.stageCurrent.stageWidth + 0.5;
				}
				
				if (telasArray[i].name != currentScreen)
			    {
					telasArray[i].disableScreen(telasArray[i]);
				}
			}
			
			addChild(barraTitulo);
			
			historyScreen.x = 170;
			historyScreen.y = 20;
			addChild(historyScreen);
			setHistory();
			
			arredorClasse.addEventListener("moveTimer", mapTimer);
			arredorClasse.addEventListener("changeInfo", changeInfo);
			localClasse.addEventListener("moveTimer", mapTimer);
			localClasse.addEventListener("changeInfo", changeInfo);
			barraTitulo.addEventListener("resetMapIcons",setIcons);
		}
		
		private function changeInfo($eventType:Event):void
		{
			barraTitulo.iconInfo.gotoAndStop($eventType.target.infoName);
			barraTitulo.iconStart();
		}
		
		private function setIcons($eventType:Event):void
		{
			arredorClasse.resetIcons();
			localClasse.resetIcons();
		}
		
		private function mapTimer($eventType:Event):void
		{
			timerGerencia.resetTimer();
		}
		
		private function changeScreen():void
		{	
			
			timerGerencia.resetTimer();
			
			currentScreenGlobal = currentScreen;
			
			if (currentScreen == "menu")
				soundControl.playSound("cancel", 1);
				else
				soundControl.playSound("confirm", 1);
			
			for (var i:int = 0; i < telasArray.length; i++)
			{
				if (telasArray[i]["showDirection"] != null && telasArray[i]["hideDirection"] != null)
				{
					if (telasArray[i].name != currentScreen)
					{
				if (telasArray[i].name == "local" || telasArray[i].name == "arredor"){
						telasArray[i].setElement(telasArray[i]["mapa"], 0, 0, 1024, 600);
						}
						telasArray[i].disableVideo();
						telasArray[i].hideScreen(telasArray[i]["hideDirection"]);
						telasArray[i].fadeScreen("fadeIn", 1.0, 0x000000);
					}
					else
					{
						telasArray[i].showScreen(telasArray[i], telasArray[i]["showDirection"]);
						telasArray[i].enableVideo(telasArray[i]);
						if (telasArray[i].name == "local" || telasArray[i].name == "arredor")
						telasArray[i].setElement(telasArray[i]["mapa"], telasArray[i]["mapa"].x, telasArray[i]["mapa"].y, 2048, 1152);
					}	
				}
			}
			
			setHistory();
		}
		
		private function setHistory():void 
		{
			trace(currentScreenGlobal);
			if (currentScreenGlobal)
			{
				historyScreen.gotoAndStop(currentScreenGlobal);
			}
		}
	}

}