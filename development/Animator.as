package chimichanga.development {
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Animator {
		
		private var target:DisplayObject;
		private var juggler:Juggler;
		private var properties:Array;
		
		private var currentIndex:uint = 0;
		
		public function Animator( target:DisplayObject, juggler:Juggler, properties:Array ) {
			
			this.juggler = juggler;
			this.target = target;
			this.properties = properties;
			
			tween();
			
		}
		
		private function tween():void {
			
			var currentProps:Object = properties[ currentIndex ];
			
			juggler.removeTweens( target );
			juggler.tween( target, properties.time, properties );
			
		}
	
	}

}