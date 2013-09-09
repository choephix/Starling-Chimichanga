package debug {
	
	/**
	 * ...
	 * @author choephix
	 */
		
	public function warn( msg:Object, condition:Boolean = Log.CND_UNDEFINED ):void {
		
		Log.printWarning( msg, condition );
		
	}

}