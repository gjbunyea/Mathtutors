class edu.cmu.hcii.ctat.CTATWindowingComponent extends edu.cmu.hcii.ctat.CTATGraphicalComponent
{
   static var symbolName = "CTATWindowingComponent";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATWindowingComponent);
   var className = "CTATWindowingComponent";
   var ParentClassName = "CTATGraphicalComponent";
   var winGraphics = null;
   var winHolder = null;
   var winWidth = 200;
   var winHeight = 200;
   var windowing = false;
   var windowHold = false;
   var moveX = 0;
   var moveY = 0;
   var titleLabel = null;
   function CTATWindowingComponent()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
   }
   function draw()
   {
      super.draw();
   }
   function size()
   {
      super.size();
   }
   function windowMouseDown(a_x, a_y)
   {
      this.debug("windowMousedown ()");
      if(a_x > 2 && a_y > 2 && a_x < this.winWidth - 4 && a_y < 20)
      {
         this.debug("Title grabbed!");
         this.windowHold = true;
         this.moveX = a_x;
         this.moveY = a_y;
      }
   }
   function windowMouseUp(a_x, a_y)
   {
      this.debug("windowMouseUp ()");
      this.windowHold = false;
   }
   function windowMouseMove(a_x, a_y)
   {
      this.debug("windowMouseMove ()");
      if(this.windowHold == true)
      {
         var _loc5_ = this.winHolder._x;
         var _loc4_ = this.winHolder._y;
         var _loc2_ = this.moveX - a_x;
         var _loc3_ = this.moveY - a_y;
         this.winHolder._x = _loc5_ + _loc2_;
         this.winHolder._y = _loc4_ + _loc3_;
      }
   }
   function showWindow(a_title)
   {
      this.debug("showWindow ()");
      this.winHolder = this.createEmptyMovieClip(this.createInstanceName(),this.getNextHighestDepth());
      this.winGraphics = new edu.cmu.hcii.ctat.CTATGraphicsTools(this.winHolder);
      this.winHolder._x = this.__get__width() / 2 - this.winWidth / 2;
      this.winHolder._y = this.__get__height() / 2 - this.winHeight / 2;
      this.winHolder._visible = true;
      var _loc2_ = new flash.filters.DropShadowFilter();
      _loc2_.blurx = 5;
      _loc2_.blury = 5;
      _loc2_.alpha = 0.45;
      _loc2_.quality = 3;
      _loc2_.angle = 45;
      _loc2_.distance = 5;
      var _loc3_ = this.winHolder.filters;
      _loc3_.push(_loc2_);
      this.winHolder.filters = _loc3_;
      this.winGraphics.drawRoundedRectangleFilled(0,0,this.winWidth,this.winHeight,5);
      this.winGraphics.drawRoundedRectangleFilled(2,2,this.winWidth - 4,20,5);
      this.titleLabel = this.winHolder.createTextField("titleLabel",this.getNextHighestDepth(),2,2,this.winWidth - 4,20);
      if(this.titleLabel != null)
      {
         this.titleLabel.autoSize = false;
         this.titleLabel.text = a_title;
         this.titleLabel.align = "center";
         this.titleLabel.selectable = true;
         this.titleLabel._visible = true;
      }
      else
      {
         this.debug("Error: unable to create title label");
      }
      return this.winHolder;
   }
   function hideWindow()
   {
      this.debug("hideWindow ()");
      this.winGraphics = null;
      this.winHolder.unloadMovie();
      this.winHolder = null;
   }
   function windowToGlobal(aPoint)
   {
      var _loc5_ = aPoint.x + this.winHolder._x;
      var _loc4_ = aPoint.y + this.winHolder._y;
      var _loc2_ = {x:_loc5_,y:_loc4_};
      this.localToGlobal(_loc2_);
      aPoint.x = _loc2_.x;
      aPoint.y = _loc2_.y;
   }
}
