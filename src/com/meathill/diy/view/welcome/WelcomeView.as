package com.meathill.diy.view.welcome 
{
  import adobe.utils.CustomActions;
  import com.meathill.diy.component.PrimaryButton;
  import com.meathill.diy.event.UserEvent;
  import flash.display.Bitmap;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
	
	/**
   * 欢迎界面
   * @author Meathill
   */
  public class WelcomeView extends Sprite {
    
    private var startButton:PrimaryButton;
    private var panes:Vector.<WelcomePane>;
    private var w:uint;
    private var h:uint;
    private var selectedItem:WelcomeItem;
    
    
    public function WelcomeView() {
      panes = new Vector.<WelcomePane>();
      w = WelcomeItem.WIDTH * 3 + WelcomeItem.GAP * 2;
      h = (WelcomeItem.HEIGHT + WelcomeItem.GAP << 1) + 100;
      
      drawButton();
      
      addEventListener(Event.ADDED_TO_STAGE, addedHandler);
      addEventListener(MouseEvent.CLICK, clickHandler);
    }
    
    
    public function show(welcome:Array, assets:Vector.<Bitmap>):void {
      var activePane:WelcomePane;
      var count:uint = 0;
      var hasSelected:Boolean = false;
      for (var i:uint = 0, len:uint = welcome.length; i < len; i++) {
        var tab:WelcomeTab = new WelcomeTab(welcome[i].name);
        tab.x = (WelcomeTab.WIDTH + WelcomeItem.GAP) * i;
        tab.y = h - 110;
        tab.selected = welcome[i].selected;
        addChild(tab);
        
        var pane:WelcomePane = new WelcomePane();
        pane.addEventListener(Event.CHANGE, pane_changeHandler);
        for (var j:uint = 0, jlen:uint = welcome[i].templates.length; j < jlen; j++) {
          var item:WelcomeItem = new WelcomeItem(assets[count], welcome[i].templates[j]);
          item.x = j % 3 * (WelcomeItem.WIDTH + WelcomeItem.GAP);
          item.y = (j / 3 >> 0) * (WelcomeItem.HEIGHT + WelcomeItem.GAP);
          item.enable = welcome[i].templates[j].available;
          item.id = welcome[i].templates[j].id;
          pane.addChild(item);
          count++;
        }
        pane.y = 30;
        panes.push(pane);
        if (welcome[i].selected) {
          activePane = pane;
          selectedItem = WelcomeItem(activePane.getChildAt(0));
          selectedItem.selected = true;
        }
        hasSelected = hasSelected || welcome[i].selected;
      }
      // 没有默认tab则显示第一组
      if (!hasSelected) {
        activePane = panes[0];
      }
      addChild(activePane);
      activePane.show(0);
      
      graphics.lineStyle(2, 0xFFFFFF);
      graphics.moveTo(0, h - 110);
      graphics.lineTo(w, h - 110);
    }
    
    private function drawButton():void {
      startButton = new PrimaryButton('开始DIY', '', w, 50);
      startButton.x = 0;
      startButton.y = h - 50;
      addChild(startButton);
    }
    
    private function pane_changeHandler(event:Event):void {
      selectedItem = WelcomePane(event.target).selectedItem;
    }
    private function addedHandler(e:Event):void {
      removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
      
      x = stage.stageWidth - w >> 1;
      y = stage.stageHeight - h >> 1;
    }
    private function clickHandler(e:MouseEvent):void {
      var tab:Sprite = Sprite(e.target);
      if (tab is WelcomeTab) {
        var index:uint = getChildIndex(tab) - 1;
        WelcomePane(getChildAt(numChildren - 1)).hide();
        addChild(panes[index]);
        panes[index].show(300);
        
        var curr:WelcomeTab = WelcomeTab(getChildByName('active'));
        if (curr) {
          curr.selected = false;
        }
        WelcomeTab(tab).selected = true;
        return;
      }
      if (tab is PrimaryButton) {
        PrimaryButton(tab).disable();
        PrimaryButton(tab).text = '加载所需素材，请稍候';
        
        var event:UserEvent = new UserEvent(UserEvent.SELECT_CLOTH);
        event.cloth = selectedItem.id;
        dispatchEvent(event);
      }
    }
  }

}