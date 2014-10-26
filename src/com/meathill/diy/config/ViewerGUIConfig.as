/**
 * Created by 路佳 on 2014/10/26.
 */
package com.meathill.diy.config {
import com.meathill.diy.mediator.PreviewMediator;
import com.meathill.diy.view.DIYView;
import com.meathill.diy.view.Preview;
import com.meathill.diy.view.Spinner;

import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

public class ViewerGUIConfig implements IConfig {
  [Inject]
  public var injector:IInjector;

  [Inject]
  public var contextView:ContextView;

  [Inject]
  public var mediatorMap:IMediatorMap;

  private var spinner:Spinner;

  public function configure():void {
    spinner = new Spinner();

    injector.map(Spinner).toValue(spinner);

    mediatorMap.map(Preview).toMediator(PreviewMediator);

    contextView.view.addChild(spinner);
  }
}
}
