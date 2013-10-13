package chimichanga.common.server {
	import chimichanga.debug.log;
	import flash.events.ErrorEvent;
	import flash.events.Event;
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
			
			loader.load( url, vars, method, onSuccess, onFail );
		
		}
		
		protected function onSuccess( e:Event ):void {
			
			var json:String = String( e.currentTarget.data );
			
			log( "SERVER response successful" );
			
			if ( !json ) {
				onFail( newErrorEvent("server response was an empty string") );
				return;
			}
			
			var data:Object;
			
			try {
				data = JSON.parse( json );
			} catch ( e:Error ) {
				onFail();
				return;
			}
			
			//TODO PARSING ERRORS + OTHER
			
			if ( dataProcessorCallback != null ) {
			
				try {
					data = dataProcessorCallback( data );
				} catch ( e:Error ) {
					onFail( e );
					return;
				}
				
			}
			
			if ( onRawDataReceivedCallback != null ) {
				
				onRawDataReceivedCallback( json );
				
			}
			
			successCallback( data );
		
		}
		
		protected function onFail( e:* = null ):void {
			
			log( "SERVER failed to respond - " + e );
			
			failCallback( e );
		
		}
		
		private function newErrorEvent( text:String ):ErrorEvent {
			
			return new ErrorEvent("", false, false, text);
			
		}
		
	}

}