package dhlib.engine.tetris.core {

	/**
	 * Simple struct of a coordinate with integer values. Save start position and can move to there
	 */
	public class ResettablePosition extends Position {
		
		private var _startX:int;
		private var _startY:int;
		
		/**
		 * First horizontal value
		 */
		public function get startX():int {
			return _startX;
		}
		
		/**
		 * First vertical value
		 */
		public function get startY():int {
			return _startY;
		}
		
		/**
		 * @param	x	Horizontal value
		 * @param	y	Vertival value
		 */
		public function ResettablePosition(x:int, y:int) {
			super(x, y);
			
			_startX = x;
			_startY = y;
		}
		
		/**
		 * Set coordinates to start coordinates 
		 */
		public function reset():void {
			_x = _startX;
			_y = _startY;
		}
	}
}