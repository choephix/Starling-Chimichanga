package chimichanga.common.display.particles {
	import nape.geom.Vec2;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author choephix
	 */
	public class Particle extends Sprite {
		
		/// ENUM
		
		public static const TYPE_SPLINTER:uint = 0;
		public static const TYPE_SMOKE:uint = 1;
		
		/// PROPERTIES
		
		private var image:Image;
		private var gravity:Number;
		
		public var rotationSpeed:Number;
		
		public var speedinitlen:Number;
		public var speed:Vec2;
		
		private var lifeinit:Number;
		private var life:Number;
		
		private var deceleration:Number;
		
		private var scale:Number;
		
		private var type:uint;
		
		public var alive:Boolean = false;
		
		public function Particle() {
		}
		
		public function init( texture:Texture, x:Number, y:Number, speed:Number, rotationSpeed:Number, gravity:Number, lifetime:Number, scale:Number = 1, type:uint = 0, color:uint = 0xFfFfFf ):void {
			
			this.deceleration = .01;
			this.alive = true;
			this.rotation = 0;
			scaleX = 1;
			scaleY = 1;
			
			this.gravity = gravity;
			this.lifeinit = lifetime;
			this.life = lifetime;
			scale = scale
			this.type = type;
			
			this.speedinitlen = speed;
			this.speed = Vec2.weak(1, 1);
			this.speed.length = Math.random() * speed;
			this.speed.angle = Math.random() * Math.PI * 2;
			
			this.x = x + this.speed.x * .1;
			this.y = y + this.speed.y * .1;
			
			if ( !image ) {
				image = new Image(texture);
				image.touchable = false;
				addChild(image);
			} else {
				if (image.texture != texture) {
					image.texture = texture;
					image.readjustSize();
				}
			}
			
			this.image.alpha = 1;
			this.image.color = color;
			this.image.scaleX = scale;
			this.image.scaleY = scale;
			this.image.x = -image.width / 2;
			this.image.y = -image.height / 2;
			
			this.rotationSpeed = rotationSpeed;
			this.rotation = Math.random() * Math.PI * 2;
			
			this.touchable = false;
		
		}
		
		public function onEnterFrame( deltaTime:Number ):void {
			
			if (alive) {
				
				life -= deltaTime;
				var g:Number = gravity * (1 - (life / lifeinit));
				
				if (life < 0) {
					die();
				} else {
					
					x += (speed.x) * deltaTime;
					y += (speed.y) * deltaTime;
					y += g * deltaTime;
					
					if (type == TYPE_SPLINTER) {
						scaleX = life / lifeinit;
						scaleY = life / lifeinit;
						speed.length = life / lifeinit * speedinitlen;
					} else if (type == TYPE_SMOKE) {
						image.alpha = life / lifeinit;
					}
					
					rotation += rotationSpeed * deltaTime;
					
				}
				
			}
		
		}
		
		public function die():void {
			
			alive = false;
			
			removeFromParent();
		}
		
		public override function dispose():void {
		
			removeFromParent();
			
			if ( image )
				image.dispose();
			
			super.dispose();
		
		}
	
	}

}