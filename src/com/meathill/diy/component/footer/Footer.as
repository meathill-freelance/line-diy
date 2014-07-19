package com.meathill.diy.component.footer 
{
  import com.meathill.diy.component.AlphaButton;
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
    private var serviceTxt:TextField;
    
    public function Footer(w:uint) {
      draw(w);
			layout(w);
    }
    
    public function addText(more:String):void {
      serviceTxt.text = more;
    }
    
    
    private function draw(w:uint):void {
      graphics.beginFill(Colors.FOOTER_BG);
      graphics.drawRoundRectComplex(2, 0, w - 4, HEIGHT - 2, 6, 6, 0, 0);
      graphics.beginFill(Colors.INFO_BG);
      graphics.drawRoundRect(w - 220, 20, 200, HEIGHT - 40, 6);
      graphics.endFill();
      
      filters = [Filters.TUQI];
    }
    private function layout(w:uint):void {
      var socialTxt:TextField = new TextField();
      socialTxt.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {color: 0xFFFFFF});
      socialTxt.x = 30;
      socialTxt.autoSize = TextFieldAutoSize.LEFT;
      socialTxt.text = '分享给大家：';
      addChild(socialTxt);
      createSocialButtons();
      
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
      
      serviceTxt = new TextField();
      serviceTxt.x = w - 210;
      serviceTxt.y = 30;
      serviceTxt.width = 180;
      serviceTxt.height = HEIGHT - 30;
      serviceTxt.wordWrap = true;
      serviceTxt.defaultTextFormat = Typography.getTextFormat(Typography.BODY, { color: Colors.INFO_FONT, size: 12, leading: 6 } );
      addChild(serviceTxt);
      
      socialTxt.y = haibaoTxt.y = 20;
      socialTxt.mouseEnabled = haibaoTxt.mouseEnabled = false;
      
      haibaoButton.y = 50;
    }
    
    private function createSocialButtons():void {
      var arr:Array = ['weibo', 'renren', 'douban', 'tweibo'];
      for (var i:uint = 0, len:uint = arr.length; i < len; i++) {
        var button:AlphaButton = new AlphaButton(arr[i]);
        button.name = arr[i];
        button.x = 30 + AlphaButton.WIDTH * i;
        button.y = 50;
        addChild(button);
      }
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