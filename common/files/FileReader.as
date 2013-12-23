package chimichanga.common.files {
	import chimichanga.debug.error;
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
	public class FileReader {
		
		private var busy:Boolean = false;
		private var queue:Vector.<FileRequestMemento> = new Vector.<FileRequestMemento>();
		
		private var file:File;
		private var str:FileStream;
		
		private var onSuccess:Function;
		private var onFailure:Function;
		private var onProgress:Function;
		private var resultType:Class;
		
		public function FileReader() {}
		
		public function read( file:File, resultType:Class, onSuccess:Function = null, onFailure:Function = null, onProgress:Function = null ):void {
			
			if ( busy ) {
			
				log( "[LoadFromFile]: Queing request for " + file.name );
				
				queue.push( new FileRequestMemento( file, null, resultType, onSuccess, onFailure, onProgress ) );
				return;
				
			}
			
			log( "[LoadFromFile]: Will read from " + file.name );
			
			busy = true;
			
			this.onProgress = onProgress;
			this.onFailure = onFailure;
			this.onSuccess = onSuccess;	
			
			this.file = file;
			this.resultType = resultType;
			
			if( !str ) {
			this.str = new FileStream();
			}
			
			str.addEventListener( ProgressEvent.PROGRESS, onEventProgress );
			str.addEventListener( Event.COMPLETE, onEventComplete );
			str.addEventListener( IOErrorEvent.IO_ERROR, onEventIOError );
			
			str.openAsync( file, FileMode.READ );
		
		}
			
		private function onEventProgress( p_evt:ProgressEvent ):void {
			
			if ( onProgress != null ) {
				
				onProgress( p_evt.bytesLoaded / p_evt.bytesTotal );
				
			}
		
		}
		
		private function onEventComplete( e:Event ):void {
			
			log( "[LoadFromFile]: Completed successfully - " + file.name );
			
			if ( onSuccess != null ) {
			
				if ( resultType == String ) {
					
					onSuccess( str.readUTFBytes( str.bytesAvailable ) );
					
				} else 		
				if ( resultType == Object ) {
					
					onSuccess( str.readObject() );
					
				} else 
				{
					
					error( "no resultType given..." );
					
				}
				
			}
			
			onFinished();
		
		}
		
		private function onEventIOError( e:IOErrorEvent ):void {
			
			log( "[LoadFromFile]: IO Error occurred" );
			
			if ( onFailure != null ) {
				
				onFailure( new IOError( "Couldn't open file " + file.name ) );
				
			}
			
			onFinished();
		
		}
		
		private function onFinished():void {
			
			cleanup();
			
			busy = false;
			
			if ( queue.length > 0 ) {
				
				var params:FileRequestMemento = queue.shift();
				
				read( params.file, params.resultType, params.onSuccess, params.onFailure, params.onProgress );
				
			}
		
		}
		
		private function cleanup():void {
			
			log( "[LoadFromFile]: Cleaning up" );
			
			str.removeEventListener( ProgressEvent.PROGRESS, onEventProgress );
			str.removeEventListener( Event.COMPLETE, onEventComplete );
			str.removeEventListener( IOErrorEvent.IO_ERROR, onEventIOError );	
			
			str.close();
			
			this.onProgress = null;
			this.onFailure = null;
			this.onSuccess = null;
			
			this.str = null;
			this.file = null;
			this.resultType = null;
			
		}
		
	}

}