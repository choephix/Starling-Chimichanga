package chimichanga.development {
	import engine.assets.AssetsBook;
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author choephix
	 */
	public final class Alerto extends Sprite {
		
		private var overlay:Quad;
		private var bg:Scale9Image;
		private var t:Label;
		private var onOkCallback:Function;
		
		public function Alerto( parent:DisplayObjectContainer, text:String, onOkCallback:Function = null, modal:Boolean = false, context:AppContext = null, widthPercentOfScr:Number = NaN, overlayAlpha:Number = .3 ) {
			
			parent.addChild( this );
			
			this.onOkCallback = onOkCallback;
			
			if ( modal ) {
				overlay = new Quad( 10, 10, 0x000000 );
				overlay.alpha = overlayAlpha;
				overlay.width = parent.stage.stageWidth;
				overlay.height = parent.stage.stageHeight;
				addChild( overlay );
			}
			
			if ( context ) {
				bg = new Scale9Image( new Scale9Textures( context.assets.getAtlasTexture( AssetsBook.MAIN_LIST_ITEM_ELEMENT_BG, AssetsBook.ATLAS_MAIN ), new Rectangle( 100 * context.scaleFactor, 100 * context.scaleFactor, 3 * context.scaleFactor, 3 * context.scaleFactor ) ) );
				
				if ( isNaN( widthPercentOfScr ) ) {
					bg.x = 40 * context.scaleFactor;
					bg.width = parent.stage.stageWidth - ( 80 * context.scaleFactor );
				} else {
					bg.width = parent.stage.stageWidth * widthPercentOfScr / 100;
					bg.x = ( parent.stage.stageWidth - bg.width ) >> 1;
				}
				addChild( bg );
				
				t = new Label();
				t.x = bg.x + ( 20 * context.scaleFactor );
				t.width = bg.width - ( 40 * context.scaleFactor );
				t.text = text;
				t.text += "\n\n(tap to continue)";
				addChild( t );
				t.validate();
				t.y = ( parent.stage.stageHeight - t.height ) >> 1;
				
				bg.y = t.y - ( 20 * context.scaleFactor );
				bg.height = t.height + ( 40 * context.scaleFactor );
			} else {
				t = new Label();
				if ( isNaN( widthPercentOfScr ) )
					t.width = parent.stage.stageWidth;
				else {
					t.width = parent.stage.stageWidth * widthPercentOfScr / 100;
					t.x = ( parent.stage.stageWidth - t.width ) >> 1;
				}
				t.text = text;
				t.text += "\n\n(tap to continue)";
				addChild( t );
				t.validate();
				t.y = ( parent.height - t.height ) >> 1;
			}
			
			parent.stage.addEventListener( TouchEvent.TOUCH, onTouch );
		}
		
		private function onTouch( e:TouchEvent ):void {
			
			if ( e.getTouch( this, TouchPhase.ENDED ) ) {
				
				die();
				
				if ( onOkCallback != null )
					onOkCallback();
			}
		
		}
		
		public function die():void {
			
			parent.stage.removeEventListener( TouchEvent.TOUCH, onTouch );
			
			parent.removeChild( this );
			
			removeChildren( 0, numChildren, true );
			
			dispose();
		}
	
	}

}