package com.meathill.diy.component.options 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.Input;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextFormatAlign;
  import flash.utils.setTimeout;
	
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
    private var totalStyle:uint;
    private var _color:uint;
    
    public function get number():uint {
      return uint(numberInput.value);
    }
    
    private var _style:uint;
    public function get style():uint {
      return _style;
    }
    
    public function SquadNumber(config:SingleStepConfig, asset:Sprite) {
      _config = config;
      _asset = asset;
      _style = _config.style;
      totalStyle = _asset.numChildren;
      layout();
      draw();
    }
    
    public function setColor():void {
      draw();
    }
    
    private function draw():void {
      var numberAsset:Sprite = Sprite(_asset.getChildAt(_style));
      while (preview.numChildren) {
        preview.removeChildAt(0);
      }
      var bmps:Vector.<Bitmap> = SquadNumberUtils.useDesign(numberAsset, numberInput.value, _config.color, _config.color2, 110, 80, true);
      for (var i:uint = 0, len:uint = bmps.length; i < len; i++) {
        preview.addChild(bmps[i]);
      }
      var event:SystemEvent = new SystemEvent(SquadNumberUtils.numColor > 1 ? SystemEvent.DOUBLE_COLOR : SystemEvent.SINGLE_COLOR);
      setTimeout(dispatchEvent, 0, event);
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
      _style = _style > totalStyle - 1 ? 0 : _style;
      draw();
      dispatchChangeEvent();
    }
    private function numberInput_changeHandler(e:Event):void {
      draw();
    }
    
  }

}