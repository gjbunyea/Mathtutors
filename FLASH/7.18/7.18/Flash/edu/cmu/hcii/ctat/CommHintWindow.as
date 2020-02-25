class edu.cmu.hcii.ctat.CommHintWindow extends edu.cmu.hcii.ctat.CTATHintWindowBase
{
   static var symbolName = "CommHintWindow";
   static var symbolOwner = edu.cmu.hcii.ctat.CommHintWindow;
   var className = "CommHintWindow";
   var ParentClassName = "CTATHintWindowBase";
   static var version = "2.9.A";
   var publicVersion = "2.9.A";
   var scrollSpeed = 3;
   var pageSpeed = 7;
   var fontSize = 12;
   var delay = 50;
   var scrolling = false;
   var hints = null;
   var hintindex = 0;
   var hintsMax = 0;
   var hintsMaxPrev = 0;
   var hintEffectiveIndex = 0;
   var animating = false;
   var animdist = 0;
   var animcount = 0;
   var sgTextBorder = false;
   var sgTextMargin = 2;
   var windowHeight = -1;
   var hintsBlocked = true;
   var scrollBlocked = false;
   var brTweenShowHint = "";
   var brTweenHideHint = "";
   var internalTimers = null;
   var bgUserFeedback = "";
   var bgUserFeedbackCorrect = false;
   function CommHintWindow()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.hints = new Array();
      this.internalTimers = new Array();
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.debug("isLivePreview: " + this.isLivePreview());
      mx.events.EventDispatcher.initialize(this);
      this.stickler._visible = false;
      if(this.isLivePreview() == false)
      {
         _global.theShell.addEventListener("FeedbackHidden",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processBlockControls));
         _global.theShell.addEventListener("FeedbackHidden",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.reset));
      }
      if(this.pageSpeed < 1)
      {
         this.pageSpeed = 1;
      }
      if(this.pageSpeed > 20)
      {
         this.pageSpeed = 20;
      }
      this.evaluateControls();
   }
   function clearAllIntervals()
   {
      this.debug("clearAllIntervals ()");
      var _loc2_ = 0;
      while(_loc2_ < this.internalTimers.length)
      {
         clearInterval(this.internalTimers[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
      this.internalTimers = new Array();
   }
   function setHintsMax(a_val)
   {
      this.debug("setHintsMax (" + a_val + ")");
      this.hintsMax = a_val;
   }
   function badComponentInit()
   {
      this.debug("badComponentInit ()");
      if(this.eventsCreated == false)
      {
         this.debug("We\'ve got valid graphical objects and events haven\'t been created yet, setting up ...");
         this.previous.addEventListener("componentOnMouseUp",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processPreviousHint));
         this.next.addEventListener("componentOnMouseUp",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processNextHint));
         this.debug("Setting up event listeners ...");
         if(this.up != null)
         {
            this.up.addEventListener("componentOnMouseDown",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onScrollUp));
            this.up.addEventListener("componentOnMouseUp",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onScrollUpStop));
         }
         else
         {
            this.debug("Error: no up button yet");
         }
         if(this.down != null)
         {
            this.down.addEventListener("componentOnMouseDown",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onScrollDown));
            this.down.addEventListener("componentOnMouseUp",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onScrollDownStop));
         }
         else
         {
            this.debug("Error: no down button yet");
         }
         this.evaluateControls();
         this.previous.setTutorComponent(false);
         this.previous.setAutoGrade(false);
         this.previous.sgAllowBlocking = false;
         this.next.setTutorComponent(false);
         this.next.setAutoGrade(false);
         this.next.sgAllowBlocking = false;
         this.up.setTutorComponent(false);
         this.up.setAutoGrade(false);
         this.up.sgAllowBlocking = false;
         this.down.setTutorComponent(false);
         this.down.setAutoGrade(false);
         this.down.sgAllowBlocking = false;
         this.eventsCreated = true;
      }
      else
      {
         this.debug("Events already created");
      }
   }
   function draw()
   {
      super.draw();
      this.debug("draw ()");
      this.testHintSurface();
   }
   function size()
   {
      super.size();
      this.debug("size ()");
   }
   function processEnableControls()
   {
      this.debug("processEnableControls ()");
      this.hintwindow._visible = true;
      this.hintsBlocked = false;
   }
   function processBlockControls()
   {
      this.debug("processBlockControls ()");
      this.hintsBlocked = true;
      this.hintwindow._visible = false;
   }
   function processPreviousHint()
   {
      this.debug("processPreviousHint ()");
      if(_global.theShell.suppressStudentFeedback == true)
      {
         this.debug("We\'re in suppressed feedback mode!");
         return undefined;
      }
      if(this.animating == true)
      {
         this.debug("We\'re animating right now");
         return undefined;
      }
      if(this.hintsBlocked == true)
      {
         this.debug("Hints are blocked right now");
         return undefined;
      }
      this.hintEffectiveIndex = this.hintEffectiveIndex - 1;
      _global.theShell.getHint("get_previous_hint_button_mc");
   }
   function processNextHint()
   {
      this.debug("processNextHint ()");
      if(_global.theShell.suppressStudentFeedback == true)
      {
         this.debug("We\'re in suppressed feedback mode!");
         return undefined;
      }
      if(this.animating == true)
      {
         this.debug("We\'re animating right now");
         return undefined;
      }
      if(this.hintsBlocked == true)
      {
         this.debug("Hints are blocked right now");
         return undefined;
      }
      if(this.hints.length == 0)
      {
         return undefined;
      }
      this.hintEffectiveIndex = this.hintEffectiveIndex + 1;
      _global.theShell.getHint("get_next_hint_button_mc");
   }
   function evaluateTweens()
   {
      this.debug("evaluateTweens ()");
      this.clearAllIntervals();
      if(this.hints.length == 0)
      {
         this.executeTween("_alpha",mx.transitions.easing.Regular.easeIn,0,100,1);
      }
   }
   function reset()
   {
      this.debug("reset ()");
      var _loc2_ = 0;
      while(_loc2_ < this.hints.length)
      {
         var _loc3_ = this.hints[_loc2_];
         _loc3_.widget.removeTextField();
         _loc2_ = _loc2_ + 1;
      }
      this.hints = new Array();
      this.hintindex = 0;
      this.hintEffectiveIndex = 0;
      this.animating = false;
      this.animdist = 0;
      this.animcount = 0;
      this.hintwindow.vPosition = 0;
      this.draw();
      this.evaluateControls();
   }
   function showFeedbackTPA(userFeedback)
   {
      this.debug("showFeedbackTPA ()");
      this.showFeedback(userFeedback,false);
   }
   function showFeedback(userFeedback, userFeedbackCorrect)
   {
      this.debug("showFeedback ()");
      var _loc3_ = new edu.cmu.hcii.ctat.CTATStringUtil();
      this.bgUserFeedback = _loc3_.replace(userFeedback,"<expression>","");
      var _loc2_ = new String();
      _loc2_ = _loc3_.replace(this.bgUserFeedback,"</expression>","");
      this.bgUserFeedback = _loc2_;
      this.bgUserFeedbackCorrect = userFeedbackCorrect;
      this.internalShowFeedback();
   }
   function internalShowFeedback()
   {
      this.debug("showFeedback ()");
      this.clearAllIntervals();
      var _loc9_ = this.bgUserFeedback;
      var _loc11_ = this.bgUserFeedbackCorrect;
      if(_global.theShell.suppressStudentFeedback == true)
      {
         this.debug("We\'re in suppressed feedback mode!");
         return undefined;
      }
      this.debug("Before: " + _loc9_);
      var _loc10_ = new edu.cmu.hcii.ctat.CTATHTMLManager();
      _loc10_.singleQuoteEscape = false;
      var _loc4_ = _loc10_.entitiesConvert(_loc9_);
      var _loc6_ = false;
      if(_loc4_.indexOf("<html") != -1 || _loc4_.indexOf("<HTML") != -1)
      {
         _loc6_ = true;
      }
      if(_loc4_.indexOf("img src") != -1)
      {
         _loc6_ = true;
      }
      if(_loc4_.indexOf("IMG SRC") != -1)
      {
         _loc6_ = true;
      }
      this.debug("After: " + _loc4_);
      this.processEnableControls();
      this.scroller = this.hintwindow.content;
      if(this.scroller == null)
      {
         this.debug("Error: no scrollpane found");
         return undefined;
      }
      if(this.windowHeight == -1)
      {
         this.windowHeight = this.hintwindow._height;
      }
      this.hintsBlocked = false;
      this.hintText = this.scroller.createTextField(this.createInstanceName(),this.getNextHighestDepth(),0,0,this.hintwindow.width - 2,this.windowHeight - 4);
      if(this.hintText != null)
      {
         var _loc7_ = this.getLastHint();
         var _loc3_ = new edu.cmu.hcii.ctat.CTATHintController();
         _loc3_.widget = this.hintText;
         this.hints.push(_loc3_);
         this.hintText.multiline = true;
         this.hintText.wordWrap = true;
         if(this.sgTextBorder == true)
         {
            this.hintText.border = true;
         }
         else
         {
            this.hintText.border = false;
         }
         this.hintText.autoSize = true;
         var _loc5_ = new TextFormat();
         _loc5_.color = 0;
         _loc5_.font = "Verdana";
         _loc5_.size = this.fontSize;
         _loc5_.bold = true;
         this.hintText.setNewTextFormat(_loc5_);
         if(_loc6_ == true)
         {
            this.hintText.html = true;
            this.hintText.htmlText = _loc4_;
         }
         else
         {
            this.hintText.text = _loc4_;
         }
         if(_loc7_ != null && _loc7_ != undefined)
         {
            var _loc8_ = _loc7_.widget._y + _loc7_.widget._height + this.sgTextMargin;
            this.debug("Adding new text at: " + _loc8_);
            this.hintText._y = _loc8_;
            _loc3_.y_scroll = _loc8_;
         }
         _loc3_.widget._width = this.hintwindow.width - 2;
         if(_loc3_.widget._height <= this.hintwindow.height - 2)
         {
            this.debug("The hint text is significantly smaller than the hint window view, adjusting to fit ...");
            this.hintText.autoSize = false;
            _loc3_.widget._height = this.windowHeight - 4;
         }
         else
         {
            _loc3_.scrollable = true;
            _loc3_.vPosA = this.hintwindow.vPosition;
            _loc3_.vPosB = _loc3_.widget._height - (this.hintwindow.height - 2);
            this.debug("Generated scroll settings: " + this.hintwindow.vPosition + ", " + _loc3_.vPosA + ", " + _loc3_.vPosB);
         }
         _loc3_.index = this.hints.length - 1;
         this.evaluateControls();
         if(this.hints.length > 1)
         {
            this.animateTo(_loc3_);
         }
      }
      else
      {
         this.debug("Unable to create hint text");
      }
   }
   function onScrollUp()
   {
      this.debug("onScrollUp ()");
      if(_global.theShell.suppressStudentFeedback == true)
      {
         this.debug("We\'re in suppressed feedback mode!");
         return undefined;
      }
      if(this.animating == true)
      {
         return undefined;
      }
      if(this.scrollBlocked == true)
      {
         return undefined;
      }
      this.scrolling = true;
      this.internalTimers.push(setInterval(this,"scrollUp",this.delay));
   }
   function onScrollDown()
   {
      this.debug("onScrollDown ()");
      if(_global.theShell.suppressStudentFeedback == true)
      {
         this.debug("We\'re in suppressed feedback mode!");
         return undefined;
      }
      if(this.animating == true)
      {
         return undefined;
      }
      if(this.scrollBlocked == true)
      {
         return undefined;
      }
      this.scrolling = true;
      this.internalTimers.push(setInterval(this,"scrollDown",this.delay));
   }
   function onScrollUpStop()
   {
      this.debug("onScrollUpStop ()");
      if(this.animating == true)
      {
         return undefined;
      }
      this.scrolling = false;
   }
   function onScrollDownStop()
   {
      this.debug("onScrollDownStop ()");
      if(this.animating == true)
      {
         return undefined;
      }
      this.scrolling = false;
   }
   function scrollUp()
   {
      this.debug("scrollUp (" + this.hintwindow.vPosition + ")");
      this.clearAllIntervals();
      if(this.scrollBlocked == true)
      {
         this.debug("Scrolling blocked, aborting ...");
         return undefined;
      }
      this.scrollBlocked = true;
      if(this.hints.length == 0)
      {
         this.debug("Just one hint, no need to scroll");
         this.clearAllIntervals();
         return undefined;
      }
      if(this.scrolling == true)
      {
         var _loc2_ = this.getLastHint();
         this.debug("Scroll status: " + this.hintwindow.vPosition + ", " + _loc2_.vPosA + ", " + _loc2_.vPosB);
         if(this.hintwindow.vPosition - this.scrollSpeed < _loc2_.vPosA)
         {
            this.debug("We\'ve reached the end of the scrollable area, stopping ...");
            this.hintwindow.vPosition = _loc2_.vPosA;
         }
         else
         {
            this.debug("We haven\'t reached the end of the scroll area, continuing ....");
            this.hintwindow.vPosition = this.hintwindow.vPosition - this.scrollSpeed;
            this.internalTimers.push(setInterval(this,"scrollUp",this.delay));
         }
      }
      this.scrollBlocked = false;
   }
   function scrollDown()
   {
      this.debug("scrollDown (" + this.hintwindow.vPosition + ")");
      this.clearAllIntervals();
      if(this.scrollBlocked == true)
      {
         this.debug("Scrolling blocked, aborting ...");
         return undefined;
      }
      this.scrollBlocked = true;
      if(this.scrolling == true)
      {
         var _loc2_ = this.getLastHint();
         this.debug("Scroll status: " + this.hintwindow.vPosition + ", " + _loc2_.vPosA + ", " + _loc2_.vPosB);
         if(this.hintwindow.vPosition + this.scrollSpeed > _loc2_.vPosA + _loc2_.vPosB)
         {
            this.debug("We\'ve reached the end of the scrollable area, stopping ...");
            this.hintwindow.vPosition = _loc2_.vPosA + _loc2_.vPosB;
            this.scrolling = false;
         }
         else
         {
            this.debug("We haven\'t reached the end of the scroll area, continuing ....");
            this.hintwindow.vPosition = this.hintwindow.vPosition + this.scrollSpeed;
            this.internalTimers.push(setInterval(this,"scrollDown",this.delay));
         }
      }
      this.scrollBlocked = false;
   }
   function animateUp()
   {
      this.debug("animateUp (" + this.hintwindow.vPosition + ")");
      this.debug("stats: " + this.animcount + ", " + this.animdist + ", " + this.pageSpeed + ", " + (this.animdist - this.pageSpeed));
      if(this.animating == true)
      {
         var _loc3_ = this.pageSpeed;
         var _loc4_ = false;
         if(this.animdist - this.pageSpeed <= 0)
         {
            _loc3_ = this.animdist;
            _loc4_ = true;
            this.debug("Off the page: " + this.animdist + "," + this.pageSpeed + "," + _loc3_);
         }
         this.hintwindow.vPosition = this.hintwindow.vPosition - _loc3_;
         this.animdist = this.animdist - _loc3_;
         if(_loc4_ == true)
         {
            var _loc2_ = this.getLastHint();
            if(_loc2_ != null)
            {
               _loc2_.vPosA = this.hintwindow.vPosition;
               _loc2_.vPosB = _loc2_.widget._height - (this.hintwindow.height - 2);
               this.debug("Adjusted generated scroll settings: " + this.hintwindow.vPosition + ", " + _loc2_.vPosA + ", " + _loc2_.vPosB);
            }
         }
         this.clearAllIntervals();
         if(_loc4_ == true)
         {
            this.animating = false;
         }
         else
         {
            this.internalTimers.push(setInterval(this,"animateUp",this.delay));
         }
      }
      else
      {
         this.clearAllIntervals();
      }
   }
   function animateDown()
   {
      this.debug("animateDown (" + this.hintwindow.vPosition + ")");
      this.debug("stats: " + this.animcount + ", " + this.animdist + ", " + this.pageSpeed);
      if(this.animating == true)
      {
         var _loc3_ = this.pageSpeed;
         var _loc4_ = false;
         if(this.animcount + this.pageSpeed >= this.animdist)
         {
            _loc3_ = this.animdist - this.animcount;
            _loc4_ = true;
            this.debug("Off the page: " + this.animdist + "," + this.pageSpeed + "," + _loc3_ + "," + this.animcount);
         }
         this.hintwindow.vPosition = this.hintwindow.vPosition + _loc3_;
         this.animcount = this.animcount + _loc3_;
         if(_loc4_ == true)
         {
            var _loc2_ = this.getLastHint();
            if(_loc2_ != null)
            {
               _loc2_.vPosA = this.hintwindow.vPosition;
               _loc2_.vPosB = _loc2_.widget._height - (this.hintwindow.height - 2);
               this.debug("Adjusted generated scroll settings: " + this.hintwindow.vPosition + ", " + _loc2_.vPosA + ", " + _loc2_.vPosB);
            }
         }
         this.clearAllIntervals();
         if(_loc4_ == true)
         {
            this.animating = false;
         }
         else
         {
            this.internalTimers.push(setInterval(this,"animateDown",this.delay));
         }
      }
      else
      {
         this.clearAllIntervals();
      }
   }
   function animateToIndex(a_hintindex)
   {
      this.debug("animateToIndex (" + a_hintindex + ")");
      this.hintindex = a_hintindex;
      this.animateTo(this.hints[a_hintindex]);
   }
   function animateTo(a_hint)
   {
      this.debug("animateTo (" + a_hint.widget._y + ")");
      var _loc2_ = a_hint.widget._y;
      this.debug("Scrolling to: " + _loc2_);
      this.hintindex = a_hint.index;
      if(_loc2_ > this.hintwindow.vPosition)
      {
         this.animdist = Math.abs(_loc2_ - Math.abs(this.hintwindow.vPosition));
         this.debug("animdist: " + this.animdist);
         this.animating = true;
         this.animcount = 0;
         this.animateDown();
      }
      else
      {
         this.animdist = Math.abs(_loc2_ - Math.abs(this.hintwindow.vPosition));
         this.debug("animdist: " + this.animdist);
         this.animating = true;
         this.animcount = 0;
         this.animateUp();
      }
   }
   function getLastHint()
   {
      return this.hints[this.hints.length - 1];
   }
   function updateContent()
   {
      this.debug("updateContent ()");
      var _loc2_ = 0;
      while(_loc2_ < this.hints.length)
      {
         this.hints[_loc2_].widget.border = this.sgTextBorder;
         _loc2_ = _loc2_ + 1;
      }
   }
   function evaluateScrolling(a_controller)
   {
      this.debug("evaluateScrolling ()");
      if(a_controller == null)
      {
         return undefined;
      }
      if(a_controller.scrollable == false)
      {
         this.up.setDisabled(true);
         this.down.setDisabled(true);
      }
      else
      {
         this.up.setDisabled(false);
         this.down.setDisabled(false);
      }
   }
   function evaluateControls()
   {
      this.debug("evaluateControls ()");
      if(this.hintEffectiveIndex <= 0)
      {
         this.hintEffectiveIndex = 0;
      }
      if(this.hintEffectiveIndex > this.hintsMax)
      {
         this.hintEffectiveIndex = this.hintsMax;
      }
      this.debug("Configuring controls for [" + this.hintsMax + "] hint/feedback entries with index: " + this.hintEffectiveIndex);
      if(this.hints.length == 0)
      {
         this.debug("The hint window is mostly likely reset");
         this.previous.locked = true;
         this.next.locked = true;
         this.previous.updateState();
         this.next.updateState();
         this.up.locked = true;
         this.down.locked = true;
         return undefined;
      }
      if(this.hintsMax == 1)
      {
         this.debug("We\'re looking at one single hint (feedback)");
         this.previous.locked = true;
         this.next.locked = true;
         this.previous.updateState();
         this.next.updateState();
         this.evaluateScrolling(this.getLastHint());
         return undefined;
      }
      if(this.hintsMax > 1)
      {
         if(this.hintEffectiveIndex == 0)
         {
            this.debug("We\'re looking at the first hint in a series");
            this.previous.locked = true;
            this.next.locked = false;
            this.previous.updateState();
            this.next.updateState();
            this.evaluateScrolling(this.getLastHint());
            return undefined;
         }
         if(this.hintEffectiveIndex == this.hintsMax - 1)
         {
            this.debug("We\'re looking at the last hint in a series");
            this.previous.locked = false;
            this.next.locked = true;
            this.previous.updateState();
            this.next.updateState();
            this.evaluateScrolling(this.getLastHint());
            return undefined;
         }
      }
      this.debug("We\'re looking at the middle of a series of hints");
      this.previous.locked = false;
      this.next.locked = false;
      this.previous.updateState();
      this.next.updateState();
      this.evaluateScrolling(this.getLastHint());
   }
   function __set__TextMargin(theValue)
   {
      this.sgTextMargin = theValue;
      return this.__get__TextMargin();
   }
   function __get__TextMargin()
   {
      return this.sgTextMargin;
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
   function __set__ScrollSpeed(theValue)
   {
      this.pageSpeed = theValue;
      return this.__get__ScrollSpeed();
   }
   function __get__ScrollSpeed()
   {
      return this.pageSpeed;
   }
   function __set__TextBorder(theValue)
   {
      this.sgTextBorder = theValue;
      this.updateContent();
      return this.__get__TextBorder();
   }
   function __get__TextBorder()
   {
      return this.sgTextBorder;
   }
   function __set__TweenShowHint(theValue)
   {
      this.brTweenShowHint = theValue;
      return this.__get__TweenShowHint();
   }
   function __get__TweenShowHint()
   {
      return this.brTweenShowHint;
   }
   function __set__TweenHideHint(theValue)
   {
      this.brTweenHideHint = theValue;
      return this.__get__TweenHideHint();
   }
   function __get__TweenHideHint()
   {
      return this.brTweenHideHint;
   }
}
