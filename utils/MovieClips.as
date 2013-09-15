package chimichanga.utils {
	import starling.display.MovieClip;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class MovieClips {
		
		public static function makeWeak( clip:MovieClip, dispose:Boolean=false ):void {
			
			clip.addEventListener( Event.COMPLETE, dispose ? killWeakMovieClipAndDispose : killWeakMovieClip );
			
		}
		
		private static function killWeakMovieClip( e:Event ):void {
			
			if( CONFIG::debug ) {
				if ( !( e.currentTarget is MovieClip ) )
					throw new Error("Couldn't kill weak movieclip because it wasn't a movieclip - " + e.currentTarget );
			}
			
			e.currentTarget.removeEventListener( Event.COMPLETE, killWeakMovieClip );
			MovieClip(e.currentTarget).removeFromParent();
			
		}
		
		private static function killWeakMovieClipAndDispose( e:Event ):void {
			
			if( CONFIG::debug ) {
				if ( !( e.currentTarget is MovieClip ) )
					throw new Error("Couldn't kill weak movieclip because it wasn't a movieclip - " + e.currentTarget );
			}
			
			e.currentTarget.removeEventListener( Event.COMPLETE, killWeakMovieClipAndDispose );
			MovieClip(e.currentTarget).removeFromParent(true);
			MovieClip(e.currentTarget).dispose();
			
		}
		
	}

}