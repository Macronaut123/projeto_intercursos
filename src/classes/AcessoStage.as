package classes
{
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Marcos Vinicius
	 */
	public class AcessoStage extends Sprite
	{
		
		public static var stageCurrent:Stage;
		
		public function AcessoStage() 
		{
			
		}
		
		public static function defineStage($stage:Stage):void
		{
			stageCurrent = $stage;
		}
	}

}