package chimichanga.utils {
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Angles {
		
		public static const PI:Number 		= Math.PI;
		public static const PI2:Number 		= PI << 1;
		
		public static const RAD360:Number 	= PI * 2.00;
		public static const RAD180:Number 	= PI * 1.00;
		public static const RAD90:Number 	= PI * 0.50;
		public static const RAD60:Number 	= PI / 3.00;
		public static const RAD45:Number 	= PI * 0.25;
		public static const RAD30:Number 	= PI / 6.00;
		
		private static var _n:Number;
		
		/**
		 * Rounds the value of the parameter angle up or down to the nearest value dividable by portion and returns it. If val is equidistant from its two nearest integers (that is, if the angle is exactly in the middle of a 'portion'), the value is rounded up. Works with both radians and degrees (depending on what you pass to <code>portion</code>, default is PI/2 in radians)
		 * Examples: 
		 * - round(88,90) 	returns 90
		 * - round(112,90) 	returns 90
		 * - round(178,90) 	returns 180
		 * - round(288,90) 	returns 270
		 * - round(88,180) 	returns 0
		 * - round(98,180) 	returns 180
		 * - round(-88,90) 	returns -90
		 * - round(45,90) 	returns 90
		 * - round(88,90) 	returns 90
		 * 
		 * @param	angle	The angle to be rounded
		 * @param	portion	The portion size to use
		 * @return	resulting angle
		 */
		public static function round( angle:Number, portion:Number = RAD90 ):Number {
								
			_n = angle % portion;
			
			if ( _n >  ( portion >> 1 ) ) {
				_n -=  portion;
			} 
			else
			_n +=  portion;
			
			return angle - _n;
			
		}
	
		/**
		 * Converts the given angle from degrees to radians and returns the result
		 */
		public static function deg2rad( deg:Number ):Number {
			return deg * RAD180 / 180;
		}
		
		/**
		 * Converts the given angle from radians to degrees and returns the result
		 */
		public static function rad2deg( rad:Number ):Number {
			return rad * 180 / RAD180;
		}
		
		/**
		 * Calculate the angle between two points in 2D space (the tip of the angle being at [0,0] coordinates) and return it (in radians).
		 * @param	x1 x coordinate of the first point
		 * @param	y1 y coordinate of the first point
		 * @param	x2 x coordinate of the second point
		 * @param	y2 y coordinate of the second point
		 * @return	the resulting angle in radians
		 */
		public static function betweenPoints( x1:Number, y1:Number, x2:Number, y2:Number ):Number {
			return Math.atan2( y2 - y1, x2 - x1 );
		}
		
		
	}

}