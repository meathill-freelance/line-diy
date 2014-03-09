package com.meathill.diy.component.number 
{
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.events.TextEvent;
  import flash.filters.DropShadowFilter;
  import flash.text.TextField;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class SquadNumber extends Sprite 
  {
    private var config:SingleStepConfig;
    private var numberInput:TextField;
    private var bgShape:Shape;
    
    public function SquadNumber(config:SingleStepConfig) {
      this.config = config;
      draw();
      layout();
      
      addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
    }
    
    
    private function draw():void {
      bgShape = new Shape();
      bgShape.graphics.beginFill(0xFFFFFF);
      bgShape.graphics.drawRoundRect(0, 0, 180, 30, 4);
      bgShape.graphics.endFill();
      bgShape.filters = [new DropShadowFilter(2, 45, 0, 0.25, 4, 4, 1, 1, true)];
      addChild(bgShape);
    }
    private function layout():void {
      numberInput = new TextField();
      numberInput.x = 15;
      numberInput.y = 15;
      numberInput.maxChars = config.length;
      numberInput.defaultTextFormat = Typography.getTextFormat(Typography.LEAD, { align: TextFormatAlign.CENTER } );
      numberInput.addEventListener(FocusEvent.FOCUS_IN, numberInput_focusInHandler);
      numberInput.addEventListener(FocusEvent.FOCUS_OUT, numberInput_focusOutHandler);
      numberInput.addEventListener(TextEvent.TEXT_INPUT, numberInput_changeHandler);
      addChild(numberInput);
    }
    
    
    private function numberInput_changeHandler(e:TextEvent):void {
      var event:DesignEvent = new DesignEvent(DesignEvent.SET_SQUAD_NUMBER);
      event.number = uint(numberInput.text);
      event.asset = config.asset;
      dispatchEvent(event);
    }
    private function numberInput_focusInHandler(e:FocusEvent):void {
      
    }
    private function numberInput_focusOutHandler(e:FocusEvent):void {
      
    }
    private function rollOverHandler(e:MouseEvent):void {
      
    }
    private function rollOutHandler(e:MouseEvent):void {
      
    }
    
  }

}