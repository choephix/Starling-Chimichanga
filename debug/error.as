package chimichanga.debug {
	
	/**
	 * ...
	 * @author choephix
	 */
		
	public function error( msg:Object, caller:Object=null ):void {
		
		Logger.printError( caller ? typeof( caller ) + ": " + msg : msg );
		//Logger.printError( arguments.callee + ": " +msg );
		
	}

}