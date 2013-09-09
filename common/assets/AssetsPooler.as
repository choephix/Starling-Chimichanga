package chimichanga.common.assets {
	import flash.utils.Dictionary;
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class AssetsPooler implements IAssetsManager {
		
		private var assets:AdvancedAssetsManager;
		private var pool:Dictionary = new Dictionary(true);
		private var _img:Image;
		
		public function AssetsPooler( assets:AdvancedAssetsManager ) {
			
			this.assets = assets;
		
		}
		
		/* DELEGATE utils.assets.AdvancedAssetsManager */
		
		public function getImage( name:String, touchable:Boolean = false, atlas:String = "" ):Image {
			
			_img = new Image( getTexture( name, atlas ) );
			_img.name = name;
			_img.touchable = touchable;
			_img.useHandCursor = touchable;
			
			return _img;
			
		}
		
		public function getMovie( prefix:String, touchable:Boolean = false, framerate:Number = 30, juggler:Juggler = null, play:Boolean = false, atlas:String = "" ):MovieClip {
			
			return assets.getMovie( prefix, touchable, framerate, juggler, play, atlas );
			
		}
		
		public function getTexture( name:String, atlas:String = "" ):Texture {
			
			if ( pool[ name ] is Texture ) {
				return pool[ name ] as Texture;
			}
			
			pool[ name ] = assets.getTexture( name, atlas );
			return assets.getTexture( name, atlas );
			
		}
		
		public function getTextures( prefix:String, atlas:String = "" ):Vector.<Texture> {
			
			return assets.getTextures( prefix, atlas );
			
		}
	
	}

}