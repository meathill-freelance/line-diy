package com.meathill.diy.component.tab 
{
  import com.meathill.diy.filter.Filters;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
	
	/**
   * ...
   * @author Meathill
   */
  public class Tab extends Sprite {
    public static const LENGTH:uint = 2;
    
    private var panes:Vector.<Sprite>;
    private var toggles:Vector.<TabButton>;
    private var activePane:Sprite;
    
    public function Tab() {
      panes = new Vector.<Sprite>();
			toggles = new Vector.<TabButton>();
    }
    
    public function get value():uint {
      return getChildIndex(getChildByName('active'));
    }
    
    public function addTab(label:String, target:Sprite = null):void {
      var button:TabButton = new TabButton(label);
      button.x = toggles.length * 105;
      button.addEventListener(MouseEvent.CLICK, tabButton_clickHandler);
      addChild(button);
      
      panes.push(target);
      toggles.push(button);
      
      if (toggles.length === 1) {
        activePane = target;
        button.active();
      } else if (target) {
        target.visible = false;
      }
    }
    
    public function active(index:uint):void {
      var tabButton:TabButton = toggles[index];
      tabButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }
    public function disable(index:uint):void {
      var tabButton:TabButton = toggles[index];
      tabButton.disable();
    }
    public function enable(index:uint):void {
      var tabButton:TabButton = toggles[index];
      tabButton.enable();
    }
    
    private function tabButton_clickHandler(e:MouseEvent):void {
      if (activePane && activePane.parent) {
        activePane.parent.removeChild(activePane);
      }
      var target:TabButton = TabButton(e.currentTarget);
      var index:uint = toggles.indexOf(target);
      activePane = panes[index];
      if (activePane) {
        activePane.visible = true;
      }
      if (getChildByName('active')) {
        TabButton(getChildByName('active')).deactive();
      }
      target.active();
    }
  }
}