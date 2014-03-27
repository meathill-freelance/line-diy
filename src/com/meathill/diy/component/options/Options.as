package com.meathill.diy.component.options 
{
  import com.meathill.diy.component.ChevronButton;
  import com.meathill.diy.component.colorCard.ColorCard;
  import com.meathill.diy.component.number.SquadNumber;
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class Options extends Sprite 
  {
    public static const WIDTH:uint = 200;
    
    private var label:TextField;
    private var components:Vector.<Sprite>
    private var prevButton:ChevronButton;
    private var nextButton:ChevronButton;
    
    public function Options() {
      components = new Vector.<Sprite>();
      draw();
			createTextField();
    }
    
    public function set title(value:String):void {
      label.text = value;
    }
    
    public function clear():void {
      while (components.length) {
        removeChild(components.pop());
      }
      if (prevButton && contains(prevButton)) {
        removeChild(prevButton);
      }
      if (nextButton && contains(nextButton)) {
        removeChild(nextButton);
      }
    }
    public function show(config:SingleStepConfig):void {
      label.text = config.title;
      var all:Array = config.type.split('|');
      for (var i:uint = 0, len:uint = all.length; i < len; i++) {
        var component:Sprite = createComponent(all[i], config);
        component.y = height + 10;
        addChild(component);
        components.push(component);
      }
    }
    public function showStepButtons(hasPrev:Boolean, hasNext:Boolean):void {
      if (hasPrev) {
        if (!prevButton) {
          prevButton = new ChevronButton(false);
          prevButton.addEventListener(MouseEvent.CLICK, prevButton_clickHandler);
        }
        prevButton.x = 5;
        prevButton.y = 5;
        addChild(prevButton);
      }
      if (hasNext) {
        if (!nextButton) {
          nextButton = new ChevronButton();
          nextButton.x = WIDTH - nextButton.width - 5;
          nextButton.addEventListener(MouseEvent.CLICK, nextButton_clickHandler);
        }
        nextButton.y = 5;
        addChild(nextButton);
      }
    }
    
    private function createComponent(type:String, config:SingleStepConfig):Sprite {
      switch(type) {
        case 'color':
          return new ColorCard(config);
          break;
          
        case 'number':
          return new SquadNumber(config);
          break;
          
        default:
          return null;
      }
    }
    private function createTextField():void {
      label = new TextField();
      label.defaultTextFormat = Typography.getTextFormat(Typography.BODY, { color: 0xffffff, align: TextFormatAlign.CENTER, bold: true } );
      label.x = 30;
      label.y = 10;
      label.width = 140;
      label.height = 20;
      label.mouseEnabled = false;
      addChild(label);
    }
    private function draw():void {
      graphics.beginFill(Colors.WET_ASPHALT);
      graphics.drawRoundRect(0, 0, 200, 40, 4, 4);
      graphics.endFill();
    }
    
    private function prevButton_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.PREV_STEP);
      dispatchEvent(event);
    }
    private function nextButton_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.NEXT_STEP);
      dispatchEvent(event);
    }
  }

}