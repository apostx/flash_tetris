package dhlib.engine.tetris {
	import dhlib.engine.tetris.core.Shape;
	import dhlib.engine.tetris.core.ResettablePosition;
	import dhlib.engine.tetris.core.GameUtils;
	import flash.geom.Point;

	public class Game {
		
		/**
		 * Matrix of fixed blocks
		 */
		private var _table:Vector.<Vector.<Boolean>>;
		
		/**
		 * Number of columns of table
		 */
		private var _colNum:uint;
		
		/**
		 * Number of rows of table
		 */
		private var _rowNum:uint;
		
		/**
		 * List of movable shapes
		 */
		private var _shapes:Vector.<Shape>;
		
		/**
		 * Movable shape
		 */
		private var _shape:Shape;
		
		/**
		 * State flag. Show if fixed blocks are changed.
		 */
		private var _tableChanged:Boolean;
		
		/**
		 * State flag. Show end of game. True if not end.
		 */
		private var _hasNext:Boolean;
		
		/**
		 * Number of columns of table
		 */
		public function get colNum():uint {
			return _colNum;
		}
		
		/**
		 * Number of rows of table
		 */
		public function get rowNum():uint {
			return _rowNum;
		}
		
		/**
		 * State flag. Show end of game. True if not end.
		 */
		public function get hasNext():Boolean {
			return _hasNext;
		}
		
		/**
		 * State flag. Show if fixed blocks are changed.
		 */
		public function get tableChanged():Boolean {
			return _tableChanged;
		}
		
		/**
		 * Movable shape
		 */
		public function get shape():IShape {
			return _shape;
		}
		
		/**
		 * Matrix of fixed blocks
		 */
		public function get table():Vector.<Vector.<Boolean>> {
			return _table;
		}
		
		public function Game(colNum:uint, rowNum:uint) {
			_shapes = new <Shape> [
				/*
				 * Shape:
				 *  ++
				 *  ++
				 */
				new Shape(
					new <IPosition> [
						new ResettablePosition(0, 0),
						new ResettablePosition(1, 0),
						new ResettablePosition(0, 1),
						new ResettablePosition(1, 1)
					],
					new Point(0.5, 0.5)
				),
				
				/*
				 * Shape:
				 *  ++
				 *   ++
				 */
				new Shape(
					new <IPosition> [
						new ResettablePosition(1, 0),
						new ResettablePosition(2, 0),
						new ResettablePosition(0, 1),
						new ResettablePosition(1, 1)
					],
					new Point(1, 0.5)
				),
				
				/*
				 * Shape:
				 *   ++
				 *  ++
				 */
				new Shape(
					new <IPosition> [
						new ResettablePosition(0, 0),
						new ResettablePosition(1, 0),
						new ResettablePosition(1, 1),
						new ResettablePosition(2, 1)
					],
					new Point(1, 0.5)
				),
				
				/*
				 * Shape:
				 *  ++++
				 */
				new Shape(
					new <IPosition> [
						new ResettablePosition(0, 0),
						new ResettablePosition(1, 0),
						new ResettablePosition(2, 0),
						new ResettablePosition(3, 0)
					],
					new Point(1.5, 0)
				),
				
				/*
				 * Shape:
				 *   +
				 *  +++
				 */
				new Shape(
					new <IPosition> [
						new ResettablePosition(0, 0),
						new ResettablePosition(1, 0),
						new ResettablePosition(2, 0),
						new ResettablePosition(1, 1)
					],
					new Point(1, 0.5)
				),
				
				/*
				 * Shape:
				 *  +
				 *  +++
				 */
				new Shape(
					new <IPosition> [
						new ResettablePosition(0, 0),
						new ResettablePosition(1, 0),
						new ResettablePosition(2, 0),
						new ResettablePosition(0, 1)
					],
					new Point(1, 0.5)
				),
				
				/*
				 * Shape:
				 *    +
				 *  +++
				 */
				new Shape(
					new <IPosition> [
						new ResettablePosition(0, 0),
						new ResettablePosition(1, 0),
						new ResettablePosition(2, 0),
						new ResettablePosition(2, 1)
					],
					new Point(1, 0.5)
				)
			];
			
			init(colNum, rowNum);
		}
		
		/**
		 * Init the game. Need it to first start.
		 */
		public function init(colNum:uint, rowNum:uint):void {
			_colNum = colNum;
			_rowNum = rowNum;
			_hasNext = true;
			_table = GameUtils.createTable(colNum, rowNum);
			
			initShape();
		}
		
		/**
		 * Set state of game to start state
		 */
		public function reset():void {
			_hasNext = true;
			
			GameUtils.clearTable(_table);
			initShape();
		}
		
		/**
		 * If it's possible, it rotates shape to right
		 */
		public function rotateShape():void {
			GameUtils.rotateShapeInTable(_shape, _table);
		}
		
		/**
		 * If it's possible, it moves shape to horizontal direction with one unit.
		 * 
		 * @param direction	Less than zero is a negativ unit. More or equal than zero is a positive unit.
		 */
		public function moveShape(direction:Number):void {
			GameUtils.moveShapeHorizontalInTable(_shape, _table,direction);
		}
		
		/**
		 * Move the game process to next step. Move shape the next position and handle the new state.
		 * 
		 * @return End of game. False if it's end.
		 */
		public function next():Boolean {
			_tableChanged = false;
			
			if (!_hasNext)
				return false;
			
			if (!GameUtils.moveShapeDownInTable(_shape,_table)) {
				GameUtils.addShapeToTable(_shape,_table);
				_tableChanged = true;
				_hasNext = _shape.maxY < _rowNum;
				initShape();
				GameUtils.manageModifiedTable(_table);
			}
			
			return _hasNext;
		}
		
		/**
		 * Select and position a new shape
		 */
		private function initShape():void {
			_shape = GameUtils.randomShape(_shapes);
			GameUtils.initShape(_shape, colNum, rowNum);
		}
	}
}