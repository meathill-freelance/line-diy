package com.meathill.diy.component.number 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.Input;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.vo.SingleStepConfig;
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
    private var asset:Sprite;
    private var preview:Sprite;
    private var prevButton:Button;
    private var nextButton:Button;
    
    public function SquadNumber(config:SingleStepConfig) {
      _config = config;
      layout();
    }
    
    public function get config():SingleStepConfig {
      return _config;
    }
    public function set asset(value:Sprite):void {
      asset = value;
    }
    
    private function layout():void {
      // 输入队服号码
      var init:Object = {
        width: 200,
        height: 45,
        maxLength: 2,
        restrict: '0-9',
        text: _config.curr.toString(),
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
    
    private function numberInput_changeHandler(e:Event):void {
      var event:DesignEvent = new DesignEvent(DesignEvent.SET_SQUAD_NUMBER);
      event.number = uint(numberInput.value);
      event.asset = _config.asset;
      dispatchEvent(event);
    }
    
  }

}