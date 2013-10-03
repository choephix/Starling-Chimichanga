package chimichanga.gui {
	import chimichanga.development.TexturelessButton;
	import chimichanga.utils.DisplayObjects;
	import flash.geom.Point;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class PopupMessageBox extends DisplayObjectContainer {
		
		public var WIDTH:Number	 = 640;
		public var HEIGHT:Number = 320;
		public var PADDING_X:Number = 15;
		public var PADDING_Y:Number = 15;
		
		private var content:Sprite;
		private var pad:DisplayObject;
		private var tf:TextField;
		
		private var textColor:uint = 0;
		private var textSize:uint = 20;
		
		private var onClosed:Function;
		private var onClosedArgs:Array;
		private var buttonsContainer:Sprite;
		
		public function PopupMessageBox( text:String, font:BitmapFont = null, pad:DisplayObject = null, modal:Boolean = true, onClosed:Function = null, onClosedArgs:Array = null ) {
			
			this.onClosedArgs = onClosedArgs;
			this.onClosed = onClosed;
			
			this.content = new Sprite();
			addChild( content );
		
			if( pad == null ) {
				pad = new Quad( 2, 2, 0x112233 );
				textColor = 0xFFEEAA;
			}
			
			this.pad = pad;
			
			DisplayObjects.centerPivots( pad );
			pad.width 	= WIDTH;
			pad.height 	= HEIGHT;
			content.addChild( pad );
			
			buttonsContainer = new Sprite();
			content.addChild( buttonsContainer );
			
			const BUTTON_HEIGHT:Number = 30;
			
			tf = new TextField( WIDTH - ( PADDING_X << 1 ), HEIGHT - BUTTON_HEIGHT - ( PADDING_Y << 1 ), text, font ? font.name : "Verdana", textSize, textColor );
			DisplayObjects.centerPivots( tf );
			content.addChild( tf );
			
			addEventListener( TouchEvent.TOUCH, onTouch );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
		}
		
		private function onAddedToStage():void {
			
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			updateSize();
			
		}
		
		private function onTouch( e:TouchEvent ):void {
			
			var touch:Touch;
			
			touch = e.getTouch( pad, TouchPhase.MOVED );
			if ( touch ) {
				
				var p:Point;
				touch.getMovement( stage, p ); 
				if( p ) {
					content.x += p.x;
					content.y += p.y;
					return;
				}
				
			}
			
			if ( e.getTouch( this, TouchPhase.ENDED ) ) {
				
				die();
				
			}
		
		}
		
		public function addButton( labelText:String, onClick:Function ):void {
			
			var b:TexturelessButton = new TexturelessButton( labelText, onClick );
			
			b.x = buttonsContainer.width;
			buttonsContainer.addChild( b );
			
		}
		
		private function updateSize():void {
			
			content.x = stage.stageWidth  >> 1;
			content.y = stage.stageHeight >> 1;
			
		}
		
		public function die():void {
				
			if ( onClosed != null ) {
				onClosed.apply( this, onClosedArgs );
			}
			
			removeEventListener( TouchEvent.TOUCH, onTouch );
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			removeFromParent( true );
			
		}
	
	}

}