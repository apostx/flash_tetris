package dhlib.engine.tetris {

	/**
	 * Simple struct of a coordinate of element in 2d space with integer values
	 */
	public interface IPosition {
		
		/**
		 * Horizontal value
		 */
		function get x():int;
		
		/**
		 * Vertival value
		 */
		function get y():int;
	}
}