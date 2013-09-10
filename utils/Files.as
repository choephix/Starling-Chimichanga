package chimichanga.utils {
	CONFIG::air {
		import flash.filesystem.File;
	}
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Files {
		
		public static function getFileOrPath( localPath:String ):* {
			
			CONFIG::air {
				return File.applicationDirectory.resolvePath( localPath );
			}
			
			return localPath;
			
		}
	
	}

}