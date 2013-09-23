package chimichanga.common.display.effects {
	import chimichanga.utils.DisplayObjects;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Flasher {
	
		private var flashee:DisplayObjectContainer;
		private var juggler:Juggler;
		
		public function Flasher( flashee:DisplayObjectContainer ) {
			
			this.flashee = flashee;
			this.juggler = Starling.juggler;
			
		}
		
		public function flashUp( color:uint, strength:Number=1.0, duration:Number=1.0 ):void {
			
			if ( strength > 1.0 )
				strength = 1.0;
			
			var flash:Image = newFlash( color, strength );
			juggler.tween( flash, duration, {
					alpha: 0,
					onComplete: flash.removeFromParent,
					onCompleteArgs: [true]
				} );
			
		}
		
		public function flashIn( color:uint, strength:Number = 1.0, duration:Number = 1.0, onEnd:Function=null ):void {
			
			if ( strength > 1.0 )
				strength = 1.0;
			
			var flash:Image = newFlash( color, 0 );
			juggler.tween( flash, duration, {
					alpha: strength,
					onComplete: function():void {
						flash.removeFromParent( true );
						if( onEnd != null ) onEnd();
					}
				} );
				
		}
		
		private function newFlash( color:uint=0xFfFfFf, alpha:Number=1.0 ):Image {
			
			var flash:Quad = new Quad( flashee.stage.stageWidth  << 1, flashee.stage.stageHeight << 1, color );
			
			DisplayObjects.centerPivots( flash );
			flash.blendMode = BlendMode.ADD;
			flash.alpha = alpha;
			flashee.addChild( flash );
			
			return flash;
			
		}
	
	}

}