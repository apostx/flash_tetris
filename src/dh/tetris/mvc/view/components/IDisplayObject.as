package dh.tetris.mvc.view.components {
	import flash.display.Stage;
	
	/**
	 * An interface to needed display object variables
	 */
	public interface IDisplayObject {
		
		function get x():Number;
		function set x(value:Number):void;
		

		function get y():Number;
		function set y(value:Number):void;
		
		function get width():Number;
		function get height():Number;
		
		function get visible():Boolean
		function set visible(value:Boolean):void
		
		function get stage():Stage;
	}
}