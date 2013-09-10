package chimichanga.common.input.keys {
	import flash.ui.Keyboard;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class KeyHandler {
		
		private var stage:Stage;
		
		private var keyUpListeners:Array = new Array();
		private var keyDownListeners:Array = new Array();
		
		public function KeyHandler( stage:Stage ) {
			
			this.stage = stage;
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
		}
		
		public function addKeyUpListener( keyCode:uint, callback:Function, ...callbackArguments ):void {
			
			keyUpListeners.push( { code:keyCode, f:callback, fargs:callbackArguments } );
			
		}
		
		public function addKeyDownListener( keyCode:uint, callback:Function, ...callbackArguments ):void {
			
			keyUpListeners.push( { code:keyCode, f:callback, fargs:callbackArguments } );
			
		}
		
		public function addNumberKeyDownListener( callback:Function ):void {
			
			keyDownListeners.push( { code:Keyboard.NUMBER_0, f:callback, fargs:0} );
			keyDownListeners.push( { code:Keyboard.NUMBER_1, f:callback, fargs:1} );
			keyDownListeners.push( { code:Keyboard.NUMBER_2, f:callback, fargs:2} );
			keyDownListeners.push( { code:Keyboard.NUMBER_3, f:callback, fargs:3} );
			keyDownListeners.push( { code:Keyboard.NUMBER_4, f:callback, fargs:4} );
			keyDownListeners.push( { code:Keyboard.NUMBER_5, f:callback, fargs:5} );
			keyDownListeners.push( { code:Keyboard.NUMBER_6, f:callback, fargs:6} );
			keyDownListeners.push( { code:Keyboard.NUMBER_7, f:callback, fargs:7} );
			keyDownListeners.push( { code:Keyboard.NUMBER_7, f:callback, fargs:7} );
			keyDownListeners.push( { code:Keyboard.NUMBER_8, f:callback, fargs:8} );
			keyDownListeners.push( { code:Keyboard.NUMBER_9, f:callback, fargs:9} );
			
		}
		
		private function dispose():void {
			
			keyUpListeners.length = 0;
			keyDownListeners.length = 0;
			
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			
			var len:int = keyDownListeners.length;
			
			if ( len <= 0 ) {
				return;
			}
			
			for ( var i:int = 0, o:Object; i < len; i++ ) {
				
				o = keyDownListeners[ i ];
				if ( o.code == e.keyCode ) {
					o.f( o.fargs );
				}
				
			}
		
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			
			var len:int = keyUpListeners.length;
			
			if ( len <= 0 ) {
				return;
			}
			
			for ( var i:int = 0, o:Object; i < len; i++ ) {
				
				o = keyUpListeners[ i ];
				if ( o.code == e.keyCode ) {
					o.f( o.fargs );
				}
				
			}
			
		}
	
	}

}