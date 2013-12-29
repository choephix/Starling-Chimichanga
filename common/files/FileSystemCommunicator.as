package chimichanga.common.files {
	import chimichanga.debug.log;
	CONFIG::air {
	import flash.filesystem.File;
	}
	
	/**
	 * ...
	 * @author choephix
	 */
	public class FileSystemCommunicator {
		
		CONFIG::air {
			
		private var writer:FileWriter;
		private var reader:FileReader;
		
		public function FileSystemCommunicator() {
			
			writer = new FileWriter();
			reader = new FileReader();
			
		}
		
		public function saveTextToFile( relativePath:String, data:String, onSuccess:Function = null, onFailure:Function = null, onProgress:Function = null, storage:Boolean = true ):void {
				
			log( "saveTextToFile(): should save to " + relativePath );
			
			writer.write( ( storage ? File.applicationStorageDirectory.resolvePath : File.applicationDirectory.resolvePath )( relativePath ),
				data, onSuccess, onFailure, onProgress );
			
		}
		
		public function loadTextFromFile( relativePath:String, onSuccess:Function, onFailure:Function, onProgress:Function = null, storage:Boolean = true ):void {
				
			log( "loadTextFromFile(): should load from " + relativePath );
			
			reader.read( ( storage ? File.applicationStorageDirectory.resolvePath : File.applicationDirectory.resolvePath )( relativePath ),
				String, onSuccess, onFailure, onProgress );
			
		}
		
		}
	
	}

}