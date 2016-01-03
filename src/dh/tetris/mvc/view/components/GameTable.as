package dh.tetris.mvc.view.components {
	import dhlib.engine.tetris.IPosition;
	import dhlib.engine.tetris.IShape;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * @see IGameTable
	 */
	public class GameTable extends Sprite implements IGameTable {
		
		private var _colNum:uint;
		private var _rowNum:uint;
		private var _blockSize:Number;
		
		private var _tableLayer:Shape;
		private var _shapeLayer:Shape;
		private var _gridLayer:Shape;
		
		/**
		 * @param	blockSize	Width and height of block in pixel
		 */
		public function GameTable(colNum:uint, rowNum:uint, blockSize:Number) {
			super();

			_colNum = colNum;
			_rowNum = rowNum;
			_blockSize = blockSize;
			
			_tableLayer = new Shape();
			_shapeLayer = new Shape();
			_gridLayer = new Shape();
			
			addChild(_tableLayer);
			addChild(_shapeLayer);
			addChild(_gridLayer);
			
			drawBackground();
			drawGrid();
		}
		
		/**
		 * @see IGameTable#moveShape()
		 */
		public function moveShape(shape:IShape):void {
			_shapeLayer.graphics.clear();
			for each(var block:IPosition in shape.blocks)
				if (shape.y + block.y < _rowNum)
					drawBlock(_shapeLayer.graphics,shape.x + block.x, shape.y + block.y,0xFF0000);
		}
		
		/**
		 * @see IGameTable#initTable()
		 */
		public function initTable(tableData:Vector.<Vector.<Boolean>>):void {
			drawBackground();
			drawTable(tableData);
		}
		
		private function drawBackground():void {
			drawRect(_tableLayer.graphics,0,0,_colNum * _blockSize,_rowNum * _blockSize,0x000000);
		}
		
		private function drawTable(tableData:Vector.<Vector.<Boolean>>):void {
			var colIndex:uint;
			var rowIndex:uint;
			
			var rowNum:uint = tableData.length;
			var colNum:uint;
			
			var row:Vector.<Boolean>;
			
			for (rowIndex = 0; rowIndex < rowNum; ++rowIndex) {
				row = tableData[rowIndex];
				colNum = row.length;
				
				for (colIndex = 0; colIndex < colNum; ++colIndex)
					if (row[colIndex])	
						drawBlock(_tableLayer.graphics,colIndex,rowIndex,0xFFFFFF);
			}
		}
		
		private function drawBlock(g:Graphics,colIndex:uint,rowIndex:uint,color:uint):void {
			drawRect(g,colIndex*_blockSize,(_rowNum - 1 - rowIndex) * _blockSize,_blockSize,_blockSize,color);
		}
		
		private function drawRect(g:Graphics ,x:Number,y:Number,width:Number,height:Number,color:uint):void {
			g.moveTo(0, 0);
			g.lineStyle(0);
			g.beginFill(color);
			g.drawRect(x, y, width, height);
			g.endFill();
		}
		
		private function drawGrid():void {
			var g:Graphics = _gridLayer.graphics;
			
			g.moveTo(0, 0);
			g.lineStyle(1,0x000000);
			g.drawRect(0, 0, _colNum * _blockSize, _rowNum * _blockSize);
			
			var i:uint;
			var tx:Number;
			var ty:Number;
			
			for (i = 1; i < _colNum; ++i) {
				tx = i * _blockSize;
				g.moveTo(tx, 0);
				g.lineTo(tx, _rowNum * _blockSize);
			}
			
			for (i = 1; i < _rowNum; ++i) {
				ty = i * _blockSize;
				g.moveTo(0, ty);
				g.lineTo(_colNum * _blockSize, ty);
			}
		}
	}
}