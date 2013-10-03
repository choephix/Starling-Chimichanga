package chimichanga.common.display.particles {
	
	/**
	 * ...
	 * @author choephix
	 */
	public class ParticleHeavy extends Particle {
		
		private var speedX:Number;
		private var speedY:Number;
		private var speedR:Number;
		
		private var initScale:Number;
		private var targetScale:Number;
		
		public function ParticleHeavy() {
		
		}
		
		override protected function advanceTime( passedTime:Number ):void {
			
			super.advanceTime( passedTime );
			
			x += passedTime * speedX;
			y += passedTime * speedY;
			rotation += passedTime * speedR;
			scaleX = initScale + lifeProgress * ( targetScale - initScale );
			scaleY = scaleY;
			
			//TODO do an if here
			alpha = 1.0 - lifeProgress;
			
		}
	
	}

}