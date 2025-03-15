package {
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;

	public class Player extends MovieClip {
		//Declaring Booleans for key codes
		private var moveUp: Boolean;
		private var moveDown: Boolean;
		private var moveLeft: Boolean;
		private var moveRight: Boolean;
		// Booleans for diagonal axis
		private var moveUpLeft: Boolean;
		private var moveDownLeft: Boolean;
		private var moveUpRight: Boolean;
		private var moveDownRight: Boolean;
		// axis state
		private var axis_y: int;
		private var axis_x: int;
		// checks whether Down was last pressed or any other key
		private var wasDown: Boolean;
		
		
		//gameOver Boolean
		private var gameOver:Boolean = false;

		//Declaring the speed of movie clip
		public var speed: Number = 5;

		public function Player() { 
			// Position player will be when game starts
			gotoAndStop("left");
			
			//Random Location to place player on stage
			x = (Math.random() * (800 - width / 2)) + (width / 2);
			//Make sure player is not moving
			moveUp = false;
			moveDown = false;
			moveLeft = false;
			moveRight = false;
			
			moveUpLeft = false;
		    moveDownLeft = false;
		 	moveUpRight = false;
			moveDownRight = false;

			//event Listeners to control player movements
			//stage refers to "our game"
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

			//use these event listeners so dude can move diagonal
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		} //Player()
		
		public function getGameState():Boolean {
			return this.gameOver;
		}
		public function setGameState(b: Boolean):void {
			this.gameOver = b;
		}
		
		private function keyDown(e: KeyboardEvent):void {
			//parsing the user keyboard event to a keycode value which can be use by keyboard
			var key: uint = e.keyCode;
			
			if(!gameOver) {
				switch (key) {
					case Keyboard.UP:
						moveUp = true;
						axis_y = -1;
						break;
					case Keyboard.DOWN:
						moveDown = true;
						axis_y = 1;
						break;
					case Keyboard.LEFT:
						moveLeft = true;
						axis_x = -1;
						break;
					case Keyboard.RIGHT:
						moveRight = true;
						axis_x = 1;
						break;
				}
			}
		} //keyDown

		private function keyUp(e: KeyboardEvent): void {

			//parsing the user keyboard event to a keycode value which can be use by keyboard
			var key: uint = e.keyCode;
			
			if(!gameOver) {
				switch (key) {
					case Keyboard.UP:
						moveUp = false;
						wasDown = false;
						axis_y = 0;
						break;
					case Keyboard.DOWN:
						moveDown = false;
						wasDown = true;
						axis_y = 0;
						break;
					case Keyboard.LEFT:
						moveLeft = false;
						axis_x = 0;
						break;
					case Keyboard.RIGHT:
						moveRight = false;
						axis_x = 0;
						break;
				}
			}
		} //keyUp

		private function onEnterFrame(e:Event):void {
			//flash references the location from top left as 0.0
			if (moveUp && !gameOver) {
				if(y - height/2 > speed+10 && !gameOver){
					y -= speed;
				}
				gotoAndStop("up");
			}
			if (moveDown && !gameOver) {
				if(y + height/2 < 580-speed+1 && !gameOver){
					y += speed;
				}
				gotoAndStop("down");
			}
			if (moveLeft && !gameOver) {
				if(x - width/2 + 20 > speed-10 && !gameOver){
					x -= speed;
				}
				gotoAndStop("left");
			}
			if (moveRight && !gameOver) {
				if(x + width/2 - 20 < 800-speed+1 && !gameOver){
					x += speed;
				}
				gotoAndStop("right");
			}
			
			// pre-diagonal axis
			// true check
			if(axis_y < 0)
			{
				if(axis_x < 0)
					moveUpLeft = true;
				if(axis_x > 0)
					moveUpRight = true;
			}
			if(axis_y > 0)
			{
				if(axis_x < 0)
					moveDownLeft = true;
				if(axis_x > 0)
					moveDownRight = true;
			}
			// false check
			if(axis_x == 0)
			{
				moveUpLeft = false;
				moveUpRight = false;
				moveDownLeft = false;
				moveDownRight = false;
			}
			if(axis_y == 0)
			{
				moveUpLeft = false;
				moveUpRight = false;
				moveDownLeft = false;
				moveDownRight = false;
			}
			
			
			// diagonal axis
			if (moveUpLeft && !gameOver) {
				gotoAndStop("upleft");
			}
			if (moveDownLeft && !gameOver) {
				gotoAndStop("downleft");
			}
			if (moveUpRight && !gameOver) {
				gotoAndStop("upright");
			}
			if (moveDownRight && !gameOver) {
				gotoAndStop("downright");
			}
			
			
			// terrible code that causes eye bleeding
			// idle animation
			if(moveUp == false)
				if(moveDown == false)
					if(moveLeft == false)
						if(moveRight == false)
							if(wasDown)
								gotoAndStop("down");
							else
								gotoAndStop("up");
		} // end of onEnterFrame
	}
}
