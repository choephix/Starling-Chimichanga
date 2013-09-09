package debug 
{
	/**
	 * ...
	 * @author choephix
	 */
	
	public function log( msg:Object, condition:Boolean = Log.CND_UNDEFINED ):void {
		
		Log.print( msg, condition );
		
	}

}