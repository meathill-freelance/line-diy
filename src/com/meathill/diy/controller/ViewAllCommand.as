/**
 * Created by 路佳 on 2014/10/26.
 */
package com.meathill.diy.controller {
import com.meathill.diy.component.Button;
import com.meathill.diy.model.ClothModel;
import com.meathill.diy.view.Preview;

import flash.display.Sprite;

import flash.events.MouseEvent;
import flash.printing.PrintJob;

import robotlegs.bender.extensions.commandCenter.api.ICommand;
import robotlegs.bender.extensions.contextView.ContextView;

public class ViewAllCommand implements ICommand {
  [Inject]
  public var contextView:ContextView;

  [Inject]
  public var cloth:ClothModel;

  private var preview:Preview;
  private var printButton:Button;
  private var container:Sprite;

  public function execute():void {
    contextView.view.removeChildAt(0);

    var stageWidth:uint = contextView.view.stage.stageWidth
      , itemWidth:uint = stageWidth / 3;
    container = new Sprite();
    container.mouseChildren = container.mouseEnabled = false;
    contextView.view.addChild(container);
    for (var i:uint = 0; i < 3; i++) {
      cloth.template = i;
      preview = new Preview();
      preview.x = itemWidth * i + (itemWidth >> 1);
      preview.y = 260;
      container.addChild(preview);
    }

    printButton = new Button('打印');
    printButton.x = stageWidth - 20 - printButton.width;
    printButton.y = 20;
    printButton.addEventListener(MouseEvent.CLICK, printButton_clickHandler);
    contextView.view.addChild(printButton);
  }

  private function printButton_clickHandler(event:MouseEvent):void {
    var job:PrintJob = new PrintJob();

    if (job.start()) {
      try {
        job.addPage(container);
      } catch (e) {
        trace(e);
      }
      job.send();
    }
  }
}
}
