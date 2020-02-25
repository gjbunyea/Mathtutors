class edu.cmu.hcii.ctat.CTATTutorableComponent extends edu.cmu.hcii.ctat.CTATLabeledComponent
{
   static var symbolName = "CTATTutorableComponent";
   static var symbolOwner = edu.cmu.hcii.ctat.CTATTutorableComponent;
   var className = "CTATTutorableComponent";
   var ParentClassName = "CTATLabeledComponent";
   var tutorWidgetName = "Button";
   static var version = "2.10.0";
   var publicVersion = "2.10.0";
   var commType = "CommButton";
   var shell = "";
   var _sendInterfDescMessages = true;
   var currentlyHighlighted = false;
   var _showHighlight = false;
   var overrideKeyProcessing = false;
   var componentSelection = "-1";
   var valueString = "";
   var actionString = "ButtonPressed";
   var overrideInstance = "undefined";
   var startStateProcessed = false;
   var lockReady = true;
   var results = null;
   function CTATTutorableComponent()
   {
      super();
   }
   function setOverrideInstance(a_string)
   {
      this.debug("setOverrideInstance (" + a_string + ")");
      this.overrideInstance = a_string;
   }
   function setAutoGrade(a_val)
   {
      this.debug("setAutoGrade (" + a_val + ")");
      this.autoGrade = a_val;
   }
   function getAutoGrade()
   {
      return this.autoGrade;
   }
   function disableShellInput(a_val)
   {
      this.debug("disableShellInput (" + a_val + ")");
      _global.theShell.disableShellInput(a_val);
   }
   function setOverrideKeyProcessing(a_val)
   {
      this.debug("setOverrideKeyProcessing (" + a_val + ")");
      this.overrideKeyProcessing = a_val;
   }
   function getOverrideKeyProcessing()
   {
      return this.overrideKeyProcessing;
   }
   function getClassVersion()
   {
      return this.publicVersion;
   }
   function setClassType(a_type)
   {
      this.className = a_type;
   }
   function getClassType()
   {
      return this.className;
   }
   function setTutorWidgetName(a_type)
   {
      this.debug("setTutorWidgetName (" + a_type + ")");
      this.tutorWidgetName = a_type;
   }
   function getTutorWidgetName()
   {
      return this.tutorWidgetName;
   }
   function getCommType()
   {
      return this.commType;
   }
   function setTutorComponent(a_val)
   {
      this.debug("setTutorComponent (" + a_val + ")");
      this.tutorComponent = a_val;
      this.behaviorRecord = a_val;
   }
   function getTutorComponent()
   {
      return this.behaviorRecord;
   }
   function setRecordBehavior(a_val)
   {
      this.debug("setRecordBehavior (" + a_val + ")");
      this.behaviorRecord = a_val;
   }
   function getRecordBehavior()
   {
      return this.behaviorRecord;
   }
   function setEvaluateComponent(a_val)
   {
      this.debug("setEvaluateComponent (" + a_val + ")");
      this.evaluateComponent = a_val;
   }
   function getEvaluateComponent()
   {
      return this.evaluateComponent;
   }
   function setShowFeedback(a_val)
   {
      this.debug("setShowFeedback (" + a_val + ")");
      this.showFeedback = a_val;
   }
   function getShowFeedback()
   {
      return this.showFeedback;
   }
   function setLockReady(a_val)
   {
      this.lockReady = a_val;
   }
   function getLockReady()
   {
      return this.lockReady;
   }
   function setComponentSelection(a_sel)
   {
      this.debug("setComponentSelection (" + a_sel + ")");
      this.componentSelection = a_sel;
      this.setValues(this.componentSelection);
   }
   function getComponentSelection()
   {
      return this.componentSelection;
   }
   function init()
   {
      super.init();
      this.debug("init");
      mx.events.EventDispatcher.initialize(this);
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      var _loc3_ = new edu.cmu.hcii.ctat.CTATShellTools();
      this.shell = _loc3_.findShell();
      this.startSocketandNewProblem();
   }
   function draw()
   {
      super.draw();
   }
   function size()
   {
      super.size();
   }
   function startSocketandNewProblem()
   {
      this.debug("startSocketandNewProblem ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      if(this.isLivePreview() == false)
      {
         this.debug("Setting up onSocketConnect and onNewProblem shell event listeners ...");
         _global.theShell.addEventListener("onSocketConnect",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.actOnSocketConnection));
         _global.theShell.addEventListener("onNewProblem",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.actOnNewProblem));
      }
      else
      {
         this.debug("We\'re in live preview mode, not setting up shell events");
      }
   }
   function actOnSocketConnection()
   {
      this.debug("actOnSocketConnection ()");
   }
   function actOnNewProblem()
   {
      this.debug("actOnNewProblem ()");
      if(this.getSendInterfDescMessages() == true)
      {
         this.sendJessInterfaceDescription();
      }
   }
   function setValues(a_val)
   {
      this.debug("setValues (" + a_val + ")");
      this.valueString = a_val;
   }
   function getValues()
   {
      return this.valueString;
   }
   function setAction(a_val)
   {
      this.debug("setAction (" + a_val + ")");
      this.actionString = a_val;
   }
   function getAction()
   {
      return this.actionString;
   }
   function sendJessInterfaceDescription()
   {
      this.debug("sendJessInterfaceDescription ()");
      if(this.tutorComponent == false)
      {
         this.debug("tutorComponent==false");
         return undefined;
      }
      var _loc5_ = this.className;
      var _loc3_ = this._name;
      var _loc4_ = this.tutorWidgetName;
      var _loc6_ = this.buildJessInterfaceDescription(_loc3_,_loc5_,_loc4_);
      _global.theShell.sendInterfaceDescription(_loc6_);
   }
   function getSlots()
   {
      var _loc1_ = new Array();
      _loc1_.push("value");
      return _loc1_;
   }
   function buildJessInterfaceDescription(componentName, componentType, defTemplateType)
   {
      this.debug("buildJessInterfaceDescription ()");
      var _loc2_ = this.getSlots();
      var _loc3_ = edu.cmu.hcii.ctat.CTATMessageFormat.makeInterfaceDescriptionMessage(componentName,componentType,defTemplateType,this.getValues(),_loc2_);
      return _loc3_;
   }
   function sendInterfaceAction(an_action, an_input)
   {
      this.debug("sendInterfaceAction (" + an_action + "," + an_input + ")");
      var _loc4_ = edu.cmu.hcii.ctat.CTATGuid.create();
      var _loc3_ = edu.cmu.hcii.ctat.CTATMessageFormat.makeInteractionMessage(this._name,an_action,an_input,_loc4_);
      this.debug("Message to send: " + _loc3_);
      _global.theShell.myXMLSocket.send(_loc3_);
   }
   function getBackgroundColor()
   {
      return this.backgroundColor;
   }
   function getText()
   {
      return null;
   }
   function click()
   {
      this.debug("click ()");
      this.gradeMe();
   }
   function setForegroundColor(theValue)
   {
   }
   function getForegroundColor()
   {
      return null;
   }
   function isHighlighted()
   {
      return this.getCurrentlyHighlighted();
   }
   function grade(aSelection, anAction, anInput)
   {
      this.debug("grade ()");
      if(this.autoGrade == false)
      {
         this.debug("AutoGrade==false, aborting ...");
         return undefined;
      }
      if(this.tutorComponent == false)
      {
         this.debug("tutorComponent==false, aborting ...");
         return undefined;
      }
      this.setShowFeedback(true);
      this.setEvaluateComponent(true);
      this.notifyTutor(aSelection,anAction,anInput);
   }
   function gradeMe()
   {
      this.debug("gradeMe ()");
      if(this.autoGrade == false)
      {
         this.debug("AutoGrade==false, aborting ...");
         return undefined;
      }
      if(this.tutorComponent == false)
      {
         this.debug("tutorComponent==false, aborting ...");
         return undefined;
      }
      this.onChange();
   }
   function onChange()
   {
      this.debug("onChange ()");
      if(this.autoGrade == false)
      {
         this.debug("AutoGrade==false, aborting ...");
         return undefined;
      }
      if(this.tutorComponent == false)
      {
         this.debug("tutorComponent==false, aborting ...");
         return undefined;
      }
      var _loc2_ = String(this);
      var _loc4_ = this.actionString;
      var _loc3_ = this.componentSelection;
      if(this.overrideInstance != "undefined")
      {
         _loc2_ = this.overrideInstance;
      }
      this.setShowFeedback(true);
      this.setEvaluateComponent(true);
      this.notifyTutor(_loc2_,_loc4_,_loc3_);
   }
   function notifyTutor(aSelection, anAction, anInput)
   {
      this.debug("notifyTutor()");
      var _loc6_ = this;
      var _loc3_ = this.commType;
      var _loc7_ = this.getRecordBehavior();
      var _loc5_ = this.getShowFeedback();
      var _loc4_ = this.getEvaluateComponent();
      _global.theShell.tutorComponentDataNew(_loc6_,_loc3_,aSelection,anAction,anInput,_loc7_,_loc5_,_loc4_);
   }
   function resetComponent()
   {
      this.debug("resetComponent ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.tutoringState = "Neutral";
      this.startStateProcessed = false;
      this.tutorUnlock();
      this.showNull();
      this.dispatchAndCallGradeNull();
      this.dispatchEvent({type:"onResetComponent",target:this});
      this.unHighlight();
      this.loaded = false;
      this.draw();
   }
   function setStartState(theSelection, theAction, theInput, theTransaction_id)
   {
      this.debug("setStartState ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.setValues(theInput);
      this.setAction(theAction);
      this.dispatchEvent({type:"onSetStartState",target:this});
      this.startStateProcessed = true;
   }
   function setStartStateCompletedFlag()
   {
      this.debug("setStartStateCompletedFlag ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.tutorLock();
      this.dispatchEvent({type:"onSetStartStateCompletedFlag",target:this});
   }
   function setResults(gradeStatus, theSelection, theAction, theInput, theEvaluation, lockAnswer)
   {
      this.debug("setResults ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.results = new Object();
      this.results.grade = gradeStatus;
      this.results.selection = theSelection;
      this.results.action = theAction;
      this.results.input = theInput;
      this.results.evaluation = theEvaluation;
      this.results.lockAnswer = lockAnswer;
      if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(gradeStatus,"Correct"))
      {
         this.showCorrect();
         if(lockAnswer == true && this.lockReady == true)
         {
            this.tutorLock();
         }
         this.dispatchAndCallGradeCorrect();
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(gradeStatus,"Incorrect"))
      {
         this.showIncorrect();
         this.tutorUnlock();
         this.dispatchAndCallGradeIncorrect();
      }
      else
      {
         this.debug("gradeStatus not Correct or Incorrect: " + gradeStatus);
      }
   }
   function setResultsSuppressFeedback(gradeStatus, theSelection, theAction, theInput, theEvaluation)
   {
      this.debug("setResultsSuppressFeedback ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
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
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.dispatchEvent({type:"showCorrect",target:this});
      this.callPostGradeFunction(this._callThisMethodonCorrect);
   }
   function dispatchAndCallGradeIncorrect()
   {
      this.debug("dispatchAndCallGradeIncorrect ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.dispatchEvent({type:"showIncorrect",target:this});
      this.callPostGradeFunction(this._callThisMethodonInCorrect);
   }
   function dispatchAndCallGradeNull()
   {
      this.debug("dispatchAndCallGradeNull ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.dispatchEvent({type:"showNull",target:this});
      this.callPostGradeFunction(this._callThisMethodonNull);
   }
   function callPostGradeFunction(sPostGradeFunctionName)
   {
      this.debug("callPostGradeFunction (" + sPostGradeFunctionName + ")");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      var myNavFunction = eval("_level0." + sPostGradeFunctionName);
      myNavFunction(this);
      this.debug("callPostGradeFunction () done");
   }
   function showCorrect()
   {
      this.debug("showCorrect ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.tutoringState = "Correct";
      this.unHighlight();
      this.fontColor = this.correctColor;
      this.setLabelProps();
      this.setIsCorrect(true);
      this.draw();
   }
   function showIncorrect()
   {
      this.debug("showIncorrect ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.tutoringState = "Incorrect";
      this.fontColor = this.incorrectColor;
      this.setLabelProps();
      this.setIsCorrect(false);
      this.draw();
   }
   function showNull()
   {
      this.debug("showNull ()");
      if(this.tutorComponent == false)
      {
         return undefined;
      }
      this.backgroundColor = this.sgBackgroundColor;
      this.fontColor = this.sgFontColor;
      this.setLabelProps();
      this.setIsCorrect(null);
      this.draw();
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
      this.setHighlighted(true);
      if(this.getDrawBase() == true)
      {
      }
      if(this.getUseLabel() == true)
      {
         this.sgFontColor = this.sgHighlightColor;
         this.setLabelProps();
      }
      this.setCurrentlyHighlighted(true);
      this.dispatchEvent({type:"onHighlightComponent",target:this});
      this.debug("highlight event!!");
      this.updateState();
      this.draw();
   }
   function unHighlight()
   {
      this.debug("unHighlight ()");
      this.setHighlighted(false);
      if(this.getDrawBase() == true)
      {
         this.backgroundColor = this.sgBackgroundColor;
      }
      else
      {
         this.fontColor = this.sgFontColor;
      }
      this.setLabelProps();
      this.setCurrentlyHighlighted(false);
      this.dispatchEvent({type:"onUnHighlightComponent",target:this});
      this.updateState();
      this.draw();
   }
   function setCurrentlyHighlighted(highlighState)
   {
      this.currentlyHighlighted = highlighState;
   }
   function getCurrentlyHighlighted()
   {
      return this.currentlyHighlighted;
   }
   function setSendInterfDescMessages(sendStatus)
   {
      this._sendInterfDescMessages = sendStatus;
   }
   function getSendInterfDescMessages()
   {
      return this._sendInterfDescMessages;
   }
   function tutorLock()
   {
      this.debug("tutorLock ()");
      this.dispatchEvent({type:"tutorLock",target:this});
   }
   function tutorUnlock()
   {
      this.debug("tutorUnlock ()");
      this.dispatchEvent({type:"tutorUnlock",target:this});
   }
}
