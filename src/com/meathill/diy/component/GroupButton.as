package com.meathill.diy.component 
{
  import com.meathill.diy.filter.Filters;
  import flash.events.Event;
  import flash.events.MouseEvent;
	/**
   * ...
   * @author Meathill
   */
  public class GroupButton extends Button {
    public static const FIRST:uint = 0;
    public static const MIDDLE:uint = 1;
    public static const LAST:uint = 2;
    
    public static var groups:Object = { };
    
    private var index:uint;
    
    private var _value:Object;
    public function get value():Object {
      return _value;
    }
    public function set value(value:Object):void {
      _value = value;
    }
    
    private var _group:String;
    public function get group():String {
      return _group;
    }
    
    public function GroupButton(label:String = 'button', icon:String = '', iconPos:uint = 1, index:uint = 0, group:String = 'key') {
      _group = group;
      this.index = index;
      super(label, icon, iconPos);
      groups[_group] = groups[_group] || new Vector.<GroupButton>();
      groups[_group].push(this);
      
      addEventListener(MouseEvent.CLICK, clickHandler);
      addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
    }
    
    
    public function active():void {
      for (var i:uint = 0, len:uint = groups[_group].length; i < len; i++) {
        groups[_group][i].deactive();
      }
      filters = [Filters.DOWN_SHADOW];
      draw(hoverBgColor, hoverBorderColor, buttonWidth, buttonHeight, hoverBgAlpha, hasHoverBorder);
      removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
    }
    public function deactive():void {
      filters = null;
      draw(bgColor, borderColor, buttonWidth, buttonHeight, bgAlpha, hasBorder);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
    }
    
    override protected function draw(bg:uint, border:uint, width:uint, height:uint, bgAlpha:Number = 1, hasBorder:Boolean = true):void {
      graphics.clear();
      graphics.beginFill(bg, bgAlpha);
      if (hasBorder) {
        graphics.lineStyle(0, border);
      }
      
      if (index === FIRST) {
        graphics.drawRoundRectComplex(0.5, 0.5, width, height, 6, 0, 6, 0);
      } else if (index === LAST) {
        graphics.drawRoundRectComplex(0.5, 0.5, width, height, 0, 6, 0, 6);
      } else {
        graphics.drawRect(0.5, 0.5, width, height);
      }
      graphics.endFill();
    }
    
    
    private function clickHandler(e:MouseEvent):void {
      active();
    }
    private function removedHandler(e:Event):void {
      removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
      for (var i:uint = 0, len:uint = groups[_group].length; i < len; i++) {
        if (groups[_group][i] === this) {
          groups[_group].splice(i, 1);
          break;
        }
      }
    }
  }

}