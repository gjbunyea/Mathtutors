class edu.cmu.hcii.ctat.CTATCommShellLogging extends edu.cmu.hcii.ctat.CTATCommShellRoot
{
   static var symbolName = "CTATCommShellLogging";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATCommShellLogging);
   var className = "CTATCommShellLogging";
   var ParentClassName = "CTATCommShellRoot";
   function CTATCommShellLogging()
   {
      super();
   }
   function init()
   {
      super.init();
      this.setClassType("CTATCommShellLogging");
      this.debug("init ()");
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
   }
   function getLogClass()
   {
      return this.internalLogger;
   }
   function newSession()
   {
      this.debug("newSession ()");
      this.getLogClass().simpleSessionLog(_level0.log_service_url,_level0.auth_token,_level0.session_id,_level0.user_guid);
   }
   function newProblem()
   {
      this.debug("newProblem ()");
      var _loc3_ = this.getLogClass().createContextMessageTransferData();
      var _loc2_ = new edu.cmu.hcii.ctat.CTATLoggingData();
      this.getLogClass().startProblem(_loc2_.getDefaultDataObj(_loc3_));
      this.problemStarted = true;
   }
   function externalTutorLogResult(brSelectionRT, brActionRT, brInputRT, theActionEvaluation, brSuccessMessage, arSkill)
   {
      this.debug("externalTutorLogResult ()");
      var _loc2_ = edu.cmu.hcii.ctat.CTATGuid.create();
      this.tutorLogResult(_loc2_,brSelectionRT,brActionRT,brInputRT,theActionEvaluation,brSuccessMessage,arSkill);
   }
   function toolLogAttempt(mySelection, myAction, myInput, pmessageName, pmessageText)
   {
      this.debug("toolLogAttempt ()");
      var _loc3_ = new Array();
      var _loc4_ = this.getLogClass().logToolMsgSimple(mySelection,myAction,myInput,pmessageName,pmessageText,_loc3_);
      var _loc2_ = _loc3_[0];
      if(_loc2_ != null)
      {
         var _loc5_ = undefined;
         try
         {
            this.callMonitorLog(_loc2_);
         }
         finally
         {
         }
      }
      else
      {
         this.debug("Error: no associated rules string created");
      }
      return _loc4_;
   }
   function toolLogAttemptFull(theTransactionID, mySelection, myAction, myInput, theSemanticTrigger, theSemanticSubType, theToolSemanticName)
   {
      this.debug("toolLogAttemptFull ()");
      var _loc2_ = this.getLogClass().logAttemptFull(theTransactionID,theSemanticTrigger,theSemanticSubType,mySelection,myAction,myInput,theToolSemanticName);
      if(_loc2_ != null)
      {
         var _loc3_ = undefined;
         try
         {
            this.callMonitorLog(_loc2_);
         }
         finally
         {
         }
      }
      else
      {
         this.debug("Error: no associated rules string created");
      }
   }
   function tutorLogResult(theTransactionID, brSelectionRT, brActionRT, brInputRT, theActionEvaluation, brSuccessMessage, arSkill, brSkillArray, brTutorSemanticName)
   {
      this.debug("tutorLogResult ()");
      this.debug("Tutor advice: " + brSuccessMessage);
      var _loc6_ = new Array();
      var _loc5_ = new Array();
      var _loc3_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < arSkill.length)
      {
         _loc3_ = arSkill[_loc2_].split(" ");
         _loc6_.push(_loc3_[0]);
         _loc5_.push(_loc3_[1]);
         _loc2_ = _loc2_ + 1;
      }
      var _loc10_ = brSuccessMessage;
      var _loc7_ = this.getLogClass().logResult(theTransactionID,brSelectionRT,brActionRT,brInputRT,theActionEvaluation,brSuccessMessage,_loc6_,_loc5_,brSkillArray,brTutorSemanticName);
      if(_loc7_ != null)
      {
         var _loc8_ = undefined;
         try
         {
            this.callMonitorLog(_loc7_);
         }
         finally
         {
         }
      }
      else
      {
         this.debug("Error: no associated rules string created");
      }
   }
   function toolLogHintRequest(theTransactionID, mySelection, myAction, myInput)
   {
      this.debug("toolLogHintRequest ()");
      var _loc2_ = this.getLogClass().logHintRequest(theTransactionID,mySelection,myAction,myInput);
      if(_loc2_ != null)
      {
         var _loc3_ = undefined;
         try
         {
            this.callMonitorLog(_loc2_);
         }
         finally
         {
         }
      }
      else
      {
         this.debug("Error: no associated rules string created");
      }
      return undefined;
   }
   function tutorLogHintMessage(theTransactionID, theHintSelection, theHintAction, theHintInput, theActionEvaluation, theText, theHintLevel, theNumberOfHints, arSkill)
   {
      this.debug("tutorLogHintMessage ()");
      var _loc6_ = new Array();
      var _loc5_ = new Array();
      var _loc3_ = new Array();
      this.debug("Processing skills array (" + arSkill.length + ") ...");
      var _loc2_ = 0;
      while(_loc2_ < arSkill.length)
      {
         this.debug("Converting skill: " + arSkill[_loc2_]);
         _loc3_ = arSkill[_loc2_].split(" ");
         _loc6_.push(_loc3_[0]);
         _loc5_.push(_loc3_[1]);
         _loc2_ = _loc2_ + 1;
      }
      var _loc7_ = this.getLogClass().logHintMessage(theTransactionID,theHintSelection,theHintAction,theHintInput,theActionEvaluation,theText,theHintLevel,theNumberOfHints,_loc6_,_loc5_);
      if(_loc7_ != null)
      {
         var _loc8_ = undefined;
         try
         {
            this.callMonitorLog(_loc7_);
         }
         finally
         {
         }
      }
      else
      {
         this.debug("Error: no associated rules string created");
      }
   }
   function callMonitorLog(messageString)
   {
      this.debug("callMonitorLog ()");
      this.debug("Message provided to user defined method: " + messageString);
      if(this._MonitorLog != null)
      {
         var myNavFunction = eval("_level0." + this._MonitorLog);
         myNavFunction(messageString);
      }
      else
      {
         this.debug("Warning: No Associated Rules Log Parameter provided");
      }
   }
   function logVideo(ptheSelection, ptheSelectionID, ptheAction, ptheActionID, ptheInput, ptheInputID, messageText)
   {
      this.debug("logVideo ()");
      this.getLogClass().logVideo(ptheSelection,ptheSelectionID,ptheAction,ptheActionID,ptheInput,ptheInputID,messageText);
   }
   function getLogClassReference()
   {
      return this.getLogClass();
   }
   function createDoneLVmsg(widget, curriculum_service_url, user_guid, session_id, student_problem_id, school_name, admit_code, theSuccessMessage)
   {
      this.debug("createDoneLVmsg ()");
      this.debug("Done 0 : effectivelyDone(widget) = " + this.effectivelyDone(widget) + "  widget._name = " + widget._name);
      if(this.effectivelyDone(widget) == false)
      {
         this.debug("createDoneLVmsg : Not effectively done so do nothing");
      }
      else if(this.effectivelyDone(widget) == true)
      {
         this.debug("createDoneLVmsg : Done 1 :  this.BRDFileName = " + this.__get__BRDFileName() + "  getTheCurrentBRDindex() = " + this.getTheCurrentBRDindex() + "  getTheBRDFiles().length = " + this.getTheBRDFiles().length);
         this.dispatchEvent({type:"doneWithProblem",target:this,problemWidget:widget});
         if(this.getTheCurrentBRDindex() < this.getTheBRDFiles().length - 1)
         {
            widget.showNextButton();
            this.debug("createDoneLVmsg : Done 2 :  More Questions Remain  :  dispatch repetitionReady : \n getTheCurrentBRDindex() = " + this.getTheCurrentBRDindex() + "\n getTheBRDFiles().length = " + this.getTheBRDFiles().length);
            this.dispatchEvent({type:"repetitionReady",target:this});
            return undefined;
         }
         this.debug("createDoneLVmsg : Done 3 :  call sendDoneLVmsg");
         var _loc3_ = "In createDoneLVmsg, the parameter  ";
         var _loc2_ = "is not valid. You should check to see if it is set in flashvars and being sent from your delivery app (e.g., OLI or TutorShop). ";
         try
         {
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(curriculum_service_url) == false)
            {
               throw new Error(_loc3_ + "curriculum_service_url  " + _loc2_);
            }
            else if(edu.cmu.hcii.ctat.CTATUtil.checkValid(user_guid) == false)
            {
               throw new Error(_loc3_ + "user_guid  " + _loc2_);
            }
            else if(edu.cmu.hcii.ctat.CTATUtil.checkValid(session_id) == false)
            {
               throw new Error(_loc3_ + "session_id  " + _loc2_);
            }
            else if(edu.cmu.hcii.ctat.CTATUtil.checkValid(student_problem_id) == false)
            {
               throw new Error(_loc3_ + "student_problem_id  " + _loc2_);
            }
            else if(edu.cmu.hcii.ctat.CTATUtil.checkValid(school_name) == false)
            {
               throw new Error(_loc3_ + "school_name  " + _loc2_);
            }
            else if(edu.cmu.hcii.ctat.CTATUtil.checkValid(admit_code) == false)
            {
               throw new Error(_loc3_ + "admit_code  " + _loc2_);
            }
            else
            {
            }
         }
         catch(myError:Error)
         {
            this.debug("EXCEPTION : " + myError);
         }
         this.handleCompletedTutorsForTutorShop(widget,curriculum_service_url,user_guid,session_id,student_problem_id,school_name,admit_code,theSuccessMessage);
      }
   }
   function handleCompletedTutorsForTutorShop(widget, curriculum_service_url, user_guid, session_id, student_problem_id, school_name, admit_code, theSuccessMessage)
   {
      this.debug("handleCompletedTutorsForTutorShop ()");
      this.debug("cmd defaults to doneNextData");
      try
      {
         this.debug("handleCompletedTutorsForTutorShop : curriculum_service_url = " + curriculum_service_url + " confirmDone = " + this.confirmDone);
         var _loc5_ = "doneNextData";
         if(this.confirmDone == true)
         {
            mx.controls.Alert.okLabel = "I\'m Done";
            mx.controls.Alert.buttonWidth = 110;
            mx.controls.Alert.cancelLabel = "Double Check";
            mx.controls.Alert.show("Are you sure you are done?","Confirm Done",mx.controls.Alert.OK | mx.controls.Alert.CANCEL,null,com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.userConfirmedDone_callback,widget),"stockIcon",mx.controls.Alert.OK);
            var _loc6_ = String(widget);
            var _loc3_ = "ButtonPressed";
            var _loc7_ = "-1";
            var _loc8_ = new Array("description");
            var _loc4_ = new Array("The student pressed the done button or equivelant causing the confirmation dialog to appear.");
            _global.theShell.getLogClassReference().logToolMsgSimple(_loc6_,_loc3_,_loc7_,_loc8_,_loc4_);
         }
         else
         {
            this.debug("handleCompletedTutorsForTutorShop : NO CONFIRMATION : call decideDelay ... :  curriculum_service_url = " + curriculum_service_url + " confirmDone = " + this.confirmDone);
            this.decideDelaySendDoneLVmsg(curriculum_service_url,user_guid,session_id,student_problem_id,school_name,admit_code,_loc5_,theSuccessMessage);
         }
      }
      catch(myError:Error)
      {
         this.debug("EXCEPTION : " + myError);
         return undefined;
      }
   }
   function decideDelaySendDoneLVmsg(curriculum_service_url, user_guid, session_id, student_problem_id, school_name, admit_code, cmd, theSuccessMessage)
   {
      this.debug("decideDelaySendDoneLVmsg (" + cmd + ")");
      if(this.__get__BehaviorRecorder() == "RunTime")
      {
         this.debug("RUNTIME OH NO");
      }
      else
      {
         clearInterval(this.delayThenSendDoneLVmsgInterval);
         this.delayThenSendDoneLVmsgInterval = setInterval(this,"delayThenSendDoneLVmsg",1000,curriculum_service_url,user_guid,session_id,student_problem_id,school_name,admit_code,cmd);
      }
      this.debug("delaySendDoneLVmsg : repetitionComplete :  this.BRDFileName = " + this.__get__BRDFileName() + "  getTheCurrentBRDindex() = " + this.getTheCurrentBRDindex() + "  getTheBRDFiles().length = " + this.getTheBRDFiles().length);
      this.repetitionDone = true;
      this.dispatchEvent({type:"repetitionComplete",target:this});
   }
   function sendImmediately(curriculum_service_url, user_guid, session_id, student_problem_id, school_name, admit_code, cmd)
   {
      this.debug("sendImmediately ()");
      this.debug("sendImmediately : No Success Message : send done msg immediately ");
      this.sendDoneLVmsg(curriculum_service_url,user_guid,session_id,student_problem_id,school_name,admit_code,cmd);
   }
   function sendDoneLVmsg(curriculum_service_url, user_guid, session_id, student_problem_id, school_name, admit_code, cmd)
   {
      this.debug("sendDoneLVmsg ()");
      this.debug("cmd: " + cmd + " lvType: " + this.__get__LVMethodForSendDone());
      if(arguments.length != 7)
      {
         this.debug("EXCEPTION : sendDoneLVmsg : too few arguments. There should be 7 but there are " + arguments.length);
      }
      if(this.obtainSummary == false)
      {
         this.debug("obtainSummary==false, directly sending tutorshop message ...");
         var _loc3_ = new edu.cmu.hcii.ctat.CTATTutorShopManage(this);
         _loc3_.sendDoneLVmsg(curriculum_service_url,user_guid,session_id,student_problem_id,school_name,admit_code,cmd,this.__get__LVMethodForSendDone(),this.createSummary());
      }
      else
      {
         this.debug("Requesting summary from tutorshop, storing tutorshop message ...");
         this.tutorcache = new edu.cmu.hcii.ctat.CTATTutorShopMessage(curriculum_service_url,user_guid,session_id,student_problem_id,school_name,admit_code,cmd,this.__get__LVMethodForSendDone());
         this.requestSummary();
      }
   }
   function userConfirmedDone_callback(evt, widget, delegate)
   {
      this.debug("userConfirmedDone_callback ()");
      this.debug("userConfirmedDone_callback :   evt.detail  = " + evt.detail);
      var _loc6_ = "doneNext";
      if(evt.detail == mx.controls.Alert.OK)
      {
         this.debug("userConfirmedDone_callback : OKKKKK :   evt.detail  = " + evt.detail);
         this.sendImmediately(this.serviceURL,_level0.user_guid,_level0.session_id,_level0.student_problem_id,_level0.school_name,_level0.admit_code,_loc6_);
         var _loc7_ = "Confirmation_Alert_Dialog_OK";
         var _loc4_ = "ButtonPressed";
         var _loc8_ = "-1";
         var _loc9_ = new Array("description");
         var _loc5_ = new Array("The student pressed the \'Im Done\' confirmation button on the confirmation dialog to posistively avance to the next problem or page.");
         _global.theShell.getLogClassReference().logToolMsgSimple(_loc7_,_loc4_,_loc8_,_loc9_,_loc5_);
      }
      else
      {
         this.debug("userConfirmedDone_callback : Cancel :   evt.detail  = " + evt.detail);
         this.endGrading();
         _loc7_ = "Confirmation_Alert_Dialog_Cancel";
         _loc4_ = "ButtonPressed";
         _loc8_ = "-1";
         _loc9_ = new Array("description");
         _loc5_ = new Array("The student pressed the \'Double Check\' confirmation button on the confirmation dialog to cancel the skip prolem action.");
         _global.theShell.getLogClassReference().logToolMsgSimple(_loc7_,_loc4_,_loc8_,_loc9_,_loc5_);
      }
   }
   function delayThenSendDoneLVmsg(curriculum_service_url, user_guid, session_id, student_problem_id, school_name, admit_code, cmd)
   {
      this.debug("delayThenSendDoneLVmsg ()");
      this.debug("delayThenSendDoneLVmsg :  1 : delayThenSendDoneLVmsgCounter = " + this.delayThenSendDoneLVmsgCounter + "  Time = " + getTimer() / 1000);
      if(this.delayThenSendDoneLVmsgCounter > 2)
      {
         this.debug("delayThenSendDoneLVmsg :  2 : delayThenSendDoneLVmsgCounter = " + this.delayThenSendDoneLVmsgCounter + "  Time = " + getTimer() / 1000);
         clearInterval(this.delayThenSendDoneLVmsgInterval);
         this.sendDoneLVmsg(curriculum_service_url,user_guid,session_id,student_problem_id,school_name,admit_code,cmd);
         this.delayThenSendDoneLVmsgCounter = 0;
         return undefined;
      }
      this.delayThenSendDoneLVmsgCounter = this.delayThenSendDoneLVmsgCounter + 1;
   }
   function sendLVmsgFlashvars(cmd)
   {
      this.debug("sendLVmsgFlashvars ()");
      this.sendDoneLVmsg(this.serviceURL,_level0.user_guid,_level0.session_id,_level0.student_problem_id,_level0.school_name,_level0.admit_code,cmd);
   }
   function createSummary()
   {
      var _loc1_ = "<ProblemSummary problemName=\"problemName\" Hints=\"3\" UniqueHints=\"4\" Errors=\"5\" UniqueErrors=\"6\"><Skills><Skill skill=\"Adding\" p_guess=\"0.4\" p_known=\"0.5\" p_slip=\"0.6\" p_learn=\"0.7\" /></Skills></ProblemSummary>";
      return _loc1_;
   }
   function requestSummary()
   {
      this.debug("requestSummary ()");
      this.sendXML("<message><verb>NotePropertySet</verb><properties><MessageType>ProblemSummaryRequest</MessageType></properties></message>");
   }
   function requestTutorServiceVersion()
   {
      this.debug("requestTutorServiceVersion ()");
      this.sendXML("<message><verb>NotePropertySet</verb><properties><MessageType>VersionInfo</MessageType></properties></message>");
   }
   function pingSummary()
   {
      this.debug("pingSummary ()");
      this.sumping = true;
      this.sendXML("<message><verb>NotePropertySet</verb><properties><MessageType>ProblemSummaryRequest</MessageType></properties></message>");
   }
   function processSummary(a_summary)
   {
      this.debug("processSummary ()");
      this.sumcache = a_summary;
      if(this.sumping == false)
      {
         this.debug("Sending summary to TutorShop Manager (or IES)");
         var _loc2_ = new edu.cmu.hcii.ctat.CTATTutorShopManage(this);
         _loc2_.sendDoneLVmsg(this.tutorcache.curriculum_service_url,this.tutorcache.user_guid,this.tutorcache.session_id,this.tutorcache.student_problem_id,this.tutorcache.school_name,this.tutorcache.admit_code,this.tutorcache.cmd,this.tutorcache.LVMethodForSendDone,a_summary);
      }
      else
      {
         this.debug("Sending summary to requesting object ...");
         this.dispatchEvent({target:this,type:"processSummaryPing"});
      }
      this.callMonitorLog(a_summary);
      this.sumping = false;
   }
   function getSummary()
   {
      return this.sumcache;
   }
}
