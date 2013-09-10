package chimichanga.common.server {
	import flash.net.URLVariables;
	import server.loader.DataLoaderFactory;
	import server.requests.ServerRequest;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class ServerCommunicatorBase {
		
		protected var _baseUrl:String = 'http://dev.loc.thechoephix.com/api/';
		
		protected function get serverRequest():ServerRequest {
			
			return new ServerRequest();
			
		}
		
		public function ServerCommunicatorBase( baseUrl:String ) {
			
			this._baseUrl = baseUrl;
			
		}
		
		public function request( urlAddon:String, vars:Object, onReady:Function, onFail:Function, dataProcessor:Function=null ):void {
			
			serverRequest.load( _baseUrl + urlAddon, processUrlVariables( vars ), onReady, onFail, dataProcessor );
		
		}
		
		protected function processUrlVariables( vars:Object ):URLVariables {
			
			if ( vars == null ) {
				
				return null;
				
			}
			
			if ( vars is URLVariables ) {
				
				return( vars as URLVariables );
				
			} 
			
			var v:URLVariables = new URLVariables();
			
			if ( vars is String ) {
				
				v.decode( vars );
				
			} else {
				
				for each ( var i:String in vars ) {
					
					v[ i ] = vars[ i ];
					
				}
				
			}
			
			return v;
			
		}
	
	}

}