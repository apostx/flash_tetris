package dhlib.engine.tetris {
	import dhlib.engine.tetris.core.Shape;
	import org.flexunit.Assert;
	
	public class GameTest {
		
		private var _game:Game;
		
		[Before]
		public function setup():void {
			_game = new Game(5,1);
		}
		
		[Test]
		public function initTest():void {
			const COL_NUM:uint = 11;
			const ROW_NUM:uint = 6;
			
			_game.init(COL_NUM, ROW_NUM);
			
			Assert.assertEquals(COL_NUM, _game.colNum);
			Assert.assertEquals(ROW_NUM, _game.rowNum);
			Assert.assertEquals(true, _game.hasNext);
			Assert.assertNotNull(_game.table);
			Assert.assertWith(initTableAsserter, _game.table, COL_NUM);
			Assert.assertNotNull(_game.shape);
			Assert.assertEquals(ROW_NUM, _game.shape.y);
		}
		
		[Test]
		public function nextTest():void {
			
			// Game is running
			Assert.assertEquals(true, _game.next());
			
			// Need it for single line shape
			_game.next(); 
			
			// Game is ended
			Assert.assertEquals(false, _game.next());
		}
		
		[Test]
		public function resetTest():void {
			
			_game.next();
			_game.next();
			
			// Game is ended
			_game.reset();
			
			// Game is running
			Assert.assertEquals(true, _game.hasNext);
			
			// Shape is in start position
			Assert.assertEquals(1, (_game.shape as Shape).minY);
			Assert.assertEquals(2, _game.shape.x + (_game.shape as Shape).blocksCenterX);
		}
		
		private static function initTableAsserter(table:Vector.<Vector.<Boolean>>, colNum:uint):void {
			for each(var row:Vector.<Boolean> in table) {
				for each(var blockData:Boolean in row)
					Assert.assertFalse(blockData);
			}
		}
	}
}