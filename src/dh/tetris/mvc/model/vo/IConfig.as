package dh.tetris.mvc.model.vo {
	import flash.display.DisplayObjectContainer;

	public interface IConfig {
		function get root():DisplayObjectContainer;
		
		function get tableColNum():uint;
		function get tableRowNum():uint;
		
		/**
		 * Width and height of block in pixel
		 */
		function get tableBlockSize():Number;
	}
}