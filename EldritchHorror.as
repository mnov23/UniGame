package {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;

	public class EldritchHorror extends MovieClip {

		//Declaring Booleans for key codes
		private var moveUp: Boolean;
		private var moveDown: Boolean;
		private var moveLeft: Boolean;
		private var moveRight: Boolean;
		
		// 
		private var gameOver:Boolean;

		//Declaring the speed of movie clip
		private const speed: Number = 14;


		public function EldritchHorror() { //the constructor ( Think JAVA) 
		
			while(true)
			{
				if(stage.safetyZoneMC.hitTestObject(this))
	   			{
		  			trace("game over");
	  			}
			}

			// Position player will be when game starts
			//gotoAndStop("gun");
			gotoAndStop("Left");

			//Random Location to place player on stage
			x = (Math.random() * (800 - width / 2)) + (width / 2);
			y = 200; 			//Make sure player is not moving
			moveUp = false;
			moveDown = false;
			moveLeft = false;
			moveRight = false;

			//event Listeners to control player movements
			//stage refers to "our game"
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);

			//use these event listeners so dude can move diagonal
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);

		} //Player()

		private function keyDown(e: KeyboardEvent):void {

			//parsing the user keyboard event to a keycode value which can be use by keyboard
			var key: uint = e.keyCode;

			switch (key) {

				case Keyboard.UP:
					moveUp = true;
					break;

				case Keyboard.DOWN:
					moveDown = true;
					break;

				case Keyboard.LEFT:
					moveLeft = true;
					break;

				case Keyboard.RIGHT:
					moveRight = true;
					break;
			} //end of switch
		} //keyDown


		private function keyUp(e: KeyboardEvent): void {

			//parsing the user keyboard event to a keycode value which can be use by keyboard
			var key: uint = e.keyCode;

			switch (key) {

				case Keyboard.UP:
					moveUp = false;
					break;

				case Keyboard.DOWN:
					moveDown = false;
					break;

				case Keyboard.LEFT:
					moveLeft = false;
					break;

				case Keyboard.RIGHT:
					moveRight = false;
					break;
			} //end of switch
		} //keyUp

		private function onEnterFrame(e:Event):void{

			//flash references the location from top left as 0.0
			if (moveUp) {
				if(y - height/2 > speed - 1 && !gameOver) {
					y -= speed;
				}
			}

			if (moveDown) {
				if(y + height/2 < 600 - speed + 1 && !gameOver) {
					y += speed;
				}
			}

			if (moveLeft) {
				if(x - width/2 > speed - 1 && !gameOver) {
					x -= speed;
				}
				gotoAndStop("Left");
			}

			if (moveRight) {
				if(x + width/2 < 787 - speed + 1 && !gameOver) {
					x += speed;
				}
				gotoAndStop("Right");
			}
		} // end of onEnterFrame

	}
}






