package com.meathill.diy.component.options 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.options.ColorCard;
  import com.meathill.diy.component.options.ColorCardItem;
  import com.meathill.diy.component.options.SquadNumber;
  import com.meathill.diy.component.tab.Tab;
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.event.SystemEvent;
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
    private var tab:Tab;
    private var colorCard:ColorCard;
    private var config:SingleStepConfig;
    private var number:SquadNumber;
    private var teamName:TeamName;
    
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
        component.removeEventListener(Event.CHANGE, colorCard_changeHandler);
        component.removeEventListener(Event.CHANGE, colorCardForSquadNumber_changeHandler);
        component.removeEventListener(Event.CHANGE, tab_changeHandler);
        component.removeEventListener(DesignEvent.SET_SQUAD_NUMBER, dispatchEvent);
        component.removeEventListener(DesignEvent.SET_TEAM_NAME, dispatchEvent);
        component.removeEventListener(SystemEvent.SINGLE_COLOR, number_singleColorEvent);
        component.removeEventListener(SystemEvent.DOUBLE_COLOR, number_doubleColorEvent);
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
      this.config = config;
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
          createTab(250);
          createColorCard(config, 300, colorCardForSquadNumber_changeHandler);
          break;
          
        case 'teamname':
          createTeamName(config, 50);
          createColorCard(config, 170, colorCardForTeamName_changeHandler);
          break;
      }
    }
    private function createColorCard(config:SingleStepConfig, offset:uint = 50, handler:Function = null):ColorCard {
      handler = handler || colorCard_changeHandler;
      colorCard = new ColorCard(config);
      colorCard.addEventListener(Event.CHANGE, handler);
      colorCard.y = offset;
      components.push(colorCard);
      addChild(colorCard);
      return colorCard;
    }
    private function createSquadNumber(config:SingleStepConfig, offset:uint = 50):SquadNumber {
      number = new SquadNumber(config, Sprite(AssetsManager.instance.getAsset(config.asset)));
      number.addEventListener(Event.CHANGE, number_changeHandler);
      number.addEventListener(SystemEvent.SINGLE_COLOR, number_singleColorEvent);
      number.addEventListener(SystemEvent.DOUBLE_COLOR, number_doubleColorEvent);
      number.y = offset;
      components.push(number);
      addChild(number);
      return number;
    }
    private function createTeamName(config:SingleStepConfig, offset:uint):TeamName {
      teamName = new TeamName(config);
      teamName.addEventListener(Event.CHANGE, teamName_changeHandler);
      teamName.y = offset;
      components.push(teamName);
      addChild(teamName);
      return teamName;
    }
    private function createTab(offset:uint = 50):Tab {
      tab = new Tab();
      tab.addTab('颜色1', null);
      tab.addTab('颜色2', null);
      tab.addEventListener(Event.CHANGE, tab_changeHandler);
      tab.y = offset;
      components.push(tab);
      addChild(tab);
      return tab;
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
    private function dispatchNumberChange():void {
      var event:DesignEvent = new DesignEvent(DesignEvent.SET_SQUAD_NUMBER);
      event.number = number.number;
      event.style = number.style;
      dispatchEvent(event);
    }
    private function dispatchTeamNameChange():void {
      var event:DesignEvent = new DesignEvent(DesignEvent.SET_TEAM_NAME);
      event.teamname = teamName.teamName;
      event.font = teamName.font;
      event.color = colorCard.color;
      dispatchEvent(event);
    }
    
    private function colorCard_changeHandler(e:Event):void {
      var event:DesignEvent = new DesignEvent(DesignEvent.SELECT_COLOR);
      event.color = colorCard.color;
      dispatchEvent(event);
    }
    private function colorCardForSquadNumber_changeHandler(e:Event):void {
      config[tab.value ? 'color2' : 'color'] = colorCard.color;
      number.setColor();
      
      dispatchNumberChange();
    }
    private function number_changeHandler(e:Event):void {
      dispatchNumberChange();
    }
    private function colorCardForTeamName_changeHandler():void {
      dispatchTeamNameChange();
    }
    private function teamName_changeHandler(e:Event):void {
      dispatchTeamNameChange() 
    }
    private function number_singleColorEvent(e:SystemEvent):void {
      tab.active(0);
      tab.disable(1);
    }
    private function number_doubleColorEvent(e:SystemEvent):void {
      tab.enable(1);
    }
    private function tab_changeHandler(e:Event):void {
      colorCard.color = tab.value ? config.color2 : config.color;
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