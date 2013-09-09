package chimichanga.common.assets
{
	import debug.error;
	import global.Files;
	import starling.display.BlendMode;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.system.System;
	import global.Conf;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.errors.AbstractClassError;
	import starling.events.Event;
	import starling.extensions.krecha.ScrollImage;
	import starling.extensions.krecha.ScrollTile;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author choephix
	 */
	public class AdvancedAssetsManager implements IAssetsManager {
		
		public var assetsReady:Boolean = false;
		
		private var assets:AssetManager = new AssetManager();
		
		private var _atlas:TextureAtlas;
		private var _texture:Texture;
		private	var _textures:Vector.<Texture>;
		private var _mc:MovieClip;
		private var _img:Image;
		private var _i:uint;
		
		public function AdvancedAssetsManager() {
			
			assets.verbose = Capabilities.isDebugger;
		}
		
		public function init( scaleFactor:Number = 1, callback:Function = null, ...rest ):void {
			
			assets.scaleFactor = scaleFactor;
			
			assets.enqueue( Files.getFileOrPath( "assets/NoTextureTexture.png" ) );
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
			
			_img = new Image( getTexture( name, atlas ) );
			_img.name = name;
			_img.touchable = touchable;
			_img.useHandCursor = touchable;
			
			return _img;
			
		}
		
		public function getScrollImage( name:String, touchable:Boolean = false, atlas:String="", width:Number=-1, height:Number=-1 ):ScrollImage {
			
			_texture = getTexture( name, atlas );
			
			if ( width <= 0 ) {
				width = _texture.width;
			}
			
			if ( height <= 0 ) {
				height = _texture.height;
			}
			
			var _simg:ScrollImage = new ScrollImage( width, height );
			_simg.addLayer( new ScrollTile( _texture, false ) );
			_simg.touchable = touchable;
			_simg.useHandCursor = touchable;
			
			return _simg;
			
		}
		
		public function getMovie( prefix:String, touchable:Boolean = false, framerate:Number = 30,
									juggler:Juggler = null, play:Boolean=false, atlas:String="" ):MovieClip {
			
			_textures = getTextures( prefix, atlas );
			
			_mc = new MovieClip( _textures, framerate );
			_mc.name = prefix;
			_mc.touchable = touchable;
			
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