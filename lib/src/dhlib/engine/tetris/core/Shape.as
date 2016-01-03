package dhlib.engine.tetris.core {
	import dhlib.engine.tetris.IPosition;
	import dhlib.engine.tetris.IShape;
	import flash.geom.Point;

	/**
	 * Move and rotate a group of positions
	 */
	public class Shape extends Position implements IShape {
		
		/**
		 * Maximum value of rotation
		 */
		private static const MAX_ANGLE:uint = 360;
		
		/**
		 * Unit of rotation
		 */
		private static const ROTATE_ANGLE:uint = 90;
		
		/**
		 * List of elements of shape
		 */
		private var _blocks:Vector.<IPosition>;
		
		/**
		 * Center of rotation coordination system
		 */
		private var _origo:Point;
		
		/**
		 * Rotated angle
		 */
		private var _angle:uint;
		
		/**
		 * Least horizontal value of elements
		 */
		private function get _blocksMinX():int {
			var minX:int = int.MAX_VALUE;
			for each(var b:IPosition in _blocks)
				if (b.x < minX)
					minX = b.x;
			
			return minX;
		}
		
		/**
		 * Least horizontal value of area of shape
		 */
		public function get minX():int {
			return _x + _blocksMinX;
		}
		
		/**
		 * Greatest horizontal value of elements
		 */
		private function get _blocksMaxX():int {
			var maxX:int = int.MIN_VALUE;
			for each(var b:IPosition in _blocks)
				if (maxX < b.x)
					maxX = b.x;
			
			return maxX;
		}
		
		/**
		 * Greatest horizontal value of area of shape
		 */
		public function get maxX():int {
			return _x + _blocksMaxX;
		}
		
		/**
		 * Least vertical value of elements
		 */
		public function get blocksMinY():int {
			var minY:int = int.MAX_VALUE;
			for each(var b:IPosition in _blocks)
				if (b.y < minY)
					minY = b.y;
					
			return minY;
		}
		
		/**
		 * Least vertical value of area of shape
		 */
		public function get minY():int {
			return _y + blocksMinY;
		}
		
		/**
		 * Greatest vertical value of elements
		 */
		private function get _blocksMaxY():int {
			var maxY:int = int.MIN_VALUE;
			for each(var b:IPosition in _blocks)
				if (maxY < b.y)
					maxY = b.y;
			
			return maxY;
		}
		
		/**
		 * Greatest vertival value of area of shape
		 */
		public function get maxY():int {
			return _y + _blocksMaxY;
		}
		
		/**
		 * Middle horizontal value of positions of elements
		 */
		public function get blocksCenterX():int {
			return Math.ceil((_blocksMinX + _blocksMaxX) / 2);
		}
		
		/**
		 * @see dhlib.engine.tetris.IShape#blocks
		 */
		public function get blocks():Vector.<IPosition> {
			return _blocks;
		}
		
		/**
		 * @param	origo	Center of rotation coordination system
		 */
		public function Shape(blocks:Vector.<IPosition>,origo:Point) {
			super(0,0);
			
			_blocks = blocks;
			_origo = origo;
		}
		
		/**
		 * Rotate a block to new position
		 * 
		 * @param	origo	Center of rotation coordination system
		 */
		static private function rotateBlock(block:ResettablePosition, origo:Point, angle:Number):void {
			var bx:Number = block.startX;
			var by:Number = block.startY;
			var ox:Number = origo.x;
			var oy:Number = origo.y;
			
			angle = angle * Math.PI / 180;
			
			block.x = Math.ceil(Shape.roundToHalf(Math.cos(angle) * (bx - ox) - Math.sin(angle) * (by - oy) + ox));
			block.y = Math.ceil(Shape.roundToHalf(Math.sin(angle) * (bx - ox) + Math.cos(angle) * (by - oy) + oy));
		}
		
		/**
		 * Round a value to integer and half
		 * 
		 * @return	Rounded value
		 */
		static private function roundToHalf(value:Number):Number {
			return Math.round(value * 2) * 0.5;
		}
		
		/**
		 * Rotate shape right
		 */
		public function rotate():void {
			rotateBlocks(-ROTATE_ANGLE);
		}
		
		/**
		 * Rotate shape left
		 */
		public function rotateBack():void {
			rotateBlocks(ROTATE_ANGLE);
		}
		
		/**
		 * Rotation and move elements to new position
		 * 
		 * @param	alpha	Angle
		 */
		private function rotateBlocks(alpha:Number):void {
			_angle = (_angle + alpha + MAX_ANGLE) % MAX_ANGLE;
			for each(var block:IPosition in _blocks)
				rotateBlock(block as ResettablePosition,_origo,_angle);
		}
		
		/**
		 * Set position of elements to start position
		 */
		public function reset():void {
			_angle = 0;
			for each(var block:IPosition in _blocks)
				(block as ResettablePosition).reset();
		}
	}
}