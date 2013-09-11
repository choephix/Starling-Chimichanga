package chimichanga.common.input.touch {
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class TouchProcessorsManager implements ITouchProcessor {
		
		private var _queue:Vector.<ITouchProcessor>;
		private var _stage:Stage;
		
		private var _i:int;
		private var _ti:int;
		private var _qlen:int;
		private var _tlen:int;
		private var _p:ITouchProcessor;
		private var _touches:Vector.<Touch> = new Vector.<Touch>();
		
		/* INTERFACE chimichanga.common.input.touch.ITouchProcessor */
		
		protected var _active:Boolean = true;
		public function get active():Boolean {
			return _active;
		}
		
		public function TouchProcessorsManager() {
		
		}
		
		public function init( stage:Stage ):void {
			
			this._stage = stage;
			_stage.addEventListener( TouchEvent.TOUCH, onTouch );
		
		}
		
		private function onTouch( e:TouchEvent ):void {
			
			_touches = e.getTouches( _stage );
			
			for ( _ti = 0, _tlen = _touches.length; _ti < _tlen; _ti++ ) {
				
				for ( _i = 0; _i < _qlen; _i++ ) {
					
					_p = _queue[ _i ];
					
					if ( _p.active ) {
						
						if ( _p.onTouch( _touches[ _ti ] ) ) {
							
							break;
							
						}
						
					}
					
				}
				
			}
		
		}
		
		public function addTouchProcessor( touchProcessor:ITouchProcessor ):void {
			
			if( _queue == null ) {
				_queue = new Vector.<ITouchProcessor>();
			}
			
			//_qlen = _queue.push( touchProcessor );
			_qlen = _queue.unshift( touchProcessor );
		
		}
		
		public function addTouchProcessorToBack( touchProcessor:ITouchProcessor ):void {
			
			if( _queue == null ) {
				_queue = new Vector.<ITouchProcessor>();
			}
			
			_qlen = _queue.push( touchProcessor );
		
		}
		
		public function removeTouchProcessor( touchProcessor:ITouchProcessor ):void {
			
			if ( _queue == null ) {
				
				warn( "Tried to remove a TouchProcessor from a manager which has none" );
				return;
				
			}
			
			_i = _queue.indexOf( touchProcessor );
			
			if ( _i <= -1 ) {
				
				warn( "Tried to remove a TouchProcessor from a manager which doesn't have it in its queue" );
				return;
				
			}
			
			_queue.splice( _i, 1 );
			_qlen--;
		
		}
		
		/**
		 * Cleans up and disposes of all properties of the TouchManager.
		 * Empties the queue and removes touch-listener from the stage.
		 */
		public function dispose():void {
			
			_queue.length = 0;
			
			_stage.removeListener( TouchEvent.TOUCH, onTouch );
			_stage = null;
			
		}
	
	}

}