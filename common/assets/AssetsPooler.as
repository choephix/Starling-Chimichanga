package chimichanga.common.assets {
	import flash.utils.Dictionary;
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	/**
	 * Wraps AdvancedAssetsManager while also pooling textures in a Dictionary.
	 * IMPORTANT!! because duplicate textures are returned as the same instance (the aforementioned texture-pooling) any changes you make to an actual texture object retrieved from here will appear on all DisplayObjects showing the same texture. Be cautious and consider using just the AdvancedAssetsManager instead of this class if you plan on fiddling with texture properties.
	 * @author choephix
	 */
	public class AssetsPooler implements IAssetsManager {
		
		private var assets:AdvancedAssetsManager;
		private var texturePool:Dictionary = new Dictionary(true);
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
			
			if ( texturePool[ name ] is Texture ) {
				return texturePool[ name ] as Texture;
			}
			
			texturePool[ name ] = assets.getTexture( name, atlas );
			return assets.getTexture( name, atlas );
			
		}
		
		public function getTextures( prefix:String, atlas:String = "" ):Vector.<Texture> {
			
			return assets.getTextures( prefix, atlas );
			
		}
	
	}

}