package chimichanga.utils {
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import chimichanga.common.display.SmartDisplayObject;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class DisplayObjects {
		
		public static function position( o:DisplayObject, p:Point ):void {
			
			o.x = p.x;
			o.y = p.y;
			
		}
		
		public static function centerPivots( o:DisplayObject ):void {
			
			if ( o is SmartDisplayObject ) {
				
				SmartDisplayObject(o).centerPivots();
				
			} else {
			
				o.pivotX = ( o.width  >> 1 );
				o.pivotY = ( o.height >> 1 );
			
			}
			
		}
		
		public static function centerPivotsButKeepInPlace( o:DisplayObject ):void {
			
			if ( o is SmartDisplayObject ) {
				
				SmartDisplayObject(o).centerPivots();
				
			} else {
			
				o.pivotX = ( o.width  >> 1 );
				o.pivotY = ( o.height >> 1 );
				o.x += ( o.width  >> 1 );
				o.y += ( o.height >> 1 );
			
			}
			
		}
		
		public static function centerPivotX( o:DisplayObject ):void {
			
			if ( o is SmartDisplayObject ) {
				
				SmartDisplayObject(o).centerPivotX();
				
			} else {
			
				o.pivotX = ( o.width  >> 1 );
			
			}
			
		}
		
		public static function centerPivotY( o:DisplayObject ):void {
			
			if ( o is SmartDisplayObject ) {
				
				SmartDisplayObject(o).centerPivotY();
				
			} else {
			
				o.pivotY = ( o.height >> 1 );
			
			}
			
		}
		
		public static function tileImage( image:Image, tileX:Number = 2, tileY:Number = 2 ):Image {
			
			image.texture.repeat = true;
			image.setTexCoords(1, new Point(tileX, 0));
			image.setTexCoords(2, new Point(0, tileY));
			image.setTexCoords(3, new Point(tileX, tileY));
			image.width  *= tileX;
			image.height *= tileY;
			
			return image;
		}
		
		public static function scale( o:DisplayObject, amount:Number ):void {
			
			o.scaleX = amount;
			o.scaleY = amount;
			
		}
		
		public static function weakMovieClip( mc:MovieClip ):MovieClip {
			
			mc.addEventListener( Event.COMPLETE, killMovieCipOnComplete );
			
			return mc;
			
		}
		
		private static function killMovieCipOnComplete( e:Event ):void {
			
			//trace( MovieClip(e.currentTarget).name );
			
			e.target.removeEventListener( Event.COMPLETE, killMovieCipOnComplete );
			MovieClip(e.currentTarget).removeFromParent( true );
			
		}
		
	}

}