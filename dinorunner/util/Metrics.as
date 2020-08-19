package dinorunner.util{
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.display.DisplayObject;
    import flash.system.System;


    public class Metrics extends Sprite{

        private const w: int = 100;
        private const h: int = 48;

        private var memUsage: TextField;
        private var fpsCur: TextField;
        private var fpsAvg: TextField;

        private var fpsMax: int;
        private var frameTime: int;
        private var fpsList: Array;


        public function Metrics(parent: DisplayObject){
            addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
            parent.stage.addChild(this);
        }

        public function onAddToStage(e: Event): void{
            visible = false;
            x = stage.stageWidth - w;
            y = 0;

            fpsCur = new TextField();
            fpsCur.x = 3;
            fpsCur.y = 5;
            addChild(fpsCur);

            fpsAvg = new TextField();
            fpsAvg.x = 3;
            fpsAvg.y = 20;
            addChild(fpsAvg);

            memUsage = new TextField();
            memUsage.x = 3;
            memUsage.y = 35;
            addChild(memUsage);

            fpsList = new Array();
            fpsMax = stage.frameRate;

            addEventListener(Event.ENTER_FRAME, onEnterFrame);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            stage.addEventListener(Event.RESIZE, onResize);
        }

        private function onResize(e: Event): void{
            x = stage.stageWidth - w;
        }

        private function onKeyDown(e: KeyboardEvent): void{
            if(e.keyCode == Keyboard.BACKQUOTE){
                visible = !visible;
            }
        }

        private function onEnterFrame(e: Event): void{
            calc();
        }

        private function calc(): void{
            memUsage.text = 'MEM: ' + Number(System.totalMemory / 1024 / 1024).toFixed(2) + ' Mb';
            var current: int = 1000 / (getTimer() - frameTime);
            fpsCur.text = 'CUR: ' + String(current) + ' FPS';
            
            frameTime = getTimer();
            fpsList.push(current);

            if(fpsList.length >= fpsMax){
                var avg: int = 0;

                for(var i: int = 0; i < fpsList.length; i++){
                    avg += fpsList[i];
                }
                avg /= fpsList.length;
                fpsAvg.text = 'AVG: ' + int(avg) + ' / ' + fpsMax + ' FPS';
                fpsList = new Array();
            }
        }

    }
}