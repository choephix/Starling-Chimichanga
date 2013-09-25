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
		
		/**
		 * Instantiate a new key handler. Pass a valid Starling stage instance to attach KEY_DOWN and KEY_UP listeners.
		 * @param	stage 	Starling stage instance to attach KEY_DOWN and KEY_UP listeners.
		 */
		public function KeyHandler( stage:Stage ) {
			
			this.stage = stage;
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
		}
		
		public function addKeyUpListener( keyCode:uint, callback:Function, ...callbackArguments ):void {
			
			keyUpListeners.push( { code:keyCode, f:callback, fargs:callbackArguments } );
			
		}
		
		public function addKeyUpListenerAdvanced( keyCode:uint, shift:Boolean, ctrl:Boolean, callback:Function, ...callbackArguments ):void {
			
			keyUpListeners.push( { code:keyCode, shift:shift, ctrl:ctrl, f:callback, fargs:callbackArguments } );
			
		}
		
		public function addKeyDownListener( keyCode:uint, callback:Function, ...callbackArguments ):void {
			
			keyDownListeners.push( { code:keyCode, f:callback, fargs:callbackArguments } );
			
		}
		
		public function addKeyDownListenerAdvanced( keyCode:uint, shift:Boolean, ctrl:Boolean, callback:Function, ...callbackArguments ):void {
			
			keyDownListeners.push( { code:keyCode, shift:shift, ctrl:ctrl, f:callback, fargs:callbackArguments } );
			
		}
		
		public function addNumberKeyDownListener( callback:Function ):void {
			
			keyDownListeners.push( { code:Keyboard.NUMBER_0, f:callback, fargs:[0] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_1, f:callback, fargs:[1] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_2, f:callback, fargs:[2] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_3, f:callback, fargs:[3] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_4, f:callback, fargs:[4] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_5, f:callback, fargs:[5] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_6, f:callback, fargs:[6] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_7, f:callback, fargs:[7] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_7, f:callback, fargs:[7] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_8, f:callback, fargs:[8] } );
			keyDownListeners.push( { code:Keyboard.NUMBER_9, f:callback, fargs:[9] } );
			
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			
			processKeyboardEvent( e, keyDownListeners );
			
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
			
			processKeyboardEvent( e, keyUpListeners );
			
		}
		
		private function processKeyboardEvent( e:KeyboardEvent, listeners:Array ):void {
			
			var len:int = listeners.length;
			
			if ( len <= 0 ) {
				return;
			}
			
			var i:int;
			var o:Object;
			
			for ( i = 0; i < len; i++ ) {
				
				o = listeners[ i ];
				if ( o.code  != e.keyCode ) continue;
				if ( o.ctrl  && !e.ctrlKey ) continue;
				if ( o.shift && !e.shiftKey ) continue;
				o.f.apply( null, o.fargs );
				
			}
			
		}
		
		public function dispose():void {
			
			keyUpListeners.length = 0;
			keyDownListeners.length = 0;
			
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		
		}
		
	}

}