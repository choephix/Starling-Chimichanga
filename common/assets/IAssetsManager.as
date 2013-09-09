package chimichanga.common.assets
{
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author choephix
	 */
	public interface IAssetsManager {
		
		function getImage( name:String, touchable:Boolean = false, atlas:String = "" ):Image;
		
		function getMovie( prefix:String, touchable:Boolean = false, framerate:Number = 30, juggler:Juggler = null, play:Boolean = false, atlas:String = "" ):MovieClip;
		
		function getTexture( name:String, atlas:String = "" ):Texture;
		
		function getTextures( prefix:String, atlas:String = "" ):Vector.<Texture>;
		
	}
	
}