package chimichanga.common {
	
	/**
	 * ...
	 * @author choephix
	 */
	public class UniqueIdentifiersCounter {
		
		private var count:int;
		
		public function UniqueIdentifiersCounter(startValue:int) {
			
			count = startValue;
			
		}
		
		public function next():int {
			
			return count++;
		
		}
		
		public function get currentCount():int {
			
			return count;
			
		}
		
	}

}