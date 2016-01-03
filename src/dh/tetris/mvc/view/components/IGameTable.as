package dh.tetris.mvc.view.components {
	import dhlib.engine.tetris.IShape;
	
	public interface IGameTable extends IDisplayObject {
		
		/**
		 * Redraw the shape
		 */
		function moveShape(shape:IShape):void;
		
		/**
		 * Redraw the fixed blocks
		 */
		function initTable(tableData:Vector.<Vector.<Boolean>>):void;
	}
}