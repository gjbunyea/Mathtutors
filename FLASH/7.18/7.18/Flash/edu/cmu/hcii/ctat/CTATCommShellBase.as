class edu.cmu.hcii.ctat.CTATCommShellBase extends edu.cmu.hcii.ctat.CTATCommShellRuntime
{
   static var symbolName = "CTATCommShellBase";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATCommShellBase);
   var className = "CTATCommShellBase";
   var ParentClassName = "CTATCommShellRuntime";
   var bgUseHourGlass = true;
   function CTATCommShellBase()
   {
      super();
   }
   function init()
   {
      super.init();
      this.setClassType("CTATCommShellBase");
      this.debug("init ()");
      this.studentSteps = new Array();
      this.skillSet = new edu.cmu.hcii.ctat.CTATSkillSet();
      this.skillSet.fromXML(_level0.skills);
      this.debug("init finished");
   }
   function externalSkillUpdate(a_string)
   {
      this.debug("externalSkillUpdate ()");
      if(this.skillSet == null)
      {
         this.skillSet = new edu.cmu.hcii.ctat.CTATSkillSet();
      }
      this.skillSet.fromXML(a_string);
   }
   function draw()
   {
      super.draw();
      this.debug("draw ()");
   }
   function size()
   {
      super.size();
      this.debug("size ()");
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.dummycontainer = _root.createEmptyMovieClip("t10",this.getNextHighestDepth());
      if(this.dummycontainer == undefined)
      {
         this.debug("Error: the dummycontainer is undefined");
         return undefined;
      }
      if(this.dummycontainer == null)
      {
         this.debug("Error: the dummycontainer is null");
         return undefined;
      }
      this.blocker = this.dummycontainer.attachMovie("Hourglass","t9",this.getNextHighestDepth() + 2);
      if(this.blocker == undefined)
      {
         this.debug("Error: the blocker indicator is undefined");
      }
      if(this.blocker == null)
      {
         this.debug("Error: the blocker indicator is null");
      }
      if(this.blocker != null && this.dummycontainer != null)
      {
         this.debug("We have a blocker!!");
         this.blocker._visible = false;
      }
      this.waitclip = new edu.cmu.hcii.ctat.CTATWaitClip();
      this.waitclip.internalInit(25,25);
      this.waitclip._x = 0;
      this.waitclip._y = 0;
      this.waitclip._width = 25;
      this.waitclip._height = 25;
      this.waitclip._visible = false;
      this.waitclip.swapDepths(this.getNextHighestDepth());
      this.indicator = new edu.cmu.hcii.ctat.CTATIndicator();
      this.indicator.hide();
   }
   function setSkillBar(a_bar)
   {
      this.debug("setSkillBar ()");
      this.ctat_skill_bar = a_bar;
      if(this.ctat_skill_bar != null)
      {
         this.ctat_skill_bar.setSkillSet(this.skillSet);
      }
   }
   function refreshSkillBar()
   {
      this.debug("refreshSkillBar ()");
      if(this.ctat_skill_bar != null)
      {
         this.ctat_skill_bar.setSkillSet(this.skillSet);
      }
   }
   function updateSkill(a_label, a_level, a_mastery)
   {
      this.debug("updateSkill (" + a_label + "," + a_level + "," + a_mastery + ")");
      var _loc3_ = Number(a_level);
      var _loc2_ = Number(a_mastery);
      if(_loc2_ == 0)
      {
         _loc2_ = 0.95;
      }
      this.skillSet.setSkillLevel(a_label,_loc3_,_loc2_);
      this.ctat_skill_bar.setSkillSet(this.skillSet);
   }
   function getSkillLevel(a_name)
   {
      this.debug("getSkillLevel (" + a_name + ")");
      return this.skillSet.getSkillLevel(a_name);
   }
   function initBehaviorRecorderMode()
   {
      this.debug("initBehaviorRecorderMode ()");
      if(this.__get__BehaviorRecorder() == "AuthorTimeTutoring")
      {
         this.authorTimeTutoringInit();
      }
      if(this.__get__BehaviorRecorder() == "AuthorTime")
      {
         this.authorTimeInit();
      }
      if(this.__get__BehaviorRecorder() == "RunTime")
      {
         this.debug("RUNTIME OH NO");
      }
   }
   function authorTimeTutoringInit()
   {
      this.debug("authorTimeTutoringInit()");
   }
   function setInterfaceIdentifcationGUID(assignedGUID)
   {
      this.debug("setInterfaceIdentifcationGUID ()");
      if(assignedGUID != null && assignedGUID != undefined)
      {
         this.debug("assignedGUID is set by the author, using this as interface ID");
         this._InterfaceIdentificationGUID = assignedGUID;
      }
      else
      {
         this.debug("assignedGUID is not set by the author, generating ...");
         if(_level0.session_id != null && _level0.session_id != undefined)
         {
            this.debug("We have a session id in the flashvars, using that as interface ID ...");
            this._InterfaceIdentificationGUID = _level0.session_id;
         }
         else
         {
            this.debug("We do not have a session id in the flashvars, generating GUID ...");
            this._InterfaceIdentificationGUID = edu.cmu.hcii.ctat.CTATGuid.create();
         }
      }
      if(this._InterfaceIdentificationGUID == undefined)
      {
         var _loc3_ = new Date();
         this._InterfaceIdentificationGUID = String(_loc3_.valueOf());
      }
   }
   function loadLoggingLibrary()
   {
      this.debug("loadLoggingLibrary () : CommShellBase : base class");
   }
   function setLoggingSourceAndDestination()
   {
      this.debug("setLoggingSourceAndDestination () : CommShellBase : base class");
   }
   function setBehaviorRecorderMode()
   {
      this.debug("setBehaviorRecorderMode ()");
      if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(_level0.BehaviorRecorderMode,"AuthorTimeTutoring") == true)
      {
         this.__set__BehaviorRecorder("AuthorTimeTutoring");
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(_level0.BehaviorRecorderMode,"AuthorTime") == true)
      {
         this.__set__BehaviorRecorder("AuthorTime");
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(_level0.BehaviorRecorderMode,"RunTime") == true)
      {
         this.debug("RUNTIME OH NO");
         this.__set__BehaviorRecorder("RunTime");
      }
      this.debug("CommShellBase : setBehaviorRecorderMode :  _level0.BehaviorRecorderMode = " + _level0.BehaviorRecorderMode + " BehaviorRecorder = " + this.__get__BehaviorRecorder() + " _global.theShell.BehaviorRecorder = " + _global.theShell.BehaviorRecorder);
      this.debug("Firing start event ...");
      this.dispatchEvent({type:"onSetBehaviorRecorderMode",target:this});
   }
   function setShellStatus()
   {
      this.__set__brdFinishedParsing(true);
   }
   function assignUI()
   {
      this.feedback_window_orientation = "down";
   }
   function authorTimeInit()
   {
      this.debug("authorTimeInit () : base class");
   }
   function sendInterfaceDescription(theInterfactDescripton)
   {
      this.debug("sendInterfaceDescription () : message = " + theInterfactDescripton);
      this.sendXML(theInterfactDescripton);
      return true;
   }
   function showHideHint()
   {
      this.debug("showHideHint ()");
      this.debug("ShowHintButton: " + this.ShowHintButton);
      this.debug("suppressStudentFeedback: " + this.suppressStudentFeedback);
      if(this.alternativeHintButton != null && this.alternativeHintButton != undefined)
      {
         this.debug("Processing showHideHint for alternative Hint Button ");
         if(this.ShowHintButton == false)
         {
            this.alternativeHintButton._visible = false;
         }
         else if(this.suppressStudentFeedback == true || this.tutorTheStudent == "false")
         {
            this.debug("We\'re operating in suppressed feedback mode, hiding alternative hint button");
            this.alternativeHintButton._visible = false;
         }
         else
         {
            this.debug("We\'re operating in normal tutoring mode, showing alternative hint button");
            this.alternativeHintButton._visible = true;
         }
      }
      else if(this.ShowHintButton == false)
      {
         this.hint_button._visible = false;
      }
      else if(this.suppressStudentFeedback == true || this.tutorTheStudent == "false")
      {
         this.debug("We\'re operating in suppressed feedback mode, hiding hint button");
         this.hint_button._visible = false;
      }
      else
      {
         this.debug("We\'re operating in normal tutoring mode, showing hint button");
         this.hint_button._visible = true;
      }
   }
   function handleKeyInput()
   {
      this.debug("handleKeyInput ()");
      if(this.disableInput == true)
      {
         this.debug("The shell\'s input processing has been disabled by a component");
         return undefined;
      }
      if(Key.getCode() == 13)
      {
         this.debug("Focus manager is currently returning: " + this.getCurrentTabFocus()._name);
         var _loc2_ = edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getCurrentTabFocus());
         if(_loc2_.commType == "textArea")
         {
            if(_loc2_.theReturnKey == "Carriage Return")
            {
               this.debug("The user has indicated that the textarea should not grade on enter");
               return undefined;
            }
         }
         if(_loc2_ == null || _loc2_ == undefined)
         {
            this.debug("The focused widget is null or undefined");
            return undefined;
         }
         this.debug("The focused widget is not null or undefined, handling Enter Key for: " + _loc2_.commType + ", with name: " + _loc2_._name);
         if(_loc2_.label == "Check")
         {
            _loc2_ = _loc2_._parent;
         }
         this.debug("About to send receiveEnterKey");
         if(_loc2_.commType == "textInput" || _loc2_.commType == "textArea")
         {
            this.determineFindNewFocus(_loc2_);
         }
      }
      if(Key.getCode() == 9)
      {
         this.debug("Processing Tab, removing focus from: " + this.getCurrentTabFocus()._name);
         this.determineFindNewFocus(this.getCurrentTabFocus());
      }
   }
   function setMouseListener()
   {
      this.debug("setMouseListener : base class");
   }
   function checkme(rawWidget)
   {
      this.debug("checkme (" + edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(rawWidget).commType + ")");
      edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(rawWidget).unHighlight();
      this.indicateActivity();
      this.actionType = [];
      var _loc15_ = edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(rawWidget).commType;
      var _loc3_ = rawWidget;
      var _loc4_ = undefined;
      var _loc6_ = undefined;
      var _loc7_ = undefined;
      var _loc5_ = undefined;
      var _loc9_ = undefined;
      var _loc8_ = undefined;
      if(_loc3_.getLockStatus() == true)
      {
         this.debug("Component has already been graded, aborting ...");
         return undefined;
      }
      if(_loc3_.commType == "textInput")
      {
         _loc4_ = edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(_loc3_);
         _loc4_.setTextChangedColor(false);
         _loc6_ = String(_loc4_);
         _loc7_ = "UpdateTextField";
         _loc5_ = edu.cmu.hcii.ctat.CTATUtil.getTextBoxInstance(_loc3_).text;
         _loc9_ = edu.cmu.hcii.ctat.CTATUtil.checkBooleanValid(_loc4_.TutorThisWidget) != true?true:_loc4_.TutorThisWidget;
         _loc8_ = edu.cmu.hcii.ctat.CTATUtil.checkBooleanValid(_loc4_.ShowFeedbackforWidget) != true?true:_loc4_.ShowFeedbackforWidget;
      }
      else if(_loc3_.commType == "textArea")
      {
         this.debug("checkme : Inside textArea stuff - widget : " + _loc3_);
         _loc4_ = edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(_loc3_);
         _loc4_.setTextChangedColor(false);
         _loc6_ = String(_loc4_);
         _loc7_ = "UpdateTextArea";
         _loc5_ = edu.cmu.hcii.ctat.CTATUtil.getTextBoxInstance(_loc3_).text;
         _loc9_ = edu.cmu.hcii.ctat.CTATUtil.checkBooleanValid(_loc4_.TutorThisWidget) != true?true:_loc4_.TutorThisWidget;
         _loc8_ = edu.cmu.hcii.ctat.CTATUtil.checkBooleanValid(_loc4_.ShowFeedbackforWidget) != true?true:_loc4_.ShowFeedbackforWidget;
      }
      else if(_loc3_.commType == "checkBox")
      {
         _loc4_ = _loc3_;
         _loc6_ = String(_loc3_);
         _loc7_ = "UpdateCheckBox";
         _loc5_ = _loc3_.label + ": " + _loc3_.selected;
         _loc9_ = true;
         _loc8_ = true;
      }
      else if(_loc3_.commType == "radioButton")
      {
         _loc4_ = _loc3_;
         _loc6_ = _loc3_.getGroupName();
         _loc7_ = "UpdateRadioButton";
         _loc5_ = String(_loc3_) + ": " + _loc3_.label;
         _loc9_ = edu.cmu.hcii.ctat.CTATUtil.checkBooleanValid(_loc4_.TutorThisWidget) != true?true:_loc4_.TutorThisWidget;
         _loc8_ = edu.cmu.hcii.ctat.CTATUtil.checkBooleanValid(_loc4_.ShowFeedbackforWidget) != true?true:_loc4_.ShowFeedbackforWidget;
      }
      else if(_loc3_.commType == "comboBox")
      {
         this.debug("Creating combobox message with input: " + _loc3_.selectedItem.label);
         _loc4_ = _loc3_;
         _loc6_ = String(_loc3_);
         _loc7_ = "UpdateComboBox";
         _loc5_ = _loc3_.selectedItem.label;
         _loc9_ = true;
         _loc8_ = true;
         this.debug("Safety check on selection: " + _loc6_ + " and input \"" + _loc5_ + "\"");
      }
      else if(_loc3_.commType == "doneButton")
      {
         _loc4_ = _loc3_;
         _loc6_ = "done";
         _loc7_ = "ButtonPressed";
         _loc5_ = "-1";
         _global.theShell.clientLogger.doneButtonTimeStamp();
         _loc9_ = edu.cmu.hcii.ctat.CTATUtil.checkBooleanValid(_loc4_.TutorThisWidget) != true?true:_loc4_.TutorThisWidget;
         _loc8_ = edu.cmu.hcii.ctat.CTATUtil.checkBooleanValid(_loc4_.ShowFeedbackforWidget) != true?true:_loc4_.ShowFeedbackforWidget;
         this.debug("Checkme : done : widgetSelection = " + _loc6_ + "  widgetAction =" + _loc7_ + "  widgetInput =" + _loc5_);
      }
      else if(_loc3_.commType == "videoAudioButton")
      {
         _loc4_ = _loc3_;
         _loc6_ = String(_loc3_);
         _loc7_ = "ButtonPressed";
         _loc5_ = _loc3_.getPlayPauseStatus();
         _loc9_ = false;
         _loc8_ = false;
      }
      else if(_loc3_.commType == "SimpleAudioButton")
      {
         _loc4_ = _loc3_;
         _loc6_ = String(_loc3_);
         _loc7_ = "ButtonPressed";
         _loc5_ = _loc3_.getPlayStopStatus();
         _loc9_ = false;
         _loc8_ = false;
      }
      if(_loc3_.commType == "textInput" || _loc3_.commType == "textArea")
      {
         this.debug("checkme : text = " + _loc5_);
         if(_loc5_ == "" || _loc5_.length == 1 && (_loc5_.charCodeAt(0) == 13 || _loc5_.charCodeAt(0) == 10))
         {
            this.debug("checkme : text field : Exception :  value is blank");
            _loc3_.showNull();
            this.closeHintAndFeedbackWindows();
            _loc3_.text = "";
            return undefined;
         }
      }
      if(_loc3_.commType == "comboBox")
      {
         if(_loc5_ == "" || _loc5_ == "select one" || _loc5_ == "Select One" || _loc5_ == "--" || _loc5_ == "---" || _loc5_ == "- - -" || _loc5_ == "-  -  -")
         {
            this.debug("checkme : Combo : Exception :  value is - - - etc. + widgetInput =  " + _loc5_);
            _loc3_.showNull();
            this.closeHintAndFeedbackWindows();
            return undefined;
         }
      }
      this.debug("Checkme : getLockStatus : trueWidget.getLockStatus() = " + _loc4_.getLockStatus());
      if(_loc4_.getLockStatus() == true)
      {
         return undefined;
      }
      if(this.__get__BehaviorRecorder() != "RunTime")
      {
         this.blockWidget(_loc4_);
      }
      else
      {
         this.debug("RUNTIME OH NO");
      }
      this.setLastGradedWidget(_loc4_);
      this.setLastActedOn(_loc4_);
      var _loc11_ = edu.cmu.hcii.ctat.CTATUtil.removeLevel(String(_loc6_));
      var _loc10_ = edu.cmu.hcii.ctat.CTATUtil.removeLevel(String(_loc5_));
      _loc10_ = edu.cmu.hcii.ctat.CTATUtil.removeLeadSpace(String(_loc10_));
      _loc10_ = edu.cmu.hcii.ctat.CTATUtil.removeEndSpace(String(_loc10_));
      var _loc13_ = this.checkShouldGrade(_loc11_,_loc10_);
      if(_loc13_ == false)
      {
         this.debug("The grading engine has decided that we\'ve already graded this component and shouldn\'t do so again.");
         return undefined;
      }
      this.dispatchEvent({type:"beginGrading",target:this,selection:_loc6_,action:_loc7_,input:_loc5_});
      if(this.__get__BehaviorRecorder() == "AuthorTime" || this.__get__BehaviorRecorder() == "AuthorTimeTutoring")
      {
         this.debug("Creating behavior recorder message with selection: " + _loc11_ + " and input " + _loc10_);
         this.authorTimeMessaging(_loc11_,_loc7_,_loc10_,_loc9_,_loc8_,true);
      }
      if(this.__get__BehaviorRecorder() == "RunTime" && this.__get__brdFinishedParsing() == true)
      {
         this.debug("RUNTIME OH NO");
      }
   }
   function checkShouldGrade(sWidgetSelection, sWidgetInput)
   {
      this.debug("checkShouldGrade ()");
      return true;
   }
   function tutorComponentData(widget, commType, widgetSelection, widgetAction, widgetInput, sendToBehaviorRecorder, showFeedbackforWidget, messageName, messageText)
   {
      this.debug("tutorComponentData ()");
      this.debug("widget name is " + widget._name + " BehaviorRecorder = " + this.__get__BehaviorRecorder() + " widgetSelection = " + widgetSelection + " widgetSelection = " + widgetSelection + " widgetAction = " + widgetAction + " widgetInput = " + widgetInput + " sendToBehaviorRecorder = " + sendToBehaviorRecorder + " showFeedbackforWidget = " + showFeedbackforWidget);
      this.actionType = [];
      if(widget.getLockStatus() == true)
      {
         return undefined;
      }
      this.setLastGradedWidget(widget);
      this.setLastActedOn(widget);
      var _loc3_ = edu.cmu.hcii.ctat.CTATUtil.removeLevel(widgetSelection);
      var _loc2_ = edu.cmu.hcii.ctat.CTATUtil.removeLevel(widgetInput);
      _loc2_ = edu.cmu.hcii.ctat.CTATUtil.stripWhiteSpace(String(_loc2_));
      var _loc6_ = this.checkShouldGrade(_loc3_,_loc2_);
      if(_loc6_ == false)
      {
         this.debug("The grading engine has decided that we\'ve already graded this component and shouldn\'t do so again.");
         return undefined;
      }
      if(this.__get__BehaviorRecorder() == "AuthorTime" || this.__get__BehaviorRecorder() == "AuthorTimeTutoring")
      {
         this.authorTimeMessaging(_loc3_,widgetAction,_loc2_,sendToBehaviorRecorder,showFeedbackforWidget,true,messageName,messageText);
      }
      if(this.__get__BehaviorRecorder() == "RunTime" && this.__get__brdFinishedParsing() == true)
      {
         this.debug("RUNTIME OH NO");
      }
   }
   function tutorComponentDataNew(widget, commType, widgetSelection, widgetAction, widgetInput, sendToBehaviorRecorder, showFeedbackforWidget, tutorTheAction, messageName, messageText)
   {
      this.debug("tutorComponentDataNew ()");
      this.debug("widget name is " + widget._name + " BehaviorRecorder = " + this.__get__BehaviorRecorder() + " widgetSelection = " + widgetSelection + " widgetSelection = " + widgetSelection + " widgetAction = " + widgetAction + " widgetInput = " + widgetInput + " sendToBehaviorRecorder = " + sendToBehaviorRecorder + " showFeedbackforWidget = " + showFeedbackforWidget + " tutorTheAction = " + tutorTheAction);
      if(widget.getLockStatus() == true)
      {
         return undefined;
      }
      this.setLastGradedWidget(widget);
      this.setLastActedOn(widget);
      var _loc5_ = edu.cmu.hcii.ctat.CTATUtil.removeLevel(widgetSelection);
      var _loc2_ = edu.cmu.hcii.ctat.CTATUtil.removeLevel(widgetInput);
      _loc2_ = edu.cmu.hcii.ctat.CTATUtil.stripWhiteSpace(String(_loc2_));
      if(this.__get__BehaviorRecorder() == "AuthorTime" || this.__get__BehaviorRecorder() == "AuthorTimeTutoring")
      {
         this.authorTimeMessaging(_loc5_,widgetAction,_loc2_,sendToBehaviorRecorder,showFeedbackforWidget,tutorTheAction,messageName,messageText);
      }
   }
   function authorTimeMessaging(selectionValue, actionValue, inputValue, sendToBehaviorRecorder, showFeedbackforWidget, tutorTheAction, messageName, messageText)
   {
      this.debug("authorTimeMessaging ()");
      var _loc2_ = edu.cmu.hcii.ctat.CTATGuid.create();
      this.debug("authorTimeMessaging : send tool message and send the action to TS :  loggingDefinition = " + this.__get__loggingDefinition());
      if(this.__get__BehaviorRecorder() == "AuthorTimeTutoring" && edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(this.__get__loggingDefinition(),"client"))
      {
         _loc2_ = this.toolLogAttempt(selectionValue,actionValue,inputValue,messageName,messageText);
      }
      this.debug("sendToBehaviorRecorder = " + sendToBehaviorRecorder);
      if(sendToBehaviorRecorder == true)
      {
         this.debug("tutorTheAction = " + tutorTheAction);
         if(tutorTheAction == true)
         {
            var _loc3_ = edu.cmu.hcii.ctat.CTATMessageFormat.makeInteractionMessage(selectionValue,actionValue,inputValue,_loc2_);
            this.debug("xml message: " + _loc3_);
            this.sendXML(_loc3_);
         }
         else
         {
            _loc3_ = edu.cmu.hcii.ctat.CTATMessageFormat.makeUntutoredActionMessage(selectionValue,actionValue,inputValue,_loc2_);
            this.debug("xml message: " + _loc3_);
            this.sendXML(_loc3_);
         }
      }
   }
   function assignRepetitionReadyHandler()
   {
   }
   function setClassTabWidgetArray(arTabWidgetArray)
   {
      this._tabWidgetArray = arTabWidgetArray;
      return undefined;
   }
   function getClassTabWidgetArray()
   {
      return this._tabWidgetArray;
   }
   function showTabOrderArray(an_array)
   {
      this.debug("showTabOrderArray ()");
      var _loc4_ = 0;
      while(_loc4_ < an_array.length)
      {
         var _loc3_ = an_array[_loc4_];
         if(_loc3_.name != undefined)
         {
            var _loc2_ = _loc3_.compRef;
            if(_loc2_.commType == "textInput" || _loc2_.commType == "textArea")
            {
               this.debug("Tab index for text component " + _loc3_.name + " is: " + _loc2_.textbox.tabIndex + " Or in the parent: " + _loc2_.tabIndex);
            }
            else
            {
               this.debug("Tab index for regular component " + _loc3_.name + " is: " + _loc2_.tabIndex);
            }
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function hasTabIndex(an_array)
   {
      this.debug("hasTabIndex ()");
      var _loc5_ = false;
      var _loc3_ = 0;
      while(_loc3_ < an_array.length)
      {
         var _loc4_ = an_array[_loc3_];
         if(_loc4_.name != undefined)
         {
            var _loc2_ = _loc4_.compRef;
            this.debug("Checking: " + _loc2_._name + " with tabIndex: " + _loc2_.tabIndex + "...");
            if(_loc2_.commType == "textInput" || _loc2_.commType == "textArea")
            {
               if(_loc2_.tabIndex != undefined || _loc2_.textbox.tabIndex != undefined)
               {
                  _loc5_ = true;
               }
            }
            else if(_loc2_.tabIndex != undefined)
            {
               _loc5_ = true;
            }
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc5_;
   }
   function findTabIndex(an_index, an_array)
   {
      this.debug("findTabIndex (" + an_index + ")");
      var _loc3_ = 0;
      while(_loc3_ < an_array.length)
      {
         var _loc4_ = an_array[_loc3_];
         if(_loc4_.name != undefined)
         {
            var _loc2_ = _loc4_.compRef;
            if(_loc2_.tabIndex != undefined)
            {
               if(_loc2_.commType == "textInput" || _loc2_.commType == "textArea")
               {
                  if(_loc2_.textbox.tabIndex == an_index)
                  {
                     return _loc2_;
                  }
               }
               else if(_loc2_.tabIndex == an_index)
               {
                  return _loc2_;
               }
            }
         }
         _loc3_ = _loc3_ + 1;
      }
      return null;
   }
   function getNextTabOrder(an_array, an_object)
   {
      this.debug("getNextTabOrder (" + an_object._name + ")");
      if(an_object == undefined || an_object == null)
      {
         this.debug("Starting object is null or undefined!");
         var _loc4_ = an_array[0];
         if(_loc4_.name != undefined)
         {
            return this.shellTools.getInstanceFromNamespace(an_array[0].name);
         }
         return null;
      }
      var _loc2_ = 0;
      while(_loc2_ < an_array.length)
      {
         _loc4_ = an_array[_loc2_];
         if(_loc4_.name != undefined)
         {
            var _loc5_ = _loc4_.compRef;
            if(_loc5_ == an_object)
            {
               if(_loc2_ == an_array.length - 1)
               {
                  this.debug("The next in line would fall outside the tab array, cycling to the first: " + an_array[0].name + " ...");
                  return this.shellTools.getInstanceFromNamespace(an_array[0].name);
               }
               this.debug("The next in line of " + an_array[_loc2_].name + " is " + an_array[_loc2_ + 1].name);
               return this.shellTools.getInstanceFromNamespace(an_array[_loc2_ + 1].name);
            }
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function gotoFirstTabIndex(an_array)
   {
      this.debug("gotoFirstTabIndex ()");
      return undefined;
   }
   function disableAllInternalTabs()
   {
      this.debug("disableAllInternalTabs ()");
      _root.tabChildren = false;
      var _loc6_ = this.getClassTabWidgetArray();
      var _loc4_ = 0;
      while(_loc4_ < _loc6_.length)
      {
         var _loc5_ = _loc6_[_loc4_];
         if(_loc5_.name != undefined)
         {
            var _loc3_ = _loc5_.compRef;
            if(_loc3_.commType == "textInput" || _loc3_.commType == "textArea")
            {
               this.debug("Removing auto tab for text component " + _loc3_._name);
               _loc3_.tabEnabled = false;
               _loc3_._focusrect = false;
               _loc3_.textbox.tabEnabled = false;
               _loc3_.textbox._focusrect = false;
               _loc3_.tabChildren = false;
            }
            else
            {
               this.debug("Removing auto tab for regular component " + _loc3_._name);
               _loc3_.tabEnabled = false;
               _loc3_._focusrect = false;
               _loc3_.tabChildren = false;
            }
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function rearrangeTabIndex()
   {
      this.debug("rearrangeTabIndex ()");
      if(this.tabarranged == true)
      {
         this.debug("The tab order has already been set, no need to do this again.");
         return undefined;
      }
      this.setCurrentTabFocusEnabled(false);
      var _loc2_ = this.getClassTabWidgetArray();
      if(_loc2_.length <= 1)
      {
         this.debug("We don\'t have any items in the tab list yet, resetting tag so we will try this again");
         this.tabarranged = false;
         return undefined;
      }
      this.showTabOrderArray(_loc2_);
      var _loc8_ = false;
      var _loc5_ = null;
      var _loc3_ = null;
      var _loc4_ = null;
      while(_loc8_ == false)
      {
         _loc8_ = true;
         var _loc7_ = 0;
         while(_loc7_ < _loc2_.length - 1)
         {
            _loc3_ = _loc2_[_loc7_].compRef;
            _loc4_ = _loc2_[_loc7_ + 1].compRef;
            if(_loc3_.tabIndex == undefined)
            {
               this.debug("Setting tab index value for widget " + _loc3_._name + " to 5000");
               _loc3_.tabIndex = 5000;
            }
            if(_loc3_.tabIndex > _loc4_.tabIndex || _loc3_.tabIndex == -1 && _loc4_.tabIndex != -1)
            {
               var _loc6_ = _loc2_[_loc7_];
               _loc2_[_loc7_] = _loc2_[_loc7_ + 1];
               _loc2_[_loc7_ + 1] = _loc6_;
               _loc8_ = false;
            }
            _loc7_ = _loc7_ + 1;
         }
      }
      this.debug("Assigning valid tab index number to any instances that did not have one ...");
      _loc7_ = 0;
      while(_loc7_ < _loc2_.length)
      {
         if(_loc7_ == 0)
         {
            _loc5_ = _loc2_[_loc7_].compRef;
            if(_loc5_.tabIndex == 5000)
            {
               _loc5_.tabIndex = 1;
            }
         }
         else
         {
            _loc3_ = _loc2_[_loc7_ - 1].compRef;
            _loc4_ = _loc2_[_loc7_].compRef;
            if(_loc4_.tabIndex == 5000)
            {
               _loc4_.tabIndex = _loc3_.tabIndex + 1;
            }
         }
         _loc7_ = _loc7_ + 1;
      }
      this.debug("Fix textarea and textinput components, move tabIndex to child widget ...");
      _loc7_ = 0;
      while(_loc7_ < _loc2_.length)
      {
         _loc5_ = _loc2_[_loc7_].compRef;
         if(_loc5_.commType == "textInput" || _loc5_.commType == "textArea")
         {
            this.debug("Re-assigning tab index for: " + _loc2_[_loc7_].name);
            _loc5_.textbox.tabIndex = _loc5_.tabIndex;
            _loc5_.tabIndex = "";
         }
         _loc7_ = _loc7_ + 1;
      }
      this.setClassTabWidgetArray(_loc2_);
      this.showTabOrderArray(_loc2_);
      this.disableAllInternalTabs();
      this.tabarranged = true;
   }
   function initTabOrder()
   {
      this.debug("initTabOrder ()");
      var _loc2_ = null;
      this.tutorTabOrder = new edu.cmu.hcii.ctat.CTATcTabOrder();
      if(this.__get__tabOrder() == "Down Columns" || this.__get__tabOrder() == "Across Rows")
      {
         _loc2_ = this.tutorTabOrder.setTabOrder(this.__get__tabOrder());
      }
      else
      {
         _loc2_ = this.tutorTabOrder.prepareBasicTabOrder();
      }
      this.setClassTabWidgetArray(_loc2_);
   }
   function initTab()
   {
      this.debug("initTab ()");
      this.gotoFirstTabIndex(this.getClassTabWidgetArray());
   }
   function findNewFocus(widgetArray, oldFocus)
   {
      this.debug("findNewFocus (array," + oldFocus._name + ")");
      var _loc2_ = this.getNextTabOrder(widgetArray,oldFocus);
      if(_loc2_ == null || _loc2_ == undefined)
      {
         this.debug("Internal error: no valid focus target found!");
         return null;
      }
      this.debug("Next focus target is:" + _loc2_._name);
      var _loc5_ = widgetArray.length;
      var _loc4_ = 0;
      while(_loc4_ < _loc5_)
      {
         if(_loc2_._visible == false || _loc2_.commType == "tutorShell")
         {
            this.debug("New focus for " + _loc2_._name + " is not visible or is the comm shell, getting next in line ...");
            _loc2_ = this.getNextTabOrder(widgetArray,_loc2_);
         }
         else if(_loc2_.locked == true || _loc2_.blocked == true)
         {
            this.debug("New focus for " + _loc2_._name + " is locked or blocked, getting next in line ...");
            _loc2_ = this.getNextTabOrder(widgetArray,_loc2_);
         }
         else if(_loc2_.commType == "textInput" || _loc2_.commType == "textArea")
         {
            if(_loc2_.textbox.editable == false)
            {
               this.debug("This component is not editable, finding next alternative ...");
               _loc2_ = this.getNextTabOrder(widgetArray,_loc2_);
            }
            else
            {
               this.debug("We\'ve found an eligible component for focus: " + _loc2_._name + " returning object ...");
               return _loc2_;
            }
         }
         else
         {
            this.debug("We\'ve found a non text based component: " + _loc2_._name);
            return _loc2_;
         }
         _loc4_ = _loc4_ + 1;
      }
      this.debug("Could not find new focus for: " + oldFocus._name);
      return null;
   }
   function findNewFocus2(widgetArray, oldFocus)
   {
      this.debug("findNewFocus2 ()");
      var _loc2_ = undefined;
      var _loc5_ = widgetArray.length;
      var _loc3_ = 0;
      while(_loc3_ < _loc5_)
      {
         _loc2_ = widgetArray[_loc3_].compRef;
         if(_loc2_.commType != "tutorShell")
         {
            if(_loc2_.commType == "textInput" || _loc2_.commType == "textArea")
            {
               if(_loc2_.getLockStatus() == false)
               {
                  if(_loc2_.getIsCorrect() == false || _loc2_.getIsCorrect() == undefined)
                  {
                     this.codeSetFocus = true;
                     this.setCurrentTabFocus(edu.cmu.hcii.ctat.CTATUtil.getTextBoxInstance(_loc2_));
                     return undefined;
                  }
               }
               else
               {
                  this.debug("Detected that widget is locked, skipping ...");
               }
            }
            else if(widgetArray[_loc3_].name != undefined)
            {
               if(_loc2_.getIsCorrect() == false || _loc2_.getIsCorrect() == undefined)
               {
                  this.codeSetFocus = true;
                  this.setCurrentTabFocus(edu.cmu.hcii.ctat.CTATUtil.getTextBoxInstance(_loc2_));
                  return undefined;
               }
            }
            else if(widgetArray[_loc3_] instanceof Array)
            {
               this.findNewFocus(this.getClassTabWidgetArray(),widgetArray[_loc3_]);
            }
         }
         else
         {
            this.debug("Skipping over component with tabIndex 5000");
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function setCurrentFocusFirst(widgetArray, theGetFocus)
   {
      this.debug("setCurrentFocusFirst ()");
      if(theGetFocus == undefined)
      {
         return widgetArray;
      }
      var _loc5_ = undefined;
      if(theGetFocus.commType == "textInput" || theGetFocus.commType == "textArea")
      {
         _loc5_ = edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(theGetFocus);
      }
      else
      {
         _loc5_ = theGetFocus;
      }
      var _loc3_ = 0;
      var _loc6_ = widgetArray.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc6_)
      {
         if(widgetArray[_loc2_].name == _loc5_)
         {
            _loc3_ = _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc9_ = widgetArray.slice(0,_loc3_);
      var _loc10_ = widgetArray.slice(_loc3_ + 1);
      var _loc8_ = _loc10_.concat(_loc9_);
      return _loc8_;
   }
   function determineFindNewFocus(gradedWidget)
   {
      this.debug("determineFindNewFocus (" + gradedWidget._name + ")");
      this._lasClickedComponent = gradedWidget._name;
      this.setLastFocus(gradedWidget);
      this.setCurrentTabFocus(gradedWidget);
      var _loc3_ = this.findNewFocus(this.getClassTabWidgetArray(),gradedWidget);
      this.setCurrentTabFocus(_loc3_);
   }
   function resetCurrentTouchBottomedOut(touchedComponent)
   {
      this.debug("resetCurrentTouchBottomedOut ()");
      if(this.getLastFocus() != edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(touchedComponent) && this.getLastFocus() != _level0.instance1.hint_window.get_next_hint_button_mc && this.getLastFocus() != _level0.instance1.hint_window.get_previous_hint_button_mc)
      {
         this.setCurrentTouchBottomedOut(false);
      }
      this.debug("resetCurrentTouchBottomedOut () done");
   }
   function manageBackgrading(touchedComponent)
   {
      this.debug("manageBackgrading (" + touchedComponent._name + " [Type:" + touchedComponent.commType + "]");
      this.resetCurrentTouchBottomedOut(touchedComponent);
      this.debug("After: resetCurrentTouchBottomedOut (touchedComponent);");
      if(this.getLastFocus() != edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(touchedComponent))
      {
         this.debug("(getLastFocus()!=CTATUtil.getTrueInstance (touchedComponent)) Before backgrading : Now the last focus and current focus should be the same but diff than the touched component : touchedComponent =" + touchedComponent + " focusManager.getFocus =  " + this.getCurrentTabFocus() + " getLastFocus =" + this.getLastFocus() + " getCurrentFocus =  " + this.getCurrentFocus());
         this.backGradeCloseHintWindow();
         this.setCurrentFocus(edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(touchedComponent));
         if(this.getLastFocus() == null || this.getLastFocus() == undefined)
         {
            this.debug("The method getLastFocus is reporting a null value");
         }
         else
         {
            this.debug("The method getLastFocus is reporting a non null and non undefined value. Commtype is: " + this.getLastFocus().commType + " instance name is: " + this.getLastFocus()._name);
         }
         this.setLastActedOn(edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()));
         this.backGrade(edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(touchedComponent));
         this.setLastFocus(edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(touchedComponent));
         this.debug("After backgrading : Now the last focus and current focus should be the same as the touched component : See getLastActedOn if you want to know what was before : true touchedComponent =" + edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(touchedComponent) + "  focusManager.getFocus =  " + this.getCurrentTabFocus() + " getLastFocus =" + this.getLastFocus() + " true getLastFocus =" + edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()) + "  getCurrentFocus =  " + this.getCurrentFocus() + " setLastActedOn = " + this.getLastActedOn());
         this.debug("manageBackgrading () done, with back grading");
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()) == edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(touchedComponent))
      {
         this.debug("manageBackgrading () done");
      }
   }
   function backGrade(touchedComponent)
   {
      this.debug("backGrade  (" + touchedComponent._name + ")");
      this.debug("touchedComponent (comp that called this method) = " + touchedComponent + " focusManager.getFocus =  " + this.getCurrentTabFocus() + " lastFocus =  " + this.getLastFocus() + " CurrentFocus =  " + this.getCurrentFocus() + " getLastGradedWidget = " + this.getLastGradedWidget());
      if(this.getLastFocus() == null || this.getLastFocus() == undefined)
      {
         this.debug("The method getLastFocus is reporting a null or undefined value");
      }
      if(this.getLastFocus().commType == undefined)
      {
         this.debug("Corrupted component instance, attempting recover of: " + this.getLastFocus()._parent.commType);
      }
      else
      {
         this.debug("Last focused component is of type: " + this.getLastFocus().commType);
      }
      if(this.getLastFocus().commType != "textInput" && this.getLastFocus().commType != "textArea")
      {
         this.debug("The last graded component is not a textfield so no need to backgrade");
         this.debug("backGrade () Done");
         return undefined;
      }
      if(this.suppressStudentFeedback == true && this.getLastFocus().getTextHasChanged() == false)
      {
         this.debug("We should not re-grade if there has been no change in value and if surpressed feedback is on");
         this.debug("backGrade () Done");
         return undefined;
      }
      if(this.getLastGradedWidget() == this.getLastActedOn() && this.getLastGradedWidget() == this.getLastFocus() && this.getLastFocus().getTextHasChanged() == false)
      {
         this.debug("Scenario 1a :  The last graded component = Last Acted On = Last Focused Component AND the text hasn\'t changed.   We don\'t need to regrade it : getLastGradedWidget = " + this.getLastGradedWidget() + " getLastActedOn() = " + this.getLastActedOn() + " getLastFocus =" + this.getLastFocus() + " getLastFocus().getTextHasChanged() = " + this.getLastFocus().getTextHasChanged());
         this.debug("backGrade () Done");
         return undefined;
      }
      if(this.getLastGradedWidget() == this.getLastActedOn() && this.getLastGradedWidget() == this.getLastFocus() && edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()).getTextHasChanged() == true)
      {
         this.debug("Scenario 1b : The last graded component = Last Acted On = Last Focused Component AND the text HAS changed.   We regrade it :  getLastGradedWidget = " + this.getLastGradedWidget() + " getLastActedOn() = " + this.getLastActedOn() + "  getLastFocus =" + this.getLastFocus() + " getLastFocus().getTextHasChanged() = " + this.getLastFocus().getTextHasChanged());
         this.backGradeCloseHintWindow();
         this.backGradeTextFields();
         this.debug("backGrade () Done");
         return undefined;
      }
      if(edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastGradedWidget()) != edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()) && edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()).getTextHasChanged() == true)
      {
         this.debug("Scenario 2a :  The last graded component = Last Acted On = Last Focused Component AND the text hasn\'t changed.   We regrade it :  getLastGradedWidget = " + this.getLastGradedWidget() + " getLastActedOn() = " + this.getLastActedOn() + "  getLastFocus =" + this.getLastFocus() + " getLastFocus().getTextHasChanged() = " + this.getLastFocus().getTextHasChanged());
         this.backGradeCloseHintWindow();
         this.backGradeTextFields();
         this.debug("backGrade () Done");
         return undefined;
      }
      if(edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()).getTextHasChanged() == false && edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()).getLockStatus() == false)
      {
         this.debug("We\'re in a situation where we\'re have a component that was previously incorrect because it was out of order but it might now be in-order, so we grade again");
         this.backGradeCloseHintWindow();
         this.backGradeTextFields();
         this.debug("backGrade () Done");
         return undefined;
      }
      if(edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()).getTextHasChanged() == true)
      {
         this.debug("Scenario 2b :  The text has changed in the last focused field so we\'ll REGRADE it regardless.  getLastGradedWidget = " + this.getLastGradedWidget() + " getLastActedOn() = " + this.getLastActedOn() + " getLastFocus =" + this.getLastFocus() + " getLastFocus().getTextHasChanged() = " + this.getLastFocus().getTextHasChanged());
         this.backGradeCloseHintWindow();
         this.backGradeTextFields();
         this.debug("backGrade () Done");
         return undefined;
      }
      this.debug("Scenario None :  getLastGradedWidget = " + edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastGradedWidget()) + " getLastActedOn() = " + edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastActedOn()) + " getLastFocus =" + edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()) + " getLastFocus().getTextHasChanged() = " + edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getLastFocus()).getTextHasChanged());
      this.debug("Probably an error: appropriate backgrade scenario activated");
      this.debug("backGrade () Done");
   }
   function backGradeCloseHintWindow()
   {
      this.debug("backGradeCloseHintWindow ()");
      if(this.getLastFocus() != edu.cmu.hcii.ctat.CTATUtil.getTrueInstance(this.getCurrentTabFocus()) && this.getLastFocus() != this.hint_window.get_next_hint_button_mc && this.getLastFocus() != this.hint_window.get_previous_hint_button_mc)
      {
         this.CloseHintWindow();
      }
      return undefined;
   }
   function backGradeTextFields()
   {
      this.debug("backGradeTextFields ()");
      if(edu.cmu.hcii.ctat.CTATUtil.getTextBoxInstance(this.getLastFocus()).text != "")
      {
         this.debug("To be graded texbox (last focused): " + edu.cmu.hcii.ctat.CTATUtil.getTextBoxInstance(this.getLastFocus())._name + " has valid text ...");
         if(this.getCurrentTabFocus() != this.getLastFocus())
         {
            this.debug("Current focused text box is not the same as the last focused text box: " + this.getCurrentTabFocus()._name + "," + this.getLastFocus()._name);
            this.checkme(this.getLastFocus());
         }
         else
         {
            this.debug("Current focused text box is exactly the same as the last focused text box (but isn\'t locked and has text): " + this.getCurrentTabFocus()._name + "," + this.getLastFocus()._name);
            if(this.getLastFocus().getLockStatus() == false)
            {
               this.debug("To be graded textbox is not locked or with editble set to false");
               this.checkme(this.getLastFocus());
            }
            else
            {
               this.debug("To be graded textbox is either locked or set to non-editable");
            }
         }
      }
      else
      {
         this.debug("The to be graded text box has no text in it: " + edu.cmu.hcii.ctat.CTATUtil.getTextBoxInstance(this.getLastFocus())._name);
      }
      return undefined;
   }
   function onSetFocusHandler(theSetObject)
   {
      this.debug("onSetFocusHandler ()");
      this.backGrade(theSetObject);
   }
   function CurrentFocus(userCurrentFocus)
   {
      this.debug("CurrentFocus ()");
      this.theCurrentFocus = userCurrentFocus;
   }
   function setCurrentFocus(sUserCurrentFocus)
   {
      this.debug("setCurrentFocus ()");
      this.debug("set CurrentTouchBottomeedOut to false :  sUserCurrentFocus =" + sUserCurrentFocus + " getCurrentTouchBottomedOut = " + this.getCurrentTouchBottomedOut());
      this.theCurrentFocus = sUserCurrentFocus;
   }
   function getCurrentFocus()
   {
      return this.theCurrentFocus;
   }
   function setCurrentTouch(sUserCurrentTouch)
   {
      this.debug("setCurrentTouch ()");
      this.theCurrentTouch = sUserCurrentTouch;
      return undefined;
   }
   function getCurrentTouch()
   {
      return this.theCurrentTouch;
   }
   function __set__LastFocus(oLastFocus)
   {
      this.debug("LastFocus ()");
      this.setLastFocus(oLastFocus);
      return this.__get__LastFocus();
   }
   function __get__LastFocus()
   {
      return this.getLastFocus();
   }
   function setLastFocus(oLastFocus)
   {
      this.debug("setLastFocus (" + oLastFocus._name + ")");
      this.lastFocus = oLastFocus;
   }
   function getLastFocus()
   {
      return this.lastFocus;
   }
   function setLastActedOn(oLastActedOn)
   {
      this._lastActedOn = oLastActedOn;
   }
   function getLastActedOn()
   {
      return this._lastActedOn;
   }
   function setLastTouch(oLastTouch)
   {
      this.lastTouch = oLastTouch;
   }
   function getLastTouch()
   {
      return this.lastTouch;
   }
   function onKillFocusHandler(theKillObject)
   {
      this.debug("onKillFocusHandler (" + theKillObject._name + ")");
      return undefined;
   }
   function setLastGradedWidget(oLastGradedWidget)
   {
      this.debug("setLastGradedWidget ()");
      this.lastGradedWidget = oLastGradedWidget;
   }
   function getLastGradedWidget()
   {
      return this.lastGradedWidget;
   }
   function showFeedbackForCheckBox(basePathOfClip, groupName, widget, gradeCorrectIncorrect)
   {
      this.debug("showFeedbackForCheckBox ()");
      var pathOfClip = eval(basePathOfClip);
      for(var p in eval(pathOfClip))
      {
         if(pathOfClip[p] instanceof mx.core.UIObject || pathOfClip[p] instanceof mx.core.UIComponent)
         {
            if(pathOfClip[p] != widget and pathOfClip[p].getGroupName() == groupName and pathOfClip[p].commType == "checkBox")
            {
               if(pathOfClip[p].getIsCorrect() == false)
               {
                  pathOfClip[p].showNull();
               }
            }
            if(pathOfClip[p].compositeCommWidget == true)
            {
               this.showFeedbackForCheckBox(pathOfClip[p],groupName,widget,gradeCorrectIncorrect);
            }
         }
         else if(typeof pathOfClip[p] == "movieclip")
         {
            this.showFeedbackForCheckBox(pathOfClip[p],groupName,widget,gradeCorrectIncorrect);
         }
      }
   }
   function clearIncorrectAnswers(basePathOfClip, widget)
   {
      this.debug("clearIncorrectAnswers ()");
      return undefined;
   }
   function __set__MonitorLog(theValue)
   {
      this._MonitorLog = theValue;
      return this.__get__MonitorLog();
   }
   function __get__MonitorLog()
   {
      return this._MonitorLog;
   }
   function __set__CorrectColor(theValue)
   {
      if(theValue == 0)
      {
         theValue = 47872;
      }
      this.correctColor = theValue;
      return this.__get__CorrectColor();
   }
   function __get__CorrectColor()
   {
      return this.correctColor;
   }
   function __set__IncorrectColor(theValue)
   {
      if(theValue == 0)
      {
         theValue = 16711680;
      }
      this.incorrectColor = theValue;
      return this.__get__IncorrectColor();
   }
   function __get__IncorrectColor()
   {
      return this.incorrectColor;
   }
   function __set__HintColor(theValue)
   {
      if(theValue == 0)
      {
         theValue = 16776960;
      }
      this._hintColor = theValue;
      return this.__get__HintColor();
   }
   function __get__HintColor()
   {
      return this._hintColor;
   }
   function __set__BackgroundColor(theValue)
   {
      if(theValue == 0)
      {
         theValue = 16777215;
      }
      this.bgColor = theValue;
      return this.__get__BackgroundColor();
   }
   function __get__BackgroundColor()
   {
      return this.bgColor;
   }
   function __set__tabOrder(sTabOrder)
   {
      this._tabOrder = sTabOrder;
      return this.__get__tabOrder();
   }
   function __get__tabOrder()
   {
      return this._tabOrder;
   }
   function __set__WidgetTabOrder(userWidgetOrder)
   {
      this._WidgetTabOrder = userWidgetOrder;
      return this.__get__WidgetTabOrder();
   }
   function __get__WidgetTabOrder()
   {
      return this._WidgetTabOrder;
   }
   function __set__includeTraces(theValue)
   {
      this._bIncludeTraces = theValue;
      if(theValue == true)
      {
         edu.cmu.hcii.ctat.CTATGlobal.suppressDebug = false;
      }
      else
      {
         edu.cmu.hcii.ctat.CTATGlobal.suppressDebug = true;
      }
      return this.__get__includeTraces();
   }
   function __get__includeTraces()
   {
      return this._bIncludeTraces;
   }
   function __set__theMediaPath(theValue)
   {
      this._theMediaPath = theValue;
      return this.__get__theMediaPath();
   }
   function __get__theMediaPath()
   {
      return this._theMediaPath;
   }
   function __set__loggingDefinition(theValue)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"client"))
      {
         this._sLoggingDefinition = "Client To Log Server";
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theValue,"Service To Log Server") || edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theValue,"ServiceToLogServer"))
      {
         this._sLoggingDefinition = "Service To Log Server";
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theValue,"Service To Disk") || edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theValue,"ServiceToDisk"))
      {
         this._sLoggingDefinition = "Service To Disk";
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theValue,"Service To Disk and Log Server") || edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theValue,"ServiceToDiskandLogServer"))
      {
         this._sLoggingDefinition = "Service To Disk and Log Server";
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theValue,"none"))
      {
         this._sLoggingDefinition = "None";
      }
      else
      {
         this.debug("EXCEPTION : loggingDefinition the value passed (" + theValue + ") is not a recognized value.");
         this._sLoggingDefinition = theValue;
      }
      return this.__get__loggingDefinition();
   }
   function __get__loggingDefinition()
   {
      return this._sLoggingDefinition;
   }
   function __set__brdFinishedParsing(bBrdFinishedParsing)
   {
      this._brdFinishedParsing = bBrdFinishedParsing;
      return this.__get__brdFinishedParsing();
   }
   function __get__brdFinishedParsing()
   {
      return this._brdFinishedParsing;
   }
   function setPrevHint(sHint)
   {
      this._prevhint = sHint;
   }
   function getPrevHint()
   {
      return this._prevhint;
   }
   function setLastClickedComponent(theComponent)
   {
      this.debug("setLastClickedComponent (" + theComponent + ")");
      var _loc2_ = this.shellTools.getInstanceFromNamespace(theComponent);
      if(_loc2_ == null)
      {
         this.debug("Error: unable to resolve component name to actual component instance");
         return undefined;
      }
      this._lasClickedComponent = _loc2_._name;
      this.debug("Fixing focus to " + _loc2_._name + " commType: " + _loc2_.commType);
      if(_loc2_.commType == "textInput" || _loc2_.commType == "textArea")
      {
         if(this.ctat_hint_window != null)
         {
            this.debug("Calling reset on hint window ...");
            this.ctat_hint_window.reset();
         }
      }
      this.setLastFocus(_loc2_);
      this.internalTabFocus = _loc2_;
   }
   function getLastClickedComponent()
   {
      return this._lasClickedComponent;
   }
   function Cleanup()
   {
      this.debug("Cleanup ()");
      super.Cleanup();
      this.waitclip._close();
      this.responseController = null;
      this.volatile_response = null;
      clearInterval(this.buildIntervalID);
      clearInterval(this.buildEventIntervalIDa);
      clearInterval(this.buildEventIntervalIDb);
      this.debug("Cleanup () done");
   }
   function blockWidget(a_widget)
   {
      this.debug("blockWidget ()");
      if(this.__get__BehaviorRecorder() == "AuthorTime")
      {
         this.debug("We\'re in tracer mode, not locking widget");
         return undefined;
      }
      if(a_widget == undefined)
      {
         this.debug("Error: widget to be blocked is undefined");
         return undefined;
      }
      if(a_widget == null)
      {
         this.debug("Error: widget to be blocked is NULL");
         return undefined;
      }
      a_widget.block();
      this.blockrep = a_widget;
      this.blocking = true;
      var _loc4_ = a_widget._width;
      var _loc5_ = a_widget._height;
      if(a_widget.getDimensions != undefined)
      {
         this.debug("The widget to be blocked has a valid \'getDimensions\' method, activating ...");
         var _loc8_ = a_widget.getDimensions();
         _loc4_ = _loc8_.right;
         _loc5_ = _loc8_.bottom;
      }
      if(this.bgUseHourGlass == true)
      {
         if(this.blocker != null)
         {
            this.debug("Original hourglass location at: " + a_widget._x + "," + a_widget._y);
            var _loc6_ = a_widget._x + _loc4_;
            var _loc7_ = a_widget._y + _loc5_;
            this.debug("Raw hourglass location at: " + _loc6_ + "," + _loc7_);
            this.indicator.show();
            this.indicator.place(_loc6_,_loc7_,_loc4_,_loc5_);
            if(a_widget._x + _loc4_ + this.blocker._width > _root.width)
            {
               _loc6_ = a_widget._x - this.blocker._width;
            }
            if(a_widget._y + _loc5_ + this.blocker._height > _root.height)
            {
               _loc7_ = a_widget._y - this.blocker._height;
            }
            this.blocker._x = _loc6_ - 2;
            this.blocker._y = _loc7_ - 2;
            this.debug("Showing hourglass at: " + this.blocker._x + "," + this.blocker._y);
            this.blocker._visible = true;
            this.blocker.swapDepths(this.getNextHighestDepth());
         }
         else
         {
            this.debug("No blocker icon to use!");
         }
      }
   }
   function unblockWidgetStr(a_widget)
   {
      this.debug("unblockWidgetStr (" + a_widget + ")");
      if(a_widget == undefined || a_widget == null)
      {
         this.debug("Internal error: wiget object to be blocked is undefined or null");
      }
      eval(a_widget).unblock();
      this.blocker._visible = false;
      this.blockrep = null;
      this.blocking = false;
   }
   function unblockWidget(a_widget)
   {
      this.debug("unblockWidget ()");
      if(a_widget == undefined || a_widget == null)
      {
         this.debug("Internal error: wiget object to be blocked is undefined or null");
      }
      a_widget.unblock();
      this.blocker._visible = false;
      this.blockrep = null;
      this.blocking = false;
   }
   function processEndofTransaction()
   {
      this.debug("processEndofTransaction ()");
      this.dispatchEvent({type:"endofTransaction",target:this});
      if(this.suppressStudentFeedback == true)
      {
         this.unblockWidget(this.blockrep);
      }
   }
   function indicateActivity()
   {
      this.debug("indicateActivity ()");
      if(this.responseIndicated == false)
      {
         if(this.responseURL != undefined)
         {
            if(this.responseURL != null)
            {
               if(this.responseURL != "unassigned")
               {
                  this.responseController = new LoadVars();
                  this.volatile_response = new LoadVars();
                  this.volatile_response.onLoad = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.getIndicateAcivityResults);
                  if(_level0.authenticity_token != undefined && _level0.authenticity_token != null)
                  {
                     this.responseController.authenticity_token = _level0.authenticity_token;
                  }
                  else
                  {
                     this.responseController.authenticity_token = edu.cmu.hcii.ctat.CTATGuid.create();
                  }
                  this.debug("Sending request (POST) to Rails with the following url: " + this.responseURL);
                  this.responseController.sendAndLoad(this.responseURL,this.volatile_response,"POST");
               }
            }
         }
         this.responseIndicated = true;
      }
   }
   function getIndicateAcivityResults()
   {
      this.debug("getIndicateAcivityResults ()");
      this.responseController = null;
      this.volatile_response = null;
   }
}
