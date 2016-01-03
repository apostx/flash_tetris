package dh.tetris.mvc.view {
	import dh.tetris.mvc.ApplicationFacade;
	import dh.tetris.mvc.view.components.GameTable;
	import dh.tetris.mvc.view.components.IGameTable;
	import dhlib.engine.tetris.IShape;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class GameMediator extends Mediator {
		
		static public const NAME:String = "GameMediator";
		
		private function get _table():IGameTable {
			return viewComponent as IGameTable;
		}
		
		public function GameMediator(viewComponent:Object,root:DisplayObjectContainer) {
			super(NAME, viewComponent);
			root.addChild(viewComponent as DisplayObject);
			_table.x = (_table.stage.stageWidth - _table.width) / 2;
			_table.y = (_table.stage.stageHeight - _table.height) / 2;
		}
		
		public function start():void {
			_table.stage.addEventListener(MouseEvent.CLICK, clickHandler, true);
			_table.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		public function pause():void {
			_table.stage.removeEventListener(MouseEvent.CLICK, clickHandler, true);
			_table.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function clickHandler(event:Event):void {
			sendNotification(ApplicationFacade.SHOW_MENU, false);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case Keyboard.DOWN:
					sendNotification(ApplicationFacade.FORCED_NEXT_STEP);
					break;
				
				case Keyboard.UP:
					sendNotification(ApplicationFacade.MOVE_SHAPE, 0);
					break;
				
				case Keyboard.LEFT:
					sendNotification(ApplicationFacade.MOVE_SHAPE, -1);
					break;
				
				case Keyboard.RIGHT:
					sendNotification(ApplicationFacade.MOVE_SHAPE, 1);
					break;
			}
		}
		
		override public function listNotificationInterests():Array {
            return [ 
				ApplicationFacade.SHAPE_MOVED,
				ApplicationFacade.TABLE_CHANGED
            ];
        }
		
		override public function handleNotification(note:INotification):void {
            switch (note.getName()) {
                
                case ApplicationFacade.SHAPE_MOVED:
					_table.moveShape(note.getBody() as IShape);
                    break;

				case ApplicationFacade.TABLE_CHANGED:
					_table.initTable(note.getBody() as Vector.<Vector.<Boolean>>);
                    break;
            }
        }
	}
}