package dhlib.engine.tetris.core {
	import dhlib.engine.tetris.IPosition;

	/**
	 * @see dhlib.engine.tetris.IPosition
	 */
	public class Position implements IPosition {
		
		/**
		 * Horizontal value
		 */
		protected var _x:int;
		
		/**
		 * Vertival value
		 */
		protected var _y:int;
		
		/**
		 * @see dhlib.engine.tetris.IPosition#x
		 */
		public function get x():int {
			return _x;
		}
		
		/**
		 * @see dhlib.engine.tetris.IPosition#y
		 */
		public function get y():int {
			return _y;
		}
		
		/**
		 * @see dhlib.engine.tetris.IPosition#x
		 */
		public function set x(value:int):void {
			_x = value;
		}
		
		/**
		 * @see dhlib.engine.tetris.IPosition#y
		 */
		public function set y(value:int):void {
			_y = value;
		}
		
		/**
		 * @param	x	Horizontal value
		 * @param	y	Vertival value
		 */
		public function Position(x:int, y:int) {
			_x = x;
			_y = y;
		}
	}
}