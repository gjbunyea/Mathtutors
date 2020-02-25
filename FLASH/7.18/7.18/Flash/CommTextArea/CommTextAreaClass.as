class CommTextArea.CommTextAreaClass extends mx.controls.TextArea
{
   var className = "CommTextAreaClass";
   static var symbolName = "CommTextAreaClass";
   static var symbolOwner = CommTextArea.CommTextAreaClass;
   static var version = "2.8";
   var publicVersion = "2.8";
   var commType = "textArea";
   var currentlyHighlighted = false;
   var hasHTML = false;
   var _sendInterfDescMessages = true;
   var _startStateCreatedStatus = false;
   var _textHasChanged = false;
   var _nBackgroundColor = 16777215;
   var _nDisabledBackgroundColor = 13421772;
   var loaded = false;
   var locked = false;
   var blocked = false;
   var allowedit = false;
   var sgScrolling = "off";
   var sgTabIndex = 5000;
   var focused = false;
   var preTexted = false;
   function CommTextAreaClass()
   {
      super();
   }
   function getClassVersion()
   {
      return this.publicVersion;
   }
   function classType()
   {
      return this.className;
   }
   function getDimensions()
   {
      this.dimensions.top = 0;
      this.dimensions.left = 0;
      this.dimensions.right = this._width;
      this.dimensions.bottom = this._height;
      return this.dimensions;
   }
   function applyScrolling()
   {
      this.debug("applyScrolling (" + this.sgScrolling + ")");
      if(this.textbox == undefined)
      {
         this.debug("Internal error: textbox is undefined");
         return undefined;
      }
      if(this.textbox == null)
      {
         this.debug("Internal error: textbox is null");
         return undefined;
      }
      if(this.textbox.vScrollPolicy == undefined)
      {
         this.debug("Internal error: textbox vScrollPolicy attribute is undefined");
         return undefined;
      }
      this.__set__wordWrap(true);
      this.textbox.__set__wordWrap(true);
      this.hScrollPolicy = this.sgScrolling;
      this.vScrollPolicy = this.sgScrolling;
      this.textbox.hScrollPolicy = this.sgScrolling;
      this.textbox.vScrollPolicy = this.sgScrolling;
      this.debug("Parent scrolling policy is set to: (h)" + this.hScrollPolicy + ", (v)" + this.vScrollPolicy);
      this.debug("Child scrolling policy is set to: (h)" + this.textbox.hScrollPolicy + ", (v)" + this.textbox.vScrollPolicy);
   }
   function debug(a_string)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug(this.classType(),a_string);
   }
   function processBorder()
   {
      this.debug("processBorder (" + this._border + ")");
      if(this._border == "Hide")
      {
         this.debug("hiding border ...");
         this.textbox.setStyle("borderStyle","none");
      }
      else
      {
         this.debug("showing border ...");
         this.textbox.setStyle("borderStyle","inset");
      }
   }
   function init()
   {
      this.debug("init ()");
      super.init();
      this.commType = "textArea";
      mx.events.EventDispatcher.initialize(this);
      this.dimensions = new edu.cmu.hcii.ctat.CTATRect();
   }
   function draw()
   {
      this.debug("draw ()");
      super.draw();
   }
   function createChildren()
   {
      this.debug("createChildren ()");
      super.createChildren();
      if(this.textbox.__get__text() != "")
      {
         this.preTexted = true;
      }
      this.fullInit();
      this.setupEventHandlers();
      this.debug("Tab index: " + this.__get__tabIndex() + " textbox tab index: " + this.textbox.__get__tabIndex());
      this.size();
      this.invalidate();
   }
   function getTextBox()
   {
      return this.textbox;
   }
   function fullInit()
   {
      this.debug("fullInit ()");
      this.assingThisToGlobalList();
      this.processBorder();
      var _loc2_ = new Object();
      _loc2_.onMouseDown = mx.utils.Delegate.create(this,this.handleMouseInput);
      Mouse.addListener(_loc2_);
      this.theLastCaretIndex = 1;
      if(this.__get__returnKey() == "Grade The Widget")
      {
         this.textbox.__set__restrict("^\r");
      }
      this.assignInitialStyles();
      this.startSocketandNewProblem();
      this.debug("hasHTML: " + this.hasHTML + " html: " + this.textbox.__get__html());
      if(this.theConvertLogicSymbols)
      {
         this.setStyle("fontFamily","Lucida Sans Unicode");
      }
      this.applyScrolling();
   }
   function assingThisToGlobalList()
   {
      this.debug("assignThisToGlobalList ()");
      pact.datastructures.SingletonList.getInstance().insert(this);
   }
   function size()
   {
      this.debug("size ()");
      super.size();
      this.textbox.setSize(this.__get__width(),this.__get__height());
      if(this.textbox.__get__html() != undefined)
      {
         if(this.loaded == false)
         {
            this.debug("Setting HTML property (" + this.hasHTML + ")...");
            this.textbox.__set__html(this.hasHTML);
            this.textbox.__set__text(this._theText);
            this.loaded = true;
            this.applyScrolling();
         }
      }
      else
      {
         this.debug("html property of textbox is undefined");
      }
      if(this.allowedit == false)
      {
         this.textbox.__set__editable(false);
      }
   }
   function setupEventHandlers()
   {
      this.debug("setupEventHandlers ()");
      if(this.textbox == undefined)
      {
         this.debug("Error, textbox instance is not defined yet!");
         return undefined;
      }
      if(this.textbox == null)
      {
         this.debug("Error, textbox instance is null!");
         return undefined;
      }
      this.debug("apparently we have a valid textbox");
      mx.events.EventDispatcher.initialize(this.textbox);
      var _loc2_ = new Object();
      _loc2_.realThis = this;
      _loc2_.onKeyDown = this.handleKeyInput;
      Key.addListener(_loc2_);
      this.textbox.addEventListener("change",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onChangeHandler));
      this.textbox.addEventListener("focusIn",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onFocusIn));
      this.textbox.addEventListener("focusOut",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onFocusOut));
   }
   function assignInitialStyles()
   {
      this.debug("assignInitialStyles ()");
      this.textbox.setStyle("fontSize",this.__get__sgFontSize());
      this.textbox.setStyle("fontFamily",this.__get__sgFontFace());
      this.textbox.setStyle("textAlign",this.__get__sgTextAlign());
      this.textbox.setStyle("backgroundColor",this.__get__sgBackgroundColor());
      this.textbox.setStyle("color",this.__get__sgTextColor());
      this.textbox.setStyle("disabledColor",this.__get__sgDisabledTextColor());
      this.applyScrolling();
   }
   function startSocketandNewProblem()
   {
      this.debug("startSocketandNewProblem ()");
      if(_global.isLivePreview != true && (_global.theShell.BehaviorRecorder == "AuthorTime" || _level0.BehaviorRecorderMode == "AuthorTime"))
      {
         this.actOnSocketConnection();
         this.actOnNewProblem();
         this.actOnStartStateCreated();
      }
   }
   function actOnSocketConnection()
   {
      this.debug("actOnSocketConnection ()");
      var _loc3_ = new Object();
      _loc3_.onSocketConnect = mx.utils.Delegate.create(this,this.onSocketConnectionCallback);
      _global.theShell.addEventListener("onSocketConnect",_loc3_);
   }
   function onSocketConnectionCallback()
   {
   }
   function actOnNewProblem()
   {
      this.debug("actOnNewProblem ()");
      var _loc3_ = new Object();
      _loc3_.onNewProblem = mx.utils.Delegate.create(this,this.onNewProblemCallback);
      _global.theShell.addEventListener("onNewProblem",_loc3_);
   }
   function onNewProblemCallback()
   {
      this.debug("onNewPRoblemCallback ()");
      this.debug("escActOnNewProblem : Text Area : newProblemListener : call  sendJessInterfaceDescription = " + this.getSendInterfDescMessages());
      if(this.getSendInterfDescMessages() == true)
      {
         this.sendJessInterfaceDescription();
      }
   }
   function actOnStartStateCreated()
   {
      this.debug("actOnStartStateCreate ()");
      var _loc3_ = new Object();
      _loc3_.onStartStateCreated = mx.utils.Delegate.create(this,this.onStartStateCreatedCallback);
      _global.theShell.addEventListener("onStartStateCreated",_loc3_);
   }
   function onStartStateCreatedCallback()
   {
      this.debug("escActOnStartStateCreated : Text Input : startStateCreatedListener");
      this.setStartStateCreatedStatus(true);
   }
   function setStartStateCreatedStatus(BStatus)
   {
      this._startStateCreatedStatus = BStatus;
   }
   function getStartStateCreatedStatus()
   {
      return this._startStateCreatedStatus;
   }
   function sendJessInterfaceDescription()
   {
      this.debug("sendJessInterfaceDescription ()");
      var _loc5_ = "commTextArea";
      var _loc3_ = this._name;
      var _loc4_ = "textArea";
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
      _loc2_ = _loc2_ + ("<value>(deftemplate " + defTemplateType + " (slot name) (slot value))</value>");
      _loc2_ = _loc2_ + "</jessDeftemplates>";
      _loc2_ = _loc2_ + "<jessInstances>";
      _loc2_ = _loc2_ + ("<value>(assert ( " + defTemplateType + " (name " + componentName + ")))</value>");
      _loc2_ = _loc2_ + "</jessInstances>";
      _loc2_ = _loc2_ + "</properties>";
      _loc2_ = _loc2_ + "</message>";
      this.debug("buildJessInterfaceDescription  :  Text Area :  the Full Message = " + _loc2_);
      return _loc2_;
   }
   function onChangeHandler(msg)
   {
      this.debug("onChangeHandler ()");
      if(this.theConvertLogicSymbols)
      {
         this.convertLogic();
      }
      this.__set__LastCaretIndex(Selection.getCaretIndex());
      this.debug("onChangeHandler : 1 : this = " + this + "  this.textbox.text = " + this.textbox.__get__text() + "  getCorrectText() = " + this.getCorrectText() + "  getIsCorrect() = " + this.getIsCorrect());
      if(this.textbox.__get__text().charCodeAt(0) == 13 && this.textbox.__get__text().length == 1)
      {
         this.textbox.__set__text("");
      }
      if(this.__get__returnKey() == "Grade The Widget" && this.textbox.__get__text().charCodeAt(this.textbox.__get__text().length - 1) == 13)
      {
         this.textbox.__set__text(this.textbox.__get__text().substring(0,this.textbox.__get__text().length - 1));
      }
      else
      {
         this.setTextHasChanged(true);
         this.setTextChangedColor(true);
      }
      if(this.getIsCorrect() == true)
      {
         this.debug("onChangeHandler : 2 : this = " + this + "  this.textbox.text = " + this.textbox.__get__text() + "  getCorrectText() = " + this.getCorrectText() + "  getIsCorrect() = " + this.getIsCorrect());
         this.textbox.__set__text(this.getCorrectText());
      }
      this.applyScrolling();
   }
   function handleMouseInput()
   {
      this.theLastCaretIndex = Selection.getCaretIndex();
      this.clickInsideThisComponent();
   }
   function clickInsideThisComponent()
   {
      if(this.locked == true || this.blocked == true)
      {
         this.debug("We\'re already graded or temporarily disabled, aborting ...");
         return undefined;
      }
      if(this._visible == false)
      {
         this.debug("This component isn\'t even visible, what the hell were we thinking??");
         return undefined;
      }
      if(this.hitTest(_level0._xmouse,_level0._ymouse) == true)
      {
         this.debug("clickInsideThisComponent : 1 hitTest is true for " + this);
         var _loc3_ = edu.cmu.hcii.ctat.CTATUtil.removeLevel(String(this));
         _global.theShell.setLastClickedComponent(_loc3_);
         return undefined;
      }
   }
   function onFocusIn()
   {
      this.debug("onFocusIn (" + this._name + ")");
      this.dispatchFocusIn();
      _global.theShell.manageBackgrading(this);
      if(this.textbox.__get__text().charCodeAt(0) == 13)
      {
         this.textbox.__set__text("");
      }
   }
   function onFocusOut()
   {
      this.debug("onFocusOut (" + this._name + ")");
      this.dispatchFocusOut();
   }
   function handleKeyInput()
   {
      this.debug("handleKeyInput ()");
   }
   function temporaryWorkaround()
   {
      this.debug("temporaryWorkaround ()");
      if(this.theConvertLogicSymbols)
      {
         this.convertLogic();
      }
      this.__set__LastCaretIndex(Selection.getCaretIndex());
      this.onChangeHandler("Source is on(Change) in Text Area Fla script");
   }
   function recieveEnterKey()
   {
      this.debug("receiveEnterKey ()");
      if(this.__get__returnKey() == "Grade The Widget")
      {
         this.debug("recieveEnterKey : TextArea : Grade The Widget");
         this.gradeTextField(this);
      }
      else if(this.__get__returnKey() == "Carriage Return")
      {
         this.debug("recieveEnterKey : TextArea : Carriage Return : no grading :");
      }
   }
   function selectSetAndFindNewFocus(newValue)
   {
      this.debug("selectSetAndFindNewFocus ()");
      this.select();
      this.setText(newValue);
      this.onChangeHandler();
      _global.theShell.determineFindNewFocus(this);
   }
   function selectSetAndEnter(newValue)
   {
      this.debug("selectSetAndEnter ()");
      this.select();
      this.setText(newValue);
      this.onChangeHandler();
      this.gradeTextField(this.textbox);
   }
   function select()
   {
      this.debug("select ()");
   }
   function setText(newValue)
   {
      this.debug("setText (): " + newValue);
      this.textbox.__set__html(this.hasHTML);
      var _loc3_ = new edu.cmu.hcii.ctat.CTATHTMLManager();
      _loc3_.singleQuoteEscape = false;
      var _loc2_ = _loc3_.entitiesConvert(newValue);
      if(_loc2_ != null)
      {
         this.debug("Assigning escaped string: " + _loc2_);
         this.textbox.__set__text(_loc2_);
      }
      else
      {
         this.debug("Assigning raw string: " + _loc2_);
         this.textbox.__set__text(newValue);
      }
   }
   function getText()
   {
      this.debug("getText ()");
      this.transformer = this.textbox.text;
      this.debug("Raw text from textbox: " + this.transformer);
      return this.transformer;
   }
   function setForegroundColor(theValue)
   {
      this.textbox.setStyle("color",theValue);
   }
   function getForegroundColor()
   {
      return this.textbox.getStyle("color");
   }
   function gradeTextField(widget)
   {
      this.debug("gradeTextField ()");
      _global.theShell.checkme(widget);
   }
   function resetComponent()
   {
      this.debug("resetComponent ()");
      this.unlock();
      if(this._theText != null)
      {
         this.textbox.__set__text(this._theText);
      }
      else
      {
         this.textbox.__set__text("");
      }
      this.assignInitialStyles();
      this.showNull();
      this.dispatchAndCallGradeNull();
      this.dispatchEvent({type:"onResetComponent",target:this});
   }
   function setStartState(theSelection, theAction, theInput, theTransaction_id)
   {
      this.debug("setStartState ()");
      this.debug(this._name + "  CommTextArea : setStartState : SAI = " + theSelection + " " + theAction + "  " + theInput + "  " + theTransaction_id);
      this.dispatchEvent({type:"onSetStartState",target:this});
   }
   function setStartStateCompletedFlag()
   {
      this.debug("setStartStateCompletedFlag ()");
      this.debug(this._name + "  setStartStateCompletedFlag : Call lock");
      this.lock();
      this.dispatchEvent({type:"onSetStartStateCompletedFlag",target:this});
   }
   function setResults(gradeStatus, theSelection, theAction, theInput, theEvaluation, lockAnswer)
   {
      this.debug("setResults ()");
      this.debug("CommTextArea : setResults : gradeStatus = " + gradeStatus + " this = " + this + "  theInput = " + theInput);
      if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(gradeStatus,"Correct"))
      {
         this.textbox.__set__text(theInput);
         if(this.__get__ShowFeedbackforWidget() == true)
         {
            this.showCorrect();
            if(lockAnswer == true)
            {
               this.lock();
            }
         }
         this.dispatchAndCallGradeCorrect();
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(gradeStatus,"Incorrect"))
      {
         if(this.__get__ShowFeedbackforWidget() == true)
         {
            this.showIncorrect();
            this.unlock();
         }
         this.dispatchAndCallGradeIncorrect();
      }
      else
      {
         this.debug("EXCEPTION : gradeStatus not Correct or Incorrect. It = " + gradeStatus);
      }
   }
   function setResultsSuppressFeedback(gradeStatus, theSelection, theAction, theInput, theEvaluation)
   {
      this.debug("setResultsSuppressFeedback ()");
      if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(gradeStatus,"Correct"))
      {
         this.textbox.__set__text(theInput);
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
      this.debug("dispatchAndCallGradeIncorrect ()");
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
      this.debug("showCorrect ()");
      this.textbox.setStyle("color",_global.theShell.correctColor);
      this.textbox.setStyle("disabledColor",_global.theShell.correctColor);
      this.setIsCorrect(true);
      this.setTextHasChanged(false);
      this.setCorrectText(this.textbox.__get__text());
   }
   function callPostGradeFunction(sPostGradeFunctionName)
   {
      this.debug("callPostGradeFunction ()");
      var myNavFunction = eval("_level0." + sPostGradeFunctionName);
      myNavFunction(this);
   }
   function showIncorrect()
   {
      this.debug("showIncorrect ()");
      this.textbox.setStyle("color",_global.theShell.incorrectColor);
      this.textbox.setStyle("disabledColor",_global.theShell.incorrectColor);
      this.setIsCorrect(false);
      this.setTextHasChanged(false);
   }
   function showNull()
   {
      this.debug("showNull ()");
      if(this.preTexted == false)
      {
         this.debug("The component has been pre-filled with text, not resetting!");
         return undefined;
      }
      this.textbox.setStyle("color",this.__get__sgTextColor());
      this.textbox.setStyle("disabledColor",this.__get__sgDisabledTextColor());
      this.setIsCorrect(null);
      this.setTextHasChanged(false);
   }
   function parseToUnicode(str)
   {
      this.debug("parseToUnicode ()");
      var _loc2_ = str.toString();
      _loc2_ = this.replace(_loc2_,"<->","↔");
      _loc2_ = this.replace(_loc2_,"->","→");
      _loc2_ = this.replace(_loc2_,"~","¬");
      _loc2_ = this.replace(_loc2_,"v.","∨");
      _loc2_ = this.replace(_loc2_,"A.","∀");
      _loc2_ = this.replace(_loc2_,"E.","∃");
      return _loc2_;
   }
   function replace(str, sSearch, sReplace)
   {
      this.debug("replace ()");
      var _loc8_ = 0;
      while(_loc8_ < str.length)
      {
         var _loc4_ = str.indexOf(sSearch,_loc8_);
         if(_loc4_ == -1)
         {
            break;
         }
         var _loc5_ = str.substr(0,_loc4_);
         var _loc6_ = str.substr(_loc4_ + sSearch.length,str.length);
         str = _loc5_ + sReplace + _loc6_;
         _loc8_ = _loc5_.length + sReplace.length;
         if(sSearch.length > 1)
         {
            Selection.setSelection(this.theLastCaretIndex - sSearch.length + 2,this.theLastCaretIndex - sSearch.length + 2);
         }
      }
      return str;
   }
   function convertLogic()
   {
      this.textbox.__set__text(this.parseToUnicode(this.textbox.__get__text()));
   }
   function gradeMe()
   {
   }
   function lock()
   {
      this.debug("lock (" + this._name + ")");
      this.textbox.setStyle("backgroundColor",this._nDisabledBackgroundColor);
      this.enabled = false;
      if(this.allowedit == true)
      {
         this.__set__editable(false);
      }
      if(this.allowedit == true)
      {
         this.textbox.enabled = false;
      }
      this.textbox.__set__editable(false);
      this.locked = true;
   }
   function unlock()
   {
      this.debug("unlock (" + this._name + ")");
      if(this.allowedit == false)
      {
         this.debug("Allowedit is set to false, we should leave this component alone");
         return undefined;
      }
      this.textbox.setStyle("backgroundColor",this.__get__sgBackgroundColor());
      this.enabled = true;
      if(this.allowedit == true)
      {
         this.__set__editable(true);
      }
      this.textbox.enabled = true;
      if(this.allowedit == true)
      {
         this.textbox.__set__editable(true);
      }
      this.locked = false;
   }
   function getLockStatus()
   {
      return this.locked;
   }
   function block()
   {
      this.debug("block (" + this._name + ")");
      if(this.locked == true)
      {
         return undefined;
      }
      this.textbox.setStyle("backgroundColor",this._nDisabledBackgroundColor);
      this.enabled = false;
      this.textbox.enabled = false;
      this.blocked = true;
   }
   function unblock()
   {
      this.debug("unblock (" + this._name + ")");
      if(this.allowedit == false)
      {
         this.debug("Allowedit is set to false, we should leave this component alone");
         return undefined;
      }
      if(this.locked == true)
      {
         return undefined;
      }
      this.textbox.setStyle("backgroundColor",this.__get__sgBackgroundColor());
      this.enabled = true;
      this.textbox.enabled = true;
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
   function highlight()
   {
      this.debug("highlight ()");
      this.setBackgroundColor(_global.theShell.HintColor);
      this.setCurrentlyHighlighted(true);
   }
   function unHighlight()
   {
      this.debug("unHighlight ()");
      if(this.locked == false && this.blocked == false)
      {
         this.setBackgroundColor(this.__get__sgBackgroundColor());
      }
      this.setCurrentlyHighlighted(false);
   }
   function setBackgroundColor(theColor)
   {
      this.textbox.setStyle("backgroundColor",theColor);
   }
   function isHighlighted()
   {
      return this.getCurrentlyHighlighted();
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
   function onLoad()
   {
      this.debug("onLoad ()");
      this.debug("3 TextArea : onLoad : textDefault = " + this.__get__textDefault() + "  this.textbox.text  " + this.textbox.__get__text());
      if(this.__get__textDefault() != undefined)
      {
         this.textbox.__set__text(this.textDefault);
      }
      this.debug("4 TextArea : onLoad : textDefault = " + this.__get__textDefault() + "  this.textbox.text  " + this.textbox.__get__text());
      this.debug("3 TextArea : onLoad : textDefault =   this.textbox.text  " + this.textbox.__get__text());
      if(this.__get__restrictDefault() != undefined)
      {
         this.textbox.__set__restrict(this.restrictDefault);
      }
      this.debug("4 TextArea : onLoad : textDefault =   this.textbox.restrict  " + this.textbox.__get__restrict());
      if(this.__get__maxCharacters() != undefined)
      {
         this.textbox.__set__maxChars(this.maxCharacters);
      }
      this.applyScrolling();
   }
   function __set__textDefault(theValue)
   {
      this.debug("1 TextArea :  set textDefault :   this._name = " + this._name + "  theValue = " + theValue + "  this.textbox.text  " + this.textbox.__get__text() + "  _theText = " + this._theText);
      this._theText = theValue;
      this.textbox.__set__html(this.hasHTML);
      this.textbox.__set__text(theValue);
      this.applyScrolling();
      this.textbox.redraw();
      this.debug("2 TextArea :  set textDefault :   this._name = " + this._name + "  theValue = " + theValue + "  this.textbox.text  " + this.textbox.__get__text() + "  _theText = " + this._theText);
      return this.__get__textDefault();
   }
   function __get__textDefault()
   {
      return this._theText;
   }
   function __set__restrictDefault(theValue)
   {
      this.debug("1 restrictDefault :    this._name = " + this._name + "  theValue = " + theValue);
      this._restrict = theValue;
      this.debug("2 restrictDefault :    this._name = " + this._name + "  theValue = " + theValue);
      return this.__get__restrictDefault();
   }
   function __get__restrictDefault()
   {
      return this._restrict;
   }
   function __set__maxCharacters(theValue)
   {
      this._maxCharacters = theValue;
      return this.__get__maxCharacters();
   }
   function __get__maxCharacters()
   {
      return this._maxCharacters;
   }
   function __set__Border(sBorder)
   {
      this.debug("set Border: " + sBorder);
      this._border = sBorder;
      this.processBorder();
      return this.__get__Border();
   }
   function __get__Border()
   {
      return this._border;
   }
   function __set__IgnoreSpaces(userIgnoreSpaces)
   {
      this.theIgnoreSpaces = userIgnoreSpaces;
      return this.__get__IgnoreSpaces();
   }
   function __get__IgnoreSpaces()
   {
      return this.theIgnoreSpaces;
   }
   function __set__IgnoreCase(userIgnoreCase)
   {
      this.theIgnoreCase = userIgnoreCase;
      return this.__get__IgnoreCase();
   }
   function __get__IgnoreCase()
   {
      return this.theIgnoreCase;
   }
   function __set__ConvertLogicSymbols(userConvertLogicSymbols)
   {
      this.theConvertLogicSymbols = userConvertLogicSymbols;
      return this.__get__ConvertLogicSymbols();
   }
   function __get__ConvertLogicSymbols()
   {
      return this.theConvertLogicSymbols;
   }
   function __set__LastCaretIndex(userLastCaretIndex)
   {
      this.theLastCaretIndex = userLastCaretIndex;
      return this.__get__LastCaretIndex();
   }
   function __get__LastCaretIndex()
   {
      return this.theLastCaretIndex;
   }
   function __set__showHTML(ishtml)
   {
      this.hasHTML = ishtml;
      this.textbox.__set__html(this.hasHTML);
      this.textbox.redraw();
      this.debug("set showHTML: " + this.textbox.__get__html());
      return this.__get__showHTML();
   }
   function __get__showHTML()
   {
      return this.hasHTML;
   }
   function __set__returnKey(userReturnKey)
   {
      this.theReturnKey = userReturnKey;
      return this.__get__returnKey();
   }
   function __get__returnKey()
   {
      return this.theReturnKey;
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
   function __set__sgFontFace(sFontFace)
   {
      this.textbox.setStyle("fontFamily",sFontFace);
      this._fontFace = sFontFace;
      return this.__get__sgFontFace();
   }
   function __get__sgFontFace()
   {
      return this._fontFace;
   }
   function __set__sgFontSize(sFontSize)
   {
      this.textbox.setStyle("fontSize",sFontSize);
      this._fontSize = sFontSize;
      return this.__get__sgFontSize();
   }
   function __get__sgFontSize()
   {
      return this._fontSize;
   }
   function __set__sgFontWeight(sFontSize)
   {
      this.textbox.setStyle("fontWeight",sFontSize);
      this._fontWeight = sFontSize;
      return this.__get__sgFontWeight();
   }
   function __get__sgFontWeight()
   {
      return this._fontWeight;
   }
   function __set__sgTextAlign(sTextAlign)
   {
      this.textbox.setStyle("textAlign",sTextAlign);
      this._textAlign = sTextAlign;
      return this.__get__sgTextAlign();
   }
   function __get__sgTextAlign()
   {
      return this._textAlign;
   }
   function __set__ShowScrolbar(a_val)
   {
      this.sgScrolling = a_val;
      return this.__get__ShowScrolbar();
   }
   function __get__ShowScrolbar()
   {
      return this.sgScrolling;
   }
   function __set__sgBackgroundColor(theValue)
   {
      if(theValue == 0)
      {
         theValue = 16777215;
      }
      this._nBackgroundColor = theValue;
      this.textbox.setStyle("backgroundColor",theValue);
      this.debug("backgroundColor: " + theValue + "(html: " + this.textbox.__get__html() + ")");
      return this.__get__sgBackgroundColor();
   }
   function __get__sgBackgroundColor()
   {
      return this._nBackgroundColor;
   }
   function __set__sgDisabledBackgroundColor(theValue)
   {
      this._nDisabledBackgroundColor = theValue;
      this.textbox.setStyle("backgroundColor",theValue);
      return this.__get__sgDisabledBackgroundColor();
   }
   function __get__sgDisabledBackgroundColor()
   {
      return this._nDisabledBackgroundColor;
   }
   function __set__sgTextColor(theValue)
   {
      this._nTextColor = theValue;
      this.textbox.setStyle("color",theValue);
      return this.__get__sgTextColor();
   }
   function __get__sgTextColor()
   {
      return this._nTextColor;
   }
   function __set__sgDisabledTextColor(theValue)
   {
      this._nDisabledTextColor = theValue;
      this.textbox.setStyle("disabledColor",theValue);
      return this.__get__sgDisabledTextColor();
   }
   function __get__sgDisabledTextColor()
   {
      return this._nDisabledTextColor;
   }
   function __set__sgUnenteredTextColor(theValue)
   {
      this._nUnenteredTextColor = theValue;
      return this.__get__sgUnenteredTextColor();
   }
   function __get__sgUnenteredTextColor()
   {
      return this._nUnenteredTextColor;
   }
   function __set__ShowFeedbackforWidget(theValue)
   {
      this._showFeedbackforWidget = theValue;
      return this.__get__ShowFeedbackforWidget();
   }
   function __get__ShowFeedbackforWidget()
   {
      return this._showFeedbackforWidget;
   }
   function __set__TutorThisWidget(theValue)
   {
      this._tutorThisWidget = theValue;
      return this.__get__TutorThisWidget();
   }
   function __get__TutorThisWidget()
   {
      return this._tutorThisWidget;
   }
   function __set__SendInterfDescMessages(sendStatus)
   {
      this._sendInterfDescMessages = sendStatus;
      return this.__get__SendInterfDescMessages();
   }
   function __get__SendInterfDescMessages()
   {
      return this._sendInterfDescMessages;
   }
   function __set__AllowEditing(a_val)
   {
      this.allowedit = a_val;
      if(this.allowedit == false)
      {
         this.debug("The user has set the component to disallow editing, permanently locking this component ...");
         this.lock();
      }
      return this.__get__AllowEditing();
   }
   function __get__AllowEditing()
   {
      return this.allowedit;
   }
   function setTextHasChanged(bStatus)
   {
      this._textHasChanged = bStatus;
   }
   function getTextHasChanged()
   {
      return this._textHasChanged;
   }
   function setTextChangedColor(bStatus)
   {
      if(bStatus == true)
      {
         this.textbox.setStyle("color",this.__get__sgUnenteredTextColor());
      }
      else
      {
         this.textbox.setStyle("color",this.__get__sgTextColor());
      }
   }
   function setCorrectText(theText)
   {
      this._correctText = theText;
   }
   function getCorrectText()
   {
      return this._correctText;
   }
   function setSendInterfDescMessages(sendStatus)
   {
      this._sendInterfDescMessages = sendStatus;
   }
   function getSendInterfDescMessages()
   {
      return this._sendInterfDescMessages;
   }
   function setCurrentlyHighlighted(bStatus)
   {
      this.currentlyHighlighted = bStatus;
   }
   function getCurrentlyHighlighted()
   {
      return this.currentlyHighlighted;
   }
   function __set__tabIndex(theValue)
   {
      this.debug("Setting tab index to: " + theValue);
      this.sgTabIndex = theValue;
      return this.__get__tabIndex();
   }
   function __get__tabIndex()
   {
      return this.sgTabIndex;
   }
}
