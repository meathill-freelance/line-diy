package com.meathill.diy.popup.view 
{
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.popup.AbstractPopup;
  import flash.display.Shape;
	import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFieldType;
	
	/**
   * ...
   * @author Meathill
   */
  public class SavePopup extends AbstractPopup
  {
    private var nameInput:TextField;
    
    public function SavePopup() {
      title = '保存作品';
    }
    
    public function get desginName():String {
      return nameInput.text;
    }
    
    public function showSuccess():void {
      
    }
    public function showError():void {
      
    }
    
    override protected function createContent():void {
      var label:TextField = new TextField();
      label.mouseEnabled = false;
      label.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {indent: 10});
      label.x = 20;
      label.y = headerHeight + 20;
      label.height = 20;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.text = '您可以保存当前作品以备将来修改或购买。\n给您的作品取个名字吧：';
      addChild(label);
      
      nameInput = new TextField();
      nameInput.type = TextFieldType.INPUT;
      nameInput.width = 200;
      nameInput.height = 20;
      nameInput.x = 20;
      nameInput.y = headerHeight + 40 + label.height + 4;
      nameInput.defaultTextFormat = Typography.getTextFormat(Typography.LEAD);
      addChild(nameInput);
      
      var bg:Shape = new Shape();
      bg.graphics.beginFill(0xFFFFFF);
      bg.graphics.drawRoundRect(0, 0, 208, 30, 4, 4);
      bg.graphics.endFill();
      bg.x = 20;
      bg.y = headerHeight + 4 + label.height;
      addChildAt(bg, getChildIndex(nameInput));
      
      contentHeight = bg.y + bg.height + 20 - headerHeight;
    }
  }

}