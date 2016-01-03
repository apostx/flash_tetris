package dh.tetris.mvc.controller {
	import dh.tetris.mvc.ApplicationFacade;
	import dh.tetris.mvc.model.GameProxy;
	import dh.tetris.mvc.model.vo.IConfig;
	import dh.tetris.mvc.view.components.GameTable;
	import dh.tetris.mvc.view.components.IGameTable;
	import dh.tetris.mvc.view.components.IMenu;
	import dh.tetris.mvc.view.components.Menu;
	import dh.tetris.mvc.view.GameMediator;
	import dh.tetris.mvc.view.MenuMediator;
	import dhlib.engine.tetris.core.Shape;
	import dhlib.engine.tetris.Game;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand {
		
		/**
		 * Init MVC components
		 */
		override public function execute(note:INotification) : void {
			var config:IConfig = note.getBody() as IConfig;
			var stage:Stage = config.root.stage;
			var gameLogic:Game = new Game(config.tableColNum, config.tableRowNum);
			
			var gameView:IGameTable = new GameTable(config.tableColNum, config.tableRowNum, config.tableBlockSize);
			var menu:IMenu = new Menu(stage.stageWidth, stage.stageHeight);
			
			facade.registerProxy(new GameProxy(gameLogic));
			
			facade.registerMediator(new GameMediator(gameView, config.root));
			facade.registerMediator(new MenuMediator(menu, config.root));
			
			facade.registerCommand(ApplicationFacade.START_GAME, StartGameCommand);
			facade.registerCommand(ApplicationFacade.RESTART_GAME, RestartGameCommand);
			facade.registerCommand(ApplicationFacade.SHOW_MENU, ShowMenuCommand);
			facade.registerCommand(ApplicationFacade.MOVE_SHAPE, MoveShapeCommand);
			facade.registerCommand(ApplicationFacade.FORCED_NEXT_STEP, ForcedNextStepCommand);
        }
	}
}