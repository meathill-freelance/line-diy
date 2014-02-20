package com.meathill.diy.config {
  import com.meathill.diy.component.bottom.BottomButtonGroup;
  import com.meathill.diy.component.bottom.BottomButtonGroupMediator;
  import com.meathill.diy.component.colorCard.ColorCard;
  import com.meathill.diy.component.colorCard.ColorCardMediator;
  import com.meathill.diy.component.footer.Footer;
  import com.meathill.diy.component.footer.FooterMediator;
  import com.meathill.diy.component.options.Options;
  import com.meathill.diy.component.options.OptionsMediator;
  import com.meathill.diy.component.rightBar.RightBar;
  import com.meathill.diy.component.rightBar.RightBarMediator;
  import com.meathill.diy.component.wizard.Wizard;
  import com.meathill.diy.component.wizard.WizardMediator;
  import com.meathill.diy.mediator.PreviewMediator;
  import com.meathill.diy.mediator.WelcomeMediator;
  import com.meathill.diy.view.DIYView;
  import com.meathill.diy.view.Preview;
  import com.meathill.diy.view.Spinner;
  import com.meathill.diy.view.WelcomeView;
  import robotlegs.bender.extensions.contextView.ContextView;
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
    
    [Inject]
    public var contextView:ContextView;
    
    public function configure():void {
      mediatorMap.map(WelcomeView).toMediator(WelcomeMediator);
      mediatorMap.map(Wizard).toMediator(WizardMediator);
      mediatorMap.map(Options).toMediator(OptionsMediator);
      mediatorMap.map(Preview).toMediator(PreviewMediator);
      mediatorMap.map(ColorCard).toMediator(ColorCardMediator);
      mediatorMap.map(BottomButtonGroup).toMediator(BottomButtonGroupMediator);
      mediatorMap.map(RightBar).toMediator(RightBarMediator);
      mediatorMap.map(Footer).toMediator(FooterMediator);
      
      contextView.view.addChild(new Spinner());
    }
    
  }

}