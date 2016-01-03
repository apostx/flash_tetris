package dh.tetris.mvc {
	import dh.tetris.mvc.controller.StartupCommand;
	import dh.tetris.mvc.model.vo.IConfig;
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade {
		
		// Facade startup notification
		static public const STARTUP:String  = "STARTUP";
		
		// Model notifications
		static public const SHAPE_MOVED:String = "SHAPE_MOVED";
		static public const TABLE_CHANGED:String = "TABLE_CHANGED";
		static public const GAME_ENDED:String = "GAME_ENDED";
		
		// View notifications
		public static const START_GAME:String = "START_GAME";
		public static const RESTART_GAME:String = "RESTART_GAME";
		public static const MOVE_SHAPE:String = "MOVE_SHAPE";
		public static const ROTATE_SHAPE:String = "ROTATE_SHAPE";
		public static const FORCED_NEXT_STEP:String = "FORCED_NEXT_STEP";
		static public const SHOW_MENU:String = "SHOW_MENU";
		
		/**
		 * Singleton pattern
		 * 
		 * @return Base of mvc patter
		 */
		public static function getInstance():ApplicationFacade {
            if ( instance == null ) instance = new ApplicationFacade();
            return instance as ApplicationFacade;
        }
		
		override protected function initializeController():void {
			super.initializeController();            
            registerCommand(STARTUP, StartupCommand);
		}
		
		/**
		 * Start the process
		 */
		public function startup(config:IConfig):void {
        	sendNotification(STARTUP, config);
        }
	}
}