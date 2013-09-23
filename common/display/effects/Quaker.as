package chimichanga.common.display.effects {
	import chimichanga.utils.MathF;
	import starling.display.DisplayObject;
	import starling.events.EnterFrameEvent;
	
	/**
	 * This object provides a "quake" effect on assigned DisplayObject. Whenever <code>quakeUp()</code> is called the object starts to jitter with random values at x and y, and gradually pacing down again. Best used for an entire screen container, which will give the effect of the "camera" shaking from tremors.
	 * Warning: Currently the object's base x and y are set at the lasy peaceful position of the subject before starting a quake. Any positions of the target set outside the Quaker instance during "quaking" will be overriden.
	 * @author choephix
	 */
	public class Quaker {
		
		protected var maximumMagnitude:Number 	= 40;
		protected var minimumMagnitude:Number 	=  1;
		protected var dampPerSecond:Number	 	= 10;
		
		protected var quakee:DisplayObject;
		
		protected var baseX:Number;
		protected var baseY:Number;
		
		protected var currentMagnitute:Number = 0;
		protected var currentMagnitute:Number = 0;
		protected var dirty:Boolean = false;
		
		/**
		 *
		 * @param	quakee the target object which will be shaken by the Quaker.
		 */
		public function Quaker( quakee:DisplayObject ) {
			
			this.quakee = quakee;
			
			quakee.addEventListener( EnterFrameEvent.ENTER_FRAME, onEnterFrame );
			
		}
		
		protected function onEnterFrame( e:EnterFrameEvent ):void {
			
			if ( !dirty ) {
				return;
			}
			
			if ( currentMagnitute < minimumMagnitude ) {
				quakee.x = baseX;
				quakee.y = baseY;
				currentMagnitute = 0;
				dirty = false;
				return;
			}
			
			quakee.x = baseX + getRand( currentMagnituteX );
			quakee.y = baseX + getRand( currentMagnituteY );
			
			currentMagnituteX -= dampPerSecond * e.passedTime;
			currentMagnituteY -= dampPerSecond * e.passedTime;
			
		}
		
		protected function getRand( amplitude:Number ):Number {
			
			if ( amplitude <= minimumMagnitude ) return 0;
			
			return MathF.random( -amplitude, amplitude );
			
		}
		
		/**
		 * Start shaking the object. The amount is in pixels and can be set separately for horisontal and vertical shaking bounds. E.g. if you do quake(5) the object will shake with bounds between -5 and 5 vertically as well as horizontally.
		 * @param	amountX	the amount in pixels to quake the object left/right. E.g. if you pass 5 the object will shake with bounds between -5 and 5 horizontally.
		 * @param	amountY the amount in pixels to quake the object up/down. E.g. if you pass 5 the object will shake with bounds between -5 and 5 vertically. If you do not specify a value the value passed for amountX will be used.
		 */
		public function quakeUp( amountX:Number, amountY:Number=NaN ):void {
			
			if ( !dirty ) {
				
				baseX = quakee.x;
				baseY = quakee.y;
				
				dirty = true;
				
			}
			
			currentMagnituteX += amountX;
			currentMagnituteY += isNaN( amountY ) ? amountX : amountY;
			
		}
	
	}

}