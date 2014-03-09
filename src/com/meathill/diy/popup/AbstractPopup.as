package com.meathill.diy.popup 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.CloseButton;
  import com.meathill.diy.component.PrimaryButton;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.UserEvent;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.filters.DropShadowFilter;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
	
	/**
   * ...
   * @author Meathill
   */
  public class AbstractPopup extends Sprite implements IPopup 
  {
    public static const FILTER:DropShadowFilter = new DropShadowFilter(8, 90, 0.4, 4, 4);
    protected var hasConfirm:Boolean;
    protected var confirmLable:String = '确定';
    protected var hasCancel:Boolean;
    protected var cancelLable:String = '取消';
    protected var title:String = '窗体';
    protected var popupWidth:uint = 600;
    protected var headerHeight:uint = 56;
    protected var contentHeight:uint = 300;
    protected var footerHeight:uint = 74;
    
    public function AbstractPopup(hasConfirm:Boolean = true, hasCancel:Boolean = true) {
      this.hasCancel = hasCancel;
      this.hasConfirm = hasConfirm;
			layout();
      draw();
      this.filters = [FILTER];
      
      addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }
    
    /* INTERFACE com.meathill.diy.popup.IPopup */
    
    public function beforeShow():void {
      
    }
    
    public function afterHide():void {
      
    }
    
    protected function createContent():void {
      
    }
    protected function draw():void {
      graphics.beginFill(0xF0F0F0);
      graphics.lineStyle(1, 0x999999);
      graphics.drawRoundRectComplex(0, 0, popupWidth, headerHeight, 10, 10, 0, 0);
      if (hasConfirm || hasCancel) {
        graphics.drawRect(0, headerHeight, popupWidth, contentHeight);
        graphics.drawRoundRectComplex(0, headerHeight + contentHeight, popupWidth, footerHeight, 0, 0, 10, 10);
      } else {
        graphics.drawRoundRectComplex(0, headerHeight, popupWidth, contentHeight, 0, 0, 10, 10);
      }
      graphics.endFill();
    }
    protected function layout():void {
      var title:TextField = new TextField();
      title.defaultTextFormat = Typography.getTextFormat(Typography.LEAD);
      title.height = 30;
      title.x = title.y = 10;
      title.autoSize = TextFieldAutoSize.LEFT;
      title.text = this.title;
      title.mouseEnabled = false;
      addChild(title);
      
      if (hasCancel) {
        var closeButton:CloseButton = new CloseButton();
        closeButton.x = popupWidth - 10 - closeButton.width;
        closeButton.y = 10;
        closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
        addChild(closeButton);
      }
      
      createContent();
      
      if (hasCancel) {
        var cancelButton:Button = new Button(cancelLable);
        cancelButton.y = 20;
        cancelButton.x = popupWidth - 20 - cancelButton.width;
        cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler);
      }
      if (hasConfirm) {
        var confirmButton:PrimaryButton = new PrimaryButton(confirmLable);
        confirmButton.y = 20;
        confirmButton.x = hasCancel ? cancelButton.x : popupWidth - 20 - confirmButton.width;
        confirmButton.addEventListener(MouseEvent.CLICK, confirmButton_clickHandler);
      }
    }
    protected function remove():void {
      parent.removeChild(this);
      afterHide();
    }
    
    private function cancelButton_clickHandler(e:MouseEvent):void {
      remove();
    }
    private function closeButton_clickHandler(e:MouseEvent):void {
      remove();
    }
    private function confirmButton_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.CONFIRM);
      dispatchEvent(event);
    }
    
    
    
    private function addedHandler(e:Event):void {
      x = stage.stageWidth - width >> 1;
      y = stage.stageHeight - height >> 1;
    }
  }

}