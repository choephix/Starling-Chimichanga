package chimichanga.common.display {
	import global.Conf;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BackgroundDimmer extends Sprite {
		
		private var onClickCallback:Function;
		
		public function BackgroundDimmer( texture:Texture, onClickCallback:Function = null ) {
			
			this.onClickCallback = onClickCallback;
			
			var dim:Image = new Image( texture );
			dim.width = Conf.DESIGN_W << 1;
			dim.height = Conf.DESIGN_H << 1;
			addChild(dim);
			
			if ( onClickCallback != null ) {
				hookOnClickCallback();
			}
		
		}
		
		private function hookOnClickCallback():void {
			
			if( !stage ) {
				addEventListener( Event.ADDED_TO_STAGE, hookOnClickCallback );
				return;
			}
			
			removeEventListener( Event.ADDED_TO_STAGE, hookOnClickCallback );
			
			stage.addEventListener( TouchEvent.TOUCH, onTouch );
			
		}
		
		private var _touch:Touch;
		private function onTouch(e:TouchEvent):void {
			
			_touch = e.getTouch( this, TouchPhase.ENDED );
			
			if ( _touch ) {
				onClickCallback();
			}
			
			_touch = null;
			
		}
	
	}

}