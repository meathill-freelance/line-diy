package com.meathill.diy.popup.view 
{
  import com.meathill.diy.component.Input;
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.popup.AbstractPopup;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
	
	/**
   * ...
   * @author Meathill
   */
  public class SavePopup extends AbstractPopup
  {
    private var nameInput:Input;
    
    public function get desginName():String {
      return nameInput.value;
    }
    
    public function showSuccess():void {
      removeLoading();
      createLabel('保存成功', 25, nameInput.y + 50);
    }
    public function showError():void {
      removeLoading();
      createLabel('保存失败', 25, nameInput.y + 50, Colors.POMEGRANATE);
    }
    
    override protected function createContent():void {
      var label:TextField = new TextField();
      label.mouseEnabled = false;
      label.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {leading: 10});
      label.x = 22;
      label.y = headerHeight + 20;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.text = '您可以保存当前作品以备将来修改或购买。\n给您的作品取个名字吧：';
      addChild(label);
      
      var init:Object = {
        width: 210,
        height: 30,
        textFormat: Typography.getTextFormat(Typography.BODY)
      };
      nameInput = new Input(init);
      nameInput.x = 25;
      nameInput.y = headerHeight + 75;
      addChild(nameInput);
      
      contentHeight = nameInput.y + nameInput.height + 20 - headerHeight + 100;
    }
    override protected function resetAttr():void {
      title = '保存作品';
    }
    
    override protected function confirmButton_clickHandler(e:MouseEvent):void {
      super.confirmButton_clickHandler(e);
      
      addLoading();
    }
  }
}