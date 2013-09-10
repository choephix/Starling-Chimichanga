package chimichanga.common.server {
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class ServerCommunicatorBase {
		
		protected var _baseUrl:String = 'http://dev.loc.thechoephix.com/api/';
		
		protected function get serverRequest():ServerRequest {
			
			//TODO write a ServerRequestPooler pool instances of ServerRequest, then instantiate a pooler here and loan objects from him
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
				
				v.decode( String( vars ) );
				
			} else {
				
				for each ( var i:String in vars ) {
					
					v[ i ] = vars[ i ];
					
				}
				
			}
			
			return v;
			
		}
	
	}

}