package chimichanga.common.yield {
	/**
	 * ...
	 * @author choephix
	 */
	
	public function yield( callback:Function, callbackArgs:Array=null, framesCount:uint = 1 ):void {
		
		new DelayedCallForFrames( callback, callbackArgs, framesCount );
	
	}

}