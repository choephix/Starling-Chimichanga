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
		private var textureArraysPool:Dictionary = new Dictionary(true);
		private var _img:Image;
		private var _t:Texture;
		
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
			
			return assets.getMovieFromTextures( getTextures( prefix, atlas ), touchable, framerate, juggler, play );
			
		}
		
		/**
		 * Get a specified texture. If the texture has never been requested before from this instance of AssetsPooper it will be created as new, and also added to a private pool. If a texture with that name has been requested before (and thus it's already in the pool) the texture instance from the pool will be returned.
		 * @param	name	name of the texture you're looking for
		 * @param	atlas	optionally you can specify a specific atlas to look through
		 */
		public function getTexture( name:String, atlas:String = "" ):Texture {
			
			if ( texturePool[ name ] is Texture ) {
				return texturePool[ name ] as Texture;
			}
			
			_t = assets.getTexture( name, atlas );
			texturePool[ name ] = _t;
			return _t;
			
		}
		
		/**
		 * Get textures with specified prefix. If the textures have never been requested before from this instance of AssetsPooper with that prefix, a new Vector.<Texture> will be created and returned, as well as also added to a private pool. If a Vector.<Texture> with that exact prefix has been requested before (and thus it's already in the pool) the vector from the pool will be returned.
		 * @param	prefix	prefix of the textures you're looking for
		 * @param	atlas	optionally you can specify a specific atlas to look through
		 */
		public function getTextures( prefix:String, atlas:String = "" ):Vector.<Texture> {
			
			if ( textureArraysPool[ prefix ] && textureArraysPool[ prefix ] is Vector.<Texture> ) {
				return textureArraysPool[ prefix ] as Vector.<Texture>;
			}
			
			return textureArraysPool[ prefix ] = assets.getTextures( prefix, atlas );
			
		}
	
	}

}