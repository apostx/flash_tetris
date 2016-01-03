package dhlib.engine {
	import dhlib.engine.tetris.core.GameUtilsTest;
	import dhlib.engine.tetris.core.PositionTest;
	import dhlib.engine.tetris.core.ResettablePositionTest;
	import dhlib.engine.tetris.core.ShapeTest;
	import dhlib.engine.tetris.GameTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")] 
	public class TetrisSuit {
		public var positionTest:PositionTest;
		public var resettablePositionTest:ResettablePositionTest;
		public var shapeTest:ShapeTest;
		public var gameUtilsTest:GameUtilsTest;
		public var gameTest:GameTest;
	}
}