package com.meathill.diy.view 
{
  import com.greensock.TweenMax;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class Preview extends Sprite {
    private const THRESHOLD:uint = 0;
    
    private var loader:Loader;
    private var cloth:Sprite;
    private var cloth1:Sprite;
    private var cloth2:Sprite;
    private var seperator:uint;
    private var _y:int;
    
    private var _isReady:Boolean;
    public function set isReady(value:Boolean):void {
      _isReady = value;
    }
    
    public function Preview() {
      buttonMode = useHandCursor = true;
      
      addEventListener(Event.ADDED_TO_STAGE, addedHandler);
      addEventListener(MouseEvent.CLICK, clickHanaler);
      //addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
    }
    
    public function show(mc:Sprite, mc2:Sprite = null, seperator:uint = 0):void {
      this.seperator = this.seperator || seperator;
      while (numChildren > 0) {
        removeChildAt(0);
      }
      cloth1 = mc;
      Scaler.resize(cloth1, 500, 500);
      cloth1.x = - cloth1.width >> 1;
      cloth1.y = - cloth1.height >> 1;
      addChild(cloth1);
      
      if (mc2) {
        cloth2 = mc2;
        Scaler.resize(cloth2, 400, 400);
        cloth2.x = -cloth2.width >> 1;
        cloth2.y = cloth1. y + 500;
        addChild(cloth2);
      }
    }
    public function setColor(color:uint, step:uint):void {
      step = checkStep(step);
      cloth.getChildAt(step).filters = [Filters.getColorFilter(color)];
    }
    public function setNumber(number:uint, style:uint, step:uint, asset:Sprite):void {
      step = checkStep(step);
      var piece:Sprite = Sprite(cloth.getChildAt(step));
      var numberAsset:Sprite = Sprite(asset.getChildAt(style));
      while (piece.numChildren > 1) {
        piece.removeChildAt(1);
      }
      var width:uint = piece.getChildAt(0).width;
      var height:uint = piece.getChildAt(0).height;
      piece.getChildAt(0).visible = false;
      var str:String = number.toString();
      var length:uint = str.length;
      var gap:uint = 10;
      var singleWidth:uint = (width - gap * (length - 1)) / length;
      for (var i:uint = 0; i < length; i++) {
        var index:uint = parseInt(str.charAt(i));
        index = index === 0 ? 10 : index;
        var mc:DisplayObject = numberAsset.getChildAt(index - 1);
        var size:Object = Scaler.getSize(mc, singleWidth, height);
        var bmpd:BitmapData = new BitmapData(size.width, size.height, true, 0);
        bmpd.draw(mc, new Matrix(size.width / mc.width, 0, 0, size.height/ mc.height), null, null, null, true);
        var bmp:Bitmap = new Bitmap(bmpd, "auto", true);
        bmp.x = (singleWidth - size.width >> 1) + i * (singleWidth + 10);
        bmp.y = height - size.height >> 1;
        piece.addChild(bmp);
      }
    }
    
    public function setTeamName(teamname:String, font:String, color:uint, step:uint):void {
      step = checkStep(step);
      var piece:Sprite = Sprite(cloth.getChildAt(step));
      piece.getChildAt(0).visible = false;
      if (piece.numChildren > 1) {
        piece.removeChildAt(1);
      }
      var tf:TextField = new TextField();
      tf.defaultTextFormat = Typography.getTextFormat(Typography.LEAD, { font: font, color: color, align: TextFormatAlign.CENTER, size: piece.getChildAt(0).height - 6, leading: 0, bold: true} );
      tf.width = piece.getChildAt(0).width;
      tf.height = piece.getChildAt(0).height;
      tf.mouseEnabled = false;
      tf.text = teamname;
      var bmpd:BitmapData = new BitmapData(piece.getChildAt(0).width, piece.getChildAt(0).height, true, 0);
      bmpd.draw(tf);
      var bmp:Bitmap = new Bitmap(bmpd, "auto", true);
      piece.addChild(bmp);
    }
    public function highlight(step:uint):void {
      step = checkStep(step);
      var tween:TweenMax = TweenMax.to(cloth.getChildAt(step), 0.3, {
        glowFilter: {
          color: 0xFFFFFF,
          alpha: 0.8,
          blurX: 16,
          blurY: 16,
          strength: 2,
          quality: 2
        },
        onComplete: function ():void {
          tween.reverse();
        }
      });
    }
    public function scrollToPart(part:uint):void {
      if (part >= numChildren) {
        return;
      }
      scrollTo(getChildAt(part));
    }
    
    private function checkStep(step:uint):uint {
      cloth = step > seperator ? cloth2 : cloth1;
      step = step > seperator ? step - seperator - 1 : step;
      scrollTo(cloth);
      return step;
    }
    private function findRealMc(parent:Sprite, mc:Sprite, stageX:Number, stageY:Number):Sprite {
      for (var i:uint = 0, len:uint = parent.numChildren; i < len; i ++) {
        var layer:Sprite = Sprite(parent.getChildAt(i));
        if (isRealClick(layer, stageX, stageY)) {
          return layer;
        }
      }
      return null;
    }
    private function isRealClick(mc:Sprite, stageX:Number, stageY:Number):Boolean {
      var point:Point = mc.globalToLocal(new Point(stageX, stageY));
      for (var i:uint = 0, len:uint = mc.numChildren; i < len; i++) {
        var layer:DisplayObject = mc.getChildAt(i);
        if (layer.visible) {
          var bmpd:BitmapData;
          if (layer is Bitmap) {
            bmpd = Bitmap(layer).bitmapData;
          } else {
            bmpd = new BitmapData(layer.width, layer.height, true, 0);
            bmpd.draw(layer);
          }
          if (bmpd.getPixel32(point.x - layer.x, point.y - layer.y) >>> 24 > THRESHOLD) {
            return true;
          }
        }
      }
      return false;
    }
    private function scrollTo(cloth:DisplayObject):void {
      if (_isReady) {
        TweenMax.to(this, 0.3, { y: cloth === cloth1 ? _y : _y - 400 } ); 
      }
    }
    
    private function addedHandler(e:Event):void {
      removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
      _y = y;
    }
    private function clickHanaler(e:MouseEvent):void {
      var mc:Sprite = Sprite(e.target);
      var parent:Sprite = Sprite(mc.parent);
      // 因为使用了位图，所以可能点击的图层判断不准，所以需要逐层判断下
      if (!isRealClick(mc, e.stageX, e.stageY)) {
        mc = findRealMc(parent, mc, e.stageX, e.stageY);
      }
      if (!mc) {
        return;
      }
      var index:uint = parent.getChildIndex(mc);
      var event:UserEvent = new UserEvent(UserEvent.GO_TO_STEP);
      if (parent === cloth2) {
        index += cloth1.numChildren;
      }
      event.step = index;
      dispatchEvent(event);
    }
    private function mouseDownHandler(e:MouseEvent):void {
      startDrag(false);
      stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }
    private function mouseUpHandler(e:MouseEvent):void {
      stopDrag();
      stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }
    
  }

}