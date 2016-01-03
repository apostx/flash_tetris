package dh.tetris.mvc.controller {
	import dh.tetris.mvc.model.GameProxy;
	import dh.tetris.mvc.view.GameMediator;
	import dh.tetris.mvc.view.MenuMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartGameCommand extends SimpleCommand {
		
		override public function execute(note:INotification) : void {
			(facade.retrieveMediator(MenuMediator.NAME) as MenuMediator).hide();
			(facade.retrieveMediator(GameMediator.NAME) as GameMediator).start();
			(facade.retrieveProxy(GameProxy.NAME) as GameProxy).start();
        }
	}
}