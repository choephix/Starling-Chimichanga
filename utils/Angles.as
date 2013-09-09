package chimichanga.utils {
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Angles {
		
		public static const RAD360:Number 	= Math.PI * 2.00;
		public static const RAD180:Number 	= Math.PI * 1.00;
		public static const RAD90:Number 	= Math.PI * 0.50;
		//public static const RAD60:Number 	= Math.PI / 3.00;
		public static const RAD45:Number 	= Math.PI * 0.25;
		//public static const RAD30:Number 	= Math.PI / 6.00;
		//public static const PI2:Number 	= RAD360;
		
		private static var _n:Number;
		
		public static function round( angle:Number, portion:Number = RAD90 ):Number {
								
			_n = angle % portion;
			
			if ( _n >  portion * .5 ) {
				_n -=  portion;
			} else
			if ( _n < -portion * .5 ) {
				_n +=  portion;
			}
			
			return angle - _n;
			
		}
	
		public static function deg2rad( deg:Number ):Number {
			return deg * RAD180 / 180;
		}
		
		public static function rad2deg( rad:Number ):Number {
			return rad * 180 / RAD180;
		}
		
		public static function between( x1:Number, y1:Number, x2:Number, y2:Number ):Number {
			return Math.atan2( y2 - y1, x2 - x1 );
		}
		
		
	}

}