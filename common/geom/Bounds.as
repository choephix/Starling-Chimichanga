package chimichanga.common.geom {
	import engine.utils.helpers.MathF;
	
	/**
	 * ...
	 * @author choephix
	 */
	public final class Bounds {
		
		public var x1:Number;
		public var x2:Number;
		public var y1:Number;
		public var y2:Number;
		
		public function get width():Number { return MathF.abs( x2 - x1 ); } //TODO turn into properties
		public function get height():Number { return MathF.abs( y2 - y1 ); }
		
		public function Bounds( x1:Number, x2:Number, y1:Number, y2:Number) {
			this.y2 = y2;
			this.y1 = y1;
			this.x2 = x2;
			this.x1 = x1;
		}
		
		public function clone():Bounds {
			return new Bounds( x1, x2, y1, y2 );
		}
		
		public function toString():String {
			return x1 + ":" + x2 + "x" + y1 + ":" + y2;
		}
	
	}

}