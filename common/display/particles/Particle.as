package chimichanga.common.display.particles {
	import chimichanga.common.TimeManager;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Particle extends Sprite {
		
		public var time:TimeManager;
		
		private var lifeTotalDuration:Number;
		
		/** A number between 0 and 1 showing the progress of the particle from birth to death. The particle dies if progress > 0 /**/
		protected var lifeProgress:Number;
		
		public function Particle() {
			
			lifeTotalDuration = 2.0;
			
			if ( stage ) {
				
				onAddedToStage();
				
			} else {
				
				addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
				
			}
		
		}
		
		private function onAddedToStage( e:Event = null ):void {
			
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			addEventListener( EnterFrameEvent.ENTER_FRAME, onEnterFrame );
		
		}
		
		private function onEnterFrame( e:EnterFrameEvent ):void {
			
			advanceTime( time ? time.delta : e.passedTime );
		
		}
		
		protected function advanceTime( passedTime:Number ):void {
			
			lifeProgress += passedTime / lifeTotalDuration;
			
		}
	
	}

}