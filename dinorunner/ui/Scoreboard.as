// Track score

package dinorunner.ui{

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;
    import flash.events.KeyboardEvent;
    import flash.display.DisplayObject;
    import flash.system.System;


    public class Scoreboard extends Sprite{

        private var scoreTf: TextField;

        private var score: Number;
        private var isAlive: Boolean;


        public function Scoreboard(parent: DisplayObject){
            addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
            parent.stage.addChild(this);
        }

        private function onAddToStage(e: Event): void{
            isAlive = true;
            score = 0;

            scoreTf = new TextField();
            scoreTf.x = 0;
            scoreTf.y = 0;
            addChild(scoreTf);
            scoreTf.text = 'Score: ' + (score);

            x = (stage.stageWidth / 2) - (scoreTf.width / 2);
            y = 10;

            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(e: Event): void{
            if(isAlive){
                scoreTf.text = 'Score: ' + Math.floor((++score) / 10);
            }
        }

        public function getScore(): Number{
            return score;
        }

        public function kill(): void{
            isAlive = false;
        }

        public function reset(): void{
            isAlive = true;
            score = 0;
        }
    }
}