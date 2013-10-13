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
		
		public function ServerRequest() {
			
			this.loader = new ServerDataLoader();
		
		}
		
		/* DELEGATE server.loader.DataLoader */
		
		internal function load( url:String, vars:URLVariables, 
					successCallback:Function, failCallback:Function, 
					dataProcessorCallback:Function = null ):void {
			
			this.successCallback = successCallback;
			this.failCallback = failCallback;
			this.dataProcessorCallback = dataProcessorCallback;
			
			loader.load( url, vars, method, onSuccess, onFail );
		
		}
		
		protected function onSuccess( e:Event ):void {
			
			var json:String = String( e.currentTarget.data );
			
			//log( "SERVER RESPONSE:\n" + json );
			
			log( "SERVER response successful" );
			
			if ( !json ) {
				onFail();
				return;
			}
			
			try {
				var data:Object = JSON.parse( json );
			} catch ( e:Error ) {
				onFail();
				return;
			}
			
			//TODO PARSING ERRORS + OTHER
			
			successCallback( dataProcessorCallback == null ? data : dataProcessorCallback( data ) );
		
		}
		
		protected function onFail( e:ErrorEvent = null ):void {
			
			log( "SERVER failed to respond - " + e.text );
			
			failCallback( e );
		
		}
		
	}

}