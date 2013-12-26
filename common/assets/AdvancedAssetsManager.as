package chimichanga.common.assets
{
	import chimichanga.debug.error;
	import chimichanga.utils.Files;
	import flash.system.Capabilities;
	import flash.system.System;
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author choephix
	 */
	public class AdvancedAssetsManager implements IAssetsManager {
		
		public var assetsReady:Boolean = false;
		
		private var assets:AssetManager;
		
		private var _atlas:TextureAtlas;
		private var _texture:Texture;
		private	var _textures:Vector.<Texture>;
		private var _mc:MovieClip;
		private var _img:Image;
		private var _i:uint;
		
		public function AdvancedAssetsManager( noTextureTexturePath:String = "assets/NoTextureTexture.png" ) {
			
			assets = new AssetManager();
			assets.verbose = Capabilities.isDebugger;
			assets.enqueue( Files.getFileOrPath( noTextureTexturePath ) );
			
		}
		
		public function init( scaleFactor:Number = 1, callback:Function = null, ...rest ):void {
			
			assets.scaleFactor = scaleFactor;
			
			assets.enqueue.apply( null, rest );
			
			assets.loadQueue( function(ratio:Number):void {
				if ( ratio == 1 )
					onAssetsReady();
				
				if ( callback != null )
					callback(ratio);
			});
			
		}
		
		public function enqueue( ...rest ):void {
			
			assets.enqueue.apply( null, rest );
		}
		
		private function onAssetsReady():void {
			
			assetsReady = true;
			
		}
		
		private function getTextureAtlas( atlas:String ):TextureAtlas {
			
			_atlas = assets.getTextureAtlas(atlas);
			return _atlas;
			
		}
		
		public function hasTexture( name:String ):Boolean {
			
			return Boolean( assets.getTexture( name ) );
			
		}
		
		public function hasTextureAtlas( name:String ):Boolean {
			
			return Boolean( assets.getTextureAtlas( name ) );
			
		}
		
		///
		
		private function getAtlasTexture( name:String, atlas:String ):Texture {
			
			if ( !assetsReady ) {
				return placeholderTexture( "Assets not ready yet.", name );
			}
			
			_atlas = getTextureAtlas(atlas);
			if ( _atlas == null ) {
				return placeholderTexture( "Could not find atlas " + atlas, name );
			}
			
			_texture = _atlas.getTexture(name);
			if ( _texture == null ) {
				return placeholderTexture( "Could not find texture in atlas " + atlas, name );
			}
			
			return _texture;
			
		}
		
		private function getAtlasTextures( prefix:String, atlas:String ):Vector.<Texture> {
			
			if ( !assetsReady ) {
				return placeholderTextures( "Assets not ready yet.", prefix, 5 );
			}
			
			_atlas = getTextureAtlas( atlas );
			if ( _atlas == null ) {
				return placeholderTextures( "Could not find atlas " + atlas, prefix, 5 );
			}
			
			_textures = _atlas.getTextures( prefix );
			if ( !_textures || _textures.length == 0 ) {
				return placeholderTextures( "Could not find textures in atlas " + atlas, prefix );
			}
			
			return _textures;
			
		}
		
		private function getAtlasImage( name:String, atlas:String, touchable:Boolean = false ):Image {
			
			_img = new Image( getAtlasTexture( name, atlas ) );
			_img.name = name;
			_img.touchable = touchable;
			_img.useHandCursor = touchable;
			//_img.blendMode = BlendMode.NONE;
			
			return _img;
			
		}
				
		///
		
		public function getTexture( name:String, atlas:String="" ):Texture {
			
			if ( atlas ) {
				return getAtlasTexture( name, atlas );
			}
			
			if ( !assetsReady ) {
				return placeholderTexture( "Assets not ready yet.", name );
			}
			
			_texture = assets.getTexture(name);
			if ( _texture == null ) {
				return placeholderTexture( "Could not find texture.", name );
			}
			
			return _texture;
			
		}
				
		public function getTextures( prefix:String, atlas:String="" ):Vector.<Texture> {
			
			if ( atlas ) {
				return getAtlasTextures( prefix, atlas );
			}
			
			if ( !assetsReady ) {
				return placeholderTextures( "Assets not ready yet.", prefix, 5 );
			}
			
			_textures = assets.getTextures( prefix );
			if ( _textures == null || _textures.length <= 0 ) {
				return placeholderTextures( "Could not find textures.", prefix, 5 );
			}
			
			return _textures;
			
		}
		
		public function getImage( name:String, touchable:Boolean = false, atlas:String="" ):Image {
			
			return getImageFromTexture( getTexture( name, atlas ), touchable );
			
		}

		public function getMovie( prefix:String, touchable:Boolean = false, framerate:Number = 30,
									juggler:Juggler = null, play:Boolean=false, atlas:String="" ):MovieClip {
			
			_textures = getTextures( prefix, atlas );
			_mc = getMovieFromTextures( _textures, touchable, framerate, juggler, play );
			_mc.name = prefix;
			
			return _mc;
			
		}
		
		public function getImageFromTexture( texture:Texture, touchable:Boolean = false, name:String=null ):Image {
			
			_img = new Image( texture );
			_img.name = name ? name : _img.name;
			_img.touchable = touchable;
			_img.useHandCursor = touchable;
			
			return _img;
			
		}
		
		internal function getMovieFromTextures( textures:Vector.<Texture>=null, touchable:Boolean = false, framerate:Number = 30,
									juggler:Juggler = null, play:Boolean=false ):MovieClip {
			
			_mc = new MovieClip( textures, framerate );
			_mc.touchable = touchable;
			_mc.useHandCursor = touchable;
			
			if( juggler ) {
				juggler.add( _mc );
				if ( play ) {
					_mc.play();
				}
			}
			
			return _mc;
			
		}
		
		///
		
		private function placeholderTexture( errorMessage:String="", name:String="unspecified" ):Texture {
			
			if ( errorMessage )
				error( "Failed to load texture '" + name + "'. " + errorMessage );
			
			return assets.getTexture( "NoTextureTexture" );
			
		}
		private function placeholderTextures( errorMessage:String="", name:String="unspecified", count:uint=1 ):Vector.<Texture> {
			
			if ( errorMessage )
				error( "Failed to load textures '" + name + "'. " + errorMessage );
			
			var v:Vector.<Texture> = new Vector.<Texture>();
			for (var _i:int = 0; _i < count; _i++)
				v.push( placeholderTexture() );
			return v;
			
		}
		private function placeholderMovieClip( errorMessage:String="", name:String="unspecified" ):MovieClip {
			
			if ( errorMessage )
				error( "Failed to load movieclip '" + name + "'. " + errorMessage );
			
			return new MovieClip( placeholderTextures(), 30 );
			
		}
		
		///
		
		public function dispose():void {
			
			assetsReady = false;
			
			if ( _atlas ) {
				_atlas.dispose();
				_atlas = null;
			}
			
			if ( _texture ) {
				_texture.dispose();
				_texture = null;
			}
			
			if ( _mc ) {
				_mc.dispose();
				_mc = null;
			}
			
			
			assets.dispose();
			assets = null;
			
			System.gc();
		}
		
	}

}