package chimichanga.debug {
	
	/**
	 * ...
	 * @author choephix
	 */
		
	public function error( msg:Object ):void {
		
		Logger.printError( arguments.callee + ": " +msg );
		
	}

}