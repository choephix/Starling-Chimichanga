package chimichanga.common.input.touch {
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class TouchProcessorsManager {
		
		private var _queue:Vector.<ITouchProcessor>;
		private var _stage:Stage;
		
		private var _i:int;
		private var _ti:int;
		private var _qlen:int;
		private var _tlen:int;
		//private var _touch:Touch;
		private var _p:ITouchProcessor;
		private var _touches:Vector.<Touch> = new Vector.<Touch>();
		
		public function TouchProcessorsManager() {
		
		}
		
		public function init( stage:Stage ):void {
			
			this._stage = stage;
			this._queue = new Vector.<ITouchProcessor>();
			
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
			
			//_qlen = _queue.push( touchProcessor );
			_qlen = _queue.unshift( touchProcessor );
		
		}
		
		public function removeTouchProcessor( touchProcessor:ITouchProcessor ):void {
			
			_i = _queue.indexOf( touchProcessor );
			
			if( _i > -1 ) {
				_queue.splice( _i, 1 );
				_qlen--;
			}
			
		}
	
	}

}