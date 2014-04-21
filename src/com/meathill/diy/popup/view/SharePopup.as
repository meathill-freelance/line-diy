package com.meathill.diy.popup.view 
{
  import com.meathill.diy.component.Input;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.popup.AbstractPopup;
	import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
	
	/**
   * ...
   * @author Meathill
   */
  public class SharePopup extends AbstractPopup
  {
    private var nameInput:Input;
    
    public function get value():String {
      return nameInput.value;
    }
    
    override protected function createContent():void {
      var label:TextField = new TextField();
      label.mouseEnabled = false;
      label.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {indent: 10});
      label.x = 12;
      label.y = headerHeight + 20;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.text = '感谢您的分享，请您简单说明一下创意来源';
      addChild(label);
      
      var init:Object = {
        width: 480,
        height: 60,
        wrap: true,
        textFormat: Typography.getTextFormat(Typography.BODY)
      };
      nameInput = new Input(init);
      nameInput.x = 25;
      nameInput.y = headerHeight + 55;
      addChild(nameInput);
      
      contentHeight = nameInput.y + nameInput.height + 20 - headerHeight;
    }
    
    override protected function resetAttr():void {
      title = '分享作品'
    }
  }

}