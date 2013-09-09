package chimichanga.utils {
	import starling.errors.AbstractClassError;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Arrays {
		
        public function Arrays() { throw new AbstractClassError(); }
		
		public static function randomElement( v:Array ):Object {
			return v[MathF.randomInt( 0, v.length)];
		}
		
	}

}