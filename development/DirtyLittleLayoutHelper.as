package chimichanga.development {
	import chimichanga.debug.logd;
	import flash.ui.Keyboard;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DirtyLittleLayoutHelper {
		
		private var subject:DisplayObject;
		private var step:Number;
		
		public function DirtyLittleLayoutHelper( subject:DisplayObject, step:Number=1 ) {
			
			this.subject = subject;
			this.step = step;
			
			if ( subject.stage ) {
				initialize();
			} else {
				subject.addEventListener( Event.ADDED_TO_STAGE, initialize );
			}
		
		}
		
		private function initialize():void {
			
			subject.removeEventListener( Event.ADDED_TO_STAGE, initialize );
			subject.addEventListener( Event.REMOVED_FROM_STAGE, dispose );
			
			subject.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			subject.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
		}
	
		public function onKeyDown(e:KeyboardEvent):void {
			
			if ( e.keyCode == Keyboard.DOWN ) {
				subject.y += step;
			} else
			if ( e.keyCode == Keyboard.UP ) {
				subject.y -= step;
			} else
			if ( e.keyCode == Keyboard.LEFT ) {
				subject.x -= step;
			} else
			if ( e.keyCode == Keyboard.RIGHT ) {
				subject.x += step;
			}
			
		}
	
		public function onKeyUp(e:KeyboardEvent):void {
			
			logd( subject + "'s current position: " + subject.x + " x " + subject.y );
			
		}
		
		public function dispose():void {
			
			subject.stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			subject.stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
			subject.removeEventListener( Event.REMOVED_FROM_STAGE, dispose );
			subject.removeEventListener( Event.ADDED_TO_STAGE, initialize );
			
		}
		
		///
		
		public static function letsPositionThis( subject:DisplayObject, step:Number = 1 ):void {
			
			new DirtyLittleLayoutHelper( subject, step );
			
		}
		
	}

}