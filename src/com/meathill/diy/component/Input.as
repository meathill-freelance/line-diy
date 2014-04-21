package com.meathill.diy.component 
{
  import com.meathill.diy.filter.Filters;
  import flash.display.Shape;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.events.TextEvent;
  import flash.text.TextField;
  import flash.text.TextFieldType;
	
	/**
   * ...
   * @author Meathill
   */
  public class Input extends Sprite 
  {
    private var bgShape:Shape;
    private var input:TextField;
    private var init:Object;
    private var hasFocus:Boolean;
    
    public function Input(init:Object) {
      this.init = init;
      draw();
      layout();
      
      addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
    }
    
    public function get value():String {
      return input.text;
    }
    public function set value(str:String):void {
      input.text = str;
    }
    
    private function draw(color:uint = 0xF0F0F0):void {
      bgShape = bgShape || new Shape();
      bgShape.graphics.clear();
      bgShape.graphics.beginFill(color);
      bgShape.graphics.lineStyle(1, 0xCCCCCC);
      bgShape.graphics.drawRoundRect(0.5, 0.5, init.width, init.height, 4);
      bgShape.graphics.endFill();
      addChildAt(bgShape, 0);
    }
    private function layout():void {
      input = new TextField();
      input.x = 5;
      input.y = 5;
      input.width = init.width - 10;
      input.height = init.height - 10;
      if (init.maxLength) {
        input.maxChars = init.maxLength;
      }
      if (init.restrict) {
        input.restrict = init.restrict;
      }
      input.wordWrap = init.wrap;
      input.type = TextFieldType.INPUT;
      input.defaultTextFormat = init.textFormat;
      input.addEventListener(FocusEvent.FOCUS_IN, numberInput_focusInHandler);
      input.addEventListener(FocusEvent.FOCUS_OUT, numberInput_focusOutHandler);
      input.addEventListener(TextEvent.TEXT_INPUT, numberInput_changeHandler);
      input.text = init.text || '';
      addChild(input);
    }
    
    private function numberInput_changeHandler(e:TextEvent):void {
      dispatchEvent(new Event(Event.CHANGE));
    }
    private function numberInput_focusInHandler(e:FocusEvent):void {
      hasFocus = true;
      bgShape.filters = [Filters.INPUT_FOCUS_IN, Filters.INPUT_GLOW];
    }
    private function numberInput_focusOutHandler(e:FocusEvent):void {
      hasFocus = false;
      bgShape.filters = [Filters.INPUT];
      draw();
    }
    private function rollOverHandler(e:MouseEvent):void {
      draw(0xFFFFFF);
    }
    private function rollOutHandler(e:MouseEvent):void {
      draw(hasFocus ? 0xFFFFFF : 0xF0F0F0);
    }
  }

}