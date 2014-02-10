package com.meathill.diy.config {
  import com.meathill.diy.mediator.WelcomeMediator;
  import com.meathill.diy.view.DIYView;
  import com.meathill.diy.view.WelcomeView;
  import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
  import robotlegs.bender.framework.api.IConfig;
  import robotlegs.bender.framework.api.IInjector;
  
	/**
   * ...
   * @author Meathill
   */
  public class GUIConfig implements IConfig {
    
    [Inject]
    public var injector:IInjector;
    
    [Inject]
    public var mediatorMap:IMediatorMap;
    
    public function configure():void {
      
      mediatorMap.map(WelcomeView).toMediator(WelcomeMediator);
      
    }
    
  }

}