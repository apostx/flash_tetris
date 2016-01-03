package dhlib.engine.tetris.core {
	import dhlib.engine.tetris.IPosition;
	import flash.geom.Point;
	import org.flexunit.Assert;

	public class ShapeTest {
		
		private var _shape:Shape;
		private var _blocks:Vector.<IPosition>;
		
		[Before]
		public function setup():void {
			_blocks= new <IPosition> [
				new ResettablePosition(0, 0),
				new ResettablePosition(1, 0),
				new ResettablePosition(1, 1),
				new ResettablePosition(2, 1)
			];
			
			_shape = new Shape(_blocks, new Point(1, 0.5));
			_shape.x = -3;
			_shape.y = -1;
		}
		
		[Test]
		public function getBlocksTest():void {
			Assert.assertEquals(_blocks,_shape.blocks);
		}
		
		[Test]
		public function getMinXTest():void {
			Assert.assertEquals(-3,_shape.minX);
		}
		
		[Test]
		public function getMaxXTest():void {
			Assert.assertEquals(-1,_shape.maxX);
		}
		
		[Test]
		public function getBlocksCenterXTest():void {
			Assert.assertEquals(1,_shape.blocksCenterX);
		}
		
		[Test]
		public function getBlocksMinYTest():void {
			Assert.assertEquals(0,_shape.blocksMinY);
		}
		
		[Test]
		public function getMinYTest():void {
			Assert.assertEquals(-1,_shape.minY);
		}
		
		[Test]
		public function getMaxYTest():void {
			Assert.assertEquals(0,_shape.maxY);
		}
		
		[Test]
		public function rotateTest():void {
			_shape.rotate();
			
			var blocks:Vector.<IPosition> = _shape.blocks;
			
			Assert.assertNotNull(blocks);
			Assert.assertEquals(4, blocks.length);
			
			Assert.assertWith(blockAsserter, 1, 2, blocks[0]);
			Assert.assertWith(blockAsserter, 1, 1, blocks[1]);
			Assert.assertWith(blockAsserter, 2, 1, blocks[2]);
			Assert.assertWith(blockAsserter, 2, 0, blocks[3]);
		}
		
		[Test]
		public function rotateBackTest():void {
			_shape.rotateBack();
			
			var blocks:Vector.<IPosition> = _shape.blocks;
			
			Assert.assertNotNull(blocks);
			Assert.assertEquals(4, blocks.length);
			
			Assert.assertWith(blockAsserter, 2, 0, blocks[0]);
			Assert.assertWith(blockAsserter, 2, 1, blocks[1]);
			Assert.assertWith(blockAsserter, 1, 1, blocks[2]);
			Assert.assertWith(blockAsserter, 1, 2, blocks[3]);
		}
		
		[Test]
		public function resetTest():void {
			_shape.rotate();
			_shape.reset();
			
			var blocks:Vector.<IPosition> = _shape.blocks;
			
			Assert.assertNotNull(blocks);
			Assert.assertEquals(4, blocks.length);
			
			Assert.assertWith(blockAsserter, 0, 0, blocks[0]);
			Assert.assertWith(blockAsserter, 1, 0, blocks[1]);
			Assert.assertWith(blockAsserter, 1, 1, blocks[2]);
			Assert.assertWith(blockAsserter, 2, 1, blocks[3]);
		}
		
		private static function blockAsserter(x:int, y:int, block:IPosition):void {
			Assert.assertEquals(x, block.x);
			Assert.assertEquals(y, block.y);
		}
	}
}