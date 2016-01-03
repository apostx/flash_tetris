package dhlib.engine.tetris.core {
	import dhlib.engine.tetris.IPosition;
	import flash.geom.Point;
	import org.flexunit.Assert;
	
	public class GameUtilsTest {
		
		private var _shape:Shape;
		private var _blocks:Vector.<IPosition>;
		private var _table:Vector.<Vector.<Boolean>>;
		
		[Before]
		public function setup():void {
			_blocks= new <IPosition> [
				new ResettablePosition(0, 0),
				new ResettablePosition(0, 1),
				new ResettablePosition(0, 2),
				new ResettablePosition(0, 3)
			];
			
			_shape = new Shape(_blocks, new Point(0, 1.5));
			_shape.x = 2;
			_shape.y = 4;
			
			_table = new < Vector.<Boolean> > [
				new <Boolean> [true,true,true,true],
				new <Boolean> [true,false,false,true],
				new <Boolean> [true,true,true,true],
				new <Boolean> [true,true,false,true],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
			];
		}
		
		[Test]
		public function addShapeToTableTest():void {
			const TABLE:Vector.<Vector.<Boolean>> = new <Vector.<Boolean>> [
				new <Boolean> [true,true,true,true],
				new <Boolean> [true,false,false,true],
				new <Boolean> [true,true,true,true],
				new <Boolean> [true,true,false,true],
				new <Boolean> [false,false,true,false],
				new <Boolean> [false,false,true,false],
				new <Boolean> [false,false,true,false],
				new <Boolean> [false,false,true,false]
			];
			
			GameUtils.addShapeToTable(_shape, _table);
			
			Assert.assertWith(tableAsserter, TABLE, _table);
		}
		
		[Test]
		public function checkRowTest():void {
			
			// Filled row
			Assert.assertEquals(1, GameUtils.checkRow(_table[2]));
			
			// Mixed row
			Assert.assertEquals(0, GameUtils.checkRow(_table[3]));
			
			// Empty row
			Assert.assertEquals(-1, GameUtils.checkRow(_table[4]));
		}
		
		[Test]
		public function checkShapeHitTest():void {
			
			// No hit
			Assert.assertEquals(false,GameUtils.checkShapeHit(_shape, _table));
			
			// Hit block
			_shape.y = 2;
			Assert.assertEquals(true, GameUtils.checkShapeHit(_shape, _table));
			
			// Hit left "wall"
			_shape.x = -1;
			Assert.assertEquals(true, GameUtils.checkShapeHit(_shape, _table));
			
			// Hit right "wall"
			_shape.x = 4;
			Assert.assertEquals(true, GameUtils.checkShapeHit(_shape, _table));
			
			// Hit bottom "wall"
			_shape.x = 0;
			_shape.y = -4;
			Assert.assertEquals(true, GameUtils.checkShapeHit(_shape, _table));
		}
		
		[Test]
		public function checkShapeHitBlockTest():void {
			
			// No hit
			Assert.assertEquals(false,GameUtils.checkShapeHitBlock(_shape, _table));
			
			// Hit block
			_shape.y -= 2;
			Assert.assertEquals(true,GameUtils.checkShapeHitBlock(_shape, _table));
		}
		
		[Test]
		public function clearRowTest():void {
			const ROW:Vector.<Boolean> = new <Boolean> [false,false,false,false];
			
			GameUtils.clearRow(_table[1]);
			
			Assert.assertWith(rowAsserter, ROW, _table[1]);
		}
		
		[Test]
		public function clearTableTest():void {
			const TABLE:Vector.<Vector.<Boolean>> = new <Vector.<Boolean>> [
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false]
			];
			
			GameUtils.clearTable(_table);
			
			Assert.assertWith(tableAsserter, TABLE, _table);
		}
		
		[Test]
		public function createTableTest():void {
			const TABLE:Vector.<Vector.<Boolean>> = new <Vector.<Boolean>> [
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false]
			];
			
			Assert.assertWith(tableAsserter, TABLE, GameUtils.createTable(4,3));
		}
		
		[Test]
		public function initShapeTest():void {
			GameUtils.initShape(_shape, 4, 8);
			
			// Shape start position
			Assert.assertEquals(2, _shape.x);
			Assert.assertEquals(8, _shape.y);
		}
		
		[Test]
		public function manageModifiedTableTest():void {
			const TABLE:Vector.<Vector.<Boolean>> = new <Vector.<Boolean>> [
				new <Boolean> [true,false,false,true],	
				new <Boolean> [true,true,false,true],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false],
				new <Boolean> [false,false,false,false]
			];
			
			GameUtils.manageModifiedTable(_table);
			
			Assert.assertWith(tableAsserter, TABLE, _table);
		}
		
		[Test]
		public function moveShapeDownInTableTest():void {
			
			// No hit
			Assert.assertEquals(true, GameUtils.moveShapeDownInTable(_shape, _table));
			
			// Hit block
			Assert.assertEquals(false, GameUtils.moveShapeDownInTable(_shape, _table));
		}
		
		[Test]
		public function moveShapeHorizontalInTableTest():void {
			// Move right - Not hit
			Assert.assertEquals(true, GameUtils.moveShapeHorizontalInTable(_shape, _table, 100.2));
			
			// Move right - Hit wall
			Assert.assertEquals(false, GameUtils.moveShapeHorizontalInTable(_shape, _table, 0));
			
			// Move left - No hit
			_shape.x = 1;
			Assert.assertEquals(true, GameUtils.moveShapeHorizontalInTable(_shape, _table, -2));
			
			// Move left - Hit wall
			Assert.assertEquals(false, GameUtils.moveShapeHorizontalInTable(_shape, _table, -10));
			
			// Between blocks - Move left and right - Hit block
			_shape.x = 2;
			_shape.y = 3;
			Assert.assertEquals(false, GameUtils.moveShapeHorizontalInTable(_shape, _table, -1));
			Assert.assertEquals(false, GameUtils.moveShapeHorizontalInTable(_shape, _table, 1));
		}
		
		[Test]
		public function randomShapeTest():void {
			const SHAPES:Vector.<Shape> = new <Shape>[_shape];
			
			Assert.assertEquals(_shape,GameUtils.randomShape(SHAPES));
		}
		
		[Test]
		public function rotateShapeInTableShapeTest():void {
			
			// Rotate on left side
			_shape.x = 0;
			Assert.assertEquals(false, GameUtils.rotateShapeInTable(_shape, _table));
			
			// Rotate on right side
			_shape.reset();
			_shape.x = 2;
			Assert.assertEquals(false, GameUtils.rotateShapeInTable(_shape, _table));
			
			// Rotate middle - No hit
			_shape.reset();
			_shape.x = 1;
			Assert.assertEquals(true, GameUtils.rotateShapeInTable(_shape, _table));
			
			// Rotate on block
			_shape.reset();
			_shape.x = 1;
			_shape.rotate();
			_shape.y = 3;
			Assert.assertEquals(false, GameUtils.rotateShapeInTable(_shape, _table));
		}
		
		/**
		 * Compare two row
		 */
		private static function rowAsserter(r1:Vector.<Boolean>, r2:Vector.<Boolean>):void {
			var length:uint = r1.length;
			
			Assert.assertEquals(length, r2.length);
			
			for (var i:uint = 0; i < length; ++i)
				Assert.assertEquals(r1[i], r2[i]);
		}
		
		/**
		 * Compare two table
		 */
		private static function tableAsserter(t1:Vector.<Vector.<Boolean>>, t2:Vector.<Vector.<Boolean>>):void {
			var length:uint = t1.length;
			
			Assert.assertEquals(length, t2.length);
			
			for (var i:uint = 0; i < length; ++i)
				rowAsserter(t1[i], t2[i]);
		}
	}
}