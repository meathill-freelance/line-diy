package com.meathill.diy.popup 
{
  import com.greensock.TweenLite;
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.CloseButton;
  import com.meathill.diy.component.PrimaryButton;
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.utils.ColorMaker;
  import flash.display.Bitmap;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.ColorTransform;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
	
	/**
   * ...
   * @author Meathill
   */
  public class AbstractPopup extends Sprite implements IPopup {
    protected var hasConfirm:Boolean;
    protected var confirmLable:String = '确定';
    protected var confirmButton:PrimaryButton;
    protected var hasCancel:Boolean;
    protected var cancelLable:String = '取消';
    protected var cancelButton:Button;
    protected var hasClose:Boolean = true;
    protected var title:String = '窗体';
    protected var popupWidth:uint = 600;
    protected var headerHeight:uint = 50;
    protected var contentHeight:uint = 300;
    protected var footerHeight:uint = 64;
    private var spinner:Sprite;
    private var closeButton:CloseButton;
    
    public function AbstractPopup(hasConfirm:Boolean = true, hasCancel:Boolean = true) {
      this.hasCancel = hasCancel;
      this.hasConfirm = hasConfirm;
      resetAttr();
			layout();
      draw();
      
      addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }
    
    /* INTERFACE com.meathill.diy.popup.IPopup */
    
    public function beforeShow():void {
      alpha = 0;
    }
    
    public function afterHide():void {
      
    }
    
    protected function createContent():void {
      
    }
    protected function draw():void {
      graphics.beginFill(0xFFFFFF);
      graphics.lineStyle(1, 0xCCCCCC);
      graphics.drawRoundRectComplex(0.5, 0.5, popupWidth, headerHeight, 10, 10, 0, 0);
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
      title.x = 12;
      title.y = 10;
      title.autoSize = TextFieldAutoSize.LEFT;
      title.text = this.title;
      title.mouseEnabled = false;
      addChild(title);
      
      if (hasClose) {
        closeButton = new CloseButton();
        closeButton.x = popupWidth - 12 - closeButton.width;
        closeButton.y = 12;
        closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
        addChild(closeButton);
      }
      
      createContent();
      
      if (hasCancel) {
        cancelButton = new Button(cancelLable);
        cancelButton.y = 15 + contentHeight + headerHeight;
        cancelButton.x = popupWidth - 15 - cancelButton.width;
        cancelButton.addEventListener(MouseEvent.CLICK, cancelButton_clickHandler);
        addChild(cancelButton);
      }
      if (hasConfirm) {
        confirmButton = new PrimaryButton(confirmLable);
        confirmButton.y = 15 + contentHeight + headerHeight;
        confirmButton.x = (hasCancel ? cancelButton.x : popupWidth) - 15 - confirmButton.width;
        confirmButton.addEventListener(MouseEvent.CLICK, confirmButton_clickHandler);
        addChild(confirmButton);
      }
    }
    protected function remove():void {
      parent.removeChild(this);
      afterHide();
    }
    protected function resetAttr():void {
      
    }
    protected function addLoading():void {
      confirmButton.mouseEnabled = cancelButton.mouseEnabled = closeButton.mouseEnabled = false;
      confirmButton.filters = cancelButton.filters = closeButton.filters = Filters.DISABLED;
      
      var bmp:Bitmap = AssetsManager.instance.clone('spinner');
      bmp.transform.colorTransform = new ColorTransform(.3, .3, .3);
      spinner = new Sprite();
      bmp.x = -bmp.width >> 1;
      bmp.y = -bmp.height >> 1;
      spinner.addChild(bmp);
      spinner.x = confirmButton.x - 25;
      spinner.y = confirmButton.y + 18;
      spinner.addEventListener(Event.ENTER_FRAME, spinner_enterFrameHandler);
      addChild(spinner);
    }
    protected function removeLoading():void {
      spinner.removeEventListener(Event.ENTER_FRAME, spinner_enterFrameHandler);
      removeChild(spinner);
      
      confirmButton.filters = cancelButton.filters = closeButton.filters = null;
      confirmButton.mouseEnabled = cancelButton.mouseEnabled = closeButton.mouseEnabled = true;
    }
    protected function createLabel(label:String, x:int = 0, y:int = 0, color:uint = 0):void {
      color = color ? color : Colors.EMERALD;
      var mc:Sprite = new Sprite();
      var text:TextField = new TextField();
      text.autoSize = TextFieldAutoSize.LEFT;
      text.defaultTextFormat = Typography.getTextFormat(Typography.LEAD, { color: 0xFFFFFF } );
      text.text = label;
      text.x = 15;
      text.y = 4;
      mc.mouseChildren = mc.mouseEnabled = false;
      mc.graphics.lineStyle(1, ColorMaker.draken(color, 20));
      mc.graphics.beginFill(color);
      mc.graphics.drawRoundRect(0.5, 0.5, text.width + 30, text.height + 6, 4);
      mc.x = x;
      mc.y = y;
      addChild(mc);
      
      TweenLite.fromTo(mc, 0.3, { alpha: 0.4, height: 0 }, { alpha: 1, height: mc.height, onComplete: function ():void {
        mc.addChild(text);
      }});
    }
    
    protected function cancelButton_clickHandler(e:MouseEvent):void {
      remove();
    }
    protected function closeButton_clickHandler(e:MouseEvent):void {
      remove();
    }
    protected function confirmButton_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.CONFIRM);
      dispatchEvent(event);
    }
    private function spinner_enterFrameHandler(e:Event):void {
      spinner.rotation += 5;
    }
    
    
    
    private function addedHandler(e:Event):void {
      x = stage.stageWidth - width >> 1;
      var toy:uint = stage.stageHeight - height >> 1;
      y = toy + 20;
      TweenLite.to(this, 0.3, { alpha: 1, y: toy } );
    }
  }

}