// Program entry

package dinorunner{

    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.text.TextField;

    import dinorunner.ui.Metrics;
    import dinorunner.ui.Scoreboard;


    public class Main extends Sprite{

        [Embed(source="assets/Cactus.png")]
        private var Cactus: Class;

        [Embed(source="assets/Player.png")]
        private var Player: Class;


        // TODO: Player class with states ?
        private var player: Bitmap;

        // private var moveUp: Boolean;
        // private var moveDown: Boolean;
        private var moveLeft: Boolean;
        private var moveRight: Boolean;
        private var isJumping: Boolean;

        private var jumpHeight: Number = 10;
        private var originalYPos: Number;
        private var gravity: Number = 0.5;
        private var jumpVelocity: Number;
        private var step: uint = 5;

        private var metrics: Metrics;
        private var scoreboard: Scoreboard;


        public function Main(){
            metrics = new Metrics(this);
            scoreboard = new Scoreboard(this);

            var cactus: Bitmap = new Cactus();
            cactus.x = 100;
            cactus.y = stage.stageHeight - (cactus.height + 25);
            addChild(cactus);

            player = new Player();
            player.x = 200;
            player.y = 100;
            addChild(player);

            var tf: TextField = new TextField();
            tf.text = "Hello Flash";
            tf.x = 10;
            tf.y = 10;
            addChild(tf);

            // player = createPlayerSprite(0xFFFF00);
            // player.x = 200;
            // player.y = 100;
            // addChild(player);

            // Register event listeners
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onKeyDown(e: KeyboardEvent): void{
            var key: uint = e.keyCode;
            moveLeft  = (key == 37 || key == 65);
            moveRight = (key == 39 || key == 68);
            // moveUp    = (key == 38 || key == 87);
            // moveDown  = (key == 40 || key == 83);

            if(key == 32 && !isJumping){
                isJumping = true;
                originalYPos = player.y;
                jumpVelocity = jumpHeight;
            }
        }

        private function onKeyUp(e: KeyboardEvent): void{
            var key: uint = e.keyCode;
            moveLeft  = !(key == 37 || key == 65);
            moveRight = !(key == 39 || key == 68);
            // moveUp    = !(key == 38 || key == 87);
            // moveDown  = !(key == 40 || key == 83);
        }

        private function onEnterFrame(e: Event): void{
            if(moveLeft)   player.x -= step;
            if(moveRight)  player.x += step;
            // if(moveUp)     player.y -= step;
            // if(moveDown)   player.y += step;

            if(isJumping){
                player.y -= jumpVelocity;
                jumpVelocity -= gravity;
            }


            // if(scoreboard.getScore() > 100){
            //     scoreboard.kill();
            // }

        }

        // Create player sprite manually
        private function createPlayerSprite(bgColor: uint): Sprite{
            var s: Sprite = new Sprite();
            
            // head
            s.graphics.beginFill(bgColor);
            s.graphics.drawCircle(0, 0, 40);
            s.graphics.endFill();

            // eyes
            s.graphics.beginFill(0x000000);
            s.graphics.drawCircle(-15, -10, 5);
            s.graphics.drawCircle(+15, -10, 5);
            s.graphics.endFill();

            // mouth
            s.graphics.lineStyle(2, 0x000000, 100);
            s.graphics.moveTo(-20, 15);
            s.graphics.curveTo(0, 35, 20, 15);

            return s;
        }

    }
}
