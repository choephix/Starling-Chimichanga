package chimichanga.debug.errors {
	
	/**
	 * ...
	 * @author choephix
	 */
	public class SingletonOverlapError extends Error {
		
		public function SingletonOverlapError( subject:* ) {
			
			super( subject 
				+ ": Instanciating a singleton class before cleaning up a previous instance." );
		
		}
	
	}

}