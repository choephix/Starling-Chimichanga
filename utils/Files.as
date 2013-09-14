package chimichanga.utils {
	CONFIG::air {
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
	}
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Files {
		
		/**
		 * Returns a File object pointed at a specified path (relative to the application's directory) if the project is currently compiled with AIR. Else returns the path unmodified.
		 * Most importantly this is used by the AdvancedAssetsManager to resolve what to pass to Starling's AssetManager's enqueue().
		 * @param	localPath
		 * @return
		 */
		public static function getFileOrPath( localPath:String ):* {
			
			CONFIG::air {
				return File.applicationDirectory.resolvePath( localPath );
			}
			
			return localPath;
		
		}
		
		///
		
		public static function getFileContentsAsString( path:String, charset:String = null, onFailCallback:Function = null ):String {
			
			var r:String;
			
			try {
				
				CONFIG::air {
					
					var f:File = File.applicationDirectory.resolvePath( path );
					var str:FileStream = new FileStream();
					str.open( f, FileMode.READ );
					r = str.readMultiByte( f.size, charset ? charset : File.systemCharset );
					str.close();
				
				}
				
			} catch ( e:Error ) {
				
				if ( onFailCallback != null )
					onFailCallback( e );
				
			}
			
			return r;
		
		}
	
		public static function saveStringToFile( content:String, path:String, charset:String = null, onFailCallback:Function = null ):String {
			
			var r:String;
			
			try {
				
				CONFIG::air {
					
					var f:File = File.applicationDirectory.resolvePath( path );
					var str:FileStream = new FileStream();
					str.open(f, FileMode.WRITE);
					str.writeUTFBytes( content );
					str.close();
				
				}
				
			} catch ( e:Error ) {
				
				if ( onFailCallback != null )
					onFailCallback( e );
				
			}
			
			return r;
		
		}
	
	}

}