package chimichanga.common.assets
{
	import starling.display.BlendMode;
	import flash.filesystem.File;
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
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author choephix
	 */
	public class AdvancedAssetsManagerDebug {
		
		public var assetsReady:Boolean = false;
		
		private var assets:AssetManager = new AssetManager();
		
		private var _atlas:TextureAtlas;
		private var _texture:Texture;
		private	var _textures:Vector.<Texture>;
		private var _mc:MovieClip;
		private var _img:Image;
		private var _i:uint;
		
		public function AdvancedAssetsManagerDebug() {
			
			assets.verbose = Capabilities.isDebugger;
			
		}
		
		public function init( scaleFactor:Number = 1, callback:Function = null, ...rest ):void {
			
			assets.scaleFactor = scaleFactor;
			
			assets.enqueue( File.applicationDirectory.resolvePath( "assets/NoTextureTexture.png" ) );
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
			
			_atlas = getTextureAtlas(atlas);
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
				return placeholderTextures( "Assets not ready yet.", prefix );
			}
			
			_atlas = getTextureAtlas( atlas );
			if ( _atlas == null ) {
				return placeholderTextures( "Could not find atlas " + atlas, prefix );
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
		
		public function getAtlasMovie( name:String, atlas:String, framerate:Number = 30, touchable:Boolean = false ):MovieClip {
			
			if ( !assetsReady ) {
				error( "COUDN'T LOAD MOVIE, ASSETS NOT READY" );
			}
			
			_atlas = getTextureAtlas(atlas);
			if ( _atlas == null ) {
				error( "Could not find atlas " + atlas );
				return placeholderMovieClip();
			}
			
			_textures = _atlas.getTextures(name);
			
			if( _textures.length > 0 ) {
			
				if ( !Conf.FULL_MOVIECLIPS ) {
					
					var f__:Boolean = true;
					
					while ( _textures.length > 1 ) {
						if ( f__ )
							_textures.pop();
						else
							_textures.shift();
						f__ = !f__;
					}
					
					_mc = new MovieClip(_textures, 2);
					
				} else {
					
					_mc = new MovieClip(_atlas.getTextures(name), framerate);
					
				}
			
			} else {
				
				_mc = placeholderMovieClip();
				
			}
			
			if( !Conf.PLAY_MOVIECLIPS ) {
				Starling.juggler.delayCall( function(mc:MovieClip):void{mc.dispatchEventWith( Event.COMPLETE );}, .5, _mc );
			}
			
			_mc.touchable = touchable;
			
			return _mc;
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
				return placeholderTextures( "Assets not ready yet.", prefix );
			}
			
			_textures = assets.getTextures( prefix );
			if ( _textures == null || _textures.length <= 0 ) {
				return placeholderTextures( "Could not find textures.", prefix );
			}
			
			return _textures;
			
		}
		
		public function getImage( name:String, touchable:Boolean = false, atlas:String="" ):Image {
			
			_img = new Image( getTexture( name, atlas ) );
			_img.touchable = touchable;
			_img.useHandCursor = touchable;
			
			return _img;
			
		}
		
		public function getMovie( name:String, juggler:Juggler = null, framerate:Number = 30, touchable:Boolean = false ):MovieClip {
			
			if ( !assetsReady ) {
				error( "COUDN'T LOAD MOVIE, ASSETS NOT READY" );
			}
			
			_textures = getTextures( name );
			
			_mc = new MovieClip(_textures, framerate);
			
			if( juggler && Conf.PLAY_MOVIECLIPS ) {
				juggler.add( _mc );
			}
			
			_mc.touchable = touchable;
			
			return _mc;
			
		}
		
		
		
		///
		
		/// HELPER METHODS
		
		public function tileImage( image:Image, tileX:Number = 2 ):Image {
			
			image.texture.repeat = true;
			image.setTexCoords(1, new Point(tileX, 0));
			image.setTexCoords(2, new Point(0, 1));
			image.setTexCoords(3, new Point(tileX, 1));
			image.width *= tileX;
			
			return image;
		}
		
		public function getAndPlayMovie( clipName:String, atlasName:String, juggler:Juggler, framerate:Number = 30, touchable:Boolean = false ):MovieClip {
			
			_mc = getAtlasMovie( clipName, atlasName, framerate, touchable );
			
			if( juggler && Conf.PLAY_MOVIECLIPS ) {
				juggler.add( _mc );
				_mc.play();
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
		
		private function error( msg:String ):Error {
			
			return error( msg );
			
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