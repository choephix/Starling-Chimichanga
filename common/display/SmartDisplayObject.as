package chimichanga.common.display {
	import chimichanga.debug.error;
	import chimichanga.debug.log;
	import global.Conf;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class SmartDisplayObject extends Sprite {
		
		private const statesList:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		private var statesCount:int = 0;
		
		private var _currentStateN:int = 0;
		
		override public function get width():Number { return super.width;}
		override public function set width(value:Number):void {
			for ( _i = 0; _i < statesCount; _i++ ) {
				statesList[_i].width = value;
			}
		}
		
		override public function get height():Number { return super.height;	}
		override public function set height(value:Number):void {
			for ( _i = 0; _i < statesCount; _i++ ) {
				statesList[_i].height = value;
			}
		}
		
		override public function get pivotX():Number { return super.pivotX;}
		override public function set pivotX(value:Number):void {
			for ( _i = 0; _i < statesCount; _i++ ) {
				statesList[_i].pivotX = value;
			}
		}
		
		override public function get pivotY():Number { return super.pivotY;	}
		override public function set pivotY(value:Number):void {
			for ( _i = 0; _i < statesCount; _i++ ) {
				statesList[_i].pivotY = value;
			}
		}
		
		public function get currentStateN():int {
			return _currentStateN;
		}
		
		public function get currentState():DisplayObject {
			return statesList[_currentStateN];
		}
		
		public var resetState:int = 0;
		
		public var onAnimationEndOnce:Function = null;
		
		private var _mc:MovieClip;
		private var _o:DisplayObject;
		private var _i:int;
		
		public function SmartDisplayObject(... states) {
			
			for each (var state:Object in states) {
				
				if ( state is String )
					name = state as String;
					
				else if ( state is DisplayObject )
					addState( DisplayObject(state) );
					
			}
			
			setState(0);
		
		}
		
		public function addState(state:DisplayObject):void {
			
			if (state != null) {
				statesList.push(state);
				addChild(state);
				disable(state);
				statesCount++;
			} else {
				throw(new Error("The state you tried to add to " + this + " is NULL"));
			}
		
		}
		
		public function setState(n:int, resetOnMovieEnd:Boolean = false, resetState:int = 0):void {
			
			if ( statesList.length == 0 ) {
				error( "cannot set state to " + this + " because it has no states left" );
				return;
			}
			
			disable(statesList[_currentStateN]);
			
			_currentStateN = n;
			
			resetState = resetState;
			
			enable(statesList[n], resetOnMovieEnd);
		
		}
		
		private function enable(state:DisplayObject, resetOnMovieEnd:Boolean = false):void {
			
			if ( state is MovieClip ) {
				
				_mc = MovieClip(state);
				
				if (resetOnMovieEnd) {
					_mc.stop();
					_mc.addEventListener(Event.COMPLETE, reset);
				}
				
				if ( onAnimationEndOnce != null ) {
					_mc.addEventListener( Event.COMPLETE, useOnAnimationEndOnceAndClear );
				}
				
				_mc.play();
				
			}
			
			state.visible = true;
		
		}
		
		private function useOnAnimationEndOnceAndClear(e:Event):void {
			
			log( "useOnAnimationEndOnceAndClear" );
			
			MovieClip( currentState ).removeEventListener(
							Event.COMPLETE, useOnAnimationEndOnceAndClear );
			onAnimationEndOnce();
			onAnimationEndOnce = null;
			
		}
		
		private function reset(e:Event = null):void {
			
			//_mc = MovieClip( currentState );
			//_mc.removeEventListener( Event.COMPLETE, reset );
			//_mc.pause();
			//Starling.juggler.delayCall( setState, _mc.getFrameDuration( _mc.currentFrame ), resetState );
			//return;
			
			setState(resetState);
		
		}
		
		private function disable( state:DisplayObject ):void {
			
			if ( state is MovieClip ) {
				MovieClip( state ).pause();
			}
			
			state.visible = false;
		
		}
		
		///
		
		//public function playStateOnce( state:int ):void {
			//
			//setState( state, true );
			//
		//}
		
		//public function playStateOnceAndStop( state:int, onMovieEnd:Function=null ):void {
			//
			//setState( state, false );
			//
			//if( onMovieEnd != null ) {
				//MovieClip( currentState ).addEventListener(Event.COMPLETE, onMovieEnd);
			//}
			//
		//}
		
		public function play():void {
			
			if ( currentState is MovieClip ) {
				MovieClip( currentState ).play();
			}
			
		}
		
		public function stop():void {
			
			if ( currentState is MovieClip ) {
				MovieClip( currentState ).stop();
			}
			
		}
		
		public function centerAllStates():void {
			
			for each (var state:DisplayObject in statesList) {
				state.x = - ( state.width  >> 1 ) ;
				state.y = - ( state.height >> 1 ) ;
			}
			
		}
		
		///
		
		public function getStateAsMc( n:int=-1 ):MovieClip {
			
			if ( n == -1 )
				n = currentStateN;
			
			return statesList[ n ] as MovieClip;
			
		}
		
		public function getStateAsImage( n:int=-1 ):Image {
			
			if ( n == -1 )
				n = currentStateN;
			
			return statesList[ n ] as Image;
			
		}
		
		///
		
		public function get color():uint {
			
			return statesList[_currentStateN].hasOwnProperty("color") ? statesList[_currentStateN]["color"] : 0x0;
		
		}
		
		public function set color(value:uint):void {
			
			for each (var state:DisplayObject in statesList) {
				if (state.hasOwnProperty("color")) {
					state["color"] = value;
				}
			}
		
		}
		
		public function centerPivots():void {
			
			for ( _i = 0; _i < statesCount; _i++ ) {
				_o = statesList[_i];
				_o.pivotX = _o.width>>1;
				_o.pivotY = _o.height>>1;
			}
			
		}
		
		public function centerPivotX():void {
			
			for ( _i = 0; _i < statesCount; _i++ ) {
				_o = statesList[_i];
				_o.pivotX = _o.width>>1;
			}
			
		}
		
		public function centerPivotY():void {
			
			for ( _i = 0; _i < statesCount; _i++ ) {
				_o = statesList[_i];
				_o.pivotY = _o.height>>1;
			}
			
		}
		
		///
		
		override public function dispose():void {
			
			statesList.length = 0;
			
			_mc = null;
			
			super.dispose();
			
		}
		
	}

}