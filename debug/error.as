package debug {
	
	/**
	 * ...
	 * @author choephix
	 */
		
	public function error( msg:Object ):void {
		
		Log.printError( arguments.callee + ": " +msg );
		
	}

}