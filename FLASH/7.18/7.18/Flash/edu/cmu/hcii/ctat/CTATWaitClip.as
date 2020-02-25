class edu.cmu.hcii.ctat.CTATWaitClip extends edu.cmu.hcii.ctat.CTATMovieClip
{
   static var _symbolClass = edu.cmu.hcii.ctat.CTATWaitClip;
   static var _symbolPackage = "__Packages.edu.cmu.hcii.ctat.CTATWaitClip";
   var _leafSize = 4;
   var _cycleSpeed = 1000;
   var _color = 8421504;
   var _leafCount = 12;
   var _trailCount = 5;
   var _circleRadius = 10;
   var _startLeaf = 9;
   var _padding = 10;
   var leafNodeItr = 1;
   var initialized = false;
   function CTATWaitClip()
   {
      super();
      this.setClassType("CTATWaitClip");
      this.debug("CTATWaitClip ()");
   }
   static function create(parent, instance, depth, init)
   {
      return (edu.cmu.hcii.ctat.CTATWaitClip)edu.cmu.hcii.ctat.CTATMovieClip.createInstance(edu.cmu.hcii.ctat.CTATWaitClip._symbolClass,parent,instance,depth,init);
   }
   function internalInit(width, height)
   {
      this.debug("internalInit ()");
      if(this.initialized == true)
      {
         return undefined;
      }
      this.throbber = this.createEmptyMovieClip("throbber",this.getNextHighestDepth());
      this.throbber._x = this._circleRadius + this._padding;
      this.throbber._y = 0;
      var _loc4_ = new Date().getMilliseconds();
      var _loc3_ = undefined;
      var _loc2_ = this._startLeaf;
      while(_loc2_ < this._leafCount + this._startLeaf)
      {
         _loc3_ = _loc2_ - this._startLeaf + 1;
         this.throbber["leaf" + _loc3_] = this.throbber.createEmptyMovieClip("leaf" + _loc3_,this.throbber.getNextHighestDepth());
         this.drawLeafStub(this.throbber["leaf" + _loc3_],Math.cos(_loc2_ * (360 / this._leafCount) * 0.017444444444444446) * this._circleRadius,Math.sin(_loc2_ * (360 / this._leafCount) * 0.017444444444444446) * this._circleRadius);
         this.throbber["leaf" + _loc3_]._alpha = 25;
         _loc2_ = _loc2_ + 1;
      }
      this.initialized = true;
   }
   function updateLeaf()
   {
      if(this.leafNodeItr > this._leafCount)
      {
         this.leafNodeItr = 1;
      }
      var _loc4_ = this._trailCount <= this.leafNodeItr?this.leafNodeItr - this._trailCount:0;
      var _loc6_ = this.leafNodeItr;
      var _loc3_ = this._trailCount <= this.leafNodeItr?this._leafCount:this._leafCount - (this._trailCount - this.leafNodeItr);
      var _loc5_ = this._leafCount;
      var _loc7_ = 25;
      var _loc2_ = 1;
      while(_loc2_ <= this._leafCount)
      {
         if(_loc2_ == this.leafNodeItr)
         {
            this.throbber["leaf" + _loc2_]._alpha = 100;
         }
         else if(_loc2_ > _loc4_ && _loc2_ <= _loc6_)
         {
            this.throbber["leaf" + _loc2_]._alpha = 25 + Math.round(75 / this._trailCount) * (_loc2_ - _loc4_ - (_loc3_ - this._leafCount));
         }
         else if(_loc2_ > _loc3_ && _loc2_ <= _loc5_)
         {
            this.throbber["leaf" + _loc2_]._alpha = 25 + Math.round(75 / this._trailCount) * (_loc2_ - (this._leafCount - (_loc4_ - (_loc3_ - this._leafCount))));
         }
         else
         {
            this.throbber["leaf" + _loc2_]._alpha = 25;
         }
         _loc2_ = _loc2_ + 1;
      }
      this.leafNodeItr = this.leafNodeItr + 1;
   }
   function drawLeafStub(target, x, y)
   {
      target.lineStyle(this._leafSize,this._color,100);
      target.moveTo(x,y);
      target.lineTo(x * 1.5,y * 1.5);
   }
   function drawLeafCircle(target, x, y)
   {
      var _loc4_ = this._leafSize;
      var _loc6_ = this._leafSize;
      _loc4_ = _loc4_ / 2;
      _loc6_ = _loc6_ / 2;
      x = x + _loc4_;
      y = y + _loc6_;
      var _loc10_ = _loc4_ * 0.41421356237309515;
      var _loc8_ = _loc4_ * 0.7071067811865476;
      var _loc9_ = _loc6_ * 0.41421356237309515;
      var _loc7_ = _loc6_ * 0.7071067811865476;
      target.lineStyle(0,this._color,100);
      target.beginFill(this._color);
      target.moveTo(x + _loc4_,y);
      target.curveTo(x + _loc4_,y + _loc9_,x + _loc8_,y + _loc7_);
      target.curveTo(x + _loc10_,y + _loc6_,x,y + _loc6_);
      target.curveTo(x - _loc10_,y + _loc6_,x - _loc8_,y + _loc7_);
      target.curveTo(x - _loc4_,y + _loc9_,x - _loc4_,y);
      target.curveTo(x - _loc4_,y - _loc9_,x - _loc8_,y - _loc7_);
      target.curveTo(x - _loc10_,y - _loc6_,x,y - _loc6_);
      target.curveTo(x + _loc10_,y - _loc6_,x + _loc8_,y - _loc7_);
      target.curveTo(x + _loc4_,y - _loc9_,x + _loc4_,y);
      target.endFill();
   }
   function stop()
   {
      this.debug("stop ()");
      clearInterval(this.interval);
   }
   function play()
   {
      this.debug("play ()");
      this.interval = setInterval(com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.updateLeaf),Math.round(this._cycleSpeed / this._leafCount));
   }
   function _close()
   {
      this.debug("close ()");
      this.stop();
      this.removeMovieClip();
   }
}
