package chimichanga.common.input.touch {
	import starling.events.Touch;
	
	/**
	 *  This class is intended for use with a TouchProcessorsManager instance. When initialized the manager will loops through queued processors' onTouch methods on each touch, until a true is returned at which point the loop will break.
	 * @author choephix
	 */
	public interface ITouchProcessor {
		
		/**
		 * This object will be ignored by the TouchProcessorsManager if <strong><code>active</code></strong> returns <code>false</code>
		 */
		function get active():Boolean;
		
		/**
		 * This method is only intended to be used by TouchProcessorsManager which loops through queued processors' onTouch methods on each touch, until a true is returned and the loop breaks.
		 * @param	touch Starling's Touch object
		 * @return	returns <code>true</code> if the touch has been successfully handled by this object and should not be processed further, <code>flase</code> if not and it can be checked by another TouchProcessor.
		 */
		function onTouch( touch:Touch ):Boolean;
	
	}

}