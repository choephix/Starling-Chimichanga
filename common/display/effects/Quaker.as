package chimichanga.common.display.effects {
	import chimichanga.utils.MathF;
	import starling.display.DisplayObject;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Quaker {
		
		public var maximumMagnitude:Number 	= 40;
		public var minimumMagnitude:Number 	=  1;
		public var dampPerSecond:Number	 	= 10;
		
		private var quakee:DisplayObject;
		
		private var currentMagnitute:Number = 0;
		private var dirty:Boolean = false;
		
		public function Quaker( quakee:DisplayObject ) {
			
			this.quakee = quakee;
			
			quakee.addEventListener( EnterFrameEvent.ENTER_FRAME, onEnterFrame );
			
		}
		
		public function onEnterFrame( e:EnterFrameEvent ):void {
			
			if ( !dirty ) {
				return;
			}
			
			if ( currentMagnitute < minimumMagnitude ) {
				quakee.x = 0;
				quakee.y = 0;
				currentMagnitute = 0;
				dirty = false;
				return;
			}
			
			quakee.x = getRand( currentMagnitute );
			quakee.y = getRand( currentMagnitute );
			
			currentMagnitute -= dampPerSecond * e.passedTime;
			
		}
		
		private function getRand( amplitude:Number ):Number {
			
			return MathF.random( -amplitude, amplitude );
			
		}
		
		public function quakeUp( amount:Number ):void {
			
			currentMagnitute += amount;
			
			dirty = true;
			
		}
	
	}

}