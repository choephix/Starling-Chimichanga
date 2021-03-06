package chimichanga.common.yield {
	import starling.core.Starling;
	import starling.display.Stage;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class DelayedCallForFrames {
		
		private var stage:Stage;
		private var callback:Function;
		private var callbackArgs:Array;
		private var framesCount:int;
		
		public function DelayedCallForFrames( callback:Function, callbackArgs:Array=null, framesCount:int=1 ) {
				
			this.callbackArgs 	= callbackArgs;
			this.callback 		= callback;
			this.stage 			= Starling.current.stage;
			this.framesCount 	= framesCount;
			
			stage.addEventListener( EnterFrameEvent.ENTER_FRAME, onEnterFrame );
			
		}
		
		private function onEnterFrame( e:EnterFrameEvent ):void {
			
			framesCount--;
			
			if ( framesCount > 0 ) {
				return;
			}
			
			callback.apply( stage, callbackArgs );
			
			stage.removeEventListener( EnterFrameEvent.ENTER_FRAME, onEnterFrame );
			
			stage = null;
			callback = null;
			callbackArgs = null;
			
		}
	
	}

}