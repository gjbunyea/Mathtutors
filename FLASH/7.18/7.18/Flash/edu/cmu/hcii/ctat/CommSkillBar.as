class edu.cmu.hcii.ctat.CommSkillBar extends edu.cmu.hcii.ctat.CTATStyledBase
{
   static var symbolName = "CommSkillBar";
   static var symbolOwner = edu.cmu.hcii.ctat.CommSkillBar;
   var className = "CommSkillBar";
   var ParentClassName = "CTATStyledBase";
   static var version = "2.8";
   var publicVersion = "2.8";
   var depth = 1001;
   var skillset = null;
   var sgSkillBarBorderColor = 13421772;
   var sgSkillBarColor = 5579298;
   var sgSkillBarThresholdColor = 6736947;
   var marginX = 6;
   var marginY = 6;
   var barDistance = 4;
   var barHeight = 15;
   var barMaxX = 150;
   var fontSize = 12;
   var fontFace = "Verdana";
   var sgThreshold = 0.95;
   var fitted = false;
   var skillgraphics = null;
   function CommSkillBar()
   {
      super();
   }
   function init()
   {
      super.init();
      this.skillset = null;
   }
   function updateVisuals()
   {
      this.draw();
   }
   function setSkillSet(a_set)
   {
      this.skillset = a_set;
      this.draw();
      this.skillwindow.invalidate();
      a_set.debugSkills();
   }
   function createChildren()
   {
      super.createChildren();
      if(this.isLivePreview() == false)
      {
         this.background._visible = false;
         this.stickler._visible = false;
      }
      this.size();
      _global.theShell.setSkillBar(this);
   }
   function testSkillSurface()
   {
      this.scroller = this.skillwindow.content;
      if(this.scroller != null && this.scroller != undefined)
      {
         if(this.fitted == false)
         {
            this.scroller.innertube._visible = false;
            this.skillgraphics = new edu.cmu.hcii.ctat.CTATGraphicsTools(this.scroller);
            this.skillwindow.swapDepths(this.getNextHighestDepth());
            if(this.isLivePreview() == false)
            {
               this.skillwindow.setStyle("borderStyle","none");
            }
            this.fitted = true;
         }
      }
   }
   function draw()
   {
      super.draw();
      if(this.wFixed == 0 || this.hFixed == 0)
      {
         return undefined;
      }
      this.testSkillSurface();
      if(this.scroller == null || this.scroller == undefined)
      {
         return undefined;
      }
      var _loc6_ = this.marginY;
      if(this.skillgraphics != null)
      {
      }
      this.skillgraphics.reset();
      if(this.isLivePreview() == false)
      {
         if(this.skillset != null)
         {
            var _loc4_ = this.skillset.getSkillSet();
            var _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               if(this.target != null)
               {
                  if(_loc4_[_loc3_].texted == false)
                  {
                     var _loc8_ = "myLabel" + _loc3_;
                     var _loc7_ = this.getNextHighestDepth();
                     _loc4_[_loc3_].textfield = this.scroller.createTextField(_loc8_,_loc7_,this.marginX + 1 + this.barMaxX + 2,_loc6_,220,25);
                     if(_loc4_[_loc3_].textfield != null)
                     {
                        _loc4_[_loc3_].textfield.autoSize = true;
                        var _loc5_ = new TextFormat();
                        _loc5_.color = 0;
                        _loc5_.font = this.fontFace;
                        _loc5_.size = this.fontSize;
                        _loc4_[_loc3_].textfield.setNewTextFormat(_loc5_);
                        _loc4_[_loc3_].texted = true;
                        if(_loc4_[_loc3_].label != null && _loc4_[_loc3_].label != undefined)
                        {
                           _loc4_[_loc3_].textfield.text = _loc4_[_loc3_].label;
                        }
                        else if(_loc4_[_loc3_].description != null && _loc4_[_loc3_].description != undefined)
                        {
                           _loc4_[_loc3_].textfield.text = _loc4_[_loc3_].description;
                        }
                        else
                        {
                           _loc4_[_loc3_].textfield.text = _loc4_[_loc3_].name;
                        }
                     }
                  }
               }
               this.skillgraphics.lineColor = this.sgSkillBarBorderColor;
               this.skillgraphics.fillColor = 16777215;
               this.skillgraphics.drawRectangle(this.marginX,_loc6_,this.barMaxX,this.barHeight);
               if(_loc4_[_loc3_].level > this.sgThreshold)
               {
                  this.skillgraphics.lineColor = this.sgSkillBarThresholdColor;
                  this.skillgraphics.fillColor = this.sgSkillBarThresholdColor;
                  this.skillgraphics.drawRectangleFilled(this.marginX + 1,_loc6_ + 1,this.calcWidth(_loc4_[_loc3_].level,this.barMaxX - 2),this.barHeight - 2);
               }
               else
               {
                  this.skillgraphics.lineColor = this.sgSkillBarColor;
                  this.skillgraphics.fillColor = this.sgSkillBarColor;
                  this.skillgraphics.drawRectangleFilled(this.marginX + 1,_loc6_ + 1,this.calcWidth(_loc4_[_loc3_].level,this.barMaxX - 2),this.barHeight - 2);
               }
               _loc6_ = _loc6_ + (this.barHeight + this.barDistance);
               _loc3_ = _loc3_ + 1;
            }
         }
      }
   }
   function size()
   {
      super.size();
      this.background._width = this.wFixed;
      this.background._height = this.hFixed;
      this.skillwindow._x = 0;
      this.skillwindow._y = 0;
      this.skillwindow._width = this.wFixed;
      this.skillwindow._height = this.hFixed;
      this.draw();
   }
   function calcWidth(prob, maxWidth)
   {
      if(prob == undefined || maxWidth == undefined)
      {
         return 0;
      }
      return maxWidth * prob;
   }
   function __set__SkillBarColor(theValue)
   {
      this.sgSkillBarColor = theValue;
      this.draw();
      return this.__get__SkillBarColor();
   }
   function __get__SkillBarColor()
   {
      return this.sgSkillBarColor;
   }
   function __set__SkillBarBorderColor(theValue)
   {
      this.sgSkillBarBorderColor = theValue;
      this.draw();
      return this.__get__SkillBarBorderColor();
   }
   function __get__SkillBarBorderColor()
   {
      return this.sgSkillBarBorderColor;
   }
   function __set__SkillBarThresholdColor(theValue)
   {
      this.sgSkillBarThresholdColor = theValue;
      this.draw();
      return this.__get__SkillBarThresholdColor();
   }
   function __get__SkillBarThresholdColor()
   {
      return this.sgSkillBarThresholdColor;
   }
   function __set__Threshold(theValue)
   {
      this.sgThreshold = theValue;
      this.draw();
      return this.__get__Threshold();
   }
   function __get__Threshold()
   {
      return this.sgThreshold;
   }
   function __set__FontSize(theValue)
   {
      this.fontSize = theValue;
      return this.__get__FontSize();
   }
   function __get__FontSize()
   {
      return this.fontSize;
   }
   function __set__Font(theValue)
   {
      this.fontFace = theValue;
      return this.__get__Font();
   }
   function __get__Font()
   {
      return this.fontFace;
   }
}
