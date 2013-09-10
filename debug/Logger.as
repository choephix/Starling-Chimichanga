package chimichanga.debug {
	
	/**
	 * ...
	 * @author choephix
	 */
	
	public class Logger {
		
		private static const ON:Boolean = true;
		
		private static const EXCEPTIONS_ON:Boolean 	= false; // true false
		private static const STACK_TRACE_ON:Boolean = false;
		
		/**
		 * use the following constants as conditions for Log.print(), so you can easily turn them on and off seperately
		 */
		
		public static const CND_UNDEFINED:Boolean	= true; // true false
		public static const CND_ERRORS:Boolean		= true;
		public static const CND_WARNINGS:Boolean	= true;
		
		private static var _i_:uint = 0;
		
		public static function print( msg:String, condition:Boolean=CND_UNDEFINED ):void {
			
			if ( ON && condition ) {
				trace( msg );
			}
			
		}
		
		//{ LOG
		
		public static function printLog( msg:Object, condition:Boolean=CND_UNDEFINED ):void {
			
			print( String( msg ), condition );
			
		}
		
		//}
		
		//{ WARNINGS
		
		public static function printWarning( msg:Object, condition:Boolean = CND_UNDEFINED ):void {
			
			print( "2: " + String(msg), CND_WARNINGS && condition );
			
		}
		
		//}
		
		//{ ERRORS
		
		private static var _error:Error;
		public static function printError( msg:Object ):Error {
			
			_error = new Error( msg );
			
			print( "4:" + (STACK_TRACE_ON ? _error.getStackTrace() : msg), CND_ERRORS );
			
			if( EXCEPTIONS_ON ) {
				throw _error;
			}
			
			if ( errorListeners != null && errorListeners.length > 0 ) {
				for ( _i_ = 0; _i_ < errorListeners.length; _i_++ ) {
					errorListeners[_i_](_error);
				}
			}
			
			return _error;
			
		}
		
		private static var errorListenersLen:int=0;
		private static var errorListeners:Vector.<Function>;
		public static function addErrorListener( callback:Function ):void {
			if ( errorListeners == null ) {
				errorListeners = new Vector.<Function>();
			}
			errorListeners.push( callback );
			errorListenersLen++;
		}
		public static function removeErrorListener( callback:Function ):void {
			if ( errorListeners != null && errorListeners.indexOf(callback)>=0 ) {
				errorListeners.splice( errorListeners.indexOf(callback), 1 );
				errorListenersLen--;
			}
		}
		public static function clearErrorListeners():void {
			errorListeners.length = 0;
			errorListenersLen = 0;
		}
		
		//}
		
	}

}