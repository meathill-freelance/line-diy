package com.meathill.diy.view 
{
  import com.meathill.diy.component.bottom.BottomButtonGroup;
  import com.meathill.diy.component.footer.Footer;
  import com.meathill.diy.component.options.Options;
  import com.meathill.diy.component.rightBar.RightBar;
  import com.meathill.diy.component.wizard.Wizard;
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
  import flash.events.Event;
	
	/**
   * ...
   * @author Meathill
   */
  public class DIYView extends Sprite 
  {
    private var wizard:Wizard;
    private var preview:Preview;
    private var options:Options;
    private var bottom:BottomButtonGroup;
    private var rightBar:RightBar;
    private var footer:Footer;
    
    public function DIYView() {
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }
    
    private function layout():void {
      wizard = new Wizard();
      wizard.x = wizard.y = 10;
      addChild(wizard);
      
      options = new Options();
      options.x = 10;
      options.y = 60;
      addChild(options);
      
      preview = new Preview();
      preview.x = 240
      preview.y = 60;
      addChild(preview);
      
      bottom = new BottomButtonGroup();
      bottom.x = 600;
      bottom.y = 500;
      addChild(bottom);
      
      rightBar = new RightBar();
      rightBar.x = stage.stageWidth - 80;
      rightBar.y = 80;
      addChild(rightBar);
      
      footer = new Footer(stage.stageWidth);
      footer.y = stage.stageHeight - Footer.HEIGHT;
      addChild(footer);
    }
    
    
    private function addedHandler(e:Event):void {
      removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
      layout();
    }
  }

}