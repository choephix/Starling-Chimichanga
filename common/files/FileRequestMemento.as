package chimichanga.common.files {
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class FileRequestMemento {
		
		public var file:File;
		public var data:Object;
		public var onSuccess:Function;
		public var onFailure:Function;
		public var onProgress:Function;
		public var resultType:Class;
		
		public function FileRequestMemento( file:File, data:Object, resultType:Class, onSuccess:Function, onFailure:Function, onProgress:Function ) {
			
			this.resultType = resultType;
			this.onProgress = onProgress;
			this.onFailure = onFailure;
			this.onSuccess = onSuccess;
			this.data = data;
			this.file = file;
		
		}
	
	}

}