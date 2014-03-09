package com.meathill.diy.popup.view 
{
  import com.greensock.TweenMax;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.popup.AbstractPopup;
  import flash.display.Shape;
	import flash.display.Sprite;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
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
    private var bg:Shape;
    private var hasFocus:Boolean;
    
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
      label.x = 12;
      label.y = headerHeight + 20;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.text = '您可以保存当前作品以备将来修改或购买。\n给您的作品取个名字吧：';
      addChild(label);
      
      bg = new Shape();
      bg.x = 20;
      bg.y = headerHeight + 75;
      drawInputBg();
      addChild(bg);
      
      nameInput = new TextField();
      nameInput.type = TextFieldType.INPUT;
      nameInput.width = 200;
      nameInput.height = 22;
      nameInput.x = 25;
      nameInput.y = bg.y + 5;
      nameInput.defaultTextFormat = Typography.getTextFormat(Typography.BODY);
      nameInput.addEventListener(MouseEvent.ROLL_OVER, nameInput_rollOverHandler);
      nameInput.addEventListener(MouseEvent.ROLL_OUT, nameInput_rollOutHandler);
      nameInput.addEventListener(FocusEvent.FOCUS_IN, nameInput_focusInHandler);
      nameInput.addEventListener(FocusEvent.FOCUS_OUT, nameInput_focusOutHandler);
      addChild(nameInput);
      
      contentHeight = bg.y + bg.height + 20 - headerHeight;
    }
    private function drawInputBg(color:uint = 0xEEEEEE):void {
      bg.graphics.clear();
      bg.graphics.beginFill(color);
      bg.graphics.lineStyle(1, 0xCCCCCC);
      bg.graphics.drawRoundRect(0.5, 0.5, 208, 30, 4, 4);
      bg.graphics.endFill();
    }
    override protected function resetAttr():void {
      title = '保存作品';
    }
    
    
    private function nameInput_focusInHandler(e:FocusEvent):void {
      hasFocus = true;
      bg.filters = [Filters.INPUT_FOCUS_IN];
    }
    private function nameInput_focusOutHandler(e:FocusEvent):void {
      hasFocus = false;
      bg.filters = null;
      drawInputBg();
    }
    private function nameInput_rollOverHandler(e:MouseEvent):void {
      drawInputBg(0xFFFFFF);
    }
    private function nameInput_rollOutHandler(e:MouseEvent):void {
      drawInputBg(hasFocus ? 0xFFFFFF : 0xEEEEEE);
    }
  }

}