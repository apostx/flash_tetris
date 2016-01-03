package dh.tetris.mvc.view {
	import dh.tetris.mvc.ApplicationFacade;
	import dh.tetris.mvc.view.components.IMenu;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuMediator extends Mediator {
		
		static public const NAME:String = "MenuMediator";
		
		private function get _menu():IMenu {
			return viewComponent as IMenu;
		}
		
		public function MenuMediator(viewComponent:Object,root:DisplayObjectContainer) {
			super(NAME, viewComponent);
			
			root.addChild(viewComponent as DisplayObject);
			
			_menu.startButton.addEventListener(MouseEvent.CLICK, startClickHandler);
			_menu.restartButton.addEventListener(MouseEvent.CLICK, restartClickHandler);
		}
		
		private function startClickHandler(e:Event):void {
			sendNotification(ApplicationFacade.START_GAME);
		}
		
		private function restartClickHandler(e:Event):void {
			sendNotification(ApplicationFacade.RESTART_GAME);
			_menu.hide();
		}
		
		/**
		 * @param	end	Game ended flag
		 */
		public function show(end:Boolean = false):void {
			_menu.show(end);
		}
		
		public function hide():void {
			_menu.hide();
		}
	}
}