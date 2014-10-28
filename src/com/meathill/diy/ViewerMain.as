package com.meathill.diy {
import com.meathill.diy.config.ViewerConfig;
import com.meathill.diy.config.ViewerGUIConfig;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;

import robotlegs.bender.framework.impl.Context;

/**
   * 展示工具
   * @author Meathill
   */
[SWF(width="900", height="1000")]
public class ViewerMain extends Sprite {
  private var context:Context;
    
  public function ViewerMain() {
    if (stage) {
      init();
    } else {
      addEventListener(Event.ADDED_TO_STAGE, init);
    }
  }

  private function init(event:Event = null):void {
    removeEventListener(Event.ADDED_TO_STAGE, init);
    stage.scaleMode = StageScaleMode.NO_SCALE;
    stage.align = StageAlign.TOP_LEFT;

    context = new Context();
    context.install(MVCSBundle);
    context.configure(ViewerConfig, ViewerGUIConfig);
    context.configure(new ContextView(this));
  }
    
}

}