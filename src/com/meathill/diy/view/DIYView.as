package com.meathill.diy.view 
{
  import com.meathill.diy.component.options.Options;
  import com.meathill.diy.component.wizard.Wizard;
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
	
	/**
   * ...
   * @author Meathill
   */
  public class DIYView extends Sprite 
  {
    private var wizard:Wizard;
    private var preview:Preview;
    private var options:Options;
    
    public function DIYView() {
      super();
			layout();
    }
    
    public function showOperation(config:SingleStepConfig):void {
      options.title = config.title;
      options.show(config.type, config);
    }
    
    private function layout():void {
      wizard = new Wizard();
      wizard.x = wizard.y = 10;
      addChild(wizard);
      
      options = new Options();
      options.x = 10;
      options.y = 60;
      addChild(options);
    }
    
  }

}