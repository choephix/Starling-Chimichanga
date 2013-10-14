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
		public static var STACK_TRACE_COMPACT:Boolean = false;
		public static var LOG_TO_FILES:Boolean = true;
		
		internal static const CND_UNDEFINED:Boolean = true; // true false
		internal static const CND_ERRORS:Boolean = true;
		internal static const CND_WARNINGS:Boolean = true;
		
		private static var _i_:uint = 0;
		private static var _fileStream_:FileStream;
		
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
				
					trace( ( clr >= 0 ? clr + ":" : "" ) + msg );
					
					logToFileALLLOG( msg, clr );
					
					var filename:String = "main";
					if ( clr == 0 ) filename = "flow";
					if ( clr == 2 ) filename = "warnings";
					if ( clr == 3 ) filename = "errors";
					if ( clr == 4 ) filename = "debug";
					logToFile( String( msg ), filename, false );
				
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
					if( !_fileStream_ ) _fileStream_ = new FileStream();
					_fileStream_.open( outFile, clearPreviousContent ? FileMode.WRITE : FileMode.APPEND );
					_fileStream_.writeUTFBytes( msg + "\n" );
					_fileStream_.close();
				
				}
			
			}
			
		}
		
		static private function logToFileALLLOG( msg:String, clr:int ):void {
			
			var channel:String = "MAIN";
			if ( clr == 0 ) channel = "FLOW";
			if ( clr == 2 ) channel = "WARNING";
			if ( clr == 3 ) channel = "ERROR";
			if ( clr == 4 ) channel = "DEBUG";
			
			logToFile( "[" + new Date().toLocaleTimeString() + "] [" + channel + "] " +  msg, "all", false );
			
		}
		
		
		//{ LOG
		
		public static function printLog( msg:Object, condition:Boolean = CND_UNDEFINED ):void {
			
			print( String( msg ), condition );
		
		}
		
		//}
		
		//{ DEBUG
		
		public static function printDebug( ...subjects ):void {
			
			print( String( subjects ), true, 4 );
		
		}
		
		//}
		
		//{ FLOW
		
		public static function printFlow( msg:Object, condition:Boolean = CND_UNDEFINED ):void {
			
			print( String( msg ), condition, 0 );
		
		}
		
		//}
		
		//{ WARNINGS
		
		public static function printWarning( msg:Object, condition:Boolean = CND_UNDEFINED ):void {
			
			print( String( msg ), CND_WARNINGS && condition, 2 );
			
		}
		
		//}
		
		//{ ERRORS
		
		private static var _error:Error;
		
		public static function printError( msg:Object ):Error {
			
			_error = new Error( msg );
			
			print( String( STACK_TRACE_ON ? _error.getStackTrace() : msg ), CND_ERRORS, 3 );
			
			logToFile( cleanStackTrace( _error.getStackTrace(), String(msg) ), "errors-stacktrace", false );
			
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
		
		public static function cleanStackTrace( s:String, cleanMsg:String ):String {
			
			const HIDDEN_LINE:String = "    ...";
			var a:Array = s.split( "\n" );
			
			if ( cleanMsg )
				a[ 0 ] = cleanMsg;
			else
				a.splice( 0, 1 );
			
			for ( var i:int = 0, len:int = a.length; i < len; i++ ) {
				
				s = a[ i ];
				
				if ( s.indexOf( "chimichanga.debug" ) >= 0 ) {
					a.splice( i, 1 );
					len--;
					i--;
				}
				
				if ( STACK_TRACE_COMPACT && s.indexOf( "at starling." ) >= 0 ) {
					
					if( i > 0 && a[ i-1 ] == HIDDEN_LINE ) {
						a.splice( i, 1 );
						len--;
						i--;
					} else {
						a[ i ] = HIDDEN_LINE;
					}
					
				}
				
			}
			
			return ( a.join( "\n" ) );
			
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