package dh.tetris.mvc.model.vo {
	import flash.display.DisplayObjectContainer;

	public class Config implements IConfig {
		
		public var _root:DisplayObjectContainer;
		public var _tableColNum:uint;
		public var _tableRowNum:uint;
		public var _tableBlockSize:Number;
		
		public function Config(root:DisplayObjectContainer, tableColNum:uint, tableRowNum:uint, tableBlockSize:Number) {
			_root = root;
			_tableColNum = tableColNum;
			_tableRowNum = tableRowNum;
			_tableBlockSize = tableBlockSize;
		}
		
		public function get root():DisplayObjectContainer {
			return _root;
		}
		
		public function get tableColNum():uint {
			return _tableColNum;
		}
		
		public function get tableRowNum():uint {
			return _tableRowNum;
		}
		
		/**
		 * @see IConfig#tableBlockSize
		 */
		public function get tableBlockSize():Number {
			return _tableBlockSize;
		}
	}
}