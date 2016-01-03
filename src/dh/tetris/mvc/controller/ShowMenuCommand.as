package dh.tetris.mvc.controller {
	import dh.tetris.mvc.model.GameProxy;
	import dh.tetris.mvc.view.GameMediator;
	import dh.tetris.mvc.view.MenuMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowMenuCommand extends SimpleCommand {
		
		/**
		 * @param	note	Body has the end of game flag
		 */
		override public function execute(note:INotification) : void {
			(facade.retrieveProxy(GameProxy.NAME) as GameProxy).pause();
			(facade.retrieveMediator(GameMediator.NAME) as GameMediator).pause();
			
			// note.getBody() - End of game flag
			(facade.retrieveMediator(MenuMediator.NAME) as MenuMediator).show(note.getBody() as Boolean);
        }
	}
}