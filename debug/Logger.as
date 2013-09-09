package  {
	
	/**
	 * ...
	 * @author choephix
	 */
	
	public class Log {
		
		private static const ON:Boolean 	= CONFIG::debug;
		private static const EXCEPTIONS_ON:Boolean 	= false; // true false
		private static const STACK_TRACE_ON:Boolean = false;
		
		/**
		 * use the following constants as conditions for Log.print(), so you can easily turn them on and off seperately
		 */
		
		public static const CND_UNDEFINED:Boolean	= true; // true false
		public static const CND_ERRORS:Boolean		= true;
		public static const CND_WARNINGS:Boolean	= true;
		
		// SHOOTING
		public static const CND_DAMAGE:Boolean		= true;
		public static const CND_COMMANDS:Boolean	= true;
		public static const CND_ABILITIES:Boolean	= true;
		public static const CND_SELECTION:Boolean	= true;
		
		//FARMING
		
		private static var _i_:uint = 0;
		
		public static function print( msg:Object, condition:Boolean=CND_UNDEFINED ):void {
			
			if ( ON && condition ) {
				trace( msg );
			}
			
		}
		
		public static function printWarning( msg:Object, condition:Boolean = CND_UNDEFINED ):void {
			
			print( "2: " + String(msg), Log.CND_WARNINGS && condition );
			
		}
		
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
		
		private static var errorListeners:Vector.<Function>;
		public static function addErrorListener( callback:Function ):void {
			if ( errorListeners == null ) {
				errorListeners = new Vector.<Function>();
			}
			errorListeners.push( callback );
		}
		public static function removeErrorListener( callback:Function ):void {
			if ( errorListeners != null && errorListeners.indexOf(callback)>=0 ) {
				errorListeners.splice( errorListeners.indexOf(callback), 1 );
			}
		}
		public static function clearErrorListeners():void {
			errorListeners.length = 0;
		}
		
	}

}