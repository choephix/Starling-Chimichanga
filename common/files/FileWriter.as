package chimichanga.common.files {
	import chimichanga.debug.log;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.OutputProgressEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class FileWriter {
		
		private var busy:Boolean = false;
		private var queue:Vector.<FileRequestMemento> = new Vector.<FileRequestMemento>();
		
		private var file:File;
		private var str:FileStream;
		
		private var onSuccess:Function;
		private var onFailure:Function;
		private var onProgress:Function;
		
		public function FileWriter() {}
		
		public function write( file:File, data:Object, onSuccess:Function = null, onFailure:Function = null, onProgress:Function = null ):void {
			
			if ( busy ) {
			
				log( "[SaveToFile]: Queing request for " + file.nativePath );
				
				queue.push( new FileRequestMemento( file, data, null, onSuccess, onFailure, onProgress ) );
				return;
				
			}
			
			log( "[SaveToFile]: Will save to " + file.nativePath );
			
			busy = true;
			
			this.onProgress = onProgress;
			this.onFailure = onFailure;
			this.onSuccess = onSuccess;	
			
			this.file = file;
			this.str = new FileStream();
			
			str.addEventListener( OutputProgressEvent.OUTPUT_PROGRESS, onEventProgress );
			str.addEventListener( IOErrorEvent.IO_ERROR, onEventIOError );
			
			str.openAsync( file, FileMode.WRITE );
			
			if( data is String ) {
				str.writeUTFBytes( data as String );
			} else {
				str.writeObject( data );
			}
		
		}
			
		private function onEventProgress( e:OutputProgressEvent ):void {
			
			if ( onProgress != null ) {
				
				onProgress( 1 - ( e.bytesPending / e.bytesTotal ) );
				
			}
			
			if ( e.bytesPending <= 0 ) {
			
				log( "[SaveToFile]: 0 bytes pending => complete" );
				
				if( onSuccess != null ) {
					
					onSuccess();
					
				}
				
				onFinished();
				
			}
		
		}
		
		private function onEventIOError( e:IOErrorEvent ):void {
			
			log( "[SaveToFile]: IO Error occurred" );
			
			if ( onFailure != null ) {
				
				onFailure( new IOError( "Couldn't open file " + file.nativePath ) );
				
			}
			
			onFinished();
		
		}
		
		private function onFinished():void {
			
			cleanup();
			
			busy = false;
			
			if ( queue.length > 0 ) {
				
				var params:FileRequestMemento = queue.shift();
				
				write( params.file, params.data, params.onSuccess, params.onFailure, params.onProgress );
				
			}
		
		}
		
		private function cleanup():void {
			
			log( "[SaveToFile]: Cleaning up" );
			
			str.removeEventListener( ProgressEvent.PROGRESS, onEventProgress );
			str.removeEventListener( IOErrorEvent.IO_ERROR, onEventIOError );	
			
			str.close();
			
			this.onProgress = null;
			this.onFailure = null;
			this.onSuccess = null;
			
			this.str = null;
			this.file = null;
			
		}
		
	}

}