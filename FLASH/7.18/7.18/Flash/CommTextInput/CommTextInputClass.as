class CommTextInput.CommTextInputClass extends mx.controls.TextInput
{
   static var symbolName = "CommTextInput";
   static var symbolOwner = CommTextInput.CommTextInputClass;
   var className = "CommTextInputClass";
   static var version = "2.8";
   var publicVersion = "2.8";
   var _showFeedbackforWidget = true;
   var _tutorThisWidget = true;
   var commType = "textInput";
   var shell = "";
   var _textHasChanged = false;
   var _nBackgroundColor = 16777215;
   var _nUnenteredTextColor = 0;
   var currentlyHighlighted = false;
   var locked = false;
   var blocked = false;
   var enterActivated = false;
   var focused = false;
   var sgTabIndex = 5000;
   var bgEditable = true;
   function CommTextInputClass()
   {
      super();
   }
   function init()
   {
      this.debug("init ()");
      super.init();
      mx.events.EventDispatcher.initialize(this);
      pact.datastructures.SingletonList.getInstance().insert(this);
      this.dimensions = new edu.cmu.hcii.ctat.CTATRect();
      this.theLastCaretIndex = 1;
      this.startSocketandNewProblem();
      this.commType = "textInput";
      if(this.theConvertLogicSymbols)
      {
         this.setStyle("fontFamily","Lucida Sans Unicode");
      }
      this.setStyle("borderStyle","none");
      var _loc3_ = new Object();
      _loc3_.onMouseDown = mx.utils.Delegate.create(this,this.handleMouseInput);
      Mouse.addListener(_loc3_);
   }
   function getCommType()
   {
      return this.commType;
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
   function debug(a_string)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug(this.classType(),a_string);
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.setupEventHandlers();
      this.assignInitialStyles();
      if(this.bgEditable == false)
      {
         this.debug("This component has been set to not allow editing ...");
         if(this.textbox == undefined || this.textbox == null)
         {
            this.debug("Internal error: child textbox does not exist yet");
         }
         else
         {
            this.__set__editable(false);
            this.textbox.__set__editable(false);
         }
      }
      else
      {
         this.debug("This component can be edited, bypassing code ...");
      }
      this.size();
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
      this.textbox.addEventListener("change",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onChangeHandler));
      this.textbox.addEventListener("focusIn",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onFocusIn));
      this.textbox.addEventListener("focusOut",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onFocusOut));
   }
   function removeEventHandlers()
   {
      this.debug("removeEventHandlers ()");
      this.textbox.removeEventListener("change");
      this.textbox.removeEventListener("focusIn");
      this.textbox.removeEventListener("focusOut");
   }
   function size()
   {
      this.debug("size ()");
   }
   function draw()
   {
      this.debug("draw (" + this.__get__width() + "," + this.__get__height() + ")");
      var _loc2_ = this.__get__width();
      var _loc3_ = this.__get__height();
      this.textbox.setSize(_loc2_,_loc3_);
   }
   function assignBorderStyle()
   {
      if(this._border == "hide")
      {
         this.debug("Hiding border ...");
         this.textbox.setStyle("borderStyle","none");
      }
      else
      {
         this.debug("Setting border style ...");
         this.textbox.setStyle("borderStyle","inset");
      }
   }
   function assignInitialStyles()
   {
      this.debug("assignInitialStyles ()");
      this.setStyle("disabledColor",this._nDisabledTextColor);
      this.textbox.setStyle("fontSize",this.__get__sgFontSize());
      this.textbox.setStyle("fontFamily",this.__get__sgFontFace());
      this.textbox.setStyle("fontWeight",this.__get__sgFontWeight());
      this.textbox.setStyle("textAlign",this.__get__sgTextAlign());
      this.textbox.setStyle("backgroundColor",this.__get__sgBackgroundColor());
      this.textbox.setStyle("color",this.__get__sgTextColor());
      this.textbox.setStyle("disabledColor",this.__get__sgDisabledTextColor());
      this.assignBorderStyle();
   }
   function startSocketandNewProblem()
   {
      this.debug("startSocketandNewProblem ()");
      if(_global.isLivePreview != true && (_global.theShell.BehaviorRecorder == "AuthorTime" || _level0.BehaviorRecorderMode == "AuthorTime"))
      {
         _global.theShell.addEventListener("onSocketConnect",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.actOnSocketConnection));
         _global.theShell.addEventListener("onNewProblem",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.actOnNewProblem));
         _global.theShell.addEventListener("onStartStateCreated",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.actOnStartStateCreated));
      }
   }
   function actOnSocketConnection()
   {
      this.debug("actOnSocketConnection ()");
      this.debug("socketListener : Complete :");
   }
   function actOnNewProblem()
   {
      this.debug("actOnNewProblem ()");
      if(this.getSendInterfDescMessages() == true)
      {
         this.debug("Sending interface description messages ...");
         this.sendJessInterfaceDescription();
      }
      else
      {
         this.debug("Component has been blocked from sending interface description messages");
      }
   }
   function actOnStartStateCreated()
   {
      this.debug("actOnStartStateCreated ()");
      this.debug("startStateCreatedListener : Demonstrating :  Graph menu, Create Start State");
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
      var _loc5_ = "commTextInput";
      var _loc3_ = this._name;
      var _loc4_ = "textInput";
      var _loc6_ = this.buildJessInterfaceDescription(_loc3_,_loc5_,_loc4_);
      _global.theShell.sendInterfaceDescription(_loc6_);
   }
   function buildJessInterfaceDescription(componentName, componentType, defTemplateType)
   {
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
      this.debug("buildJessInterfaceDescription  :  Text Input : the Full Message = " + _loc2_);
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
      this.debug("1 this.textbox.text = " + this.textbox.__get__text() + "  getCorrectText() = " + this.getCorrectText() + "  getIsCorrect() = " + this.getIsCorrect());
      this.setTextHasChanged(true);
      this.setTextChangedColor(true);
      if(this.getIsCorrect() == true && _global.theShell.LockTheWidget == true)
      {
         this.textbox.__set__text(this.getCorrectText());
         this.debug("onChangeHandler : 2 : this = " + this + "  textbox.text = " + this.textbox.__get__text() + "  getCorrectText() = " + this.getCorrectText() + "  getIsCorrect() = " + this.getIsCorrect());
      }
      this.dispatchEvent({type:"textchange",target:this});
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
         var _loc3_ = edu.cmu.hcii.ctat.CTATUtil.removeLevel(String(this));
         this.debug("clickInsideThisComponent : 1 hitTest is true for " + this + " call setLastClickedComponent : sComponent = " + _loc3_);
         _global.theShell.setLastClickedComponent(_loc3_);
         return undefined;
      }
   }
   function onFocusIn()
   {
      this.debug("onFocusIn (" + this._name + ")");
      this.dispatchFocusIn();
      _global.theShell.manageBackgrading(this);
   }
   function onFocusOut()
   {
      this.debug("onFocusOut (" + this._name + ")");
      this.dispatchFocusOut();
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
   function gradeMe2(messageName, messageText)
   {
      this.debug("CommTextInput : gradeMe2 : ");
      var _loc5_ = String(this);
      var _loc6_ = "UpdateTextField";
      var _loc3_ = this.getText();
      var _loc4_ = true;
      _global.theShell.tutorComponentData(this,this.getCommType(),this,"UpdateRadioButton",_loc3_,_loc4_,this.__get__ShowFeedbackforWidget(),messageName,messageText);
   }
   function select()
   {
      this.debug("select ()");
   }
   function setText(newValue)
   {
      this.debug("setText ()");
      this.textbox.__set__text(newValue);
   }
   function getText()
   {
      return this.textbox.__get__text();
   }
   function getForegroundColor()
   {
      return this.textbox.getStyle("color");
   }
   function setForegroundColor(theValue)
   {
      this.textbox.setStyle("color",theValue);
   }
   function isHighlighted()
   {
      return this.getCurrentlyHighlighted();
   }
   function handleKeyInput()
   {
   }
   function recieveEnterKey()
   {
      this.debug("recieveEnterKey ()");
      this.enterActivated = true;
      this.gradeTextField(this);
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
      this.unblock();
      this.textbox.__set__text("");
      this.assignInitialStyles();
      this.showNull();
      this.dispatchAndCallGradeNull();
      this.dispatchEvent({type:"onResetComponent",target:this});
   }
   function setStartState(theSelection, theAction, theInput, theTransaction_id)
   {
      this.debug("setStartState ()");
      this.dispatchEvent({type:"onSetStartState",target:this});
   }
   function setStartStateCompletedFlag()
   {
      this.debug("setStartStateCompletedFlag ()");
      this.lock();
      this.dispatchEvent({type:"onSetStartStateCompletedFlag",target:this});
   }
   function setResults(gradeStatus, theSelection, theAction, theInput, theEvaluation, lockAnswer)
   {
      this.debug("setResults (): gradeStatus = " + gradeStatus + " this = " + this + " theSelection = " + theSelection + " theAction = " + theAction + " theInput = " + theInput + " theEvaluation = " + theEvaluation + " ShowFeedbackforWidget = " + this.__get__ShowFeedbackforWidget());
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
         else
         {
            this.debug("CommTextInput : setResults : ShowFeedbackforWidget seems undefined : ShowFeedbackforWidget = " + this.__get__ShowFeedbackforWidget());
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
      this.dispatchEvent({type:"showNull",target:this});
      this.callPostGradeFunction(this.__get__callThisMethodonNull());
   }
   function showCorrect()
   {
      this.debug("showCorrect : this = " + this);
      this.textbox.setStyle("color",_global.theShell.correctColor);
      this.textbox.setStyle("disabledColor",_global.theShell.correctColor);
      this.setIsCorrect(true);
      this.setTextHasChanged(false);
      this.setCorrectText(this.textbox.__get__text());
   }
   function dispatchAndCallGradeCorrectTEMP()
   {
      this.dispatchEvent({type:"showCorrect",target:this});
      this.callPostGradeFunction(this.__get__callThisMethodonCorrect());
   }
   function callPostGradeFunction(sPostGradeFunctionName)
   {
      var myNavFunction = eval("_level0." + sPostGradeFunctionName);
      myNavFunction(this);
   }
   function showIncorrect()
   {
      this.debug("showIncorrect : this = " + this);
      this.textbox.setStyle("color",_global.theShell.incorrectColor);
      this.textbox.setStyle("disabledColor",_global.theShell.incorrectColor);
      this.setIsCorrect(false);
      this.setTextHasChanged(false);
   }
   function dispatchAndCallGradeIncorrectTEMP()
   {
      this.dispatchEvent({type:"showIncorrectButton",target:this});
      this.callPostGradeFunction(this.__get__callThisMethodonInCorrect());
   }
   function showNull()
   {
      this.debug("showNull : this = " + this);
      this.textbox.setStyle("color",this.__get__sgTextColor());
      this.setIsCorrect(null);
      this.setTextHasChanged(false);
   }
   function dispatchAndCallGradeNullTEMP()
   {
      this.dispatchEvent({type:"showNull",target:this});
      this.callPostGradeFunction(this.__get__callThisMethodonNull());
   }
   function gradeMe()
   {
   }
   function lock()
   {
      this.debug("lock ()");
      this.textbox.setStyle("backgroundColor",this._nDisabledBackgroundColor);
      this.enabled = false;
      this.textbox.enabled = false;
      this.locked = true;
   }
   function unlock()
   {
      this.debug("unlock ()");
      this.textbox.setStyle("backgroundColor",this.__get__sgBackgroundColor());
      this.enabled = true;
      this.textbox.enabled = true;
      this.locked = false;
   }
   function getLockStatus()
   {
      return this.locked;
   }
   function block()
   {
      this.debug("block ()");
      if(this.locked == true)
      {
         this.debug("Component is locked, aborting blocking");
         return undefined;
      }
      this.textbox.setStyle("backgroundColor",this._nDisabledBackgroundColor);
      this.enabled = false;
      this.textbox.enabled = false;
      this.blocked = true;
   }
   function unblock()
   {
      this.debug("unblock ()");
      if(this.locked == true)
      {
         this.debug("Component is locked, aborting unblocking");
         return undefined;
      }
      if(this.bgEditable == false)
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
      this.debug("setIsCorrect : this = " + this + "  state = " + correctState);
      this.isCorrect = correctState;
   }
   function highlight()
   {
      this.setBackgroundColor(_global.theShell.HintColor);
      this.setCurrentlyHighlighted(true);
   }
   function unHighlight()
   {
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
   function parseToUnicode(str)
   {
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
      var _loc6_ = 0;
      while(_loc6_ < str.length)
      {
         var _loc4_ = str.indexOf(sSearch,_loc6_);
         if(_loc4_ == -1)
         {
            break;
         }
         var _loc5_ = str.substr(0,_loc4_);
         var _loc7_ = str.substr(_loc4_ + sSearch.length,str.length);
         str = _loc5_ + sReplace + _loc7_;
         _loc6_ = _loc5_.length + sReplace.length;
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
   function onLoad()
   {
      this.debug("3 TextInput : onLoad : textDefault = " + this.__get__textDefault() + "  textbox.text  " + this.textbox.__get__text());
      if(this.__get__textDefault() != undefined)
      {
         this.textbox.__set__text(this.textDefault);
      }
      this.debug("4 TextInput : onLoad : textDefault = " + this.__get__textDefault() + "  textbox.text  " + this.textbox.__get__text());
      this.debug("3 TextInput : onLoad : textDefault =   textbox.text  " + this.textbox.__get__text());
      if(this.__get__restrictDefault() != undefined)
      {
         this.textbox.__set__restrict(this.restrictDefault);
      }
      this.debug("4 TextInput : onLoad : textDefault =   textbox.restrict  " + this.textbox.__get__restrict());
      if(this.__get__maxCharacters() != undefined)
      {
         this.textbox.__set__maxChars(this.maxCharacters);
      }
   }
   function __set__textDefault(theValue)
   {
      this._theText = theValue;
      this.textbox.__set__text(theValue);
      this.textbox.redraw();
      return this.__get__textDefault();
   }
   function __get__textDefault()
   {
      return this._theText;
   }
   function __set__restrictDefault(theValue)
   {
      this._restrict = theValue;
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
   function __set__border(sBorder)
   {
      this._border = sBorder;
      return this.__get__border();
   }
   function __get__border()
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
   function __set__sgBackgroundColor(theValue)
   {
      if(theValue == 0)
      {
         theValue = 16777215;
      }
      this.textbox.setStyle("backgroundColor",theValue);
      this._nBackgroundColor = theValue;
      return this.__get__sgBackgroundColor();
   }
   function __get__sgBackgroundColor()
   {
      return this._nBackgroundColor;
   }
   function __set__sgDisabledBackgroundColor(theValue)
   {
      this._nDisabledBackgroundColor = theValue;
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
      this.debug("setTextChangedColor (" + bStatus + ")");
      if(this._nUnenteredTextColor == undefined)
      {
         this.debug("Attribute _nUnenteredTextColor is undefined! resetting to 0x000000");
         this._nUnenteredTextColor = 0;
      }
      if(bStatus == true)
      {
         this.debug("Setting text color to unentered: " + this._nUnenteredTextColor);
         this.textbox.setStyle("color",this._nUnenteredTextColor);
      }
      else
      {
         this.debug("Setting text color to current: " + this.__get__sgTextColor());
         this.textbox.setStyle("color",this.__get__sgTextColor());
      }
   }
   function setCorrectText(theText)
   {
      this.debug("TextInput : setCorrectText : theText = " + theText);
      this._correctText = theText;
   }
   function getCorrectText()
   {
      this.debug("getCorrectText(" + this._correctText + ")");
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
   function __set__Editable(a_val)
   {
      this.debug("Setting the editable flag to: " + a_val);
      if(this.textbox == undefined)
      {
         this.debug("Expected error: the sub textbox is undefined");
      }
      this.bgEditable = a_val;
      return this.__get__Editable();
   }
   function __get__Editable()
   {
      return this.bgEditable;
   }
}
