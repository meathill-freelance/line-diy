package com.meathill.diy.popup.view 
{
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.popup.AbstractPopup;
  import com.meathill.diy.service.AssetsManager;
  import flash.display.Bitmap;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.geom.ColorTransform;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class BuyPopup extends AbstractPopup {
    private static var stepsLabel:Array = ['保存设计', '生成订单', '跳转页面'];
    private static var colorTransform:ColorTransform = new ColorTransform(0, 0, 0, 1, 46, 204, 113);
    
    private var steps:Vector.<PopupStepItem>;
    private var icons:Vector.<Bitmap>;
    private var info:TextField;
    
    public function BuyPopup() {
      super();
			
    }
    
    public function light(step:uint):void {
      steps[step].working = true;
      info.text = '正在' + stepsLabel[step] + '中，请稍候';
      if (step > 0) {
        steps[step - 1].ready = true;
      }
      if (step - 1 < icons.length && step > 0) {
        icons[step - 1].transform.colorTransform = colorTransform;
      }
    }
    override public function removeLoading():void {
      super.removeLoading();
      
      info.text = '请登录后再购买球衣。';
      steps[0].working = false;
    }
    
    override protected function createContent():void {
      steps = new Vector.<PopupStepItem>();
      icons = new Vector.<Bitmap>();
      for (var i:uint = 0, len:uint = stepsLabel.length; i < len; i++) {
        var step:PopupStepItem = new PopupStepItem(i, stepsLabel[i]);
        step.x = i * 200 + 60;
        step.y = headerHeight + 20;
        addChild(step);
        steps.push(step);
        
        if (i < stepsLabel.length - 1) {
          var icon:Bitmap =  AssetsManager.instance.clone('chevronRight');
          icon.x = step.x + 130;
          icon.y = step.y + 30;
          icon.transform.colorTransform = new ColorTransform(0.5, 0.5, 0.5);
          addChild(icon);
          icons.push(icon);
        }
      }
      
      info = new TextField();
      info.x = 20;
      info.y = headerHeight + contentHeight - 30;
      info.width = popupWidth - 40;
      info.defaultTextFormat = Typography.getTextFormat(Typography.BODY, { align: TextFormatAlign.CENTER } );
      info.wordWrap = false;
      info.text = '保存您的设计并添加进购物车需要一点时间，请耐心等候。';
      addChild(info);
    }
    override protected function resetAttr():void {
      title = '添加到购物车';
      contentHeight = 200;
    } 
    
    override protected function confirmButton_clickHandler(e:MouseEvent):void {
      super.confirmButton_clickHandler(e);
      
      addLoading();
      light(0);
    }
  }

}