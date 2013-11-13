package chimichanga.common.display {
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SmartPositioner {
		
		public var w:Number = 0;
		public var h:Number = 0;
		public var paddingX:Number = 0;
		public var paddingY:Number = 0;
		
		public const center:Point = new Point();
		
		public const __rect:Rectangle = new Rectangle();
		
		public function SmartPositioner( w:Number, h:Number) {
			
			updateDimensions( w, h );
		
		}
		
		public function updateDimensions( w:Number, h:Number ):void {
			
			this.w = w;
			this.h = h;
			
			center.setTo( getCenterX(), getCenterY() );
		
		}
		
		public function positionAtRatios( o:DisplayObject, x:Number, y:Number ):void {
			
			positionAtRatioX( o, x );
			positionAtRatioY( o, y );
			
		}
		
		public function positionAtRatioX( o:DisplayObject, x:Number ):int {
			
			o.getBounds( o, __rect );
			return o.x = int ( ( w - __rect.width - __rect.x ) * x );
			//return o.x = int ( ( w - o.width + o.pivotX * o.scaleX ) * x );
			
		}
		
		public function positionAtRatioY( o:DisplayObject, y:Number ):int {
			
			o.getBounds( o, __rect );
			return o.y = int ( ( h - __rect.height - __rect.y ) * y );
			//return o.y = int ( ( h - o.height + o.pivotY * o.scaleY ) * y );
			
		}
		
		public function getFromRatioX( x:Number ):int {
			
			return int ( w * x );
			
		}
		
		public function getFromRatioY( y:Number ):int {
			
			return int ( h * y );
			
		}
		
		public function getCenterX():int {
			
			return int ( w >> 1 );
			
		}
		
		public function getCenterY():int {
			
			return int ( h >> 1 );
			
		}
	
	}

}