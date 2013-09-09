package chimichanga.common.display.particles {
	import engine.GameContext;
	import engine.GameContextEvent;
	import global.Conf;
	import starling.display.DisplayObjectContainer;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author choephix
	 */
	public final class ParticlesManager {
		
		private var maxCount:uint = 160;
		
		private var pool:Vector.<Particle> = new Vector.<Particle>();
		private var poolSize:uint 	= 0;
		private var poolIndex:uint 	= 0;
		
		private var _i:int = 0;
		private var _p:Particle;
		
		private var total:uint = 0;
		
		public var active:Boolean;
		
		public function ParticlesManager( maxCount:uint=25 ) {
			
			this.maxCount = maxCount;
			
			active = Conf.PARTICLES_ON;
			
			while ( pool.length < maxCount ) {
				pool.push( new Particle() );
			}
			
		}
		
		public function loop( deltaTime:Number ):void {
			
			for ( _i = 0; _i < poolSize ; _i++ ) {
				
				_p = pool[_i];
				
				if ( _p.alive )
					_p.onEnterFrame( deltaTime );
				
			}
			
		}
		
		public function addMany( count:int, parent:DisplayObjectContainer, texture:Texture, x:Number, y:Number, speed:Number, rotationSpeed:Number, gravity:Number, lifetime:Number, scale:Number = 1, type:uint = 0, color:uint = 0xFfFfFf, variants:uint = 3 ):void {
			
			if ( active ) {
				
				while( count-- ) {
					add(  texture, x, y, speed, rotationSpeed, gravity, lifetime, scale, type, color, variants, parent );
				}
			
			}
		}
		
		public function add( texture:Texture, x:Number, y:Number, speed:Number, rotationSpeed:Number, gravity:Number, lifetime:Number, scale:Number = 1, type:uint = 0, color:uint = 0xFfFfFf, variants:uint = 3, parent:DisplayObjectContainer=null ):Particle {
			
			if( active ) {
			
				if ( poolSize <= poolIndex ) {
					pool.push( new Particle() );
					poolSize++;
				}
				
				_p = pool[poolIndex];
				_p.init(
						texture,
						x, y,
						speed,
						rotationSpeed,
						gravity,
						lifetime,
						scale,
						type,
						color
					);
					
				poolIndex ++;
				if ( poolIndex >= maxCount ) {
					poolIndex = 0;
				}
				
				if ( parent ) {
					parent.addChild( _p );
				}
			
			}
			
			return _p;
			
		}
		
		public function dispose():void {
				
			while ( pool.length ) {
				_p = pool.pop();
				_p.dispose();
			}
			
			_p = null;
			
		}
	
	}

}