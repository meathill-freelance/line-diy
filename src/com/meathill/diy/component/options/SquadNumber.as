package com.meathill.diy.component.options 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.Input;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Matrix;
  import flash.sampler.getSize;
  import flash.sampler.getSize;
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
    private var _style:uint;
    private var totalStyle:uint;
    private var _color:uint;
    
    public function SquadNumber(config:SingleStepConfig, asset:Sprite) {
      _config = config;
      _asset = asset;
      totalStyle = _asset.numChildren;
      layout();
      draw();
    }
    public function get number():uint {
      return uint(numberInput.value);
    }
    public function get style():uint {
      return _style;
    }
    
    
    public function setColor(value:uint, index:uint = 0):void {
      addFilter(value, index);
    }
    
    
    private function addFilter(color:uint, index:uint):void {
      preview.getChildAt(index).filters = [Filters.getColorFilter(color, 0)];
    }
    private function draw():void {
      var numberAsset:Sprite = Sprite(_asset.getChildAt(_style));
      while (preview.numChildren) {
        preview.removeChildAt(0);
      }
      for (var i:uint = 0, len:uint = numberInput.value.length; i < len; i++) {
        var index:uint = parseInt(numberInput.value.charAt(i));
        index = index === 0 ? 10 : index;
        var mc:DisplayObject = numberAsset.getChildAt(index - 1);
        var size:Object = Scaler.getSize(mc, 50, 100);
        var bmpd:BitmapData = new BitmapData(size.width, size.height, true, 0);
        bmpd.draw(mc, new Matrix(size.width / mc.width, 0, 0, size.height/ mc.height));
        var bmp:Bitmap = new Bitmap(bmpd, "auto", true);
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
      var event:Event = new Event(Event.CHANGE);
      dispatchEvent(event);
    }
    
    
    private function prevButton_clickHandler(e:MouseEvent):void {
      _style = _style === 0 ? totalStyle - 1 : (_style - 1);
      draw();
      dispatchChangeEvent();
    }
    
    private function nextButton_clickHandler(e:MouseEvent):void {
      _style++;
      _style = _style > totalStyle - 1 ? totalStyle - 1: _style;
      draw();
      dispatchChangeEvent();
    }
    private function numberInput_changeHandler(e:Event):void {
      draw();
      dispatchChangeEvent();
    }
    
  }

}