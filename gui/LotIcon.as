package chimichanga.gui {
	
	import engine.utils.helpers.Angles;
	import engine.utils.helpers.MathF;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author choephix
	 */
	public final class LotIcon extends DisplayObjectContainer {
		
		static public const MIN_SCALE:Number = 0.5;
		static public const MAX_SCALE:Number = 1.0;
		
		private var picsContainer:DisplayObjectContainer;
		private var pics:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		private var picsCount:int;
		private var picsCountMax:int;
		
		private var pad:DisplayObject;
		
		private var picTexture:Texture;
		
		public function LotIcon( padTexture:Texture, picTexture:Texture, count:int, picsCountMax:int ) {
			
			this.picTexture = picTexture;
			this.picsCountMax = picsCountMax;
			
			pad = new Image( padTexture );
			addChild( pad );
			
			picsContainer = new Sprite();
			addChild( picsContainer );
			
			setCount( count );
			
		}
		
		private function setCount( count:int ):void {
			
			picsContainer.removeChildren();
			
			for ( var i:int = 0; i < count; i++ ) {
				
				addPic();
				
			}
			
		}
		
		private function addPic():void {
			
			var pic:DisplayObject = new Image( picTexture );
			
			picsCount = pics.push( pic );
			
			picsContainer.addChildAt( pic, 0 );
			
			updatePicTransform( pic );
			
		}
		
		private function updatePicTransform( pic:DisplayObject ):void {
			
			const SPATULA:Number = ( picsCount / picsCountMax );
			
			pic.scaleY =
			pic.scaleX = MAX_SCALE - ( SPATULA * ( MAX_SCALE - MIN_SCALE ) );
			
			const MAX_ANGLE:Number = SPATULA * Angles.RAD90;
			
			pic.rotation = MathF.random( -MAX_ANGLE, MAX_ANGLE );
			
			const MAX_DISTANCE:Number = SPATULA * pad.width * .4;
			
			pic.x = MathF.random( -MAX_DISTANCE, MAX_DISTANCE );
			
		}
	
	}

}