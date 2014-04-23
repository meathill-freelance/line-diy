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
			draw(stageWidth);
    }
    
    public function show(welcome:Vector.<Bitmap>):void {
      var names:Array = ['篮球', '足球', '高尔夫'];
      for (var i:uint = 0, len:uint = welcome.length; i < len; i++) {
        var mc:WelcomeItemView = new WelcomeItemView(welcome[i], names[i]);
        mc.x = 100 + WelcomeItemView.GAP * i;
        mc.y = 120;
        mc.enable = i === 0;
        mc.selected = i === 0;
        mc.fadeInUp(i);
        addChild(mc);
      }
    }
    
    private function draw(stageWidth:uint):void {
      startButton = new PrimaryButton('开始DIY', '', 300, 50);
      startButton.x = stageWidth - 300 >> 1;
      startButton.y = 600;
      addChild(startButton);
      startButton.addEventListener(MouseEvent.CLICK, startButton_clickHandler);
    }
    
    private function startButton_clickHandler(e:MouseEvent):void 
    {
      dispatchEvent(new UserEvent(UserEvent.START_DIY));
    }
  }

}