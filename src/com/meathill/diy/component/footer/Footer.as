package com.meathill.diy.component.footer 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.UserEvent;
  import flash.display.GradientType;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.geom.Matrix;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
	
	/**
   * ...
   * @author Meathill
   */
  public class Footer extends Sprite 
  {
    public static const HEIGHT:uint = 160;
    
    private var haibaoButton:Button;
    private var shareButton:Button;
    
    public function Footer(w:uint) {
      draw(w);
			layout();
    }
    
    
    private function draw(w:uint):void {
      var matrix:Matrix = new Matrix();
      matrix.createGradientBox(w, HEIGHT, Math.PI / 2);
      graphics.beginGradientFill(GradientType.LINEAR, [0x333333, 0x111111], [1, 1], [0, 1], matrix);
      graphics.drawRect(0, 0, w, HEIGHT);
      graphics.endFill();
    }
    private function layout():void {
      var socialTxt:TextField = new TextField();
      socialTxt.defaultTextFormat = Typography.getTextFormat(Typography.LEAD);
      socialTxt.x = socialTxt.y = 10;
      socialTxt.autoSize = TextFieldAutoSize.LEFT;
      socialTxt.text = '分享给大家：';
      addChild(socialTxt);
      
      var haibaoTxt:TextField = new TextField();
      haibaoTxt.defaultTextFormat = socialTxt.defaultTextFormat;
      haibaoTxt.x = 300;
      haibaoTxt.y = 10;
      haibaoTxt.autoSize = TextFieldAutoSize.LEFT;
      haibaoTxt.text = '制作海报';
      addChild(haibaoTxt);
      haibaoButton = new Button('开始');
      haibaoButton.x = 300;
      haibaoButton.y = 60;
      haibaoButton.addEventListener(MouseEvent.CLICK, haibaoBtn_clickHandler);
      addChild(haibaoButton);
      
      var shareTxt:TextField = new TextField();
      shareTxt.x = 600;
      shareTxt.y = 10;
      shareTxt.autoSize = TextFieldAutoSize.LEFT;
      shareTxt.text = '贡献到XLine设计库';
      addChild(shareTxt);
      shareButton = new Button('开始');
      shareButton.x = 600;
      shareButton.y = 60;
      shareButton.addEventListener(MouseEvent.CLICK, shareButton_clickHandler);
      addChild(shareButton);
      
      socialTxt.mouseEnabled = haibaoTxt.mouseEnabled = shareTxt.mouseEnabled = false;
    }
    
    
    private function haibaoBtn_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.HAIBAO);
      dispatchEvent(event);
    }
    private function shareButton_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.CONTRIBUTE);
      dispatchEvent(event);
    }
    
  }

}