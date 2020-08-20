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

        private const jumpHeight: Number = 15;
        private const gravity: Number = 0.75;
        private const baseSpeed: Number = 5;

        [Embed(source="assets/Cactus.png")]
        private var Cactus: Class;

        [Embed(source="assets/Player.png")]
        private var Player: Class;

        private var metrics: Metrics;
        private var scoreboard: Scoreboard;
        private var ground: Sprite;

        private var player: Bitmap;
        private var cactus: Bitmap;

        private var speed: Number;
        private var isAlive: Boolean;

        private var isJumping: Boolean;        
        private var jumpVelocity: Number;
        private var originalYPos: int;
        private var groundYPos: int;


        public function Main(){
            metrics = new Metrics(this);
            scoreboard = new Scoreboard(this);
            initGround();

            cactus = new Cactus();
            cactus.x = stage.width - cactus.width;
            cactus.y = groundYPos - cactus.height;
            addChild(cactus);

            player = new Player();
            player.y = groundYPos - player.height;
            addChild(player);

            reset();

            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function initGround(): void{
            groundYPos = stage.stageHeight - (stage.stageHeight / 2);

            ground = new Sprite();
            ground.graphics.lineStyle(2, 0, 1.0); // thick,color,alpha
            ground.graphics.moveTo(0, groundYPos);
            ground.graphics.lineTo(stage.stageWidth, groundYPos);
            addChild(ground);
        }

        private function onKeyDown(e: KeyboardEvent): void{
            var key: uint = e.keyCode;

            if(key == 32 && !isJumping){
                isJumping = true;
                originalYPos = player.y;
                jumpVelocity = jumpHeight;
            }
        }

        private function onEnterFrame(e: Event): void{
            if(isJumping){
                processJump();
            }
            processCactus();
            checkHit();
        }

        private function checkHit(): void{
            if(    (cactus.hitTestPoint(player.x + player.width / 2, player.y + player.height / 2, true))
                || (cactus.hitTestPoint(player.x + player.width / 2, player.y - player.height / 2, true))
                || (cactus.hitTestPoint(player.x - player.width / 2, player.y + player.height / 2, true))
                || (cactus.hitTestPoint(player.x - player.width / 2, player.y - player.height / 2, true))
            ){
                reset();
            }
        }

        private function processJump(): void{
            if(player.y > originalYPos){
                player.y = originalYPos;
                isJumping = false;
            } else {
                player.y -= jumpVelocity;
                jumpVelocity -= gravity;
            }
        }

        private function processCactus(): void{
            if(cactus.x <= 0){
                cactus.x = (stage.width - cactus.width) + Math.floor(Math.random() * 10) + 1;
                speed = baseSpeed + Math.floor(Math.random() * 15) + 1;
            } else{
                cactus.x -= speed;
            }
        }

        private function reset(): void{
            isAlive = true;

            player.x = 75;
            player.y = groundYPos - player.height;

            speed = baseSpeed;
            scoreboard.reset();
        }
    }
}
