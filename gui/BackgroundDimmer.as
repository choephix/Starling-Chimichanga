package chimichanga.gui {
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BackgroundDimmer extends DisplayObjectContainer {
		
		private var onClickCallback:Function;
		private var dim:Quad;
		
		public function BackgroundDimmer( parent:DisplayObjectContainer, onClickCallback:Function = null, dimAlpha:Number = .5 ) {
			
			this.onClickCallback = onClickCallback;
			
			parent.addChild( this );
			
			dim = new Quad( 1, 1, 0x000000 );
			dim.alpha = dimAlpha;
			dim.width =  stage.stageWidth;
			dim.height = stage.stageHeight;
			addChild( dim );
				
			if ( onClickCallback != null ) {
				setOnClickCallback();
			}
		
		}
		
		private function setOnClickCallback():void {
			
			if( !stage ) {
				addEventListener( Event.ADDED_TO_STAGE, setOnClickCallback );
				return;
			}
			
			removeEventListener( Event.ADDED_TO_STAGE, setOnClickCallback );
			
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
		
		public function hide():void {
			
			alpha = 0;
			
		}
		
		public function show():void {
			
			alpha = 1;
			
		}
		
		public function remove():void {
			
			removeFromParent( true );
			
		}
	
	}

}