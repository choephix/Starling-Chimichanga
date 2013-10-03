package chimichanga.development {
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author choephix
	 */
	public final class Alerto extends DisplayObjectContainer {
		
		private var dimmer:Quad;
		private var contentContainer:DisplayObjectContainer;
		private var pad:DisplayObject;
		private var tf:TextField;
		private var onOkCallback:Function;
		
		private var widthPercentOfScreen:Number = NaN;
		
		public function Alerto( text:String, modal:Boolean = false, dimmerAlpha:Number = .3 ) {
			
			parent.addChild( this );
			
			if ( modal ) {
				dimmer = new Quad( 10, 10, 0x000000 );
				dimmer.alpha = dimmerAlpha;
				addChild( dimmer );
			}
			
			contentContainer = new Sprite();
			addChild( contentContainer );
			
			pad = new Quad( 10, 10, 0xFfFfFf );
			pad.width  = 500;
			pad.height = 200;
			contentContainer.addChild( pad );
			
			tf = new TextField( 500, 200, text );
			contentContainer.addChild( tf );
			
			addEventListener( TouchEvent.TOUCH, onTouch );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
		}
		
		private function onTouch( e:TouchEvent ):void {
			
			if ( e.getTouch( this, TouchPhase.ENDED ) ) {
				
				die();
				
				if ( onOkCallback != null )
					onOkCallback();
			}
		
		}
		
		private function onAddedToStage():void {
			
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			updateSize();
			
		}
		
		private function updateSize():void {
			
			if( dimmer ) {
				dimmer.width  = stage.stageWidth;
				dimmer.height = stage.stageHeight;
			}
			
			if( !isNaN( widthPercentOfScreen ) ) {
				pad.width = stage.stageWidth * widthPercentOfScreen / 100;
				tf.width  = stage.stageWidth * widthPercentOfScreen / 100;
			}
			
			pad.x = ( stage.stageWidth - pad.width ) >> 1;
			tf.x  = ( stage.stageWidth - tf.width ) >> 1;
			
		}
		
		public function setWidth( width:Number ):void {
			
			pad.width = stage.stageWidth - ( 80 );
			updateSize();
			
		}
		
		public function setWidthToPercentOfScreen( value:Number ):void {
			
			widthPercentOfScreen = value;
			updateSize();
			
		}
		
		public function setOkCallback( onOkCallback:Function ):void {
			
			this.onOkCallback = onOkCallback;
			
		}
		
		public function die():void {
			
			removeEventListener( TouchEvent.TOUCH, onTouch );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			removeChildren( 0, numChildren, true );
			
			removeFromParent( true );
			
		}
		
		///
		
		/**
		 * Add a new Alert
		 * @param	parent
		 * @param	text
		 * @param	onOkCallback
		 * @param	modal
		 * @param	dimmerAlpha
		 * @param	widthPercentOfScr
		 */
		public static function add( text:String, parent:DisplayObjectContainer, onOkCallback:Function = null,
				modal:Boolean = false, dimmerAlpha:Number = .3, widthPercentOfScr:Number = NaN ) {
			
			var a:Alerto = new Alerto( text, onOkCallback, modal, dimmerAlpha );
			
			if ( onOkCallback ) {
				a.setOkCallback( onOkCallback );
			}
			
			if ( !isNaN( widthPercentOfScr ) ) {
				a.setWidthToPercentOfScreen( widthPercentOfScr );
			}
			
			parent.addChild( a );
			
		}
	
	}

}