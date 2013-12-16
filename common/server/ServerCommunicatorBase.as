package chimichanga.common.server {
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class ServerCommunicatorBase {
		
		protected var _baseUrl:String = '';
		
		protected function get serverRequest():ServerRequest {
			
			//TODO write a ServerRequestPooler pool instances of ServerRequest, then instantiate a pooler here and loan objects from him
			return new ServerRequest();
			
		}
		
		public function ServerCommunicatorBase( baseUrl:String ) {
			
			this._baseUrl = baseUrl;
			
		}
		
		/**
		 * 
		 * @param	urlAddon			a suffix string to the base URL this communicator uses
		 * @param	vars				variables to be passed with the request (via POST method). Can be URLVariables, or can be a String, which will be decoded to URLVariables or a regular Object, which will be looped through (single level) and its properties dumped into URLVariables
		 * @param	onReady 			on success, the result from the request is parsed and passed to onReady as an Object if dataProcessor is null, else the product of dataProcessor( the Object ) is passed to onReady instead.
		 * @param	onFail				on failure, a ServerCommunicationError is passed, hopefully containing explanations for the nature of the failure
		 * @param	dataProcessor		if dataProcessor, on success the result from the request is parsed and passed to dataProcessor() as an Object, and the result from that (no voids, okay?) is passed to onReady. 
		 * @param	onRawDataReceived	mostly for logging purposes, if you want to be given the raw string data from the request, i t can be passed to onRawDataReceived() if specified. Does not modify or affect the rest of the operation.
		 */
		public function request( urlAddon:String, vars:Object, onReady:Function, onFail:Function, dataProcessor:Function=null, onRawDataReceived:Function=null ):void {
			
			serverRequest.load( _baseUrl + urlAddon, processUrlVariables( vars ), onReady, onFail, dataProcessor, onRawDataReceived );
		
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