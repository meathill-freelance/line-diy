package com.meathill.diy.component.number 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.Input;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class SquadNumber extends Sprite 
  {
    private var _config:SingleStepConfig;
    private var numberInput:Input;
    private var _asset:Sprite;
    private var preview:Sprite;
    private var prevButton:Button;
    private var nextButton:Button;
    private var style:uint;
    private var totalStyle:uint;
    
    public function SquadNumber(config:SingleStepConfig) {
      _config = config;
      layout();
    }
    
    public function get config():SingleStepConfig {
      return _config;
    }
    public function set asset(value:Sprite):void {
      _asset = value;
      totalStyle = _asset.numChildren;
      draw();
    }
    
    private function draw():void {
      var numberAsset:Sprite = Sprite(_asset.getChildAt(style));
      while (preview.numChildren) {
        preview.removeChildAt(0);
      }
      for (var i:uint = 0, len:uint = numberInput.value.length; i < len; i++) {
        var index:uint = parseInt(numberInput.value.charAt(i));
        index = index === 0 ? 10 : index;
        var mc:DisplayObject = numberAsset.getChildAt(index - 1);
        var bmpd:BitmapData = new BitmapData(mc.width, mc.height, true, 0);
        bmpd.draw(mc);
        var bmp:Bitmap = new Bitmap(bmpd, "auto", true);
        Scaler.resize(bmp, 50, 100);
        bmp.x = preview.width + (i % len * 10) + (_config.length - len) * 25; 
        preview.addChild(bmp);
      }
    }
    private function layout():void {
      // 输入队服号码
      var init:Object = {
        width: 200,
        height: 45,
        maxLength: 2,
        restrict: '0-9',
        text: _config.number.toString(),
        textFormat: Typography.getTextFormat(Typography.LEAD, { align: TextFormatAlign.CENTER } )
      }
      numberInput = new Input(init);
      numberInput.addEventListener(Event.CHANGE, numberInput_changeHandler);
      addChild(numberInput);
      
      // 选择号码样式
      prevButton = new Button('<');
      prevButton.y = 80;
      prevButton.addEventListener(MouseEvent.CLICK, prevButton_clickHandler);
      addChild(prevButton);
      nextButton = new Button('>');
      nextButton.x = 200 - nextButton.width;
      nextButton.y = 80;
      nextButton.addEventListener(MouseEvent.CLICK, nextButton_clickHandler);
      addChild(nextButton);
      preview = new Sprite();
      preview.x = prevButton.width + 10;
      preview.y = 60;
      addChild(preview);
    }
    private function dispatchChangeEvent():void {
      var event:DesignEvent = new DesignEvent(DesignEvent.SET_SQUAD_NUMBER);
      event.number = uint(numberInput.value);
      event.style = style;
      event
      dispatchEvent(event);
    }
    
    
    private function prevButton_clickHandler(e:MouseEvent):void {
      style = style === 0 ? totalStyle - 1 : (style - 1);
      draw();
      dispatchChangeEvent();
    }
    
    private function nextButton_clickHandler(e:MouseEvent):void {
      style++;
      style = style > totalStyle - 1 ? totalStyle - 1: style;
      draw();
      dispatchChangeEvent();
    }
    private function numberInput_changeHandler(e:Event):void {
      draw();
      dispatchChangeEvent();
    }
    
  }

}