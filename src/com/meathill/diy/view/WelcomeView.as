package com.meathill.diy.view 
{
  import com.meathill.diy.component.PrimaryButton;
  import com.meathill.diy.event.UserEvent;
  import flash.display.Bitmap;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
	
	/**
   * 欢迎界面
   * @author Meathill
   */
  public class WelcomeView extends Sprite 
  {
    private var startButton:PrimaryButton;
    
    public function WelcomeView(stageWidth:uint) {
			drawLabel(stageWidth);
      
      addEventListener(MouseEvent.CLICK, clickHandler);
    }
    
    public function show(welcome:Array, assets:Vector.<Bitmap>):void {
      for (var i:uint = 0, len:uint = welcome.length; i < len; i++) {
        var mc:WelcomeItemView = new WelcomeItemView(assets[i], welcome[i].name);
        mc.x = 100 + WelcomeItemView.GAP * i;
        mc.y = 120;
        mc.enable = i === 0;
        mc.fadeInUp(i);
        addChild(mc);
      }
    }
    
    private function drawButton(stageWidth:uint):void {
      startButton = new PrimaryButton('开始DIY', '', 300, 50);
      startButton.x = stageWidth - 300 >> 1;
      startButton.y = 600;
      addChild(startButton);
      startButton.addEventListener(MouseEvent.CLICK, startButton_clickHandler);
    }
    private function drawLabel(stageWidth:uint):void {
      
    }
    
    private function startButton_clickHandler(e:MouseEvent):void {
      dispatchEvent(new UserEvent(UserEvent.START_DIY));
    }
    private function clickHandler(e:MouseEvent):void {
      
    }
  }

}