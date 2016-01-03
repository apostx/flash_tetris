package dh.tetris.mvc.view.components {
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	
	public interface IMenu extends IDisplayObject {
		
		function get startButton():IEventDispatcher;
		function get restartButton():IEventDispatcher;
		
		/**
		 * @param	end	Game ended flag
		 */
		function show(end:Boolean = false):void;
		
		function hide():void;
	}
}