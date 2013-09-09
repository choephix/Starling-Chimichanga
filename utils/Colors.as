package chimichanga.utils {
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Colors {
		
		private static var c:uint;
		
		/**
		 * @param	brightness - a number from 0 to 1 denoting the brightness of the returned gray color (from black to white respectively)
		 * @return	- returns a hexedemical representation of a gray color
		 */
		public static function getGrayColor( brightness:Number ):uint {
			
			c = brightness * 0xFF;
			c += c * 0x100;
			c += c * 0x10000;
			return c;
			
		}

		/**
		 * A static method for directly converting from Red,Green,and Blue values
		 * to Hex.
		 * @param r the Red value (0-255)
		 * @param g the Green value (0-255)
		 * @param b the Blue value (0-255)
		 * @return the Hex value of the specified RGB color
		 */
		public static function getHex( r:int, g:int, b:int ):uint{
			return (r<<16)|(g << 8)|b;
		}

		/*
		 * Getters for each channel, converts from Hex
		 */
		public static function getRed( color:uint ):int {
			return color >> 16;
		}
		public static function getGreen( color:uint ):int {
			return (color >> 8) & 0xFF;
		}
		public static function getBlue( color:uint ):int {
			return color & 0x00FF;
		}
	
	}

}