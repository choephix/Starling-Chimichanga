package chimichanga.common.input.touch {
	import starling.events.Touch;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class TouchProcessor implements ITouchProcessor {
		
		private var _queue:Vector.<Function>;
		private var _queueLen:int;
		
		private var _i:int;
		
		private var _active:Boolean = true;
		/* INTERFACE chimichanga.common.input.touch.ITouchProcessor */
		public function get active():Boolean {
			return _active;
		}
		public function set active( value:Boolean ):void {
			_active = value;
		}
		
		public function TouchProcessor( ... handlers ) {
			
			if ( handlers && handlers.length > 0 ) {
				
				addTouchHandlers.apply( this, handlers );
				
			}
		
		}
		
		public function addTouchHandler( handlerCallback:Function ):void {
			
			if ( _queue == null ) {
				
				_queue = new Vector.<ITouchProcessor>();
				
			}
			
			_queueLen = _queue.unshift( handlerCallback );
		
		}
		
		public function addTouchHandlers( ... handlers ):void {
			
			if ( _queue == null ) {
				
				_queue = new Vector.<Function>();
				
			}
			
			//_queueLen = _queue.push.apply( this, handlers );
			_queueLen = _queue.unshift.apply( this, handlers.reverse() );
		
		}
		
		public function removeTouchHandler( handlerCallback:Function ):void {
			
			var i:int = _queue.indexOf( handlerCallback );
			
			if ( i > -1 ) {
				
				_queue.splice( i, 1 );
				_queueLen--;
				
			}
		
		}
		
		/* INTERFACE chimichanga.common.input.touch.ITouchProcessor */
		public function onTouch( touch:Touch ):Boolean {
			
			for ( _i = 0; _i < _queueLen; _i++ ) {
						
				if ( _queue[ _i ]( touch ) ) {
					return true;
				}
				
			}
			
			return false;
		
		}
	
	}

}