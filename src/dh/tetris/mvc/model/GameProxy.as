package dh.tetris.mvc.model {
	import dh.tetris.mvc.ApplicationFacade;
	import dhlib.engine.tetris.Game;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class GameProxy extends Proxy {
		
		static public const NAME:String = "GameProxy";
		
		private var _timer:Timer = new Timer(300);
		
		private function get _game():Game {
			return data as Game;
		}
		
		public function GameProxy(data:Object=null) {
			super(NAME, data);
			
			_timer.addEventListener(TimerEvent.TIMER, next);
		}
		
		private function next(e:Event = null):void {
			var hasNext:Boolean = _game.next();
			
			sendNotification(ApplicationFacade.SHAPE_MOVED, _game.shape);
			
			if (_game.tableChanged)
				sendNotification(ApplicationFacade.TABLE_CHANGED, _game.table);
				
			if (!hasNext)
				sendNotification(ApplicationFacade.SHOW_MENU,true);
		}
		
		public function start():void {
			_timer.start();
		}
		
		public function pause():void {
			_timer.reset();
		}
		
		public function reset():void {
			_game.reset();
			
			sendNotification(ApplicationFacade.SHAPE_MOVED, _game.shape);
			sendNotification(ApplicationFacade.TABLE_CHANGED, _game.table);
		}
		
		/**
		 * Move or rotate shape
		 * 
		 * @param	direction [0]-rotate, [< 0]-move left, [0 <]-move right
		 */
		public function moveShape(direction:Number):void {
			if (direction == 0)
				_game.rotateShape();
				
			else
				_game.moveShape(direction);
				
			sendNotification(ApplicationFacade.SHAPE_MOVED, _game.shape);
		}
		
		public function forceNext():void {
			next();
			_timer.reset();
			_timer.start();
		}
	}
}