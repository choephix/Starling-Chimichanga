package chimichanga.common.input.touch {
	import chimichanga.debug.warn;
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
		
		/* INTERFACE chimichanga.common.input.touch.ITouchProcessor */
		public function onTouch( touch:Touch ):Boolean {
			
			if ( _queue == null ) {
				
				return;
				
			}
			
			for ( _i = 0; _i < _queueLen; _i++ ) {
						
				if ( _queue[ _i ]( touch ) ) {
					return true;
				}
				
			}
			
			return false;
		
		}
		
		public function addTouchHandler( handlerCallback:Function ):void {
			
			if ( _queue == null ) {
				
				_queue = new Vector.<ITouchProcessor>();
				
			}
			
			_queueLen = _queue.unshift( handlerCallback );
		
		}
		
		public function addTouchHandlerToBack( handlerCallback:Function ):void {
			
			if ( _queue == null ) {
				
				_queue = new Vector.<ITouchProcessor>();
				
			}
			
			_queueLen = _queue.push( handlerCallback );
		
		}
		
		public function addTouchHandlers( ... handlers ):void {
			
			if ( _queue == null ) {
				
				_queue = new Vector.<Function>();
				
			}
			
			_queueLen = _queue.unshift.apply( this, handlers.reverse() );
		
		}
		
		public function addTouchHandlersToBack( ... handlers ):void {
			
			if ( _queue == null ) {
				
				_queue = new Vector.<Function>();
				
			}
			
			_queueLen = _queue.push.apply( this, handlers );
		
		}
		
		public function removeTouchHandler( handlerCallback:Function ):void {
			
			if ( _queue == null ) {
				
				warn( "Tried to remove touch handler from a processor which has none" );
				return;
				
			}
			
			_i = _queue.indexOf( handlerCallback );
			
			if ( _i <= -1 ) {
				
				warn( "Tried to remove touch handler from a processor which doesn't have it in its queue" );
				return;
				
			}
				
			_queue.splice( _i, 1 );
			_queueLen--;
		
		}
	
	}

}