package chimichanga.common.server {
	import chimichanga.debug.error;
	import chimichanga.debug.log;
	import chimichanga.debug.warn;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author choephix
	 */
	internal class ServerRequest {
		
		protected const method:String = URLRequestMethod.GET;
		
		protected var loader:ServerDataLoader;
		protected var successCallback:Function;
		protected var failCallback:Function;
		protected var dataProcessorCallback:Function;
		protected var onRawDataReceivedCallback:Function;
		
		public function ServerRequest() {
			
			this.loader = new ServerDataLoader();
		
		}
		
		/**
		 * 
		 * @param	url
		 * @param	vars
		 * @param	successCallback
		 * @param	failCallback
		 * @param	dataProcessorCallback
		 * @param	onRawDataReceivedCallback	optionally this function can be passed the raw text response from the server, but only after it has separately been parsed and processed with no errors
		 */
		internal function load( url:String, vars:URLVariables, 
					successCallback:Function, failCallback:Function, 
					dataProcessorCallback:Function = null, 
					onRawDataReceivedCallback:Function=null ):void {
			
			this.successCallback = successCallback;
			this.failCallback = failCallback;
			this.dataProcessorCallback = dataProcessorCallback;
			this.onRawDataReceivedCallback = onRawDataReceivedCallback;
			
			loader.load( url, vars, method, onLoaderSuccess, onLoaderFailure );
		
		}
		
		protected function onLoaderSuccess( e:Event ):void {
			
			var json:String = String( e.currentTarget.data );
			
			log( "SERVER successfully responded with something..." );
			
			if ( !json ) {
				
				fail( newError( "server response was an empty string" ) );
				
				return;
				
			}
			
			var data:Object;
			
			try {
				
				data = JSON.parse( json );
				
			} catch ( e:Error ) {
				
				fail( newError( "Parsing Error -- " + e.message ) );
				
				return;
				
			}
			
			//TODO PARSING ERRORS + OTHER
			
			if ( dataProcessorCallback != null ) {
			
				try {
					
					data = dataProcessorCallback( data );
					
				} catch ( e:Error ) {
					
					fail( newError( "dataProcessorCallback Failed -- " + e.message ) );
					
					return;
					
				}
				
			}
			
			try { 
			
				if ( onRawDataReceivedCallback != null ) {
					
					onRawDataReceivedCallback( json );
					
				}
			
			} catch ( e:Error ) {
				
				error( e );
				
			}
			
			successCallback( data );
		
		}
		
		private function onLoaderFailure( e:ErrorEvent ):void {
			
			function newErrorFromEvent( prefix:String ):ServerCommunicationError {
				
				return newError( prefix + " (" + e.type + "): " + e.text );
				
			}
			
			if ( e is IOErrorEvent ) {
				
				fail( newErrorFromEvent( "IOError" ) );
				return;
				
			}
			
			if ( e is SecurityErrorEvent ) {
			
				fail( newErrorFromEvent( "SecurityError" ) );
				return;
				
			}
			
			fail( newErrorFromEvent( "UncomprehendableError" ) );
			
		}
		
		protected function fail( e:ServerCommunicationError = null ):void {
			
			warn( "SERVER communication error -- " + e.message );
			
			failCallback( e );
		
		}
		
		private function newError( text:String, id:int=0 ):ServerCommunicationError {
			
			return new ServerCommunicationError( text );
			
		}
		
	}

}