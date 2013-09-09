package chimichanga.development {
	import flash.ui.Keyboard;
	import game.events.GameEvent;
	import game.Game;
	import game.unit.Unit;
	import global.Conf;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class DevelopmentGod {
		
		public function DevelopmentGod() {
		
		}
		
		public function registerGame( g:Game ):void {
			
			g.addEventListener( GameEvent.DISPOSED, deregisterGame );
			g.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			g.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		
		}
		
		private function deregisterGame( e:Event ):void {
			
			var g:Game = Game( e.currentTarget );
			
			g.removeEventListener( GameEvent.DISPOSED, deregisterGame );
			g.stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			g.stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		
		}
		
		private function onKeyDown( e:KeyboardEvent ):void {
			
			if( Game.current ) {
			
				switch( e.keyCode ) {
					
					case Keyboard.SPACE:
						Game.current.time.speed = ( Game.current.time.speed == 1.0 ? 4.0 : 1.0 );
						return;
					
					default:
						onKeyDownUnit( e );
						return;
					
				}
			}
		
		}
		
		private function onKeyDownUnit( e:KeyboardEvent ):void {
			
			var u:Unit;
			
			if ( Game.current.selections.selectedUnit )
				u = Game.current.selections.selectedUnit;
				
			if ( Game.current.selections.targetedUnit )
				u = Game.current.selections.targetedUnit;
				
			if ( u == null )
				return;
			
			switch( e.keyCode ) {
				
				case Keyboard.K:
					u.damage( 8, null );
					break;
				
				case Keyboard.D:
					u.damage( 1, null );
					break;
				
				case Keyboard.H:
					u.heal( 1, null );
					break;
				
				case Keyboard.R:
					u.resurrect();
					break;
				
				default: warn( "key " + e.keyCode + " not mapped" );
				
			}
		
		}
		
		private function onKeyUp( e:KeyboardEvent ):void {
		
		}
	
	}

}