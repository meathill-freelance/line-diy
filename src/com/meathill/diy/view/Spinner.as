package com.meathill.diy.view 
{
  import com.greensock.plugins.TweenPlugin;
  import com.greensock.TweenLite;
  import com.greensock.plugins.TintPlugin;
  import com.meathill.diy.config.Typography;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
	
	/**
   * 加载进度
   * @author Meathill
   */
  public class Spinner extends Sprite {
    private var color:uint = 0x2ECC71;
    private var tween:TweenLite;
    
    [Embed(source="../../../../../assets/xlinecom.swf")]
    private var Logo:Class;
    private var logo:Sprite;
    private var tips:TextField;
    
    public function set tip(value:String):void {
      tips.text = value;
      tips.x = -tips.width >> 1;
    }
    
    public function Spinner() {
      mouseChildren = mouseEnabled = false;
      
      logo = new Logo() as Sprite;
      logo.x = -logo.width >> 1;
      logo.y = -logo.height;
      addChild(logo);
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
      
      tips = new TextField();
      tips.defaultTextFormat = Typography.getTextFormat(Typography.LEAD, { color: 0xCCCCCC } );
      tips.autoSize = TextFieldAutoSize.LEFT;
      tips.y = 30;
      addChild(tips);
    }
    
    
    private function tween_complateHandler():void {
      tween.reverse();
    }
    private function tween_reverseCompleteHandler():void {
      tween.restart();
    }
    private function addedHandler(e:Event):void {
      x = stage.stageWidth >> 1;
      y = stage.stageHeight >> 1;
      
      TweenPlugin.activate([TintPlugin]);
      tween = TweenLite.to(logo, 1, { tint: color, onComplete: tween_complateHandler, onReverseComplete: tween_reverseCompleteHandler } );
      
      removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
      addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
    }
    private function removedHandler(e:Event):void {
      tween.kill();
      
      removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
      addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }
    
  }

}