package dhlib.engine.tetris.core {
	import org.flexunit.Assert;

	public class ResettablePositionTest {
		
		private static const X:int = -2;
		private static const Y:int = -1;
		
		private var _position:ResettablePosition;
		
		[Before]
		public function setup():void {
			_position = new ResettablePosition(X, Y);
		}
		
		[Test]
		public function getStartXTest():void {
			Assert.assertEquals(X, _position.startX);
		}
		
		[Test]
		public function getStartYTest():void {
			Assert.assertEquals(Y, _position.startY);
		}
		
		[Test]
		public function resetTest():void {
			_position.x = -4;
			_position.y = -3;
			
			_position.reset();
			
			Assert.assertEquals(X, _position.x);
			Assert.assertEquals(Y, _position.y);
		}
	}
}