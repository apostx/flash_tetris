package dh.tetris.mvc.controller {
	import dh.tetris.mvc.model.GameProxy;
	import org.puremvc.as3.interfaces.INotification;

	public class RestartGameCommand extends StartGameCommand {
		
		override public function execute(note:INotification) : void {
			(facade.retrieveProxy(GameProxy.NAME) as GameProxy).reset();
	
			// StartGameCommand#execute()
			super.execute(note);
        }
	}
}