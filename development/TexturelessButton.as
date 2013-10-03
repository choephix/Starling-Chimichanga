package chimichanga.development {
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class TexturelessButton extends Sprite {
		
		private var pad:DisplayObject;
		
		private var onClick:Function;
		private var onClickArgs:Array;
		
		public function TexturelessButton( labelText:String, onClick:Function, ...onClickArgs ) {
			
			this.onClick = onClick;
			this.onClickArgs = onClickArgs;
			
			pad = new Quad( 100, 50, 0xFFDDBB );
			addChild( pad );
			
			addChild( new TextField( 100, 50, labelText ) );
			
			addEventListener( TouchEvent.TOUCH, onTouch );
			
		}
		
		private function onTouch(e:TouchEvent):void {
			
			if ( e.getTouch( pad, TouchPhase.ENDED ) ) {
				
				onClick.apply( null, onClickArgs );
				
			}
			
		}
		
	}

}