package dhlib.engine.tetris.core {
	import org.flexunit.Assert;
	
	public class PositionTest {
		
		private static const X:int = -2;
		private static const Y:int = -1;
		
		private var _position:Position;
		
		[Before]
		public function setup():void {
			_position = new Position(X, Y);
		}
		
		[Test]
		public function getXTest():void {
			Assert.assertEquals(X, _position.x);
		}
		
		[Test]
		public function getYTest():void {
			Assert.assertEquals(Y, _position.y);
		}
		
		[Test]
		public function setXTest():void {
			const X:int = -4;
			_position.x = X;
			
			Assert.assertEquals(X, _position.x);
		}
		
		[Test]
		public function setYTest():void {
			const Y:int = -4;
			_position.y = Y;
			
			Assert.assertEquals(Y, _position.y);
		}
	}
}