package{
    import flash.text.TextField;
    import flash.display.Sprite;

    public class Main extends Sprite{

        public function Main(){
            var tf: TextField = new TextField();
            tf.text = "Hello Flash";
            tf.x = 50;
            tf.y = 40;
            addChild(tf);
        }
    }
}
 