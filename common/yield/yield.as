package chimichanga.common.yield {
	/**
	 * ...
	 * @author choephix
	 */
	
	public function yield( callback:Function, callbackArgs:Array, framesCount:uint = 1 ):void {
		
		new DelayedCallForFrames( callback, callbackArgs, framesCount );
	
	}

}