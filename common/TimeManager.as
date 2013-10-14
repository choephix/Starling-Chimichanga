package chimichanga.common {
	
	/**
	 * ...
	 * @author choephix
	 */
	public class TimeManager {
		
		//private static const MAX_DELTA:Number = 0.0500;
		private static const MAX_DELTA:Number = 0.100;
		private static const MIN_SPEED:Number = 0.010;
		
		private var baseSpeed:Number = 1;
		
		public var delta:Number = 0;
		public var elapsed:Number = 0;
		public var speed:Number = 1;
		
		public function TimeManager() {}
		
		public function update( passedTime:Number ):void {
			
			if ( speed < MIN_SPEED ) {
				speed = MIN_SPEED;
			}
			
			delta = passedTime * speed * baseSpeed;
			
			if ( delta > MAX_DELTA ) {
				delta = MAX_DELTA;
			}
			
			elapsed += delta;
			
		}
		
		public function resetSpeed():void {
			
			speed = 1;
			
		}
		
		public function setBaseSpeed(value:Number):void {
			
			baseSpeed = value;
			
		}
	
	}

}