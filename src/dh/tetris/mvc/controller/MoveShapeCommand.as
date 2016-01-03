package dh.tetris.mvc.controller {
	import dh.tetris.mvc.model.GameProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class MoveShapeCommand extends SimpleCommand {
		
		/**
		 * @param	note	Body has: [0]-rotate, [< 0]-move left, [0 <]-move right
		 */
		override public function execute(note:INotification):void {
			(facade.retrieveProxy(GameProxy.NAME) as GameProxy).moveShape(note.getBody() as Number);
        }
	}
}