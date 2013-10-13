package chimichanga.utils {
	import flash.geom.Point;
	import starling.errors.AbstractClassError;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class MathF {
		
		//private static const PI:Number = Math.PI;
		private static const PI2:Number = Math.PI * 2;
		
		public static function get rand():Number {
			return Math.random();
			//return Random.rand;
		}
		
		///
		
		public static function abs(value:Number):Number {
			return value < 0 ? -value : value;
		}
		
		public static function absInt(value:int):int {
			return (value + (value >> 31)) ^ (value >> 31);
		}
		
		static public function clip( value:Number, max:Number=1, min:Number=0 ):Number {
			if ( value >= max ) return max;
			if ( value <= min ) return min;
			return value;
		}
		
		/// ANGLES
		
		public static function angleFromXY(x:Number, y:Number):Number {
			return Math.atan2(y, x);
		}
		
		public static function lerp(a:Number, b:Number, amount:Number = .5):Number {
			return a + (b - a) * amount;
		}
		
		public static function round(n:Number, decimals:Number = 0):Number {
			return (decimals <= 0) ? Math.round(n) : int(n * Math.pow(10, decimals)) * Math.pow(.1, decimals);
		}
		
		public static function roundToString(n:Number, decimals:Number = 0):String {
			return (decimals <= 0) ? Math.round(n).toString() : int(n).toString() + "." + (int(abs(n % 1) * Math.pow(10, decimals)));
		}
		
		/**
		 * @return returns the difference between two angles (in degrees)
		 */
		public static function diffDeg(deg1:Number, deg2:Number):Number {
			deg1 = fixDeg(deg1);
			deg2 = fixDeg(deg2);
			var diff:Number = abs(deg2 - deg1);
			return (diff > 180) ? diff : 360 - diff;
		}
		
		/**
		 * @return returns the given degree normalized between 0 and 360
		 */
		public static function fixDeg(deg:Number):Number {
			while (deg < 0) {
				deg += 360;
			}
			while (deg > 360) {
				deg -= 360;
			}
			return deg;
		}
		
		/**
		 * @return returns the difference between two angles (in radians)
		 */
		public static function diffRad(rad1:Number, rad2:Number):Number {
			rad1 = fixRad(rad1);
			rad2 = fixRad(rad2);
			var diff:Number = abs(rad2 - rad1);
			return (diff > Math.PI) ? diff : PI2 - diff;
		}
		
		/**
		 * @return returns the given radian normalized between 0 and 360
		 */
		public static function fixRad(rad:Number):Number {
			while (rad < 0) {
				rad += PI2;
			}
			while (rad > PI2) {
				rad -= PI2;
			}
			return rad;
		}
		
		public static function deg2rad(deg:Number):Number {
			return deg * Math.PI / 180;
		}
		
		public static function rad2deg(rad:Number):Number {
			return rad * 180 / Math.PI;
		}
		
		public static function random(min:Number, max:Number):Number {
			return (rand * (max - min) + min);
		}
		
		/**
		 *
		 * @param	min inclusive
		 * @param	max exclusive
		 * @return	random number between min (incl) and max (not incl)
		 */
		public static function randomInt(min:Number, max:Number):int {
			return int(Math.floor(rand * (max - min) + min)); //TODO remove Math.floor and test difference
		}
		
		static public function interpolateFromTo(from:Number, to:Number, amount:Number, maxDifference:Number = NaN):Number {
			
			if (!isNaN(maxDifference)) {
				if (from > to + maxDifference) {
					return to + maxDifference;
				} else if (from < to - maxDifference) {
					return to - maxDifference;
				}
			}
			
			return from + amount * (to - from);
		
		}
		
		static public function chance( percent:Number ):Boolean {
			
			return rand * 100 <= percent;
		
		}
		
		public function MathF() {
			throw new AbstractClassError();
		}
	
	}

}