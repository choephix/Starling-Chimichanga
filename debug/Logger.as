package chimichanga.debug {
	CONFIG::air {
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
	}
	
	/**
	 * ...
	 * @author choephix
	 */
	
	public class Logger {
		
		public static var ON:Boolean = true;
		
		public static var EXCEPTIONS_ON:Boolean = false; // true false
		public static var STACK_TRACE_ON:Boolean = false;
		public static var LOG_TO_FILES:Boolean = true;
		
		internal static const CND_UNDEFINED:Boolean = true; // true false
		internal static const CND_ERRORS:Boolean = true;
		internal static const CND_WARNINGS:Boolean = true;
		
		private static var _i_:uint = 0;
		
		public static function cleanup():void {
					
			if ( LOG_TO_FILES ) {
				
				CONFIG::air {
						
					logToFile( "", "main", true );
					logToFile( "", "warnings", true );
					logToFile( "", "errors", true );
					logToFile( "", "hidden", true );
				
				}
			
			}
			
		}
		
		//
		
		private static function print( msg:String, condition:Boolean = CND_UNDEFINED, clr:int = -1 ):void {
			
			if ( ON ) {
				
				if( condition ) {
				
					trace( ( clr > 0 ? clr + ":" : "" ) + msg );
					
					CONFIG::air { //remove this condition when web solution for logging has been added too
							
						logToFile( new Date().toTimeString() + "\n" +  msg + "\n", "all", false );
						
					}
				
				} else {
			
					logToFile( String( msg ), "hidden", false );
					
				}
				
			}
		
		}
		
		private static function logToFile( msg:String, logFileName:String, clearPreviousContent:Boolean ):void {
					
			if ( LOG_TO_FILES ) {
				
				CONFIG::air {
						
					var outFile:File = File.applicationStorageDirectory;
					outFile = outFile.resolvePath( "logs\\" + logFileName + ".log" );
					var outStream:FileStream = new FileStream();
					outStream.open( outFile, clearPreviousContent ? FileMode.WRITE : FileMode.APPEND );
					outStream.writeUTFBytes( msg + "\n" );
					outStream.close();
				
				}
			
			}
			
		}
		
		
		//{ LOG
		
		public static function printLog( msg:Object, condition:Boolean = CND_UNDEFINED ):void {
			
			print( String( msg ), condition );
			
			logToFile( String( msg ), "main", false );
		
		}
		
		//}
		
		//{ WARNINGS
		
		public static function printWarning( msg:Object, condition:Boolean = CND_UNDEFINED ):void {
			
			print( String( msg ), CND_WARNINGS && condition, 2 );
			
			logToFile( String( msg ), "warnings", false );
		
		}
		
		//}
		
		//{ ERRORS
		
		private static var _error:Error;
		
		public static function printError( msg:Object ):Error {
			
			_error = new Error( msg );
			
			print( String( STACK_TRACE_ON ? _error.getStackTrace() : msg ), CND_ERRORS, 4 );
			
			logToFile( String( msg ), "errors", false );
			
			if ( EXCEPTIONS_ON ) {
				throw _error;
			}
			
			if ( errorListeners != null && errorListeners.length > 0 ) {
				for ( _i_ = 0; _i_ < errorListeners.length; _i_++ ) {
					errorListeners[ _i_ ]( _error );
				}
			}
			
			return _error;
		
		}
		
		private static var errorListenersLen:int = 0;
		private static var errorListeners:Vector.<Function>;
		
		public static function addErrorListener( callback:Function ):void {
			if ( errorListeners == null ) {
				errorListeners = new Vector.<Function>();
			}
			errorListeners.push( callback );
			errorListenersLen++;
		}
		
		public static function removeErrorListener( callback:Function ):void {
			if ( errorListeners != null && errorListeners.indexOf( callback ) >= 0 ) {
				errorListeners.splice( errorListeners.indexOf( callback ), 1 );
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