package dh.tetris.mvc.controller {
	import dh.tetris.mvc.model.GameProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ForcedNextStepCommand extends SimpleCommand {
		
		override public function execute(note:INotification):void {
			(facade.retrieveProxy(GameProxy.NAME) as GameProxy).forceNext();
        }
	}
}