package com.meathill.diy.component.options 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.options.ColorCard;
  import com.meathill.diy.component.options.ColorCardItem;
  import com.meathill.diy.component.options.SquadNumber;
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import com.meathill.diy.service.AssetsManager;
  import flash.display.Sprite;
  import flash.events.Event;
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
    private var prevButton:Button;
    private var nextButton:Button;
    
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
        var component:Sprite = components.pop();
        component.removeEventListener(MouseEvent.CLICK, colorCard_clickHandler);
        component.removeEventListener(DesignEvent.SET_SQUAD_NUMBER, dispatchEvent);
        removeChild(component);
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
        createComponent(all[i], config);
      }
    }
    public function showStepButtons(hasPrev:Boolean, hasNext:Boolean):void {
      if (hasPrev) {
        if (!prevButton) {
          prevButton = new Button('上一步', 'chevronLeft');
          prevButton.addEventListener(MouseEvent.CLICK, prevButton_clickHandler);
        }
        prevButton.x = 5;
        prevButton.y = height + 20;
        addChild(prevButton);
      }
      if (hasNext) {
        if (!nextButton) {
          nextButton = new Button('下一步', 'chevronRight', Button.ICON_RIGHT);
          nextButton.x = WIDTH - nextButton.width - 5;
          nextButton.addEventListener(MouseEvent.CLICK, nextButton_clickHandler);
        }
        nextButton.y = prevButton ? prevButton.y : height + 20;
        addChild(nextButton);
      }
    }
    
    private function createComponent(type:String, config:SingleStepConfig):void {
      switch(type) {
        case 'color':
          createColorCard(config, 50);
          break;
          
        case 'number':
          createSquadNumber(config, 50);
          createColorCard(config, 250, colorCardForSquadNumber_clickHandler);
          break;
      }
    }
    private function createColorCard(config:SingleStepConfig, offset:uint = 50, handler:Function = null):ColorCard {
      handler = handler || colorCard_clickHandler;
      var colorCard:ColorCard = new ColorCard(config);
      colorCard.addEventListener(MouseEvent.CLICK, handler);
      colorCard.y = offset;
      components.push(colorCard);
      addChild(colorCard);
      return colorCard;
    }
    private function createSquadNumber(config:SingleStepConfig, offset:uint = 50):SquadNumber {
      var number:SquadNumber = new SquadNumber(config, Sprite(AssetsManager.instance.getAsset(config.asset)));
      number.addEventListener(Event.CHANGE, number_changeHandler);
      number.addEventListener(DesignEvent.DOUBLE_COLOR, number_doubleColorEvent);
      number.y = 50;
      components.push(number);
      addChild(number);
      return number;
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
    
    
    private function colorCard_clickHandler(e:MouseEvent):void {
      var colorCard:ColorCard = ColorCard(e.currentTarget)
        , curr:ColorCardItem = ColorCardItem(colorCard.getChildByName('active'));
      if (curr) {
        curr.deactive();
      }
      var item:ColorCardItem = ColorCardItem(e.target);
      item.active();
      var event:DesignEvent = new DesignEvent(DesignEvent.SELECT_COLOR);
      event.color = item.color;
      dispatchEvent(event);
    }
    private function colorCardForSquadNumber_clickHandler(event:MouseEvent):void {
      var number:SquadNumber = SquadNumber(components[0]);
      var colorCard:ColorCard = ColorCard(event.currentTarget);
      var item:ColorCardItem = ColorCardItem(event.target);
      var curr:ColorCardItem = ColorCardItem(colorCard.getChildByName('active'));
      if (curr) {
        curr.deactive();
      }
      item.active();
      number.setColor(item.color);
    }
    private function number_changeHandler(e:Event):void {
      var number:SquadNumber = SquadNumber(e.currentTarget);
      var event:DesignEvent = new DesignEvent(DesignEvent.SET_SQUAD_NUMBER);
      event.number = number.number;
      event.style = number.style;
      dispatchEvent(event);
    }
    private function number_doubleColorEvent(e:DesignEvent):void {
      
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