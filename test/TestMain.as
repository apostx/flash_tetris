package {
	import dhlib.engine.TetrisSuit;
	import flash.display.Sprite;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	
	public class TestMain extends Sprite {
		
		public function TestMain() {
			var test:FlexUnitCore = new FlexUnitCore();
			test.addListener(new TraceListener());
			test.run(TetrisSuit);
		}
	}
}