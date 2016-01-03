package dhlib.engine.tetris.core {
	import dhlib.engine.tetris.IPosition;
	import dhlib.engine.tetris.IShape;
	
	public class GameUtils {
		
		/**
		 * Check the vector has just false [-1], just true [1] or both [0]; 
		 * 
		 * @return	-1 - Just false values, 0 - Mixed values, 1 - Just true values
		 */
		static public function checkRow(row:Vector.<Boolean>):int {
			var count:uint = 0;
			for each(var block:Boolean in row)
				if (block)
					++count;
			
			return count == row.length ? 1 : (count == 0 ? -1 : 0);
		}
		
		/**
		 * Set block of table to true if blocks of shape and table are equal in coordinates
		 */
		static public function addShapeToTable(shape:IShape, table:Vector.<Vector.<Boolean>>):void {
			var y:int;
			var rowNum:uint = table.length;
			for each(var block:IPosition in shape.blocks) {
				y = shape.y + block.y;
				
				if (y < rowNum)
					table[shape.y + block.y][shape.x + block.x] = true;
			}
		}
		
		/**
		 * Check shape and table have same coordinates and return the result.
		 * 
		 * @return	Hit
		 */
		static public function checkShapeHitBlock(shape:IShape, table:Vector.<Vector.<Boolean>>):Boolean {
			var hit:Boolean = false;
			var rowNum:uint = table.length;
			var y:int;
			
			for each(var block:IPosition in shape.blocks) {
				y = shape.y + block.y;
					
				if ((y < rowNum && table[y][shape.x + block.x])) {
					hit = true;
					break;
				}
			}
			
			return hit;
		}
		
		/**
		 * Check shape and table have same coordinates or coordinates of shape are out of table. Return the result
		 * 
		 * @return	Hit or out of table
		 */
		static public function checkShapeHit(shape:Shape, table:Vector.<Vector.<Boolean>>):Boolean {
			return shape.minX < 0 || table[0].length <= shape.maxX || shape.minY < 0 || checkShapeHitBlock(shape,table);
		}
		
		/**
		 * Remove filled rows and move down the other
		 */
		static public function manageModifiedTable(table:Vector.<Vector.<Boolean>>):void {
			var emptyRowIndex:int = -1;
			var row:Vector.<Boolean>;
			var rowNum:uint = table.length;
			for (var i:uint = 0; i < rowNum; ++i) {
				row = table[i];
				switch(checkRow(row)) {
					case 0:
						if (-1 < emptyRowIndex) {
							table[i] = table[emptyRowIndex];
							table[emptyRowIndex] = row;
							++emptyRowIndex;
						}
						break;
					case 1:
						if (emptyRowIndex == -1)
							emptyRowIndex = i;

						clearRow(row);
						break;
				}
			}
		}
		
		/**
		 * Set every value of row to false
		 */
		static public function clearRow(row:Vector.<Boolean>):void {
			var length:uint = row.length;
			for (var i:uint = 0; i < length; ++i)
					row[i] = false;
		}
		
		/**
		 * Set every value of matrix to false
		 */
		static public function clearTable(table:Vector.<Vector.<Boolean>>):void {
			for each(var row:Vector.<Boolean> in table)
				clearRow(row);
		}
		
		/**
		 * Create a boolean matrix with false values
		 * 
		 * @return	False boolean matrix
		 */
		static public function createTable(colNum:uint, rowNum:uint):Vector.<Vector.<Boolean>> {
			var table:Vector.<Vector.<Boolean>> = new Vector.<Vector.<Boolean>>(rowNum);
			for (var i:uint = 0; i < rowNum; ++i)
				table[i] = new Vector.<Boolean>(colNum);
				
			return table;
		}
		
		
		/**
		 * Choose a random shape from the list
		 * 
		 * @return 	A random shape
		 */
		static public function randomShape(shapes:Vector.<Shape>):Shape {
			return shapes[Math.round((shapes.length - 1) * Math.random())];
		}
		
		/**
		 * Rotate back shape to original state and move it to above the table
		 */
		static public function initShape(shape:Shape, colNum:uint, rowNum:uint):void {
			shape.reset();
			shape.x = Math.floor(colNum / 2) - shape.blocksCenterX;
			shape.y = rowNum - shape.blocksMinY;
		}
		
		/**
		 * Rotate shape if the new state of shape is not out of table and don't hit fixed blocks. Return success of action
		 * 
		 * @return	Success
		 */
		static public function rotateShapeInTable(shape:Shape, table:Vector.<Vector.<Boolean>>):Boolean {
			var succ:Boolean = true;
			shape.rotate();
			
			if (checkShapeHit(shape, table)) {
				succ = false;
				shape.rotateBack();
			}
			
			return succ;
		}
		
		/**
		 * Move shape horizontally with one unit if the new state of shape is not out of table and don't hit fixed blocks. Return success of action
		 * 
		 * @param	direction	Less than zero is a negativ unit. More or equal than zero is a positive unit.
		 * @return	Success
		 */
		static public function moveShapeHorizontalInTable(shape:Shape,table:Vector.<Vector.<Boolean>>,direction:Number):Boolean {
			var succ:Boolean = true;
			var d:int = 0 <= direction ? 1 : -1;
			shape.x += d;
			
			if (checkShapeHit(shape, table)) {
				shape.x -= d;
				succ = false;
			}
			
			return succ;
		}
		
		/**
		 * Move shape vertically with one negative unit if the new state of shape is not out of table and don't hit fixed blocks. Return success of action
		 * 
		 * @return Success
		 */
		static public function moveShapeDownInTable(shape:Shape,table:Vector.<Vector.<Boolean>>):Boolean {
			var succ:Boolean = true;
			--shape.y;
			
			if (checkShapeHit(shape, table)) {
				++shape.y;
				succ = false;
			}
			
			return succ;
		}
	}
}