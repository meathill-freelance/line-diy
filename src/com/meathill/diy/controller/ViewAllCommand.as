/**
 * Created by 路佳 on 2014/10/26.
 */
package com.meathill.diy.controller {
import com.meathill.diy.model.ClothModel;
import com.meathill.diy.view.Preview;

import robotlegs.bender.extensions.commandCenter.api.ICommand;
import robotlegs.bender.extensions.contextView.ContextView;

public class ViewAllCommand implements ICommand {
  [Inject]
  public var contextView:ContextView;

  [Inject]
  public var cloth:ClothModel;

  private var preview:Preview;

  public function execute():void {
    contextView.view.removeChildAt(0);

    for (var i:uint = 0; i < 3; i++) {
      cloth.template = i;
      preview = new Preview();
      preview.x = 400 * i + 200;
      preview.y = 260;
      preview.mouseChildren = preview.mouseEnabled = false;
      contextView.view.addChild(preview);
    }

  }
}
}
