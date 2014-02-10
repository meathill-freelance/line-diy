package com.meathill.diy.view 
{
  import com.meathill.diy.component.PrimaryButton;
  import com.meathill.diy.event.UserEvent;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
	
	/**
   * 欢迎界面
   * @author Meathill
   */
  public class WelcomeView extends Sprite 
  {
    private var startButton:PrimaryButton;
    
    public function WelcomeView() 
    {
      super();
			draw();
    }
    
    private function draw():void {
      startButton = new PrimaryButton('开始DIY');
      startButton.x = 100;
      startButton.y = 100;
      addChild(startButton);
      startButton.addEventListener(MouseEvent.CLICK, startButton_clickHandler);
    }
    
    private function startButton_clickHandler(e:MouseEvent):void 
    {
      dispatchEvent(new UserEvent(UserEvent.START_DIY));
    }
  }

}