package chimichanga.debug
{
	/**
	 * ...
	 * @author choephix
	 */
	
	public function logd( ...subjects ):void {
		
		Logger.printDebug.apply( null, subjects );
		
	}

}