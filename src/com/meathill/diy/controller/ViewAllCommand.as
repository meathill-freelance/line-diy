/**
 * Created by 路佳 on 2014/10/26.
 */
package com.meathill.diy.controller {
import com.meathill.diy.component.Button;
import com.meathill.diy.model.ClothModel;
import com.meathill.diy.view.Preview;

import flash.display.BitmapData;

import flash.display.Sprite;

import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.printing.PrintJob;
import flash.utils.ByteArray;

import mx.graphics.codec.JPEGEncoder;
import mx.utils.Base64Encoder;

import robotlegs.bender.extensions.commandCenter.api.ICommand;
import robotlegs.bender.extensions.contextView.ContextView;

public class ViewAllCommand implements ICommand {
  [Inject]
  public var contextView:ContextView;

  [Inject]
  public var cloth:ClothModel;

  private var preview:Preview;
  private var container:Sprite;

  public function execute():void {
    contextView.view.removeChildAt(0);

    var offset:uint = 0;
    container = new Sprite();
    container.mouseChildren = container.mouseEnabled = false;
    contextView.view.addChild(container);
    for (var i:uint = 0; i < 3; i++) {
      cloth.template = i;
      preview = new Preview();
      preview.y = 260;
      container.addChild(preview);
      preview.x = offset + (preview.width + 20 >> 1);
      offset += preview.width + 20;
    }

    // 生成base64的图
    if (!ExternalInterface.available) {
      return;
    }
    var encoder:JPEGEncoder = new JPEGEncoder()
      , bmpd:BitmapData = new BitmapData(container.width + 40, container.height + 40)
      , base64:Base64Encoder = new Base64Encoder();
    bmpd.draw(container);
    var data:ByteArray = encoder.encode(bmpd);
    base64.encodeBytes(data);
    ExternalInterface.call('createPic', contextView.view.loaderInfo.parameters.id, base64.toString());
  }
}
}
