class CommButton.CommButtonClass extends mx.controls.Button
{
   static var symbolName = "CommButton";
   static var symbolOwner = Object(CommButton.CommButtonClass);
   var className = "CommButtonClass";
   var ParentClassName = "Button";
   static var version = "2.10.0";
   var publicVersion = "2.10.0";
   var commType = "CommButton";
   var shell = "";
   var shellAbs = "";
   var zlabel = "";
   var _sendInterfDescMessages = true;
   var onTheMove = false;
   var _showHighlight = false;
   var locked = false;
   var blocked = false;
   function CommButtonClass()
   {
      super();
   }
   function getClassVersion()
   {
      return this.publicVersion;
   }
   function setClassType(a_type)
   {
      this.className = a_type;
   }
   function classType()
   {
      return this.getClassType();
   }
   function getClassType()
   {
      return this.className;
   }
   function getCommType()
   {
      return this.commType;
   }
   function getDimensions()
   {
      this.dimensions.top = 0;
      this.dimensions.left = 0;
      this.dimensions.right = this._width;
      this.dimensions.bottom = this._height;
      return this.dimensions;
   }
   function debug(a_string)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug(this.getClassType(),a_string);
   }
   function init()
   {
      super.init();
      this.debug("init ()");
      this.dimensions = new edu.cmu.hcii.ctat.CTATRect();
      pact.datastructures.SingletonList.getInstance().insert(this);
      this.setStyle("themeColor","0xeeeeee");
      this.setStyle("disabledColor","0x000000");
      mx.events.EventDispatcher.initialize(this);
      this.addEventListener("focusIn",this.onFocusIn);
      this.addEventListener("focusOut",this.onFocusOut);
      this.addEventListener("click",this.onChange);
      this.startSocketandNewProblem();
   }
   function draw()
   {
      super.draw();
   }
   function createChildren(Void)
   {
      super.createChildren();
      this.debug("createChildren ()");
      var _loc4_ = new Object();
      _loc4_._width = this.__get__width() - 8;
      _loc4_._height = this.__get__height() - 7.5;
      _loc4_._visible = true;
      this.attachMovie("buttonHighlight","buttonHighlight",998,_loc4_);
      this.buttonHighlight._x = 4;
      this.buttonHighlight._y = 4;
      this.buttonHightlightColor = new Color(this.buttonHighlight);
      this.setBackgroundColor(16777215);
      this.createTextField("highlightLabel",this.getNextHighestDepth(),0,0,100,30);
      this.highlightLabel.autoSize = "left";
      var _loc5_ = new Color(this.highlightLabel);
      if(_global.theShell.HintColor != undefined && _global.theShell.HintColor != null)
      {
         this.highlightLabel.setRGB(_global.theShell.HintColor);
      }
      else
      {
         this.highlightLabel.setRGB(13158);
      }
      this.doLater(this,"setHighlightLabeltothisLabel");
   }
   function size(Void)
   {
      super.size();
      this.debug("size ()");
      var _loc3_ = this.getTextMetrics(this.getHighlightLabel(),this.__get__highlightLabelSize(),this.__get__highlightLabelFace());
      this.highlightLabel._y = this.__get__height() / 2 - _loc3_.height / 2 - 2;
      this.highlightLabel._x = this.__get__width() / 2 - _loc3_.width / 2 - 2;
      this.highlightLabel._visible = true;
      this.buttonHighlight._width = this.__get__width() - 8;
      this.buttonHighlight._height = this.__get__height() - 7.5;
   }
   function startSocketandNewProblem()
   {
      this.debug("startSocketandNewProblem ()");
      if(_global.isLivePreview != true && (_level0[this.shell].BehaviorRecorder == "AuthorTime" || _level0.BehaviorRecorderMode == "AuthorTime"))
      {
         _global.theShell.addEventListener("onSocketConnect",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.actOnSocketConnection));
         _global.theShell.addEventListener("onNewProblem",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.actOnNewProblem));
      }
   }
   function actOnSocketConnection()
   {
   }
   function actOnNewProblem()
   {
      this.debug("actOnNewProblem ()");
      if(this.getSendInterfDescMessages() == true)
      {
         this.sendJessInterfaceDescription();
      }
   }
   function sendJessInterfaceDescription()
   {
      this.debug("sendJessInterfaceDescription ()");
      var _loc5_ = "CommButton";
      var _loc3_ = this._name;
      var _loc4_ = "Button";
      var _loc6_ = this.buildJessInterfaceDescription(_loc3_,_loc5_,_loc4_);
      _global.theShell.sendInterfaceDescription(_loc6_);
   }
   function buildJessInterfaceDescription(componentName, componentType, defTemplateType)
   {
      this.debug("buildJessInterfaceDescription ()");
      var _loc2_ = "<message>";
      _loc2_ = _loc2_ + "<verb>SendNoteProperty</verb>";
      _loc2_ = _loc2_ + "<properties>";
      _loc2_ = _loc2_ + "<MessageType>InterfaceDescription</MessageType>";
      _loc2_ = _loc2_ + ("<WidgetType>" + componentType + "</WidgetType>");
      _loc2_ = _loc2_ + (" <DorminName>" + componentName + "</DorminName>");
      _loc2_ = _loc2_ + "<UpdateEachCycle>false</UpdateEachCycle>";
      _loc2_ = _loc2_ + "<jessDeftemplates>";
      _loc2_ = _loc2_ + ("<value>(deftemplate " + defTemplateType + " (slot name))</value>");
      _loc2_ = _loc2_ + "</jessDeftemplates>";
      _loc2_ = _loc2_ + "<jessInstances>";
      _loc2_ = _loc2_ + ("<value>(assert ( " + defTemplateType + " (name " + componentName + ")))</value>");
      _loc2_ = _loc2_ + "</jessInstances>";
      _loc2_ = _loc2_ + "</properties>";
      _loc2_ = _loc2_ + "</message>";
      return _loc2_;
   }
   function onFocusOut()
   {
      this.debug("onFocusOut ()");
      _global.theShell.onKillFocusHandler(this);
   }
   function onFocusIn()
   {
      this.debug("onFocusIn ()");
      _global.theShell.onSetFocusHandler(this);
      _global.theShell.CurrentFocus(this);
   }
   function getBackgroundColor()
   {
      return this.buttonHightlightColor.getRGB();
   }
   function getText()
   {
      return this.getHighlightLabel();
   }
   function click()
   {
      _root.focusManager.setFocus(this);
      this.gradeMe();
   }
   function setForegroundColor(theValue)
   {
      this.setStyle("color",theValue);
   }
   function getForegroundColor()
   {
      return this.getStyle("color");
   }
   function isHighlighted()
   {
      return this.getCurrentlyHighlighted();
   }
   function gradeMe()
   {
      this.onChange();
   }
   function onChange()
   {
      var _loc3_ = this;
      var _loc5_ = this.commType;
      var _loc6_ = String(_loc3_);
      var _loc9_ = "ButtonPressed";
      var _loc4_ = "-1";
      var _loc8_ = true;
      var _loc7_ = true;
      _global.theShell.tutorComponentData(_loc3_,_loc5_,_loc6_,_loc9_,_loc4_,_loc8_,_loc7_);
   }
   function resetComponent()
   {
      this.debug("resetComponent ()");
      this.unlock();
      this.showNull();
      this.dispatchAndCallGradeNull();
      this.dispatchEvent({type:"onResetComponent",target:this});
   }
   function setStartState(theSelection, theAction, theInput, theTransaction_id)
   {
      this.dispatchEvent({type:"onSetStartState",target:this});
   }
   function setStartStateCompletedFlag()
   {
      this.lock();
      this.dispatchEvent({type:"onSetStartStateCompletedFlag",target:this});
   }
   function setResults(gradeStatus, theSelection, theAction, theInput, theEvaluation, lockAnswer)
   {
      this.debug("setResults ()");
      if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(gradeStatus,"Correct"))
      {
         this.showCorrect();
         if(lockAnswer == true)
         {
            this.lock();
         }
         this.dispatchAndCallGradeCorrect();
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(gradeStatus,"Incorrect"))
      {
         this.showIncorrect();
         this.unlock();
         this.dispatchAndCallGradeIncorrect();
      }
   }
   function setResultsSuppressFeedback(gradeStatus, theSelection, theAction, theInput, theEvaluation)
   {
      this.debug("setResultsSuppressFeedback ()");
      if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(gradeStatus,"Correct"))
      {
         this.dispatchAndCallGradeCorrect();
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(gradeStatus,"Incorrect"))
      {
         this.dispatchAndCallGradeIncorrect();
      }
      return undefined;
   }
   function dispatchAndCallGradeCorrect()
   {
      this.debug("dispatchAndCallGradeCorrect ()");
      this.dispatchEvent({type:"showCorrect",target:this});
      this.callPostGradeFunction(this.__get__callThisMethodonCorrect());
   }
   function dispatchAndCallGradeIncorrect()
   {
      this.dispatchEvent({type:"showIncorrectButton",target:this});
      this.callPostGradeFunction(this.__get__callThisMethodonInCorrect());
   }
   function dispatchAndCallGradeNull()
   {
      this.debug("dispatchAndCallGradeNull ()");
      this.dispatchEvent({type:"showNull",target:this});
      this.callPostGradeFunction(this.__get__callThisMethodonNull());
   }
   function showCorrect()
   {
      this.setStyle("color",_global.theShell.correctColor);
      this.setStyle("disabledColor",_global.theShell.correctColor);
      this.setIsCorrect(true);
      this.setHighlightLabelFormat(this.__get__highlightLabelFace(),this.__get__highlightLabelSize(),_global.theShell.correctColor);
   }
   function callPostGradeFunction(sPostGradeFunctionName)
   {
      this.debug("callPostGradeFunction (" + sPostGradeFunctionName + ")");
      var myNavFunction = eval("_level0." + sPostGradeFunctionName);
      myNavFunction(this);
      this.debug("callPostGradeFunction () done");
   }
   function showIncorrect()
   {
      this.debug("showIncorrect ()");
      this.setStyle("color","0xFF0000");
      this.setIsCorrect(false);
      this.setHighlightLabelFormat(this.__get__highlightLabelFace(),this.__get__highlightLabelSize(),_global.theShell.incorrectColor);
   }
   function showNull()
   {
      this.debug("showNull ()");
      this.setStyle("color","0x000000");
      this.setStyle("disabledColor","0x000000");
      this.setIsCorrect(null);
      this.setHighlightLabelFormat(this.__get__highlightLabelFace(),this.__get__highlightLabelSize(),0);
   }
   function lock()
   {
      this.debug("lock ()");
      this.enabled = false;
      this.locked = true;
   }
   function unlock()
   {
      this.debug("unlock ()");
      this.enabled = true;
      this.locked = false;
   }
   function getLockStatus()
   {
      return this.locked;
   }
   function block()
   {
      this.debug("block ()");
      if(this.getLockStatus() == true)
      {
         this.debug("The component is current locked, aborting");
         return undefined;
      }
      this.enabled = false;
      this.blocked = true;
   }
   function unblock()
   {
      this.debug("unblock ()");
      if(this.getLockStatus() == true)
      {
         this.debug("The component is current locked, aborting");
         return undefined;
      }
      this.enabled = true;
      this.blocked = false;
   }
   function getBlockStatus()
   {
      return this.blocked;
   }
   function getIsCorrect()
   {
      return this.isCorrect;
   }
   function setIsCorrect(correctState)
   {
      this.isCorrect = correctState;
   }
   function setBackgroundColor(theColor)
   {
      this.buttonHightlightColor.setRGB(theColor);
   }
   function highlight()
   {
      if(this.__get__showHighlight() == true)
      {
         if(_global.theShell.HintColor != undefined && _global.theShell.HintColor != null)
         {
            this.setBackgroundColor(_global.theShell.HintColor);
         }
         else
         {
            this.setBackgroundColor(16776960);
         }
      }
      this.setCurrentlyHighlighted(true);
   }
   function unHighlight()
   {
      this.setBackgroundColor(16777215);
      this.highlightLabel._visible = true;
      this.setCurrentlyHighlighted(false);
   }
   function setHighlightLabeltothisLabel()
   {
      this.setHighlightLabel(this.__get__highlightLabelText());
   }
   function setHighlightLabel(sLabel)
   {
      this.highlightLabel._visible = true;
      this.__set__label(sLabel);
      this.highlightLabel.text = sLabel;
      this.highlightLabel.embedFonts = false;
      this.setHighlightLabelFormat(this.__get__highlightLabelFace(),this.__get__highlightLabelSize(),0);
      this.sizeButton(this.__get__highlightLabelSize(),this.__get__highlightLabelFace());
   }
   function setHighlightLabelFormat(theFace, theSize, theColor)
   {
      var _loc2_ = new TextFormat();
      _loc2_.font = theFace;
      _loc2_.size = theSize;
      _loc2_.color = theColor;
      this.highlightLabel.setTextFormat(_loc2_);
   }
   function getHighlightLabel()
   {
      return this.highlightLabel.text;
   }
   function sizeButton(theFontSize, theFontFace)
   {
      var _loc2_ = this.getTextMetrics(this.getHighlightLabel(),theFontSize,theFontFace);
      var _loc4_ = _loc2_.textFieldWidth + 40;
      var _loc3_ = _loc2_.height + 8;
      this.setSize(this.__get__width(),_loc3_);
      return undefined;
   }
   function getTextMetrics(sText2BSized, theFontSize, thefontFace)
   {
      var my_fmt = new TextFormat();
      my_fmt.size = theFontSize;
      with(my_fmt)
      {
         font = thefontFace
         rightMargin = 2
         leftMargin = 2
         
      };
      var metrics = my_fmt.getTextExtent(sText2BSized);
      return metrics;
   }
   function setCurrentlyHighlighted(highlighState)
   {
      this.currentlyHighlighted = highlighState;
   }
   function getCurrentlyHighlighted()
   {
      return this.currentlyHighlighted;
   }
   function __set__highlightLabelText(theValue)
   {
      this._highlightLabelText = theValue;
      return this.__get__highlightLabelText();
   }
   function __get__highlightLabelText()
   {
      return this._highlightLabelText;
   }
   function __set__highlightLabelFace(sFontFace)
   {
      this._highlightLabelFace = sFontFace;
      return this.__get__highlightLabelFace();
   }
   function __get__highlightLabelFace()
   {
      return this._highlightLabelFace;
   }
   function __set__highlightLabelSize(usersize)
   {
      this._highlightLabelSize = usersize;
      return this.__get__highlightLabelSize();
   }
   function __get__highlightLabelSize()
   {
      return this._highlightLabelSize;
   }
   function __set__callThisMethodonCorrect(sCallThisMethodonCorrect)
   {
      this._callThisMethodonCorrect = sCallThisMethodonCorrect;
      return this.__get__callThisMethodonCorrect();
   }
   function __get__callThisMethodonCorrect()
   {
      return this._callThisMethodonCorrect;
   }
   function __set__callThisMethodonInCorrect(sCallThisMethodonInCorrect)
   {
      this._callThisMethodonInCorrect = sCallThisMethodonInCorrect;
      return this.__get__callThisMethodonInCorrect();
   }
   function __get__callThisMethodonInCorrect()
   {
      return this._callThisMethodonInCorrect;
   }
   function __set__callThisMethodonNull(sCallThisMethodonNull)
   {
      this._callThisMethodonNull = sCallThisMethodonNull;
      return this.__get__callThisMethodonNull();
   }
   function __get__callThisMethodonNull()
   {
      return this._callThisMethodonNull;
   }
   function __set__showHighlight(theValue)
   {
      this._showHighlight = theValue;
      return this.__get__showHighlight();
   }
   function __get__showHighlight()
   {
      return this._showHighlight;
   }
   function __set__treatCheckAsDone(bCheckDone)
   {
      this._checkDone = bCheckDone;
      return this.__get__treatCheckAsDone();
   }
   function __get__treatCheckAsDone()
   {
      return this._checkDone;
   }
   function setSendInterfDescMessages(sendStatus)
   {
      this._sendInterfDescMessages = sendStatus;
   }
   function getSendInterfDescMessages()
   {
      return this._sendInterfDescMessages;
   }
}
