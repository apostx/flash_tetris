package dhlib.engine.tetris {

	/**
	 * Group of elements in 2D space
	 */
	public interface IShape extends IPosition {
		
		/**
		 * List of the elements
		 */
		function get blocks():Vector.<IPosition>;
	}
}