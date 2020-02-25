class edu.cmu.hcii.ctat.CTATGraphicalComponent extends edu.cmu.hcii.ctat.CTATComponentBase
{
   static var symbolName = "CTATGraphicalComponent";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATGraphicalComponent);
   var className = "CTATGraphicalComponent";
   var ParentClassName = "CTATComponentBase";
   var depth = 1001;
   var target = null;
   static var GRAY = 10066329;
   static var L_GRAY = 16316664;
   static var SGILIGHTGRAY = 11184810;
   static var GREEN = 65280;
   static var BLACK = 0;
   static var RED = 16711680;
   static var YELLOW = 16776960;
   static var WHITE = 16777215;
   static var BLUE = 255;
   var sgOutterBorderColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.GRAY;
   var sgBackgroundColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.L_GRAY;
   var sgHighlightColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.YELLOW;
   var sgFontDefaultColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.BLACK;
   var sgFontColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.BLACK;
   var sgCorrectColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.GREEN;
   var sgIncorrectColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.RED;
   var borderColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.GRAY;
   var backgroundColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.L_GRAY;
   var highlightColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.YELLOW;
   var fontColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.BLACK;
   var correctColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.GREEN;
   var incorrectColor = edu.cmu.hcii.ctat.CTATGraphicalComponent.RED;
   var wFixed = 0;
   var hFixed = 0;
   var dimensions = null;
   var sgBorderRoundness = 5;
   var sgFontName = "Verdana";
   var sgFontSize = 12;
   var sgFontBold = false;
   var sgFontItalic = false;
   var sgFontUnderline = false;
   var drawBase = true;
   var highlighted = false;
   var filterString = "";
   var tutoringState = "Neutral";
   var highlightGlowFilter = null;
   function CTATGraphicalComponent()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.highlightGlowFilter = new flash.filters.GlowFilter();
      this.highlightGlowFilter.alpha = 0.5;
      this.highlightGlowFilter.blurX = 5;
      this.highlightGlowFilter.blurY = 5;
      this.highlightGlowFilter.strength = 10;
      if(_global.theShell.HintColor != undefined && _global.theShell.HintColor != null)
      {
         this.highlightGlowFilter.color = _global.theShell.HintColor;
      }
      else
      {
         this.highlightGlowFilter.color = 16776960;
      }
   }
   function setVisible(a_val)
   {
      this.debug("setVisible (" + a_val + ")");
      if(a_val == true)
      {
         this._alpha = 100;
         this.dispatchEvent({type:"componentShow"});
      }
      else
      {
         this._alpha = 0;
         this.dispatchEvent({type:"componentHide"});
      }
   }
   function setDrawBase(a_val)
   {
      this.debug("setDrawBase (" + a_val + ")");
      this.drawBase = a_val;
   }
   function getDrawBase()
   {
      return this.drawBase;
   }
   function setHighlighted(a_val)
   {
      this.highlighted = a_val;
   }
   function getHighlighted()
   {
      return this.highlighted;
   }
   function updateVisuals()
   {
      this.draw();
   }
   function executeTween(a_param, a_method, a_begin, a_end, a_duration)
   {
      this.debug("executeTween (" + this._name + ")");
      var _loc2_ = new mx.transitions.Tween(this,a_param,a_method,a_begin,a_end,a_duration,true);
   }
   function executeTweenObject(a_target, a_param, a_method, a_begin, a_end, a_duration)
   {
      this.debug("executeTween (" + a_target._name + ")");
      var _loc3_ = new mx.transitions.Tween(a_target,a_param,a_method,a_begin,a_end,a_duration,true);
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.wFixed = this.width;
      this.hFixed = this.height;
      this.target = this.createEmptyMovieClip(this.createInstanceName(),this.getNextHighestDepth());
      this.graphics = new edu.cmu.hcii.ctat.CTATGraphicsTools(this.target);
      this.addEventListener("focusIn",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onFocusIn));
      this.addEventListener("focusOut",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onFocusOut));
      this.size();
      this.debug("createChildren () Done");
   }
   function draw()
   {
      super.draw();
      if(this.wFixed == 0 && this.hFixed == 0)
      {
         this.debug("Error: no component dimensions available yet");
         return undefined;
      }
      this.target.filters = [];
      if(this.graphics != null)
      {
         this.graphics.reset();
         if(this.target != null)
         {
            if(this.drawBase == true)
            {
               this.graphics.lineColor = this.borderColor;
               this.graphics.fillColor = this.backgroundColor;
               if(this.highlighted == true)
               {
                  var _loc3_ = this.target.filters;
                  _loc3_.push(this.highlightGlowFilter);
                  this.target.filters = _loc3_;
               }
               this.graphics.drawRoundedRectangleFilled(0,0,this.wFixed,this.hFixed,this.sgBorderRoundness);
            }
            else
            {
               this.debug("Component is configured to hide the base");
            }
            if(this.target.filters.length == 0 && this.filterString.length > 1)
            {
               this.parseFilters(this.filterString);
            }
         }
         else
         {
            this.debug("Error: target is null!");
         }
      }
      this.debug("Internal error: graphics object is null, can\'t reset");
      return undefined;
   }
   function getDimensions()
   {
      if(this.dimensions == null)
      {
         this.dimensions = new edu.cmu.hcii.ctat.CTATRect();
      }
      this.dimensions.top = this.x;
      this.dimensions.left = this.y;
      if(this.wFixed == 0)
      {
         this.dimensions.right = this._width;
      }
      else
      {
         this.dimensions.right = this.wFixed;
      }
      if(this.hFixed == 0)
      {
         this.dimensions.bottom = this._height;
      }
      else
      {
         this.dimensions.bottom = this.hFixed;
      }
      return this.dimensions;
   }
   function size()
   {
      super.size();
      this.wFixed = this.width;
      this.hFixed = this.height;
      this.invalidate();
   }
   function dispatchFocusIn()
   {
      this.debug("dispatchFocusIn ()");
      this.dispatchEvent({type:"textInputFocusIn",target:this});
   }
   function dispatchFocusOut()
   {
      this.debug("dispatchFocusOut ()");
      this.dispatchEvent({type:"textInputFocusOut",target:this});
   }
   function onFocusIn()
   {
      this.debug("onFocusIn (" + this._name + ")");
      if(this.getLockStatus() == true || this.getBlockStatus() == true)
      {
         this.debug("ERROR!! Can\'t process focus when locked or blocked, asking the shell for new focus!");
         _global.theShell.determineFindNewFocus(this);
         return undefined;
      }
      this.dispatchFocusIn();
      _global.theShell.manageBackgrading(this);
      _global.theShell.setLastClickedComponent(null);
   }
   function onFocusOut()
   {
      this.debug("onFocusOut (" + this._name + ")");
      this.dispatchFocusOut();
   }
   function getLockStatus()
   {
      return this.locked;
   }
   function getBlockStatus()
   {
      return this.blocked;
   }
   function parseFilters(a_filterstring)
   {
      this.debug("parseFilters (" + a_filterstring + ")");
      if(this.target == null)
      {
         return undefined;
      }
      var _loc16_ = a_filterstring.toUpperCase();
      var _loc15_ = _loc16_.split(";");
      this.debug("Found " + _loc15_.length + " filter definitions");
      var _loc8_ = 0;
      while(_loc8_ < _loc15_.length)
      {
         var _loc4_ = _loc15_[_loc8_];
         if(_loc4_.indexOf("DROPSHADOW") != -1)
         {
            var _loc10_ = _loc4_.substr(10);
            this.debug("Processing DROPSHADOW filter on parameter string: " + _loc10_ + "...");
            var _loc13_ = new pact.utils.RegExp("\\[","g");
            var _loc14_ = _loc10_.replace(_loc13_,"");
            var _loc12_ = new pact.utils.RegExp("\\]","g");
            var _loc11_ = _loc14_.replace(_loc12_,"");
            var _loc3_ = _loc11_.split(",");
            var _loc5_ = new flash.filters.DropShadowFilter();
            _loc5_.blurx = _loc3_[0];
            _loc5_.blury = _loc3_[1];
            _loc5_.alpha = _loc3_[2];
            _loc5_.quality = _loc3_[3];
            _loc5_.angle = _loc3_[4];
            _loc5_.distance = _loc3_[5];
            var _loc9_ = this.target.filters;
            _loc9_.push(_loc5_);
            this.target.filters = _loc9_;
         }
         if(_loc4_.indexOf("GLOW") != -1)
         {
            _loc10_ = _loc4_.substr(4);
            this.debug("Processing GlowFilter filter on parameter string: " + _loc10_ + "...");
            _loc13_ = new pact.utils.RegExp("\\[","g");
            _loc14_ = _loc10_.replace(_loc13_,"");
            _loc12_ = new pact.utils.RegExp("\\]","g");
            _loc11_ = _loc14_.replace(_loc12_,"");
            _loc3_ = _loc11_.split(",");
            var _loc6_ = new flash.filters.GlowFilter();
            _loc6_.alpha = _loc3_[0];
            _loc6_.blurX = _loc3_[1];
            _loc6_.blurY = _loc3_[2];
            _loc6_.color = _loc3_[3];
            _loc6_.strength = _loc3_[6];
            _loc9_ = this.target.filters;
            _loc9_.push(_loc6_);
            this.target.filters = _loc9_;
         }
         if(_loc4_.indexOf("BLUR") != -1)
         {
            _loc10_ = _loc4_.substr(4);
            this.debug("Processing BlurFilter filter on parameter string: " + _loc10_ + "...");
            _loc13_ = new pact.utils.RegExp("\\[","g");
            _loc14_ = _loc10_.replace(_loc13_,"");
            _loc12_ = new pact.utils.RegExp("\\]","g");
            _loc11_ = _loc14_.replace(_loc12_,"");
            _loc3_ = _loc11_.split(",");
            var _loc7_ = new flash.filters.BlurFilter();
            _loc7_.blurX = _loc3_[0];
            _loc7_.blurY = _loc3_[1];
            _loc7_.quality = _loc3_[2];
            _loc9_ = this.target.filters;
            _loc9_.push(_loc7_);
            this.target.filters = _loc9_;
         }
         if(_loc4_.indexOf("BEVEL") != -1)
         {
            _loc10_ = _loc4_.substr(5);
            this.debug("Processing BevelFilter filter on parameter string: " + _loc10_ + "...");
            _loc13_ = new pact.utils.RegExp("\\[","g");
            _loc14_ = _loc10_.replace(_loc13_,"");
            _loc12_ = new pact.utils.RegExp("\\]","g");
            _loc11_ = _loc14_.replace(_loc12_,"");
            _loc3_ = _loc11_.split(",");
            var _loc2_ = new flash.filters.BevelFilter();
            _loc2_.angle = _loc3_[0];
            _loc2_.blurX = _loc3_[1];
            _loc2_.blurY = _loc3_[2];
            _loc2_.distance = _loc3_[3];
            _loc2_.highlightAlpha = _loc3_[4];
            _loc2_.highlightColor = _loc3_[5];
            _loc2_.knockout = _loc3_[6];
            _loc2_.quality = _loc3_[7];
            _loc2_.shadowAlpha = _loc3_[8];
            _loc2_.shadowColor = _loc3_[9];
            _loc2_.strength = _loc3_[10];
            _loc2_.type = _loc3_[11];
            _loc9_ = this.target.filters;
            _loc9_.push(_loc2_);
            this.target.filters = _loc9_;
         }
         _loc8_ = _loc8_ + 1;
      }
   }
}
