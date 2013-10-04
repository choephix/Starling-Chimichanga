package chimichanga.development {
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DirtyLittleLayoutHelperAdvanced {
		
		private var subject:DisplayObject;
		private var step:Number;
		
		public function DirtyLittleLayoutHelperAdvanced( subject:DisplayObject, step:Number=1 ) {
			
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
			
			subject.removeEventListeners( TouchEvent.TOUCH );
			subject.addEventListener( TouchEvent.TOUCH, onTouch );
			subject.addEventListener( Event.REMOVED_FROM_STAGE, dispose );
			
		}
		
		private var _touch:Touch;
		private var _delta:Point;
		public function onTouch( e:TouchEvent ):void {
			
			_touch = e.getTouch( subject );
			
			if ( !_touch )
				return;
			
			if ( _touch.phase == TouchPhase.MOVED ) {
				_delta = _touch.getMovement( subject );
				subject.x += _delta.x;
				subject.y += _delta.y;
			}
			
			if ( _touch.phase == TouchPhase.ENDED ) {
				if( _delta.length > 0 ) {
					trace( subject + "'s current position: " + subject.x + " x " + subject.y );
					e.stopPropagation();
				}
			}
			
		}
		
		public function dispose():void {
			
			subject.removeEventListener( TouchEvent.TOUCH, onTouch );
			
			subject.removeEventListener( Event.REMOVED_FROM_STAGE, dispose );
			subject.removeEventListener( Event.ADDED_TO_STAGE, initialize );
			
		}
		
		///
		
		public static function letsPositionThis( subject:DisplayObject, step:Number = 1 ):void {
			
			new DirtyLittleLayoutHelperAdvanced( subject, step );
			
		}
		
	}

}