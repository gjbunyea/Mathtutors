class edu.cmu.hcii.ctat.CTATparseXML extends edu.cmu.hcii.ctat.CTATBase
{
   var className = "parseXML";
   var nAnswerNumber = 0;
   var rebuildInProgress = false;
   var nCounter = 0;
   var delayUnlockID = 0;
   var delayedSelection = "dummy";
   var doneTimer = 0;
   var SAI = null;
   function CTATparseXML(theShell)
   {
      super();
      this.setClassType("CTATparseXML");
      this.debug("CTATparseXML ()");
      this.setSelectionIntervalID = new Array();
      this.setSelectionIntervalCounter = new Array();
      this.theSource = theShell;
      this.as2eval = new edu.cmu.hcii.ctat.CTATAS2Processor();
      this.metrics = new edu.cmu.hcii.ctat.CTATPerformanceMetrics();
      _global.linkData.serviceInfo.ServerOffset = Number(0);
   }
   function classType()
   {
      return this.className;
   }
   function handleData(src)
   {
      this.debug("handleData ()");
      this.metrics.startMarker();
      var _loc2_ = new XML(src);
      this.theSource.addPerformanceEntry("*",this.metrics.readMarker(),"ParseXML");
      this.handleXML(_loc2_);
   }
   function handleXML(xmlObject)
   {
      this.debug("handleXML ()");
      this.debug("XML: " + xmlObject.toString());
      var _loc6_ = xmlObject.firstChild;
      if(_loc6_ == null || _loc6_ == undefined)
      {
         this.debug("Internal error: undefined root");
         return undefined;
      }
      if(_loc6_.nodeName == "StartStateMessages" || _loc6_.nodeName == "Bundle")
      {
         var _loc5_ = _loc6_.childNodes;
         if(_loc6_.nodeName == "StartStateMessages")
         {
            _global.theShell.clientLogger.logTime("GotStartState");
            this.debug("Setting CommShell StartState to true");
            this.debug("Setting CommShell StartState to TRUE");
            this.theSource.processingStartState = true;
         }
         this.debug("Processing bundle of [" + _loc5_.length + "] messages ...");
         var _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            this.debug("Processing message: " + _loc3_);
            var _loc4_ = new edu.cmu.hcii.ctat.CTATPerformanceMetrics();
            _loc4_.startMarker();
            var _loc8_ = this.handleXMLRegular(_loc5_[_loc3_],_loc5_[_loc3_]);
            this.theSource.addPerformanceEntry("B",_loc4_.readMarker(),_loc8_);
            _loc3_ = _loc3_ + 1;
         }
         if(_loc6_.nodeName == "StartStateMessages")
         {
            this.theSource.processingStartState = false;
         }
         this.debug("Setting CommShell StartState to FALSE");
         return undefined;
      }
      if(_loc6_.nodeName == "message")
      {
         this.debug("Processing single XML message ...");
         this.metrics.startMarker();
         _loc8_ = this.handleXMLRegular(xmlObject.firstChild,xmlObject);
         this.theSource.addPerformanceEntry("S",this.metrics.readMarker(),_loc8_);
         return undefined;
      }
   }
   function handleXMLRegular(xmlRoot, xmlObject)
   {
      this.debug("handleXMLRegular ()");
      var _loc3_ = "undefined";
      this.theSource.dispatchGotXMLMessageEvent(xmlObject);
      this.theSource.setSocketConnectionStartTime(this.theSource.getTimerS());
      var _loc9_ = xmlRoot;
      if(_loc9_ == null || _loc9_ == undefined)
      {
         this.debug("Internal error: incoming XML message does not have a root node!");
         return undefined;
      }
      this.debug("XML object\'s root node name: " + _loc9_.nodeName);
      if(_loc9_.nodeName == "message")
      {
         this.debug("Found BR root element, going deeper ...");
         var _loc7_ = _loc9_.childNodes;
         if(_loc7_ == null)
         {
            this.debug("Internal error: no child nodes found in root");
            return undefined;
         }
         var _loc6_ = 0;
         while(_loc6_ < _loc7_.length)
         {
            this.debug("Examining child node: " + _loc7_[_loc6_].nodeName);
            if(_loc7_[_loc6_].nodeName == "properties")
            {
               var _loc5_ = _loc7_[_loc6_].childNodes;
               var _loc4_ = 0;
               while(_loc4_ < _loc5_.length)
               {
                  if(_loc5_[_loc4_].nodeName == "MessageType")
                  {
                     _loc3_ = _loc5_[_loc4_].firstChild.nodeValue;
                     this.debug("Found properties node, obtaining message type [" + _loc3_ + "]...");
                     if(_global.theShell.getStartStateEndHappened() == false)
                     {
                        if(_loc3_ == "AssociatedRules")
                        {
                           this.debug("Skipping message, mtype = " + _loc3_);
                           return _loc3_;
                        }
                     }
                     this.handleXMLMain(_loc3_,xmlObject,_loc5_);
                     return _loc3_;
                  }
                  _loc4_ = _loc4_ + 1;
               }
            }
            _loc6_ = _loc6_ + 1;
         }
      }
      this.debug("Internal error: no message node found, aborting parsing ...");
      return _loc3_;
   }
   function handleXMLMain(brMessageType, xmlObject, xmlChildren)
   {
      this.debug("handleXMLMain (" + xmlChildren.length + ")");
      var brSelection = "undefined";
      var brAction = "undefined";
      var brInput = "undefined";
      var brTransaction_id = "undefined";
      var brBuggyMessage = "undefined";
      var brIndicator = "undefined";
      var brSuccessMessage = "undefined";
      var brErrorType = "undefined";
      var brErrorDetails = "undefined";
      var brTutorAdvice = "undefined";
      var brEvaluation = "undefined";
      var brToolSelection = "undefined";
      var brEndfTransaction = "false";
      var brSkillsObject = null;
      var skillsFound = false;
      var x = 0;
      while(x < xmlChildren.length)
      {
         var child = xmlChildren[x];
         switch(child.nodeName)
         {
            case "BuggyMsg":
               brBuggyMessage = child.firstChild.nodeValue;
               break;
            case "Indicator":
               brIndicator = child.firstChild.nodeValue;
               break;
            case "SuccessMsg":
               brSuccessMessage = child.firstChild.nodeValue;
               break;
            case "ErrorType":
               brErrorType = child.firstChild.nodeValue;
               break;
            case "Details":
               brErrorDetails = child.firstChild.nodeValue;
               break;
            case "TutorAdvice":
               this.theSource.hintList.parseXML(child);
               brTutorAdvice = this.theSource.hintList.getFirstHint();
               break;
            case "action_evaluation":
               brEvaluation = child.firstChild.nodeValue;
               break;
            case "tool_selection":
               brToolSelection = child.firstChild.nodeValue;
               break;
            case "HintsMessage":
               this.theSource.hintList.parseXML(child);
               break;
            case "end_of_transaction":
               brEndfTransaction = child.firstChild.nodeValue;
               break;
            case "Skills":
               this.theSource.skillSet.touchSkills();
               brSkillsObject = this.processSkills(xmlChildren[x]);
               skillsFound = true;
         }
         x++;
      }
      if(brMessageType == "InterfaceAction")
      {
         this.debug("brMessageType==InterfaceAction");
         this.SAI = new edu.cmu.hcii.ctat.CTATSAI();
         this.SAI.parseSAI(xmlChildren);
         brSelection = this.SAI.selection;
         brAction = this.SAI.action;
         brInput = this.SAI.input;
         brTransaction_id = this.SAI.transaction;
         this.debug("SAI: selection=" + this.SAI.selection + " action=" + this.SAI.action + " input=" + this.SAI.input);
         var comp = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         for(var i in comp)
         {
            var ref = comp[i];
            if(ref.refname == this.SAI.selection)
            {
               ref.refinput = this.SAI.input;
               ref.refaction = this.SAI.action;
            }
         }
         var tempArray = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         var tempString = "";
         for(var i in tempArray)
         {
            var ref = tempArray[i];
            tempString = tempString + ref.refname + " " + ref.refinput + " " + ref.refaction + "\n";
         }
         this.debug("ComponentList\n" + tempString);
         if(brSelection == "done")
         {
            this.debug("brSelection=done");
            brSelection = this.checkForTarget(brSelection,brAction,brInput,"_level0","doneButton");
         }
         if(_global.theShell.getStartStateEndHappened() == true)
         {
            this.as2eval.logTutorPerformedToolMsg(brTransaction_id,brSelection,brAction,brInput);
         }
         var dummySkills = new Array();
         var isTPA = this.as2eval.isTutorPerformedAction(brAction);
         if(isTPA == true)
         {
            this.debug("The interface action is a tutor performed action");
            this.as2eval.handleTutorPerformedAction(brTransaction_id,brSelection,brAction,brInput,"CORRECT",brSuccessMessage,dummySkills,brMessageType);
         }
         else if(this.SAI.selObject.commType == "textInput" || this.SAI.selObject.commType == "textArea")
         {
            this.debug("Processing Interface Action for CommTextInput or CommTextArea");
            if(this.SAI.action != "setText" && this.SAI.action != "UpdateTextArea" && this.SAI.action != "UpdateTextField")
            {
               this.debug("Calling interface action on text component that isn\'t \'setText\':" + brAction);
               this.SAI.selObject[brAction](brInput,this.SAI);
            }
            else
            {
               this.SAI.selObject.setText(brInput);
               this.theSource.lockTheWidget(this.SAI.selObject);
            }
         }
         else if(this.SAI.selObject.commType == "checkBox")
         {
            this.debug("Processing Interface Action for checkBox");
            this.SAI.selObject.selected = true;
            this.SAI.selObject.showStartState();
            this.theSource.lockTheWidget(this.SAI.selObject);
         }
         else if(brAction == "UpdateRadioButton")
         {
            this.debug("Processing Interface Action for UpdateRadioButton");
            var colonIndex = brInput.indexOf(":");
            brSelection = brInput.substring(0,colonIndex);
            this.SAI.selObject.selected = true;
            this.SAI.selObject.showStartState();
            this.theSource.lockTheWidget(this.SAI.selObject);
            this.theSource.showFeedbackForRadioButtons("_level0",this.SAI.selObject.getGroupName(),this.SAI.selObject,true);
         }
         else if(this.SAI.selObject.commType == "comboBox")
         {
            this.debug("Processing Interface Action for CommComboBox");
            var testSelection = this.SAI.selObject;
            if(testSelection == null || testSelection == undefined)
            {
               this.debug("Error: can\'t find combobox instance: " + brSelection);
            }
            else
            {
               testSelection.setSelectedLabel(brInput);
            }
            this.theSource.lockTheWidget(this.SAI.selObject);
         }
         else if(this.SAI.selObject.commType == "listBox")
         {
            this.debug("Processing Interface Action for listBox");
            var idx = 0;
            while(idx < this.SAI.selObject.getLength())
            {
               if(this.SAI.selObject.getItemAt(idx).label == brInput)
               {
                  this.SAI.selObject.selectedIndex = idx;
               }
               idx++;
            }
            this.theSource.lockTheWidget(this.SAI.selObject);
         }
         else if(this.SAI.selObject.commType == "doneButton")
         {
            this.debug("Processing Interface Action for doneButton");
            this.theSource.lockTheWidget(this.SAI.selObject);
         }
         else if(this.SAI.selObject.commType == "SimpleAudioButton")
         {
            this.debug("Processing Interface Action for SimpleAudioButton");
            this.theSource.lockTheWidget(this.SAI.selObject);
         }
         else if(this.SAI.selObject.commType == "videoAudioButton")
         {
            this.debug("Processing Interface Action for videoAudioButton");
            this.theSource.lockTheWidget(this.SAI.selObject);
         }
         else if(this.SAI.selObject.commType == "mediaMultipleSelection" || this.SAI.selObject.commType == "multipleSelection" || this.SAI.selObject.commType == "jumble")
         {
            this.debug("Processing Interface Action for mediaMultipleSelection, multipleSelection or jumble");
            this.theSource.lockTheWidget(this.SAI.selObject);
         }
         else
         {
            this.debug("Processing Interface Action for default action");
            if(this.SAI.selObject[brAction] != undefined)
            {
               this.debug("The selection contains the action we\'re looking for. We\'ll try to call the method: " + brAction + " on the selection: " + brSelection + " with argument: " + brInput);
               if(brInput == undefined || brInput == null)
               {
                  this.SAI.selObject[brAction]("null",this.SAI);
               }
               else
               {
                  this.SAI.selObject[brAction](brInput,this.SAI);
               }
            }
            else
            {
               this.debug("The selection " + brSelection + " does not contain the method: " + brAction + ", completely bottoming out, attempting to call setStartState () ...");
               if(this.SAI.selection == null || this.SAI.selection == undefined)
               {
                  this.debug("Internal error: the selection is undefined in the SAI object!");
               }
               else
               {
                  this.debug("Attempting to call setStartState method on component instance ...");
                  this.SAI.selObject.setStartState(brSelection,brAction,brInput,brTransaction_id);
               }
            }
         }
         if(_global.theShell.getStartStateEndHappened() == true)
         {
            this.theSource.CloseHintWindow(true);
         }
         return undefined;
      }
      if(brMessageType == "InterfaceDescription")
      {
         this.debug("brMessageType==InterfaceDescription");
         this.SAI = new edu.cmu.hcii.ctat.CTATSAI();
         this.SAI.parseSAI(xmlChildren);
         brSelection = this.SAI.selection;
         brAction = this.SAI.action;
         brInput = this.SAI.input;
         brTransaction_id = this.SAI.transaction;
         this.debug("SAI: selection=" + this.SAI.selection + " action=" + this.SAI.action + " input=" + this.SAI.input);
         var comp = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         for(var i in comp)
         {
            var ref = comp[i];
            if(ref.refname == this.SAI.selection)
            {
               ref.refinput = this.SAI.input;
               ref.refaction = this.SAI.action;
            }
         }
         var tempArray = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         var tempString = "";
         for(var i in tempArray)
         {
            var ref = tempArray[i];
            tempString = tempString + ref.refname + " " + ref.refinput + " " + ref.refaction + "\n";
         }
         this.debug("ComponentList\n" + tempString);
         if(brSelection == "done")
         {
            this.debug("brSelection=done");
            brSelection = this.checkForTarget(brSelection,brAction,brInput,"_level0","doneButton");
         }
         var brWidgetType = "undefined";
         var brWidgetName = "undefined";
         var brJessTemplates = "undefined";
         var brJessInstances = "undefined";
         var v = 0;
         while(v < xmlChildren.length)
         {
            var vchild = xmlChildren[v];
            switch(vchild.nodeName)
            {
               case "WidgetType":
                  brWidgetType = vchild.firstChild.nodeValue;
                  break;
               case "DorminName":
                  brWidgetName = vchild.firstChild.nodeValue;
                  break;
               case "jessDeftemplates":
                  var val = vchild.firstChild;
                  if(val.nodeName == "value")
                  {
                     brJessTemplates = val.firstChild.nodeValue;
                  }
                  else
                  {
                     this.debug("Error: no value found for Version element");
                  }
                  break;
               case "jessInstances":
                  var val = vchild.firstChild;
                  if(val.nodeName == "value")
                  {
                     brJessInstances = val.firstChild.nodeValue;
                  }
                  else
                  {
                     this.debug("Error: no value found for Version element");
                  }
            }
            v++;
         }
         var evalSelection = eval(brSelection);
         var evalDormin = eval(brWidgetName);
         this.debug("commType = " + evalSelection.commType + "  brSelection = " + brSelection + "  brAction = " + brAction);
         this.debug("commType = " + evalDormin.commType + "  brSelection = " + brWidgetName);
         if(brJessTemplates != undefined && brJessTemplates != null)
         {
            if(brJessInstances != undefined && brJessInstances != null)
            {
               this.debug("Parsing Jess instances ...");
               var jessParser = new edu.cmu.hcii.ctat.CTATJessParser(brJessInstances);
               var jessProcessor = new edu.cmu.hcii.ctat.CTATJessProcessor();
               jessProcessor.process(brWidgetType,brWidgetName,jessParser);
            }
            else
            {
               this.debug("Warning: no Jess instances found in interface description message");
            }
         }
         else
         {
            this.debug("Warning: no Jess templates found in interface description message");
         }
         this.xml_loader = new edu.cmu.hcii.ctat.CTATXML2Object();
         this.as2obj = this.xml_loader.parseXML(xmlObject);
         var iProperties = this.as2obj.message.properties;
         if(iProperties.Selection.value.data != undefined)
         {
            this.setScaffoldingFromInterfaceDescription(iProperties);
         }
         else
         {
            this.debug("iProperties.Selection.value.data == undefined");
         }
         return undefined;
      }
      if(brMessageType == "ShowHintsMessage")
      {
         this.debug("brMessageType==ShowHintsMessage");
         this.SAI = new edu.cmu.hcii.ctat.CTATSAI();
         this.SAI.parseSAI(xmlChildren);
         brSelection = this.SAI.selection;
         brAction = this.SAI.action;
         brInput = this.SAI.input;
         brTransaction_id = this.SAI.transaction;
         this.debug("SAI: selection=" + this.SAI.selection + " action=" + this.SAI.action + " input=" + this.SAI.input);
         var comp = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         for(var i in comp)
         {
            var ref = comp[i];
            if(ref.refname == this.SAI.selection)
            {
               ref.refinput = this.SAI.input;
               ref.refaction = this.SAI.action;
            }
         }
         var tempArray = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         var tempString = "";
         for(var i in tempArray)
         {
            var ref = tempArray[i];
            tempString = tempString + ref.refname + " " + ref.refinput + " " + ref.refaction + "\n";
         }
         this.debug("ComponentList\n" + tempString);
         this.theSource.forwardTransactionID = brTransaction_id;
         if(brSelection == "done")
         {
            this.debug("brSelection=done");
            brSelection = this.checkForTarget(brSelection,brAction,brInput,"_level0","doneButton");
         }
         if(brSelection == "hint")
         {
            this.debug("brSelection=hint");
         }
         var compSelection;
         if(brAction == "UpdateRadioButton")
         {
            var colonIndex = brInput.indexOf(":");
            compSelection = brInput.substring(0,colonIndex);
         }
         else
         {
            compSelection = brSelection;
         }
         this.theSource.theCurrentFocus = eval(compSelection);
         if(this.theSource.theCurrentFocus.commType == "textInput" || this.theSource.theCurrentFocus.commType == "textArea")
         {
            this.theSource.setCurrentTabFocus(this.theSource.theCurrentFocus);
         }
         else if(this.theSource.theCurrentFocus.commType == "checkBox")
         {
            this.debug("Checking highlight applicability for checkBox ...");
         }
         else
         {
            this.debug("Applying default \'setCurrentTabFocus ()\'");
            this.theSource.setCurrentTabFocus(this.theSource.theCurrentFocus);
         }
         this.theSource.setTheCurrentHighlight(this.theSource.theCurrentFocus);
         this.theSource.assembleHintsforShowHint(eval(compSelection),brAction,brInput,this.theSource.hintList.hints,null);
         return undefined;
      }
      if(brEndfTransaction != null && brEndfTransaction != undefined)
      {
         this.debug("Processing end of transaction indicator");
         if(brEndfTransaction == "true" || brEndfTransaction == "TRUE")
         {
            _global.theShell.processEndofTransaction();
         }
      }
      if(brMessageType == "TutoringServiceAlert")
      {
         var brTextForUser = "undefined";
         var brDiagnosticText = "undefined";
         var brUserEffect = "undefined";
         var l = 0;
         while(l < xmlChildren.length)
         {
            this.debug("Examining version node: " + xmlChildren[l].nodeName);
            if(xmlChildren[l].nodeName == "TextForUser")
            {
               brTextForUser = xmlChildren[l].firstChild.nodeValue;
            }
            if(xmlChildren[l].nodeName == "DiagnosticText")
            {
               brDiagnosticText = xmlChildren[l].firstChild.nodeValue;
            }
            if(xmlChildren[l].nodeName == "UserEffect")
            {
               brUserEffect = xmlChildren[l].firstChild.nodeValue;
            }
            l++;
         }
         var sht = new edu.cmu.hcii.ctat.CTATShellTools();
         sht.displayMessage(brTextForUser,brDiagnosticText,brUserEffect);
         return undefined;
      }
      if(brMessageType == "AuthorModeChange")
      {
         this.debug("brMessageType==AuthorModeChange");
         var brOldMode = "undefined";
         var brNewMode = "undefined";
         var m = 0;
         while(m < xmlChildren.length)
         {
            switch(xmlChildren[m].nodeName)
            {
               case "oldMode":
                  brOldMode = xmlChildren[m].firstChild.nodeValue;
                  break;
               case "newMode":
                  brNewMode = xmlChildren[m].firstChild.nodeValue;
            }
            m++;
         }
         this.processModeChange(brOldMode,brNewMode);
         return undefined;
      }
      if(brMessageType == "ConfirmDone")
      {
         this.debug("brMessageType==ConfirmDone");
         _global.theShell.scrim.setGrading(true);
         this.theSource.createDoneLVmsg(null,_level0.curriculum_service_url,_level0.user_guid,_level0.session_id,_level0.student_problem_id,_level0.school_name,_level0.admit_code,"fakeSuccess");
         return undefined;
      }
      if(brMessageType == "VersionInfo")
      {
         this.debug("brMessageType==VersionInfo");
         var k = 0;
         while(k < xmlChildren.length)
         {
            var kchild = xmlChildren[k];
            this.debug("Examining version node: " + kchild.nodeName);
            switch(kchild.nodeName)
            {
               case "Version":
                  _global.linkData.serviceInfo.serviceVersion = kchild.firstChild.nodeValue;
                  break;
               case "Build_Number":
                  _global.linkData.serviceInfo.buildNumber = kchild.firstChild.nodeValue;
                  break;
               case "Build_Date":
                  _global.linkData.serviceInfo.buildDate = kchild.firstChild.nodeValue;
                  break;
               case "NtpDate":
                  _global.linkData.serviceInfo.NtpDate = kchild.firstChild.nodeValue;
                  break;
               case "NtpMillis":
                  _global.linkData.serviceInfo.NtpMillis = new Date(Number(kchild.firstChild.nodeValue));
                  _global.linkData.serviceInfo.ServerOffset = Number(new Date().getTime() - _global.linkData.serviceInfo.NtpMillis.getTime());
                  break;
               case "NtpServer":
                  _global.linkData.serviceInfo.NtpServer = kchild.firstChild.nodeValue;
            }
            k++;
         }
         _global.linkData.serviceInfo.transaction_id = brTransaction_id;
         this.debug("-> " + _global.linkData.serviceInfo.serviceVersion + ", " + _global.linkData.serviceInfo.buildNumber + ", " + _global.linkData.serviceInfo.buildDate + ", " + _global.linkData.serviceInfo.transaction_id + ", " + _global.linkData.serviceInfo.NtpDate + ", " + _global.linkData.serviceInfo.NtpMillis.getTime() + ", " + _global.linkData.serviceInfo.ServerOffset);
         if(_global.linkData.serviceInfo.SendServerTimeStamp == true)
         {
            this.debug("log the server timestamp");
            var stampSelection = "NtpDate";
            var stampAction = "NtpTimeCheck";
            var stampInput = _global.linkData.serviceInfo.NtpDate;
            var pmessageName = new Array("server_name","server_time_millis","calculated_offset");
            var pmessageText = new Array(_global.linkData.serviceInfo.NtpServer,_global.linkData.serviceInfo.NtpMillis.getTime(),_global.linkData.serviceInfo.ServerOffset);
            var catcher = new Array();
            _global.theShell.getLogClassReference().logToolMsgSimple(stampSelection,stampAction,stampInput,pmessageName,pmessageText,catcher);
            _global.linkData.serviceInfo.SendServerTimeStamp = false;
         }
         return undefined;
      }
      if(brMessageType == "ProblemSummaryResponse")
      {
         this.debug("brMessageType==ProblemSummaryResponse");
         _global.theShell.clientLogger.logProblemComplete();
         var w = 0;
         while(w < xmlChildren.length)
         {
            this.debug("Examining summary node: " + xmlChildren[w].nodeName);
            if(xmlChildren[w].nodeName == "ProblemSummary")
            {
               this.theSource.processSummary(xmlChildren[w].firstChild.nodeValue);
               return undefined;
            }
            w++;
         }
         return undefined;
      }
      if(brMessageType == "AssociatedRules")
      {
         this.debug("brMessageType==AssociatedRules");
         if(skillsFound == false)
         {
            this.debug("No skill info found, resetting datastructure ...");
            this.theSource.skillSet.touchSkills();
         }
         this.SAI = new edu.cmu.hcii.ctat.CTATSAI();
         this.SAI.parseSAI(xmlChildren);
         brSelection = this.SAI.selection;
         brAction = this.SAI.action;
         brInput = this.SAI.input;
         brTransaction_id = this.SAI.transaction;
         this.debug("SAI: selection=" + this.SAI.selection + " action=" + this.SAI.action + " input=" + this.SAI.input);
         var comp = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         for(var i in comp)
         {
            var ref = comp[i];
            if(ref.refname == this.SAI.selection)
            {
               ref.refinput = this.SAI.input;
               ref.refaction = this.SAI.action;
            }
         }
         var tempArray = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         var tempString = "";
         for(var i in tempArray)
         {
            var ref = tempArray[i];
            tempString = tempString + ref.refname + " " + ref.refinput + " " + ref.refaction + "\n";
         }
         this.debug("ComponentList\n" + tempString);
         if(brSelection == "done")
         {
            this.debug("brSelection=done");
            brSelection = this.checkForTarget(brSelection,brAction,brInput,"_level0","doneButton");
         }
         this.debug("brToolSelection: " + brToolSelection);
         var brSemanticNameOverride = "RESULT";
         if(brTransaction_id == this.theSource.forwardTransactionID)
         {
            this.debug("Processing associated rules for hint button press ...");
            brSemanticNameOverride = "HINT_MSG";
         }
         else
         {
            this.debug("Processing regular associated rules logging ...");
         }
         if(brSkillsObject != null && brSkillsObject != undefined)
         {
            this.debug("Assigning skills list to cache ...");
            this.theSource.arTheSkillArray = brSkillsObject;
         }
         else
         {
            this.debug("Error, we do not have a valid skills object");
         }
         this.handleAssociatedRules(brTransaction_id,brSelection,brAction,brInput,brIndicator,null,brTutorAdvice,xmlObject,brEvaluation,brToolSelection,brSkillsObject,brSemanticNameOverride);
         return undefined;
      }
      if(brMessageType == "TutoringServiceError")
      {
         this.debug("brMessageType==TutoringServiceError");
         this.debug("handleXMLMain : TutoringServiceError in handleXMLMain : Creating Feedback Window ");
         if(brErrorType = "Load Problem Error")
         {
            this.theSource.Feedback("The Tutoring Service is having difficult loading the BRD specified in Flashvars.\nIt says: " + brErrorDetails + "\n" + "A typical way to fix this error is to change the Flashvars section of your tutor HTML," + " if this does not fix the error, you may need to change the location of the BRD file " + "inside your Tutoring Service directory." + "If you can\'t resolve this problem, please contact the <font color=\'#0000FF\'><u><a href=\'mailto:datashop-help@lists.andrew.cmu.edu\'>Data Shop</a></u></font> or <font color=\'#0000FF\'><u><a href=\'mailto:ctat-support@lists.andrew.cmu.edu\'>CTAT</a></u></font>. ",false);
         }
         else
         {
            this.theSource.Feedback("The Tutoring Service reported an error.\nIt says: " + brErrorDetails + "\n" + "If you can\'t resolve this problem, please contact the <font color=\'#0000FF\'><u><a href=\'mailto:ctat-support@lists.andrew.cmu.edu\'>CTAT</a></u></font>. ",false);
         }
         return undefined;
      }
      if(brMessageType == "StartNewProblem")
      {
         this.debug("brMessageType==StartNewProblem");
         this.theSource.dispatchNewProblemEvent();
      }
      if(brMessageType == "StateGraph")
      {
         this.debug("brMessageType==StateGraph");
         this.handleStateGraph(xmlChildren);
         return undefined;
      }
      if(brMessageType == "StartProblem" || brMessageType == "StartNewProblem")
      {
         if(brMessageType == "StartProblem")
         {
            this.debug("brMessageType==StartProblem");
            this.setStartProblem();
         }
         this.resetInterface(brMessageType);
         return undefined;
      }
      if(brMessageType == "StartStateCreated")
      {
         this.debug("brMessageType==StartStateCreated");
         this.theSource.dispatchStartStateCreatedEvent();
         this.setStartStateCompletedFlagInComponents("_level0");
         return undefined;
      }
      if(brMessageType == "StartStateEnd")
      {
         this.debug("brMessageType==StartStateEnd");
         this.setStartStateEnd();
         return undefined;
      }
      if(brMessageType == "ResetAction")
      {
         this.theSource.dispatchResetActionEvent();
         return undefined;
      }
      if(brMessageType == "InterfaceForceQuit")
      {
         this.debug("brMessageType==InterfaceForceQuit");
         this.theSource.setForceQuitStatus(true);
         this.theSource.dispatchForceQuitStatusEvent();
         return undefined;
      }
      if(brMessageType == "CorrectAction")
      {
         this.debug("brMessageType==CorrectAction");
         this.SAI = new edu.cmu.hcii.ctat.CTATSAI();
         this.SAI.parseSAI(xmlChildren);
         brSelection = this.SAI.selection;
         brAction = this.SAI.action;
         brInput = this.SAI.input;
         brTransaction_id = this.SAI.transaction;
         this.debug("SAI: selection=" + this.SAI.selection + " action=" + this.SAI.action + " input=" + this.SAI.input);
         var comp = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         for(var i in comp)
         {
            var ref = comp[i];
            if(ref.refname == this.SAI.selection)
            {
               ref.refinput = this.SAI.input;
               ref.refaction = this.SAI.action;
            }
         }
         var tempArray = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         var tempString = "";
         for(var i in tempArray)
         {
            var ref = tempArray[i];
            tempString = tempString + ref.refname + " " + ref.refinput + " " + ref.refaction + "\n";
         }
         this.debug("ComponentList\n" + tempString);
         if(brSelection == "done")
         {
            this.debug("brSelection=done");
            brSelection = this.checkForTarget(brSelection,brAction,brInput,"_level0","doneButton");
         }
         if(eval(brSelection).commType == "doneButton")
         {
            _global.theShell.scrim.setGrading(true);
         }
         var dummySkills = new Array();
         if(this.as2eval.isTutorPerformedAction(brAction) == true)
         {
            this.debug("handleCorrect : 2");
            this.as2eval.handleTutorPerformedAction(brTransaction_id,brSelection,brAction,brInput,"CORRECT",brSuccessMessage,dummySkills,brMessageType);
            this.debug("handleCorrect : 3");
         }
         else
         {
            this.debug("handleCorrect : 4");
            this.handleCorrect(brTransaction_id,brSelection,brAction,brInput,"CORRECT",brSuccessMessage,dummySkills);
            this.debug("handleCorrect : 5");
         }
         return undefined;
      }
      if(brMessageType == "InCorrectAction")
      {
         this.debug("brMessageType==InCorrectAction");
         this.SAI = new edu.cmu.hcii.ctat.CTATSAI();
         this.SAI.parseSAI(xmlChildren);
         brSelection = this.SAI.selection;
         brAction = this.SAI.action;
         brInput = this.SAI.input;
         brTransaction_id = this.SAI.transaction;
         this.debug("SAI: selection=" + this.SAI.selection + " action=" + this.SAI.action + " input=" + this.SAI.input);
         var comp = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         for(var i in comp)
         {
            var ref = comp[i];
            if(ref.refname == this.SAI.selection)
            {
               ref.refinput = this.SAI.input;
               ref.refaction = this.SAI.action;
            }
         }
         var tempArray = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         var tempString = "";
         for(var i in tempArray)
         {
            var ref = tempArray[i];
            tempString = tempString + ref.refname + " " + ref.refinput + " " + ref.refaction + "\n";
         }
         this.debug("ComponentList\n" + tempString);
         if(brSelection == "done")
         {
            this.debug("brSelection=done");
            brSelection = this.checkForTarget(brSelection,brAction,brInput,"_level0","doneButton");
         }
         this.debug("brMessageType==InCorrectAction");
         var dummySkills = new Array();
         this.handleIncorrect(brTransaction_id,brSelection,brAction,brInput,"INCORRECT",brBuggyMessage,dummySkills);
         return undefined;
      }
      if(brMessageType == "HighlightMsg")
      {
         this.debug("brMessageType==HighlightMsg");
         this.SAI = new edu.cmu.hcii.ctat.CTATSAI();
         this.SAI.parseSAI(xmlChildren);
         brSelection = this.SAI.selection;
         brAction = this.SAI.action;
         brInput = this.SAI.input;
         brTransaction_id = this.SAI.transaction;
         this.debug("SAI: selection=" + this.SAI.selection + " action=" + this.SAI.action + " input=" + this.SAI.input);
         var comp = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         for(var i in comp)
         {
            var ref = comp[i];
            if(ref.refname == this.SAI.selection)
            {
               ref.refinput = this.SAI.input;
               ref.refaction = this.SAI.action;
            }
         }
         var tempArray = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         var tempString = "";
         for(var i in tempArray)
         {
            var ref = tempArray[i];
            tempString = tempString + ref.refname + " " + ref.refinput + " " + ref.refaction + "\n";
         }
         this.debug("ComponentList\n" + tempString);
         if(brSelection == "done")
         {
            this.debug("brSelection=done");
            brSelection = this.checkForTarget(brSelection,brAction,brInput,"_level0","doneButton");
         }
         var brHighlightMsgText = "undefined";
         var u = 0;
         while(u < xmlChildren.length)
         {
            if(xmlChildren[u].nodeName == "HighlightMsgText")
            {
               brHighlightMsgText = xmlChildren[u].firstChild.nodeValue;
            }
            u++;
         }
         this.debug("Highlighting: " + brSelection + " for: " + eval(brSelection).commType);
         this.theSource.Feedback(brHighlightMsgText,false);
         this.theSource.dispatchHighlightMessageEvent();
         this.theSource.setTheCurrentHighlight(eval(brSelection));
         if(eval(brSelection).commType == "radioButton" || brAction == "UpdateRadioButton")
         {
            this.debug("Highlighting radio group ...");
            this.theSource.highlightRadio("_level0",eval(brSelection).getGroupName(),eval(brSelection),true);
         }
         else
         {
            this.debug("Calling highlight on desired component: " + brSelection);
            eval(brSelection).highlight();
         }
         return undefined;
      }
      if(brMessageType == "BuggyMessage")
      {
         this.debug("brMessageType==BuggyMessage");
         this.theSource.Feedback(brBuggyMessage,false);
         this.theSource.dispatchBuggyMessageEvent();
         return undefined;
      }
      if(brMessageType == "SuccessMessage")
      {
         this.debug("brMessageType==SuccessMessage");
         this.theSource.Feedback(brSuccessMessage,true);
         this.theSource.dispatchSuccessMessageEvent();
         return undefined;
      }
      if(brMessageType == "IsTutorVisible")
      {
         this.debug("brMessageType==IsTutorVisible");
         this.theSource.dispatchIsTutorVisibleEvent();
         return undefined;
      }
      if(brMessageType == "LoadBRDFileSuccess")
      {
         this.debug("brMessageType==LoadBRDFileSuccess");
         this.theSource.dispatchLoadBRDFileSuccessEvent();
         return undefined;
      }
      if(brMessageType == "SendWidgetLock")
      {
         this.debug("brMessageType==SendWidgetLock");
         this.theSource.dispatchSendWidgetLockEvent();
         return undefined;
      }
      if(brMessageType == "ShowLoginWindow")
      {
         this.debug("brMessageType==ShowLoginWindow");
         this.theSource.dispatchShowLoginWindowEvent();
         return undefined;
      }
   }
   function processConfirmDone()
   {
      this.debug("processConfirmDone");
      clearInterval(this.doneTimer);
      this.theSource.createDoneLVmsg(null,_level0.curriculum_service_url,_level0.user_guid,_level0.session_id,_level0.student_problem_id,_level0.school_name,_level0.admit_code,"fakeSuccess");
   }
   function processModeChange(oldMode, newMode)
   {
      this.debug("processModeChange ()");
      this.theSource.setShellMode(oldMode,newMode);
   }
   function handleStateGraph(xmlChildren)
   {
      this.debug("handleStateGraph (" + xmlChildren.toString() + ")");
      if(xmlChildren.length == 0)
      {
         return undefined;
      }
      var _loc4_ = "false";
      var _loc8_ = "false";
      var _loc9_ = "false";
      var _loc7_ = "false";
      var _loc5_ = "false";
      var _loc6_ = "false";
      var _loc2_ = 0;
      while(_loc2_ < xmlChildren.length)
      {
         switch(xmlChildren[_loc2_].nodeName)
         {
            case "firstCheckAllStates":
               _loc4_ = xmlChildren[_loc2_].nodeValue;
               break;
            case "setCaseInsensitive":
               _loc8_ = xmlChildren[_loc2_].nodeValue;
               break;
            case "setUnorderedMode":
               _loc9_ = xmlChildren[_loc2_].firstChild.nodeValue;
               break;
            case "setHighlightRightSelection":
               _loc7_ = xmlChildren[_loc2_].firstChild.nodeValue;
               break;
            case "setEnforceDone":
               _loc5_ = xmlChildren[_loc2_].firstChild.nodeValue;
               break;
            case "setConfirmDone":
               _loc6_ = xmlChildren[_loc2_].firstChild.nodeValue;
               break;
            case "lockWidget":
               this.theSource.LockCorrectAnswers = edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultFalse(xmlChildren[_loc2_].firstChild.nodeValue);
               break;
            case "suppressStudentFeedback":
               this.theSource.suppressStudentFeedback = edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultFalse(xmlChildren[_loc2_].firstChild.nodeValue);
               break;
            case "Skills":
               this.processSkills(xmlChildren[_loc2_]);
         }
         _loc2_ = _loc2_ + 1;
      }
      this.theSource.setFirstCheckAllStates(edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultFalse(_loc4_));
      this.theSource.setCaseInsensitive(edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultFalse(_loc8_));
      this.theSource.setUnorderedMode(edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultTrue(_loc9_));
      this.theSource.setHighlightRightSelection(edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultFalse(_loc7_));
      this.theSource.setEnforceDone(edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultFalse(_loc5_));
      this.theSource.setConfirmDone(edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultFalse(_loc6_));
      this.theSource.showHideHint();
      this.theSource.tutorTheStudent = !this.theSource.suppressStudentFeedback;
      this.debug("parseXML : handleStateGraph :  getFirstCheckAllStates = " + this.theSource.getFirstCheckAllStates());
      this.debug("parseXML : handleStateGraph :  getCaseInsensitive = " + this.theSource.getCaseInsensitive());
      this.debug("parseXML : handleStateGraph :  getUnorderedMode = " + this.theSource.getUnorderedMode());
      this.debug("parseXML : handleStateGraph :  suppressStudentFeedback = " + this.theSource.suppressStudentFeedback);
      this.debug("parseXML : handleStateGraph :  tutorTheStudent = " + this.theSource.tutorTheStudent);
      this.debug("parseXML : handleStateGraph :  getHighlightRightSelection = " + this.theSource.getHighlightRightSelection());
      this.debug("parseXML : handleStateGraph :  getEnforceDone = " + this.theSource.getEnforceDone());
      this.debug("parseXML : handleStateGraph :  getConfirmDone = " + this.theSource.getConfirmDone());
      this.debug("parseXML : handleStateGraph :  DisableSuccessMsgAfterLastHint = " + this.theSource.DisableSuccessMsgAfterLastHint);
   }
   function handleAssociatedRules(theTransaction_id, theSelection, theAction, theInput, theIndicator, theRules, theTutorAdvice, xmlObject, theEvaluation, theToolSelection, theSkillArray, theTutorSemanticName)
   {
      this.debug("handleAssociatedRules ()");
      this.debug("****************************************************");
      this.debug("theTransaction_id:String - " + theTransaction_id);
      this.debug("theSelection:String - " + theSelection);
      this.debug("theAction:String - " + theAction);
      this.debug("theInput:String - " + theInput);
      this.debug("theIndicator:String - " + theIndicator);
      this.debug("theTutorAdvice:String - " + theTutorAdvice);
      this.debug("theEvaluation:String - " + theEvaluation);
      this.debug("theToolSelection:String - " + theToolSelection);
      this.debug("theRules[0]:Array - " + theRules[0]);
      this.debug("theSkillArray:Array - " + theSkillArray.toString());
      this.debug("****************************************************");
      this.theSource.tutorLogResult(theTransaction_id,theSelection,theAction,theInput,theIndicator,theTutorAdvice,theRules,theSkillArray,theTutorSemanticName);
      this.theSource.processAssociatedRules(theTransaction_id,theSelection,theAction,theInput,theIndicator,theTutorAdvice,theRules,theEvaluation,theToolSelection);
   }
   function processSkills(a_skillSet)
   {
      this.debug("processSkills (" + a_skillSet.toString() + ")");
      var _loc2_ = this.theSource.skillSet.processSkills(a_skillSet);
      this.theSource.refreshSkillBar();
      return _loc2_;
   }
   function handleIncorrect(brTransaction_id, brSelection, brAction, brInput, Evaluation, brFailureMessage, arEdgeSkills)
   {
      this.debug("handleIncorrect ()");
      if(eval(brSelection).getOnIncorrectDelay != undefined)
      {
         this.debug("Processing onIncorrect delay for " + eval(brSelection).getOnIncorrectDelay() + " milliseconds ...");
         this.delayedSelection = brSelection;
         this.delayUnlockID = setInterval(this,"delayUnlock",eval(brSelection).getOnIncorrectDelay());
      }
      else
      {
         this.theSource.unblockWidget(eval(brSelection));
      }
      this.theSource.emitInCorrectActionDetectedEvent();
      if(eval(brSelection).commType == "videoAudioButton")
      {
         if(this.theSource.tutorTheStudent == true && this.theSource.suppressStudentFeedback == false)
         {
            eval(brSelection).setResults("Incorrect",brSelection,brAction,brInput,Evaluation);
            eval(brSelection).showCorrect();
         }
         else
         {
            eval(brSelection).setResultsSuppressFeedback("Incorrect",brSelection,brAction,brInput,Evaluation);
         }
      }
      else if(eval(brSelection).commType == "mediaMultipleSelection" || eval(brSelection).commType == "multipleSelection" || eval(brSelection).commType == "jumble")
      {
         if(this.theSource.tutorTheStudent == true && this.theSource.suppressStudentFeedback == false)
         {
            eval(brSelection).setResults("Incorrect",brSelection,brAction,brInput,Evaluation);
            eval(brSelection).showIncorrect();
         }
         else
         {
            eval(brSelection).setResultsSuppressFeedback("Incorrect",brSelection,brAction,brInput,Evaluation);
         }
      }
      else
      {
         var theSelection = this.detectRadioWidget(brInput);
         if(theSelection.isaRadioButton == true)
         {
            brSelection = theSelection.brSelection;
         }
         if(this.theSource.tutorTheStudent == true && this.theSource.suppressStudentFeedback == false)
         {
            eval(brSelection).setResults("Incorrect",brSelection,brAction,brInput,Evaluation);
         }
         else
         {
            eval(brSelection).setResultsSuppressFeedback("Incorrect",brSelection,brAction,brInput,Evaluation);
         }
      }
      this.theSource.clearIncorrectAnswers("_level0",eval(brSelection));
   }
   function delayUnlock()
   {
      this.debug("delayUnlock (" + this.delayedSelection + ")");
      clearInterval(this.delayUnlockID);
      this.theSource.unblockWidgetStr(this.delayedSelection);
   }
   function detectRadioWidget(theInput)
   {
      this.debug("detectRadioWidget ()");
      var brSelection = theInput.split(":")[0];
      var oSelection;
      var inputObject = new Object();
      oSelection = inputObject.brSelection = eval(brSelection);
      if(oSelection.commType == "radioButton")
      {
         inputObject.isaRadioButton = true;
      }
      else
      {
         inputObject.isaRadioButton = false;
      }
      this.debug("detectRadioWidget : theInput = " + theInput + " commType = " + inputObject.brSelection.commType + " brSelection = " + brSelection);
      return inputObject;
   }
   function handleCorrect(brTransaction_id, brSelection, brAction, brInput, Evaluation, brSuccessMessage, arEdgeSkills)
   {
      this.debug("handleCorrect ()");
      this.debug("brTransaction_id = " + brTransaction_id + " brSelection = " + brSelection + " brAction = " + brAction + " brInput = " + brInput + " Evaluation = " + Evaluation + " brSuccessMessage = " + brSuccessMessage);
      this.theSource.unblockWidget(eval(brSelection));
      this.theSource.CloseFeedbackWindow(true);
      this.theSource.emitCorrectActionDetectedEvent();
      if(eval(brSelection).commType == "videoAudioButton")
      {
         this.debug("Processing setResults for videoAudioButton ...");
         if(this.theSource.tutorTheStudent == true && this.theSource.suppressStudentFeedback == false)
         {
            this.debug("We\'re not in suppressed feedback mode");
            eval(brSelection).setResults("Correct",brSelection,brAction,brInput,Evaluation);
         }
         else
         {
            this.debug("We\'re in suppressed feedback mode");
            eval(brSelection).setResultsSuppressFeedback("Correct",brSelection,brAction,brInput,Evaluation);
         }
      }
      else if(eval(brSelection).commType == "mediaMultipleSelection" || eval(brSelection).commType == "multipleSelection" || eval(brSelection).commType == "jumble")
      {
         this.debug("Processing setResults for mediaMultipleSelection, multipleSelection or jumble ...");
         if(this.theSource.tutorTheStudent == true && this.theSource.suppressStudentFeedback == false)
         {
            this.debug("We\'re not in suppressed feedback mode");
            eval(brSelection).setResults("Correct",brSelection,brAction,brInput,Evaluation);
            eval(brSelection).showCorrect();
            eval(brSelection).setCorrectInput(brInput);
            if(this.theSource.LockCorrectAnswers == true)
            {
               this.theSource.lockTheWidget(eval(brSelection));
            }
         }
         else
         {
            this.debug("We\'re in suppressed feedback mode");
            eval(brSelection).setResultsSuppressFeedback("Correct",brSelection,brAction,brInput,Evaluation);
         }
      }
      else
      {
         this.debug("Processing setResults for any other component type ...");
         var theSelection = this.detectRadioWidget(brInput);
         if(theSelection.isaRadioButton == true)
         {
            brSelection = theSelection.brSelection;
         }
         if(this.theSource.tutorTheStudent == true && this.theSource.suppressStudentFeedback == false)
         {
            eval(brSelection).setResults("Correct",brSelection,brAction,brInput,Evaluation,this.theSource.LockCorrectAnswers);
         }
         else
         {
            eval(brSelection).setResultsSuppressFeedback("Correct",brSelection,brAction,brInput,Evaluation);
         }
      }
      this.theSource.CloseHintWindow(true);
      this.theSource.clearIncorrectAnswers("_level0",eval(brSelection));
      this.theSource.createDoneLVmsg(eval(brSelection),_level0.curriculum_service_url,_level0.user_guid,_level0.session_id,_level0.student_problem_id,_level0.school_name,_level0.admit_code,"fakeSuccess");
   }
   function resetInterface(theMessageType)
   {
      this.debug("resetInterface () :  parseXML : StartProblem and StartNewProblem block in handleXML. : theMessageType =  " + theMessageType);
      if(this.theSource.getInitWarning() == false)
      {
         this.theSource.CloseFeedbackWindow();
         this.theSource.CloseHintWindow(true);
      }
      this.theSource.setInitWarning(false);
      this.setComponentsToBlank("_level0");
   }
   function checkForHandle(brSelectionParam, basePathOfClip)
   {
      this.debug("checkForHandle ()");
      var pathOfClip = eval(basePathOfClip);
      for(var p in eval(pathOfClip))
      {
         if(!(pathOfClip[p] instanceof mx.core.UIObject || pathOfClip[p] instanceof mx.core.UIComponent))
         {
            if(typeof pathOfClip[p] == "movieclip")
            {
               this.checkForHandle(brSelectionParam,pathOfClip[p]);
            }
         }
      }
   }
   function checkForTarget(brSelectionParam, brAction, brInput, basePathOfClip, sCommType)
   {
      this.debug("checkForTarget ()");
      var pathOfClip = eval(basePathOfClip);
      this.debug("checkForTarget method.  brSelection =  " + brSelectionParam + " brAction =  " + brAction + " brInput =  " + brInput + "  sCommType = " + sCommType + " basePathOfClip = " + basePathOfClip + " pathOfClip = " + pathOfClip);
      for(var p in eval(pathOfClip))
      {
         if(pathOfClip[p] instanceof mx.core.UIObject || pathOfClip[p] instanceof mx.core.UIComponent)
         {
            if(pathOfClip[p].commType == sCommType)
            {
               this.brSelection = pathOfClip[p];
               this.debug("checkForTarget : Found Done Button : sCommType = " + sCommType + "  brSelection = " + this.brSelection);
               return this.brSelection;
            }
         }
         else if(typeof pathOfClip[p] == "movieclip")
         {
            this.checkForTarget(this.brSelection,brAction,brInput,pathOfClip[p],sCommType);
         }
      }
      this.debug("checkForTarget() :  target could NOT be found in this tutor.  return literal \'done\'.  sCommType = " + sCommType + " brSelectionParam= " + brSelectionParam);
      return "done";
   }
   function setStartStateCompletedFlagInComponents(basePathOfClip)
   {
      this.debug("setStartStateCompletedFlagInComponents ()");
      var pathOfClip = eval(basePathOfClip);
      for(var p in eval(pathOfClip))
      {
         if(pathOfClip[p] instanceof mx.core.UIObject || pathOfClip[p] instanceof mx.core.UIComponent)
         {
            if(pathOfClip[p].commType == "textInput" || pathOfClip[p].commType == "textArea")
            {
               if(pathOfClip[p].textbox.text != "")
               {
                  pathOfClip[p].lock();
               }
            }
            else if(pathOfClip[p].commType == "checkBox")
            {
               if(pathOfClip[p].selected == true)
               {
                  pathOfClip[p].lock();
                  pathOfClip[p].showStartState();
               }
            }
            else if(pathOfClip[p].commType == "radioButton")
            {
               if(pathOfClip[p].selected)
               {
                  pathOfClip[p].showStartState();
                  this.startStateRadio(pathOfClip,pathOfClip[p].getGroupName());
               }
            }
            else if(pathOfClip[p].commType == "comboBox")
            {
               if(pathOfClip[p].selectedIndex != 0)
               {
                  pathOfClip[p].lock();
               }
            }
            else if(pathOfClip[p].commType == "listBox")
            {
               if(pathOfClip[p].selectedIndex != 0)
               {
                  pathOfClip[p].lock();
               }
            }
            else if(pathOfClip[p].commType != "doneButton")
            {
               if(pathOfClip[p].commType == "SimpleAudioButton")
               {
                  pathOfClip[p].lock();
               }
               else if(pathOfClip[p].commType != "videoAudioButton")
               {
                  if(pathOfClip[p].commType == "table")
                  {
                     this.setStartStateCompletedFlagInComponents(pathOfClip[p]);
                  }
                  else if(pathOfClip[p].commType == "mediaMultipleSelection" || pathOfClip[p].commType == "multipleSelection" || pathOfClip[p].commType == "jumble")
                  {
                  }
               }
            }
         }
         else if(typeof pathOfClip[p] == "movieclip")
         {
            this.setStartStateCompletedFlagInComponents(pathOfClip[p]);
         }
      }
   }
   function startStateRadio(basePathOfClip, groupName)
   {
      this.debug("startStateRadio ()");
      var pathOfClip = eval(basePathOfClip);
      for(var p in eval(pathOfClip))
      {
         if(pathOfClip[p] instanceof mx.core.UIObject || pathOfClip[p] instanceof mx.core.UIComponent)
         {
            if(pathOfClip[p].getGroupName() == groupName)
            {
               pathOfClip[p].lock();
            }
         }
         else if(typeof pathOfClip[p] == "movieclip")
         {
            this.startStateRadio(pathOfClip[p],groupName);
         }
      }
   }
   function setComponentsToBlank(basePathOfClip)
   {
      var _loc1_ = new edu.cmu.hcii.ctat.CTATShellTools();
      _loc1_.setComponentsToBlank();
   }
   function startProblemRadio(basePathOfClip, groupName)
   {
      this.debug("startProblemRadio ()");
      var pathOfClip = eval(basePathOfClip);
      for(var p in eval(pathOfClip))
      {
         if(pathOfClip[p] instanceof mx.core.UIObject || pathOfClip[p] instanceof mx.core.UIComponent)
         {
            if(pathOfClip[p].getGroupName() == groupName)
            {
               pathOfClip[p].unlock();
               pathOfClip[p].showNull();
               pathOfClip[p].selected = false;
            }
         }
         else if(typeof pathOfClip[p] == "movieclip")
         {
            this.startProblemRadio(pathOfClip[p],groupName);
         }
      }
   }
   function setStartStateCreated(iProperties)
   {
      this.debug("setStartStateCreated ()");
   }
   function setStartProblem()
   {
      this.debug("setStartProblem ()");
      this.theSource.dispatchStartProblemEvent();
   }
   function setStartStateEnd()
   {
      this.debug("setStartStateEnd ()");
      this.theSource.dispatchStartStateEndEvent();
   }
   function setInterfaceAction(iProperties)
   {
      this.debug("setInterfaceAction ()");
      var brSelection = iProperties.Selection.value.data;
      var brAction = iProperties.Action.value.data;
      var brInput = iProperties.Input.value.data;
      var brTransaction_id = iProperties.transaction_id.data;
      this.debug("setInterfaceAction : \n  brSelection = " + brSelection + "\n  brAction = " + brAction + "\n  brInput = " + brInput);
      if(brAction == "UpdateRadioButton")
      {
         var colonIndex = brInput.indexOf(":");
         brSelection = brInput.substring(0,colonIndex);
      }
      if(this.as2eval.isTutorPerformedAction(brAction) == true)
      {
         this.debug("setInterfaceAction : 1");
         var brMessageType = "InterfaceAction";
         var brSuccessMessage = "";
         var dummySkills = new Array();
         this.as2eval.handleTutorPerformedAction(brTransaction_id,brSelection,brAction,brInput,"CORRECT",brSuccessMessage,dummySkills,brMessageType);
         this.debug("setInterfaceAction : 2");
         return undefined;
      }
      var brSelectionObj = eval(brSelection);
      if(brSelectionObj.commType == "textInput" || brSelectionObj.commType == "textArea")
      {
         brSelectionObj.textbox.text = brInput;
      }
      else if(brSelectionObj.commType == "checkBox")
      {
         brSelectionObj.selected = true;
      }
      else if(brAction == "UpdateRadioButton")
      {
         brSelectionObj.selected = true;
         this.theSource.showFeedbackForRadioButtons("_level0",brSelectionObj.getGroupName(),brSelectionObj,true);
      }
      else if(brSelectionObj.commType == "comboBox")
      {
         var i = 0;
         while(i < brSelectionObj.getLength())
         {
            if(brSelectionObj.getItemAt(i).label == brInput)
            {
               brSelectionObj.setSelectedIndex(i);
            }
            i++;
         }
      }
      else if(!(brSelectionObj.commType == "mediaMultipleSelection" || brSelectionObj.commType == "multipleSelection" || brSelectionObj.commType == "jumble"))
      {
         if(brSelectionObj.commType == "listBox")
         {
            var idx = 0;
            while(idx < brSelectionObj.getLength())
            {
               if(brSelectionObj.getItemAt(idx).label == brInput)
               {
                  brSelectionObj.selectedIndex = idx;
               }
               idx++;
            }
         }
         else
         {
            brSelectionObj.setStartState(brSelection,brAction,brInput,brTransaction_id);
         }
      }
      if(brSelectionObj.commType != undefined)
      {
         this.theSource.lockTheWidget(brSelectionObj);
         brSelectionObj.showStartState();
      }
      this.theSource.CloseHintWindow(true);
   }
   function setScaffoldingFromInterfaceDescription(iProperties)
   {
      this.debug("setScaffoldingFromInterfaceDescription ()");
      this.nAnswerNumber = 0;
      var brSelection = iProperties.Selection.value.data;
      var evalSelection = eval(brSelection);
      var brAction = iProperties.Action.value.data;
      this.debug("_level0.numberLine1 = " + _level0.numberLine1 + " brSelection = " + brSelection + " evalSelection = " + evalSelection + " evalSelection.commType = " + evalSelection.commType + " brAction = " + brAction + " iProperties.MessageType.data  = " + iProperties.MessageType.data);
      evalSelection = eval(brSelection);
      this.setSelectionIntervalID.push(0);
      this.setSelectionIntervalCounter.push(0);
      var idx = this.setSelectionIntervalID.length - 1;
      this.setSelection(iProperties,brSelection,brAction,idx);
   }
   function setSelection(iProperties, brSelection, brAction, idx)
   {
      this.debug("setSelection ()");
      var evalSelection = eval(brSelection);
      this.debug("setSelectionIntervalCounter [" + idx + "] = " + this.setSelectionIntervalCounter[idx] + " brSelection = " + brSelection + " evalSelection = " + evalSelection + " brAction = " + brAction + " idx = " + idx);
      this.setScaffoldingFromInterfaceDescription2(iProperties,evalSelection,brSelection,brAction);
   }
   function setScaffoldingFromInterfaceDescription2(iProperties, evalSelection, brSelection, brAction)
   {
      this.debug("setScaffoldingFromInterfaceDescription2 ()");
      this.debug("brSelection = " + brSelection + " evalSelection = " + evalSelection + " brAction = " + brAction);
      if(evalSelection.commType == "dualListJumble" && brAction == "setDualListProperties")
      {
         this.debug("parseXML : setScaffoldingFromInterfaceDescription : commtype is dualList or action is setDualList");
         if(edu.cmu.hcii.ctat.CTATUtil.inLivePreview() == false)
         {
            evalSelection.setScaffoldingPropertiesFromBRD(evalSelection,brAction,this.brInput,iProperties);
         }
         return undefined;
      }
      if(evalSelection.commType == "jumble" && brAction == "setJumbleDeclarations" || evalSelection.commType == "jumble" && brAction == "JumbleCheckButtonPressed" || evalSelection.commType == "mediaMultipleSelection" && brAction == "MultipleSelectionButtonPressed" || evalSelection.commType == "mediaMultipleSelection" && brAction == "setMSMedia")
      {
         this.debug("parseXML.setScaffoldingFromInterfaceDescription :  now call StoreBrdData repeatedly ");
         evalSelection.storeBrdData(iProperties.setAnswerMediaType.value.data,"setAnswerMediaType");
         evalSelection.storeBrdData(iProperties.setLayoutOrientation.value.data,"setLayoutOrientation");
         evalSelection.storeBrdData(iProperties.setNumberOfAnswers.value.data,"setNumberOfAnswers");
         evalSelection.storeBrdData(iProperties.setQuestionMediaType.value.data,"setQuestionMediaType");
         evalSelection.storeBrdData(iProperties.setStandardError.value.data,"setStandardError");
         evalSelection.storeBrdData(iProperties.setInstructions.value.data,"setInstructions");
         evalSelection.storeBrdData(iProperties.setQuestionData.value.data,"setQuestionData");
         var _loc4_ = 0;
         while(_loc4_ < iProperties.setAnswerData.value.length)
         {
            this.debug("parseXML : AnswerData = " + iProperties.setAnswerData.value[_loc4_].data);
            evalSelection.storeBrdData(iProperties.setAnswerData.value[_loc4_].data,"setAnswerData",this.nAnswerNumber);
            this.nAnswerNumber = this.nAnswerNumber + 1;
            _loc4_ = _loc4_ + 1;
         }
         evalSelection.triggerAssembleInterface();
         return undefined;
      }
      if(evalSelection.commType == "multipleSelection" && brAction == "setMSMedia" || evalSelection.commType == "multipleSelection" && brAction == "MultipleSelectionButtonPressed")
      {
         this.debug("parseXML : setScaffoldingFromInterfaceDescription : commtype is multipleSelection or action is setMSMedia");
         evalSelection.storeBrdData(iProperties.setLayoutOrientation.value.data,"setLayoutOrientation");
         evalSelection.storeBrdData(iProperties.setNumberOfAnswers.value.data,"setNumberOfAnswers");
         evalSelection.storeBrdData(iProperties.setStandardError.value.data,"setStandardError");
         _loc4_ = 0;
         while(_loc4_ < iProperties.setAnswerData.value.length)
         {
            this.debug("parseXML : AnswerData = " + iProperties.setAnswerData.value[_loc4_].data);
            evalSelection.storeBrdData(iProperties.setAnswerData.value[_loc4_].data,"setAnswerData",this.nAnswerNumber);
            this.nAnswerNumber = this.nAnswerNumber + 1;
            _loc4_ = _loc4_ + 1;
         }
         this.nAnswerNumber = 0;
         evalSelection.triggerAssembleInterface();
         return undefined;
      }
      this.debug("parseXML 1 : setScaffoldingFromInterfaceDescription : general case for ID messages");
      if(edu.cmu.hcii.ctat.CTATUtil.inLivePreview() == false)
      {
         this.debug("parseXML 2 : setScaffoldingFromInterfaceDescription : general case for ID messages evalSelection = " + evalSelection + " evalSelection.commType = " + evalSelection.commType);
         evalSelection.setScaffoldingPropertiesFromBRD(iProperties);
         this.debug("parseXML 3 : setScaffoldingFromInterfaceDescription : general case for ID messages evalSelection = " + evalSelection + " evalSelection.commType = " + evalSelection.commType);
      }
      return undefined;
   }
   function checkInterfacDescriptionExceptions(evalSelection, brSelection, brAction)
   {
      var _loc2_ = "";
      if(evalSelection == undefined)
      {
         return undefined;
      }
      if(evalSelection.commType == undefined && evalSelection.getCommType() == undefined)
      {
         _loc2_ = _loc2_ + "EXCEPTION : parseXML.setInterfaceDescription : ";
         _loc2_ = _loc2_ + ("The BRD cotains a Interface Description message that names a component (selection) as \'" + evalSelection + "\' ");
         _loc2_ = _loc2_ + ("but there is apparently no component with that Instance Name on the Stage (no commType " + evalSelection.commType + "). ");
         _loc2_ = _loc2_ + "The likely cause of this problem is a mis-named in the BRD Interface Description message. ";
      }
      if(brSelection.indexOf("instance") != -1)
      {
         var _loc5_ = undefined;
         _loc5_ = _loc5_ + "EXCEPTION : parseXML.setInterfaceDescription : ";
         _loc5_ = _loc5_ + ("The BRD has a Interface Description message wherein the selection (" + brSelection + ") has a machien assigned name. ");
         _loc5_ = _loc5_ + "This is bad practice and often leads to lack of assignment. ";
         this.debug("Shell : checkInterfacDescriptionExceptions \n excMsg = " + _loc5_);
      }
      if(evalSelection.commType == "dualListJumble" && brAction != "setDualListProperties" || evalSelection.commType == "jumble" && !(brAction == "setJumbleDeclarations" || brAction == "JumbleCheckButtonPressed") || evalSelection.commType == "mediaMultipleSelection" && !(brAction == "setMSMedia" || brAction == "MultipleSelectionButtonPressed") || evalSelection.commType == "multipleSelection" && !(brAction == "setMSMedia" || brAction == "MultipleSelectionButtonPressed"))
      {
         _loc2_ = _loc2_ + "EXCEPTION : parseXML.setInterfaceDescription : ";
         _loc2_ = _loc2_ + "There is a mis-match in the type of component and the action in the BRD Interface Description msg. ";
         _loc2_ = _loc2_ + ("The component commType is  \'" + evalSelection.commType + "\' whle the Action is  \'" + brAction + "\'. ");
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_loc2_))
      {
         this.displayMsgForInterfacDescriptionExceptions(_loc2_);
      }
   }
   function displayMsgForInterfacDescriptionExceptions(theFeedbackMsg)
   {
      this.debug(theFeedbackMsg);
      var _loc2_ = false;
      this.theSource.Feedback(theFeedbackMsg,_loc2_);
   }
}
