package chimichanga.common.display {
	import flash.geom.Point;
	import starling.display.DisplayObject;
	
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
		
		public function positionAtRatioX( o:DisplayObject, x:Number ):void {
			
			o.x = int ( ( w - o.width  + o.pivotX * o.scaleX ) * x );
			
		}
		
		public function positionAtRatioY( o:DisplayObject, y:Number ):void {
			
			o.y = int ( ( h - o.height + o.pivotY * o.scaleY ) * y );
			
		}
		
		public function getFromRatioX( x:Number ):void {
			
			return = int ( w * x );
			
		}
		
		public function getFromRatioY( y:Number ):void {
			
			return = int ( h * y );
			
		}
		
		public function getCenterX():void {
			
			return = int ( w >> 1 );
			
		}
		
		public function getCenterY():void {
			
			return = int ( h >> 1 );
			
		}
	
	}

}