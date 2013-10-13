package chimichanga.common.server {
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	internal class ServerDataLoader {
		
		private var loader:URLLoader;
		private var request:URLRequest;
		private var resultCallback:Function;
		private var failCallback:Function;
		
		public function ServerDataLoader() {
			this.loader = new URLLoader();
		}
		
		internal function load( url:String, vars:URLVariables, method:String, resultCallback:Function = null, failCallback:Function = null ):void {
			
			this.failCallback = failCallback;
			this.resultCallback = resultCallback;
			
			var urlRequest:URLRequest = new URLRequest( url );
			urlRequest.method = method;
			urlRequest.data = vars;
			
			this.loader.addEventListener( ProgressEvent.PROGRESS, onProgress );
			this.loader.addEventListener( Event.COMPLETE, onLoaded );
			this.loader.addEventListener( IOErrorEvent.IO_ERROR, onFailed );
			this.loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onFailed );
			this.loader.load( urlRequest );
		
		}
		
		private function onProgress( e:ProgressEvent ):void {
			
			//trace( e.bytesLoaded + " / " + e.bytesTotal );
		
		}
		
		private function onLoaded( e:Event ):void {
			
			cleanup();
			
			if ( resultCallback != null )
				resultCallback( e );
		
		}
		
		private function onFailed( e:Event ):void {
			
			cleanup();
			
			if ( failCallback != null )
				failCallback( e );
		
		}
		
		private function cleanup():void {
			
			this.loader.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			this.loader.removeEventListener( Event.COMPLETE, onLoaded );
			this.loader.removeEventListener( IOErrorEvent.IO_ERROR, onFailed );
			this.loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onFailed );
		
		}
	
	}

}