package dh.tetris.mvc.view.components {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	/**
	 * @see IMenu
	 */
	public class Menu extends Sprite implements IMenu {
		
		[Embed(source = "../../../../../../assets/graphic/play_btn.png")]
		private static const StartButton:Class;
		
		[Embed(source = "../../../../../../assets/graphic/restart_btn.png")]
		private static const RestartButton:Class;
		
		private var _background:Shape;
		private var _startButton:DisplayObjectContainer;
		private var _restartButton:DisplayObjectContainer;
		
		public function get startButton():IEventDispatcher {
			return _startButton;
		}
		
		public function get restartButton():IEventDispatcher {
			return _restartButton;
		}
		
		public function Menu(width:Number,height:Number) {
			super();
			
			_background = new Shape();
			_startButton = new Sprite()
			_restartButton = new Sprite();
			
			initBackground(width, height);
			
			_startButton.addChild(new StartButton() as DisplayObject);
			_restartButton.addChild(new RestartButton() as DisplayObject);
			
			var space:Number = (height - _startButton.height - _restartButton.height) / 3;
			
			_startButton.x = (width - _startButton.width) / 2;
			_startButton.y = space;
			
			_restartButton.x = (width - _restartButton.width) / 2;
			_restartButton.y = _startButton.height + 2 * space;
			
			addChild(_background);
			addChild(_startButton);
			addChild(_restartButton).visible = false;
		}
		
		/**
		 * Color the background layer
		 */
		private function initBackground(width:Number,height:Number):void {
			var g:Graphics = _background.graphics;
			g.moveTo(0, 0);
			g.lineStyle();
			g.beginFill(0xFFFFFF,0.5);
			g.drawRect(0, 0, width, height);
			g.endFill();
		}
		
		/**
		 * @see IMenu#show()
		 */
		public function show(end:Boolean = false):void {
			visible = true;
			_startButton.visible = !end;
			_restartButton.visible = true;
		}
		
		public function hide():void {
			visible = false;
		}
	}
}