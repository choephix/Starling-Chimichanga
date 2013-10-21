package chimichanga.common.display {
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class LinearGradientQuad extends Quad {
		
		static public const DIRECTION_UP:String = "up";
		static public const DIRECTION_RIGHT:String = "right";
		static public const DIRECTION_DOWN:String = "down";
		static public const DIRECTION_LEFT:String = "left";
		
		private var va:Array;
		
		private var _color1:uint;
		private var _color2:Number;
		private var _alpha1:Number;
		private var _alpha2:Number;
		private var _direction:String;
		
		public function LinearGradientQuad( color1:uint = 0xFfFfFf, color2:Number = 0x000000, alpha1:Number = 1.0, alpha2:Number = 1.0, direction:String = DIRECTION_DOWN ) {
			
			super( 50, 50, 0xFFFFFF );
			
			this.direction = direction;
			this.alpha1 = alpha1;
			this.alpha2 = alpha2;
			this.color1 = color1;
			this.color2 = color2;
		
		}
		
		public function get color1():uint {
			return _color1;
		}
		
		public function set color1( value:uint ):void {
			_color1 = value;
			setVertexColor( va[0], value );
			setVertexColor( va[1], value );
		}
		
		public function get color2():Number {
			return _color2;
		}
		
		public function set color2( value:Number ):void {
			_color2 = value;
			setVertexColor( va[2], value );
			setVertexColor( va[3], value );
		}
		
		public function get alpha1():Number {
			return _alpha1;
		}
		
		public function set alpha1( value:Number ):void {
			_alpha1 = value;
			setVertexAlpha( va[0], value );
			setVertexAlpha( va[1], value );
		}
		
		public function get alpha2():Number {
			return _alpha2;
		}
		
		public function set alpha2( value:Number ):void {
			_alpha2 = value;
			setVertexAlpha( va[2], value );
			setVertexAlpha( va[3], value );
		}
		
		public function get direction():String {
			return _direction;
		}
		
		public function set direction( value:String ):void {
			
			_direction = value;
			
			var offset:int;
			switch( value ) {
				case DIRECTION_UP: 		va = [ 0, 1, 2, 3 ]; break;
				case DIRECTION_RIGHT: 	va = [ 1, 3, 2, 0 ]; break;
				case DIRECTION_DOWN: 	va = [ 2, 3, 0, 1 ]; break;
				case DIRECTION_LEFT: 	va = [ 2, 0, 1, 3 ]; break;
			}
			
			color1 = color1;
			color2 = color2;
			alpha1 = alpha1;
			alpha2 = alpha2;
			
		}
	
	}

}