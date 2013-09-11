package chimichanga.development {
	import starling.display.DisplayObjectContainer;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Lablo extends DisplayObjectContainer {
		
		public function Lablo( text:String ) {
			
			super();
			var _tf:TextField = new TextField( 500, 80, text );
			addChild( _tf );
		
		}
	
	}

}