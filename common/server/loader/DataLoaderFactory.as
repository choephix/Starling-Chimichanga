package server.loader
{
	public class DataLoaderFactory {
		
		private var urlRoot:String;
		public var sessionId:String;
		
		public function DataLoaderFactory( urlRoot:String ) {
			this.urlRoot = urlRoot;
		}
		
		public function getDataLoader():DataLoader {
			return new DataLoader();
		}
		
	}
	
}