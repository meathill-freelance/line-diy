package com.meathill.diy.component.footer 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.filter.Filters;
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
    public static const HEIGHT:uint = 130;
    
    private var haibaoButton:Button;
    private var shareButton:Button;
    
    public function Footer(w:uint) {
      draw(w);
			layout();
    }
    
    
    private function draw(w:uint):void {
      graphics.beginFill(Colors.FOOTER_BG);
      graphics.drawRect(2, 0, w - 4, HEIGHT - 2);
      graphics.endFill();
      
      filters = [Filters.TUQI];
    }
    private function layout():void {
      var socialTxt:TextField = new TextField();
      socialTxt.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {color: 0xFFFFFF});
      socialTxt.x = 30;
      socialTxt.autoSize = TextFieldAutoSize.LEFT;
      socialTxt.text = '分享给大家：';
      addChild(socialTxt);
      
      var haibaoTxt:TextField = new TextField();
      haibaoTxt.defaultTextFormat = socialTxt.defaultTextFormat;
      haibaoTxt.x = 300;
      haibaoTxt.autoSize = TextFieldAutoSize.LEFT;
      haibaoTxt.text = '制作海报';
      addChild(haibaoTxt);
      haibaoButton = new Button('开始');
      haibaoButton.x = 300;
      haibaoButton.addEventListener(MouseEvent.CLICK, haibaoBtn_clickHandler);
      addChild(haibaoButton);
      
      var shareTxt:TextField = new TextField();
      shareTxt.x = 600;
      shareTxt.autoSize = TextFieldAutoSize.LEFT;
      shareTxt.defaultTextFormat = socialTxt.defaultTextFormat;
      shareTxt.text = '贡献到XLine设计库';
      addChild(shareTxt);
      shareButton = new Button('开始');
      shareButton.x = 600;
      shareButton.addEventListener(MouseEvent.CLICK, shareButton_clickHandler);
      addChild(shareButton);
      
      socialTxt.y = haibaoTxt.y = shareTxt.y = 20;
      socialTxt.mouseEnabled = haibaoTxt.mouseEnabled = shareTxt.mouseEnabled = false;
      
      haibaoButton.y = shareButton.y = 50;
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