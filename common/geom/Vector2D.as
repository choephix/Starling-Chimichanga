package chimichanga.common.geom {
	
	/**
	 * ...
	 * @author choephix
	 */
	public final class Vector2D {
		
		public var x:Number;
		public var y:Number;
		
		public function Vector2D(x:Number = 0, y:Number = 0) {
			setXY(x, y);
		}
		
		public function setXY(x:Number = 0, y:Number = 0):void {
			this.x = x;
			this.y = y;
		}
		
		public function clone():Vector2D {
			return new Vector2D( x, y );
		}
	
	}

}