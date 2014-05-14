package com.meathill.diy.component.options 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.Input;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class TeamName extends Sprite {
    private static var FONTS:Array = ['宋体', '微软雅黑', '幼圆'];
    private var _config:SingleStepConfig;
    private var fontText:TextField;
    private var prevButton:Button;
    private var nextButton:Button;
    private var nameInput:Input;
    private var _style:uint;
    
    public function TeamName(config:SingleStepConfig) {
      _config = config;
			layout();
      draw();
    }
    
    public function get teamName():String {
      return nameInput.value;
    }
    public function get font():String {
      return FONTS[_style];
    }
    
    private function draw():void {
      fontText.text = FONTS[_style];
    }
    private function dispatchChangeEvent():void {
      var event:Event = new Event(Event.CHANGE);
      dispatchEvent(event);
    }
    private function layout():void {
      // 输入队服号码
      var init:Object = {
        width: 200,
        height: 45,
        maxLength: 10,
        text: _config.teamname,
        textFormat: Typography.getTextFormat(Typography.LEAD, { align: TextFormatAlign.CENTER } )
      }
      nameInput = new Input(init);
      nameInput.addEventListener(Event.CHANGE, nameInput_changeHandler);
      addChild(nameInput);
      
      // 选择号码样式
      prevButton = new Button('<');
      prevButton.y = 60;
      prevButton.addEventListener(MouseEvent.CLICK, prevButton_clickHandler);
      addChild(prevButton);
      nextButton = new Button('>');
      nextButton.x = 200 - nextButton.width;
      nextButton.y = 60;
      nextButton.addEventListener(MouseEvent.CLICK, nextButton_clickHandler);
      addChild(nextButton);
      fontText = new TextField();
      fontText.defaultTextFormat = Typography.getTextFormat(Typography.LEAD, {align: TextFormatAlign.CENTER, color: 0xFFFFFF});
      fontText.x = prevButton.width + 10;
      fontText.y = 60;
      fontText.width = nextButton.x - 10 - fontText.x;
      fontText.height = 40;
      addChild(fontText);
    }
    
    private function nameInput_changeHandler(e:Event):void {
      draw();
      dispatchChangeEvent();
    }
    private function prevButton_clickHandler(e:MouseEvent):void {
      _style = _style === 0 ? FONTS.length - 1 : (_style - 1);
      draw();
      dispatchChangeEvent();
    }
    private function nextButton_clickHandler(e:MouseEvent):void {
      _style++;
      _style = _style > FONTS.length - 1 ? 0 : _style;
      draw();
      dispatchChangeEvent();
    }
    
  }

}