package debug {
	
	/**
	 * ...
	 * @author choephix
	 */
		
	public function warn( msg:Object, condition:Boolean = Log.CND_UNDEFINED ):void {
		
		Logger.printWarning( msg, condition );
		
	}

}