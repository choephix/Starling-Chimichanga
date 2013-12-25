package chimichanga.utils {
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Random {
		
		private static var stale:Boolean = true;
		
		private static const POOL_SIZE:uint = 100;
		private static var pool:Vector.<Number> = new Vector.<Number>(POOL_SIZE);
		private static var index:int = 0;
		
		public static function get rand():Number {
			
			if ( stale ) jiggleUp();
			
			index %= POOL_SIZE;
			
			return pool[ index++ ];
			
		}
		
		private static function jiggleUp():void {
			
			stale = false;
			
			for ( index = 0; index < POOL_SIZE; index++ ) {
				
				//pool[ index ] = Math.random();
				pool[ index ] = (Math.random() + (index/POOL_SIZE)) % 1;
				//pool[ index ] = int(Math.random()*100)/100;
				
			}
			
			pool.reverse();
			
			index = 0;
			
		}
	
	}

}