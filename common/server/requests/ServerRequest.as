package server.requests {
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import server.loader.DataLoader;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class ServerRequest {
		
		protected const method:String = URLRequestMethod.GET;
		
		protected var loader:DataLoader;
		protected var successCallback:Function;
		protected var failCallback:Function;
		private var dataProcessorCallback:Function;
		
		public function ServerRequest() {
			
			this.loader = new DataLoader();
		
		}
		
		/* DELEGATE server.loader.DataLoader */
		
		public function load( url:String, vars:URLVariables, 
					successCallback:Function, failCallback:Function, 
					dataProcessorCallback:Function = null ):void {
			
			this.successCallback = successCallback;
			this.failCallback = failCallback;
			this.dataProcessorCallback = dataProcessorCallback;
			
			loader.load( url, vars, method, onSuccess, onFail );
		
		}
		
		protected function onSuccess( e:Event ):void {
			
			var json:String = String( e.currentTarget.data );
			
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
		
		protected function onFail( e:Event = null ):void {
			
			failCallback( e );
		
		}
		
	}

}