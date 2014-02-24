package com.meathill.diy.popup 
{
  import com.meathill.diy.component.CloseButton;
  import com.meathill.diy.config.Typography;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
	
	/**
   * ...
   * @author Meathill
   */
  public class AbstractPopup extends Sprite implements IPopup 
  {
    protected var hasConfirm:Boolean;
    protected var hasCancel:Boolean;
    
    
    public function AbstractPopup(hasConfirm:Boolean = true, hasCancel:Boolean = true) {
      this.hasCancel = hasCancel;
      this.hasConfirm = hasConfirm;
      draw();
			layout();
      
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
      graphics.drawRoundRect(0, 0, width + 20, height + 20, 10, 10)
      graphics.endFill();
    }
    protected function layout():void {
      var title:TextField = new TextField();
      title.defaultTextFormat = Typography.getTextFormat(Typography.LEAD);
      title.height = 30;
      title.x = title.y = 10;
      title.autoSize = TextFieldAutoSize.LEFT;
      addChild(title);
      
      if (hasCancel) {
        var closeButton:CloseButton = new CloseButton();
        closeButton.y = 10;
        closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
        addChild(closeButton);
      }
      
      createContent();
    }
    
    private function closeButton_clickHandler(e:MouseEvent):void {
      parent.removeChild(this);
      afterHide();
    }
    
    
    
    private function addedHandler(e:Event):void {
      x = stage.stageWidth - width >> 1;
      y = stage.stageHeight - height >> 1;
    }
  }

}