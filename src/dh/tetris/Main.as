package dh.tetris {
	import dh.tetris.mvc.ApplicationFacade;
	import dh.tetris.mvc.model.vo.Config;
	import dh.tetris.mvc.model.vo.IConfig;
	import dhlib.engine.tetris.core.ResettablePosition;
	import dhlib.engine.tetris.core.Shape;
	import dhlib.engine.tetris.Game;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	[SWF(width="400", height="800", backgroundColor="#FFFFFF", frameRate="40")]
	public class Main extends Sprite {
		
		static private const TABLE_COL_NUM:uint = 10;
		static private const TABLE_ROW_NUM:uint = 20;
		
		/**
		 * A block size of width and height in pixel
		 */
		static private const TABLE_BLOCK_SIZE:Number = 40;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var config:IConfig = new Config(
				stage,
				TABLE_COL_NUM,
				TABLE_ROW_NUM,
				TABLE_BLOCK_SIZE
			);
			
			(new ApplicationFacade()).startup(config);
		}
	}
}