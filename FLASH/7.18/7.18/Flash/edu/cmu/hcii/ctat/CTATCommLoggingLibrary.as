class edu.cmu.hcii.ctat.CTATCommLoggingLibrary extends edu.cmu.hcii.ctat.CTATCommLoggingLibraryBase
{
   var className = "CTATCommLoggingLibrary";
   static var metaDataHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<tutor_related_message_sequence version_number=\"4\">\n";
   var problemStarted = false;
   var startMsgSent = false;
   var shell = null;
   static var static_shell = null;
   var url = "http://tutors.pslc.cs.cmu.edu/tutorshop/log/server";
   var utils = null;
   function CTATCommLoggingLibrary(a_url)
   {
      super();
      this.setClassType("CTATCommLoggingLibrary");
      this.debug("CTATCommLoggingLibrary (" + a_url + ")");
      this.utils = new edu.cmu.hcii.ctat.CTATUtil();
      this.url = a_url;
      this.setTabLevel();
      mx.events.EventDispatcher.initialize(this);
      this.debug(getVersionData());
      this.detectOldShell();
      this.debug("CTATCommLoggingLibrary () Done");
   }
   function dispatchEvent()
   {
   }
   function addEventListener()
   {
   }
   function removeEventListener()
   {
   }
   function setShell(the_shell)
   {
      this.shell = the_shell;
      edu.cmu.hcii.ctat.CTATCommLoggingLibrary.static_shell = the_shell;
      this.debug("CommShell assigned, logging to browser window enabled");
   }
   function classType()
   {
      return this.className;
   }
   function setProblemStarted(isStarted)
   {
      this.problemStarted = isStarted;
   }
   function getProblemStarted()
   {
      return this.problemStarted;
   }
   function setStartMessageSent(theValue)
   {
      this.startMsgSent = theValue;
   }
   function getStartMessageSent()
   {
      return this.startMsgSent;
   }
   function logLoadTutor(dataObj)
   {
      this.debug("logLoadTutor ()");
      this.startProblem(dataObj);
   }
   function logStartTutor(dataObj)
   {
      this.debug("logStartTutor ()");
      this.setTheDataObj(dataObj);
      this.checkArgumentLength(arguments.length,1,"logStartProblem",arguments);
      this.getTheDataObj().setthe_action_msg_type("START_TUTOR");
      this.getTheDataObj().setthe_action_msg_source("TOOL_ACTION");
      this.startProblemFull(this.getTheDataObj());
   }
   function startProblem(dataObj)
   {
      this.debug("startProblem ()");
      this.debug("setdataset_name = " + dataObj.getdataset_name());
      this.setTheDataObj(dataObj);
      this.checkArgumentLength(arguments.length,1,"startProblem",arguments);
      if(this.checkValid(this.getTheDataObj().getthe_action_msg_type()) == false)
      {
         this.getTheDataObj().setthe_action_msg_type("LOAD_TUTOR");
      }
      this.getTheDataObj().setthe_action_msg_source("TOOL_ACTION");
      this.startProblemFull(this.getTheDataObj());
   }
   function startProblemFull(dataObj)
   {
      this.debug("startProblemFull ()");
      this.setTheDataObj(dataObj);
      if(arguments.length > 1)
      {
         this.debug("The library method startProblemFull received too many arguments (" + arguments.length + "). It should have one of type CTATContextMessageTransferData ");
         return undefined;
      }
      if(arguments.length == 0)
      {
         this.debug("The library method startProblemFull received no arguments. It should have one of type CTATContextMessageTransferData.");
         return undefined;
      }
      this.setDefaults(this.getTheDataObj());
      this.sendContextMessage(this.getTheDataObj());
   }
   function logLoadVideo(dataObj)
   {
      this.debug("logLoadVideo ()");
      this.setTheDataObj(dataObj);
      this.checkArgumentLength(arguments.length,1,"logLoadVideo",arguments);
      this.getTheDataObj().setthe_action_msg_type("LOAD_VIDEO");
      this.getTheDataObj().setthe_action_msg_source("TOOL_ACTION");
      this.startProblemFull(this.getTheDataObj());
   }
   function logStartVideo(dataObj)
   {
      this.debug("logStartVideo ()");
      this.setTheDataObj(dataObj);
      this.checkArgumentLength(arguments.length,1,"logStartVideo",arguments);
      this.getTheDataObj().setthe_action_msg_type("START_VIDEO");
      this.getTheDataObj().setthe_action_msg_source("TOOL_ACTION");
      this.startProblemFull(this.getTheDataObj());
   }
   function logLoadAudio(dataObj)
   {
      this.debug("logLoadAudio ()");
      this.setTheDataObj(dataObj);
      this.checkArgumentLength(arguments.length,1,"logLoadAudio",arguments);
      this.getTheDataObj().setthe_action_msg_type("LOAD_AUDIO");
      this.getTheDataObj().setthe_action_msg_source("TOOL_ACTION");
      this.startProblemFull(this.getTheDataObj());
   }
   function logStartAudio(dataObj)
   {
      this.debug("logStartAudio ()");
      this.setTheDataObj(dataObj);
      this.checkArgumentLength(arguments.length,1,"logStartAudio",arguments);
      this.getTheDataObj().setthe_action_msg_type("START_AUDIO");
      this.getTheDataObj().setthe_action_msg_source("TOOL_ACTION");
      this.startProblemFull(this.getTheDataObj());
   }
   function logLoadMedia(dataObj)
   {
      this.debug("logLoadMedia ()");
      this.setTheDataObj(dataObj);
      this.checkArgumentLength(arguments.length,1,"logLoadMedia",arguments);
      this.getTheDataObj().setthe_action_msg_type("LOAD_MEDIA");
      this.getTheDataObj().setthe_action_msg_source("TOOL_ACTION");
      this.startProblemFull(this.getTheDataObj());
   }
   function logStartMedia(dataObj)
   {
      this.debug("logStartMedia ()");
      this.setTheDataObj(dataObj);
      this.checkArgumentLength(arguments.length,1,"logStartMedia",arguments);
      this.getTheDataObj().setthe_action_msg_type("START_MEDIA");
      this.getTheDataObj().setthe_action_msg_source("TOOL_ACTION");
      this.startProblemFull(this.getTheDataObj());
   }
   function checkArgumentLength(nArgs, nCorrect, cSource, theArguments)
   {
      this.debug("checkArgumentLength ()");
      if(nArgs > nCorrect)
      {
         this.debug("EXCEPTION : The library method \'" + cSource + "\' received too many arguments (" + nArgs + "). It should have one of type CTATContextMessageTransferData ");
      }
      else if(nArgs == 0)
      {
         this.debug("EXCEPTION : The library method \'" + cSource + "\' received no arguments. It should have one of type CTATContextMessageTransferData. This exception handler will call getDefaultDataObj to create a CTATContextMessageTransferData object and set defaults based on flashvars values. ");
         this.getDefaultDataObj();
      }
      if(nArgs == 13)
      {
         this.debug("EXCEPTION : The library method \'" + cSource + "\' received 13 arguments but it expects one of type CTATContextMessageTransferData. It appears that you are trying to call the version 1 library method startProblem which had 13 parameters. This method will call startProblemOld with the 13 parameters that you passed. ");
         startProblemOld(theArguments[0],theArguments[1],theArguments[2],theArguments[3],theArguments[4],theArguments[5],theArguments[6],theArguments[7],theArguments[8],theArguments[9],theArguments[10],theArguments[11],theArguments[12]);
      }
      else if(nArgs == 1 && !(theArguments[0] instanceof edu.cmu.hcii.ctat.CTATContextMessageTransferData))
      {
         if(theArguments[0] instanceof String)
         {
            var _loc5_ = "String";
         }
         this.debug("EXCEPTION : The library method \'" + cSource + "\' received 1 argument but it is of type \'" + _loc5_ + "\'. It should have one argument of type CTATContextMessageTransferData. This exception handler will call getDefaultDataObj to create a CTATContextMessageTransferData object and set defaults based on flashvars values. ");
         this.getDefaultDataObj();
      }
   }
   function setTheContextGuid(theValue)
   {
      this._theContextGuid = theValue;
   }
   function getTheContextGuid()
   {
      return this._theContextGuid;
   }
   function sendContextMessage(dataObj)
   {
      this.debug("sendContextMessage ()");
      var _loc6_ = this.getGuid();
      this.setTheContextGuid(_loc6_);
      this.debug("sendContextMessage :   theGuid = " + _loc6_ + "  getTheContextGuid = " + this.getTheContextGuid() + " dataObj = " + dataObj);
      dataObj.setTheCM("abcdefgh");
      this.debug("sendContextMessage :   getTheCM = " + dataObj.getTheCM());
      this.traceDataObject(dataObj);
      this.infoString = edu.cmu.hcii.ctat.CTATCommLoggingLibrary.metaDataHeader;
      this.infoString = this.infoString + ("<context_message context_message_id=\"" + this.getTheContextGuid() + "\" name=\"" + dataObj.getthe_action_msg_type() + "\">\n");
      if(this.existClassElements(dataObj) == true)
      {
         this.infoString = this.infoString + "<class>\n";
         if(this.checkValid(dataObj.getclass_name()) == true)
         {
            this.infoString = this.infoString + ("<name>" + dataObj.getclass_name() + "</name>\n");
         }
         if(this.checkValid(dataObj.getschool_name()) == true)
         {
            this.infoString = this.infoString + ("<school>" + dataObj.getschool_name() + "</school>\n");
         }
         if(this.checkValid(dataObj.getperiod_name()) == true)
         {
            this.infoString = this.infoString + ("<period>" + dataObj.getperiod_name() + "</period>\n");
         }
         if(this.checkValid(dataObj.getclass_description()) == true)
         {
            this.infoString = this.infoString + ("<description>" + dataObj.getclass_description() + "</description>\n");
         }
         if(this.checkValid(dataObj.getinstructor_name()) == true)
         {
            this.infoString = this.infoString + ("<instructor>" + dataObj.getinstructor_name() + "</instructor>\n");
         }
         this.infoString = this.infoString + "</class>\n";
      }
      this.infoString = this.infoString + "<dataset>\n";
      this.infoString = this.infoString + ("<name>" + dataObj.getdataset_name() + "</name>\n");
      var _loc4_ = dataObj.getdataset_level_obj();
      var _loc5_ = dataObj.getdataset_level_obj().type.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc5_)
      {
         if(this.checkValid(_loc4_.type[_loc2_]) == true)
         {
            this.infoString = this.infoString + ("<level type=\"" + _loc4_.type[_loc2_] + "\">\n");
            this.infoString = this.infoString + ("<name>" + _loc4_.name[_loc2_] + "</name>\n");
         }
         _loc2_ = _loc2_ + 1;
      }
      this.infoString = this.infoString + this.getProblemElements(dataObj);
      _loc2_ = 0;
      while(_loc2_ < _loc5_)
      {
         this.infoString = this.infoString + "</level>\n";
         _loc2_ = _loc2_ + 1;
      }
      this.infoString = this.infoString + "</dataset>\n";
      this.infoString = this.infoString + this.getConditionElements(dataObj);
      this.infoString = this.infoString + this.getCustomFieldElements(dataObj);
      this.infoString = this.infoString + "</context_message>\n";
      this.infoString = this.infoString + "</tutor_related_message_sequence>\n";
      this.SendLog(this.infoString,"CONTEXT_ACTION " + dataObj.getthe_action_msg_type());
   }
   function setDefaults(dataObj)
   {
      this.debug("setDefaults ()");
      if(this.checkValid(dataObj.getquestion_file()) == false)
      {
         dataObj.setquestion_file("Question File Not Set in Tutor");
      }
      if(this.checkValid(dataObj.getproblem_name()) == false)
      {
         dataObj.setproblem_name("Problem Name Not Set in Tutor");
      }
      if(this.checkValid(dataObj.getdataset_name()) == false)
      {
         dataObj.setdataset_name("Dataset Name Not Set in Tutor");
      }
      if(this.checkValid(dataObj.getdataset_level_obj().type[0]) == false)
      {
         dataObj.getdataset_level_obj().type[0] = "default level type";
         dataObj.getdataset_level_obj().name[0] = "default level type";
      }
   }
   function getProblemElements(dataObj)
   {
      this.debug("getProblemElements ()");
      var _loc2_ = "";
      _loc2_ = _loc2_ + ("<problem" + this.setTutorFlag(dataObj) + this.setOtherProblemFlag(dataObj) + ">\n");
      _loc2_ = _loc2_ + ("<name>" + dataObj.getproblem_name() + "</name>\n");
      if(this.checkValid(dataObj.getproblem_context()) == true)
      {
         _loc2_ = _loc2_ + ("<context>" + dataObj.getproblem_context() + "</context>\n");
      }
      _loc2_ = _loc2_ + "</problem>\n";
      return _loc2_;
   }
   function getConditionElements(dataObj)
   {
      this.debug("getConditionElements ()");
      var _loc4_ = "";
      if(this.existConditionElements(dataObj) == true)
      {
         var _loc5_ = dataObj.getstudy_condition_obj().name.length;
         var _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc4_ = _loc4_ + "<condition>\n";
            if(this.checkValid(dataObj.getstudy_condition_obj().name[_loc2_]) == true)
            {
               _loc4_ = _loc4_ + ("<name>" + dataObj.getstudy_condition_obj().name[_loc2_] + "</name>\n");
            }
            if(this.checkValid(dataObj.getstudy_condition_obj().type[_loc2_]) == true)
            {
               _loc4_ = _loc4_ + ("<type>" + dataObj.getstudy_condition_obj().type[_loc2_] + "</type>\n");
            }
            if(this.checkValid(dataObj.getstudy_condition_obj().description[_loc2_]) == true)
            {
               _loc4_ = _loc4_ + ("<desc>" + dataObj.getstudy_condition_obj().description[_loc2_] + "</desc>\n");
            }
            _loc4_ = _loc4_ + "</condition>\n";
            _loc2_ = _loc2_ + 1;
         }
      }
      return _loc4_;
   }
   function getCustomFieldElements(dataObj)
   {
      this.debug("getCustomFieldsElement ()");
      var _loc4_ = "";
      var _loc5_ = dataObj.getcustom_field_obj().name.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc5_)
      {
         if(this.checkValid(dataObj.getcustom_field_obj().name[_loc2_]) == true)
         {
            this.debug("getCustomFieldElements :  name [" + _loc2_ + "] = " + dataObj.getcustom_field_obj().name[_loc2_] + " value [" + _loc2_ + "] = " + dataObj.getcustom_field_obj().value[_loc2_]);
            _loc4_ = _loc4_ + "<custom_field>\n";
            if(this.checkValid(dataObj.getcustom_field_obj().name[_loc2_]) == true)
            {
               _loc4_ = _loc4_ + ("<name>" + dataObj.getcustom_field_obj().name[_loc2_] + "</name>\n");
            }
            if(this.checkValid(dataObj.getcustom_field_obj().value[_loc2_]) == true)
            {
               _loc4_ = _loc4_ + ("<value>" + dataObj.getcustom_field_obj().value[_loc2_] + "</value>\n");
            }
            _loc4_ = _loc4_ + "</custom_field>\n";
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function existClassElements(dataObj)
   {
      if(this.checkValid(dataObj.getclass_name()) == true || this.checkValid(dataObj.getschool_name()) == true || this.checkValid(dataObj.getperiod_name()) == true || this.checkValid(dataObj.getclass_description()) == true || this.checkValid(dataObj.getinstructor_name()) == true)
      {
         return true;
      }
      return false;
   }
   function existConditionElements(dataObj)
   {
      if(this.checkValid(dataObj.getstudy_condition_obj().name[0]) == true)
      {
         return true;
      }
      return false;
   }
   function setTutorFlag(dataObj)
   {
      var _loc2_ = "";
      if(this.checkValid(dataObj.getproblem_tutorflag()) == true)
      {
         _loc2_ = " tutorFlag = \"" + dataObj.getproblem_tutorflag() + "\" ";
      }
      return _loc2_;
   }
   function setOtherProblemFlag(dataObj)
   {
      var _loc2_ = "";
      if(dataObj.getproblem_tutorflag() == "other")
      {
         if(this.checkValid(dataObj.getproblem_otherproblemflag()) == true)
         {
            _loc2_ = " other = \"" + dataObj.getproblem_otherproblemflag() + "\" ";
         }
      }
      return _loc2_;
   }
   function checkValid(aVaraible)
   {
      if(aVaraible == null || aVaraible == undefined || aVaraible == "")
      {
         return false;
      }
      return true;
   }
   function checkProblemStartedAndStartMessageSent(semanticEventName)
   {
      this.debug("checkProblemStartedAndStartMessageSent ()");
      this.debug("No longer relevant, the StartStateEnd should take care of this");
      return undefined;
   }
   function logAction(theSelection, theAction, theInput, theActionEvaluation, theText, arSkillName, arSkillCategory)
   {
      this.debug("logAction ()");
      if(arguments.length < 7)
      {
         this.debug("EXCEPTION : The library method logAction received only " + arguments.length + " arguments. It should have seven (7).");
         return undefined;
      }
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc7_ = "";
      var _loc5_ = "";
      var _loc4_ = new Array();
      var _loc6_ = "";
      var _loc3_ = "";
      this.logActionFull(_loc7_,_loc5_,theSelection,theAction,theInput,theActionEvaluation,theText,arSkillName,arSkillCategory,_loc4_,_loc6_,_loc3_);
   }
   function logActionFull(theSemanticTrigger, theSemanticSubType, theSelection, theAction, theInput, theActionEvaluation, theText, arSkillName, arSkillCategory, arSkillModel, theSkillProbability, theSkillBuggy)
   {
      this.debug("logActionFull ()");
      if(arguments.length < 12)
      {
         this.debug("EXCEPTION : The library method logActionFull received only " + arguments.length + " arguments. It should have twelve (12).");
         return undefined;
      }
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      arSkillModel = new Array();
      theSkillProbability = "";
      theSkillBuggy = "";
      this.theTransactionID = this.getGuid();
      var _loc3_ = "ATTEMPT";
      var _loc4_ = "RESULT";
      this.logAttemptFull(this.theTransactionID,theSemanticTrigger,theSemanticSubType,theSelection,theAction,theInput,_loc3_);
      this.logResultFull(this.theTransactionID,theSemanticTrigger,theSemanticSubType,theSelection,theAction,theInput,theActionEvaluation,theText,arSkillName,arSkillCategory,arSkillModel,theSkillProbability,theSkillBuggy,_loc4_);
   }
   function logAttempt(theTransactionID, theSelection, theAction, theInput)
   {
      this.debug("logAttempt ()");
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc4_ = "";
      var _loc3_ = "";
      var _loc2_ = "ATTEMPT";
      this.logAttemptFull(theTransactionID,_loc4_,_loc3_,theSelection,theAction,theInput,_loc2_);
   }
   function logAttemptFull(theTransactionID, theSemanticTrigger, theSemanticSubType, theSelection, theAction, theInput, theSemanticEventName)
   {
      this.debug("logAttemptFull ()");
      if(arguments.length < 7)
      {
         this.debug("EXCEPTION:  The library method logAttemptFull received only " + arguments.length + " arguments. It should have seven (7).  No tool (attempt) message will be logged.");
         return null;
      }
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc7_ = "TOOL_ACTION";
      var _loc3_ = new Array();
      var _loc6_ = new Array();
      var _loc4_ = new Array();
      var _loc8_ = "";
      var _loc5_ = "";
      return this.TutorLog(theTransactionID,_loc7_,theSemanticEventName,theSemanticTrigger,theSemanticSubType,theSelection,theAction,theInput,"","","","",_loc3_,_loc6_,_loc4_,_loc8_,_loc5_);
   }
   function logResult(theTransactionID, theSelection, theAction, theInput, theActionEvaluation, theText, arSkillName, arSkillCategory, brSkillArray, brSemanticNameOverride)
   {
      this.debug("logResult ()");
      if(typeof arguments[6] == "string")
      {
         this.debug("EXCEPTION : The library method logResult has received the wrong parameter type. The last two parameters should be arrays.");
         return null;
      }
      this.debug("Tutor advice: " + theText);
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc9_ = "";
      var _loc7_ = "";
      var _loc6_ = new Array();
      var _loc8_ = "";
      var _loc5_ = "";
      var _loc3_ = "RESULT";
      if(brSemanticNameOverride != NULL && brSemanticNameOverride != undefined)
      {
         this.debug("We have a semantic name override! Using: " + brSemanticNameOverride);
         _loc3_ = brSemanticNameOverride;
      }
      else
      {
         this.debug("We\'re using the defaul RESULT semantic name");
      }
      return this.logResultFull(theTransactionID,_loc9_,_loc7_,theSelection,theAction,theInput,theActionEvaluation,theText,arSkillName,arSkillCategory,_loc6_,_loc8_,_loc5_,_loc3_,brSkillArray);
   }
   function logResultFull(theTransactionID, theSemanticTrigger, theSemanticSubType, theSelection, theAction, theInput, theActionEvaluation, theText, arSkillName, arSkillCategory, arSkillModel, theSkillProbability, theSkillBuggy, theSemanticEventName, brSkillArray)
   {
      this.debug("logResultFull ()");
      if(arguments.length < 14)
      {
         this.debug("EXCEPTION : The library method logResultFull received only " + arguments.length + " arguments. It should have fourteen (14).");
         return null;
      }
      this.debug("Tutor advice: " + theText);
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc5_ = "TUTOR_ACTION";
      var _loc3_ = "";
      var _loc4_ = "";
      return this.TutorLog(theTransactionID,_loc5_,theSemanticEventName,theSemanticTrigger,theSemanticSubType,theSelection,theAction,theInput,theActionEvaluation,theText,_loc3_,_loc4_,arSkillName,arSkillCategory,arSkillModel,theSkillProbability,theSkillBuggy,brSkillArray);
   }
   function logHint(theSelection, theAction, theInput, theActionEvaluation, theText, theHintLevel, theNumberOfHints, arSkillName, arSkillCategory)
   {
      this.debug("logHint ()");
      if(arguments.length < 9)
      {
         this.debug("EXCEPTION : The library method logHint received only " + arguments.length + " arguments. It should have nine (9).");
         return undefined;
      }
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc7_ = "";
      var _loc5_ = "";
      var _loc3_ = new Array();
      var _loc6_ = "";
      var _loc4_ = "";
      this.logHintFull(_loc7_,_loc5_,theSelection,theAction,theInput,theActionEvaluation,theText,theHintLevel,theNumberOfHints,arSkillName,arSkillCategory,_loc3_,_loc6_,_loc4_);
   }
   function logHintFull(theSemanticTrigger, theSemanticSubType, theSelection, theAction, theInput, theActionEvaluation, theText, theHintLevel, theNumberOfHints, arSkillName, arSkillCategory, arSkillModel, theSkillProbability, theSkillBuggy)
   {
      this.debug("logHintFull ()");
      if(arguments.length < 14)
      {
         this.debug("EXCEPTION : The library method logHintFull received only " + arguments.length + " arguments. It should have fourteen (14).");
         return undefined;
      }
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      this.theTransactionID = this.getGuid();
      this.logHintRequestFull(this.theTransactionID,theSemanticTrigger,theSemanticSubType,theSelection,theAction,theInput);
      this.logHintMessageFull(this.theTransactionID,theSemanticTrigger,theSemanticSubType,theSelection,theAction,theInput,theActionEvaluation,theText,theHintLevel,theNumberOfHints,arSkillName,arSkillCategory,arSkillModel,theSkillProbability,theSkillBuggy);
   }
   function logHintRequest(theTransactionID, theSelection, theAction, theInput)
   {
      this.debug("logHintRequest ()");
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc3_ = "";
      var _loc2_ = "";
      return this.logHintRequestFull(theTransactionID,_loc3_,_loc2_,theSelection,theAction,theInput);
   }
   function logHintRequestFull(theTransactionID, theSemanticTrigger, theSemanticSubType, theSelection, theAction, theInput)
   {
      this.debug("logHintRequestFull ()");
      if(arguments.length < 6)
      {
         this.debug("EXCEPTION : The library method logHintRequestFull received only " + arguments.length + " arguments. It should have six (6).");
         return null;
      }
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc8_ = "TOOL_ACTION";
      var _loc6_ = "HINT_REQUEST";
      var _loc3_ = new Array();
      var _loc7_ = new Array();
      var _loc4_ = new Array();
      var _loc9_ = "";
      var _loc5_ = "";
      return this.TutorLog(theTransactionID,_loc8_,_loc6_,theSemanticTrigger,theSemanticSubType,theSelection,theAction,theInput,"","","","",_loc3_,_loc7_,_loc4_,_loc9_,_loc5_);
   }
   function logHintMessage(theTransactionID, theSelection, theAction, theInput, theActionEvaluation, theText, theHintLevel, theNumberOfHints, arSkillName, arSkillCategory)
   {
      this.debug("logHintMessage ()");
      if(arguments.length < 10)
      {
         this.debug("EXCEPTION : The library method logHintMessage received only " + arguments.length + " arguments. It should have ten (10).");
         return null;
      }
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc7_ = "";
      var _loc5_ = "";
      var _loc3_ = new Array();
      var _loc6_ = "";
      var _loc4_ = "";
      return this.logHintMessageFull(theTransactionID,_loc7_,_loc5_,theSelection,theAction,theInput,theActionEvaluation,theText,theHintLevel,theNumberOfHints,arSkillName,arSkillCategory,_loc3_,_loc6_,_loc4_);
   }
   function logHintMessageFull(theTransactionID, theSemanticTrigger, theSemanticSubType, theSelection, theAction, theInput, theActionEvaluation, theText, theHintLevel, theNumberOfHints, arSkillName, arSkillCategory, arSkillModel, theSkillProbability, theSkillBuggy)
   {
      this.debug("logHintMessageFull ()");
      if(arguments.length < 15)
      {
         this.debug("EXCEPTION : The library method logHintMessageFull received only " + arguments.length + " arguments. It should have fifteen (15).");
         return null;
      }
      this.checkProblemStartedAndStartMessageSent("START_TUTOR");
      var _loc4_ = "TUTOR_ACTION";
      var _loc3_ = "HINT_MSG";
      return this.TutorLog(theTransactionID,_loc4_,_loc3_,theSemanticTrigger,theSemanticSubType,theSelection,theAction,theInput,theActionEvaluation,theText,theHintLevel,theNumberOfHints,arSkillName,arSkillCategory,arSkillModel,theSkillProbability,theSkillBuggy);
   }
   function logPlay(theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logPlay ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      this.logPlayAndStop("play",theSelection,theMediaFile,theClipLength,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logMediaPlay(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logMediaPlay ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logPlay(theSelection,theMediaFile,theClipLength,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoPlay(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logVideoPlay ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logPlay(theSelection,theMediaFile,theClipLength,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioPlay(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logAudioPlay ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logPlay(theSelection,theMediaFile,theClipLength,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logRecord(theSelection, theMediaFile, theTime, messageText, semanticEventName)
   {
      this.debug("logRecord ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      var _loc2_ = "NA";
      this.logPlayAndStop("record",theSelection,theMediaFile,_loc2_,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logMediaRecord(theSelection, theMediaFile, theTime, messageText)
   {
      this.debug("logMediaRecord ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logRecord(theSelection,theMediaFile,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoRecord(theSelection, theMediaFile, theTime, messageText)
   {
      this.debug("logVideoRecord ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logRecord(theSelection,theMediaFile,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioRecord(theSelection, theMediaFile, theTime, messageText)
   {
      this.debug("logAudioRecord ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logRecord(theSelection,theMediaFile,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logStop(theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logStop ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      this.logPlayAndStop("stop",theSelection,theMediaFile,theClipLength,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logMediaStop(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logMediaStop ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logStop(theSelection,theMediaFile,theClipLength,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoStop(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logVideoStop ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logStop(theSelection,theMediaFile,theClipLength,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioStop(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logAudioStop ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logStop(theSelection,theMediaFile,theClipLength,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logPause(theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logPause ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      this.logPlayAndStop("pause",theSelection,theMediaFile,theClipLength,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logMediaPause(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logMediaPause ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logPause(theSelection,theMediaFile,theClipLength,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoPause(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logVideoPause ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logPause(theSelection,theMediaFile,theClipLength,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioPause(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logAudioPause ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logPause(theSelection,theMediaFile,theClipLength,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logClose(theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logClose ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      this.logPlayAndStop("close",theSelection,theMediaFile,theClipLength,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logMediaClose(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logMediaClose ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logClose(theSelection,theMediaFile,theClipLength,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoClose(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logVideoClose ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logClose(theSelection,theMediaFile,theClipLength,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioClose(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("LogAudioClose ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logClose(theSelection,theMediaFile,theClipLength,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logEnd(theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logEnd ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      this.logPlayAndStop("end",theSelection,theMediaFile,theClipLength,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logMediaEnd(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logMediaEnd ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logEnd(theSelection,theMediaFile,theClipLength,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoEnd(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logVideoEnd ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logEnd(theSelection,theMediaFile,theClipLength,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioEnd(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logAudioEnd ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logEnd(theSelection,theMediaFile,theClipLength,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logMediaMute(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logMediaMute ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logMute(theSelection,theMediaFile,theClipLength,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoMute(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logVideoMute ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logMute(theSelection,theMediaFile,theClipLength,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioMute(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logAudioMute ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logMute(theSelection,theMediaFile,theClipLength,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logMute(theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logMute ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      this.logPlayAndStop("mute",theSelection,theMediaFile,theClipLength,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logUnmute(theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logUnmute ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      this.logPlayAndStop("unmute",theSelection,theMediaFile,theClipLength,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logMediaUnmute(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logMediaUnmute ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logUnmute(theSelection,theMediaFile,theClipLength,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoUnmute(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logVideoUnmute ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logUnmute(theSelection,theMediaFile,theClipLength,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioUnmute(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logAudioUnmute ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logUnmute(theSelection,theMediaFile,theClipLength,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logNextClip(theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logNextClip ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      this.logPlayAndStop("next_clip",theSelection,theMediaFile,theClipLength,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logMediaNextClip(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logMediaNextClip ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logNextClip(theSelection,theMediaFile,theClipLength,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoNextClip(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logVideoNextClip ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logNextClip(theSelection,theMediaFile,theClipLength,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioNextClip(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logAudioNextClip ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logNextClip(theSelection,theMediaFile,theClipLength,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logPreviousClip(theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logPreviousClip ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      this.logPlayAndStop("prev_clip",theSelection,theMediaFile,theClipLength,theTime,messageText,semanticEventName);
      return undefined;
   }
   function logMediaPreviousClip(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logMediaPreviousClip ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logPreviousClip(theSelection,theMediaFile,theClipLength,theTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoPreviousClip(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logVideoPreviousClip ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logPreviousClip(theSelection,theMediaFile,theClipLength,theTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioPreviousClip(theSelection, theMediaFile, theClipLength, theTime, messageText)
   {
      this.debug("logAudioPreviousClip ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logPreviousClip(theSelection,theMediaFile,theClipLength,theTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logVolumeChange(theSelection, theMediaFile, theClipLength, time, start_level, final_level, messageText, semanticEventName)
   {
      this.debug("logVolumeChange ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      var _loc3_ = new Array(theSelection,theMediaFile,theClipLength);
      var _loc6_ = new Array("","media_file","clip_length");
      var _loc4_ = new Array("volume_change");
      var _loc7_ = new Array("");
      var _loc5_ = new Array(time,start_level,final_level);
      var _loc2_ = new Array("time","start_level","final_level");
      this.logVideo(_loc3_,_loc6_,_loc4_,_loc7_,_loc5_,_loc2_,messageText,semanticEventName);
      return undefined;
   }
   function logMediaVolumeChange(theSelection, theMediaFile, theClipLength, time, start_level, final_level, messageText)
   {
      this.debug("logMediaVolumeChange ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logVolumeChange(theSelection,theMediaFile,theClipLength,time,start_level,final_level,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoVolumeChange(theSelection, theMediaFile, theClipLength, time, start_level, final_level, messageText)
   {
      this.debug("logVideoVolumeChange ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logVolumeChange(theSelection,theMediaFile,theClipLength,time,start_level,final_level,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioVolumeChange(theSelection, theMediaFile, theClipLength, time, start_level, final_level, messageText)
   {
      this.debug("logAudioVolumeChange ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logVolumeChange(theSelection,theMediaFile,theClipLength,time,start_level,final_level,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logCue(theSelection, theMediaFile, theClipLength, theStartTime, theStopTime, messageText, semanticEventName)
   {
      this.debug("logCue ()");
      this.checkProblemStartedAndStartMessageSent(semanticEventName);
      var _loc3_ = new Array(theSelection,theMediaFile,theClipLength);
      var _loc6_ = new Array("","media_file","clip_length");
      var _loc4_ = new Array("cue");
      var _loc7_ = new Array("");
      var _loc5_ = new Array(theStartTime,theStopTime);
      var _loc2_ = new Array("start_cue","stop_cue");
      this.logVideo(_loc3_,_loc6_,_loc4_,_loc7_,_loc5_,_loc2_,messageText,semanticEventName);
      return undefined;
   }
   function logMediaCue(theSelection, theMediaFile, theClipLength, theStartTime, theStopTime, messageText)
   {
      this.debug("logMediaCue ()");
      this.checkProblemStartedAndStartMessageSent("START_MEDIA");
      this.logCue(theSelection,theMediaFile,theClipLength,theStartTime,theStopTime,messageText,"MEDIA_ACTION");
      return undefined;
   }
   function logVideoCue(theSelection, theMediaFile, theClipLength, theStartTime, theStopTime, messageText)
   {
      this.debug("logVideoCue ()");
      this.checkProblemStartedAndStartMessageSent("START_VIDEO");
      this.logCue(theSelection,theMediaFile,theClipLength,theStartTime,theStopTime,messageText,"VIDEO_ACTION");
      return undefined;
   }
   function logAudioCue(theSelection, theMediaFile, theClipLength, theStartTime, theStopTime, messageText)
   {
      this.debug("logAudioCue ()");
      this.checkProblemStartedAndStartMessageSent("START_AUDIO");
      this.logCue(theSelection,theMediaFile,theClipLength,theStartTime,theStopTime,messageText,"AUDIO_ACTION");
      return undefined;
   }
   function logPlayAndStop(theAction, theSelection, theMediaFile, theClipLength, theTime, messageText, semanticEventName)
   {
      this.debug("logPlayAndStop ()");
      var _loc3_ = new Array(theSelection,theMediaFile,theClipLength);
      var _loc6_ = new Array("","media_file","clip_length");
      var _loc4_ = new Array(theAction);
      var _loc7_ = new Array("");
      var _loc5_ = new Array(theTime);
      var _loc2_ = new Array("time");
      this.logVideo(_loc3_,_loc6_,_loc4_,_loc7_,_loc5_,_loc2_,messageText,semanticEventName);
      return undefined;
   }
   function logVideo(ptheSelection, ptheSelectionType, ptheAction, ptheActionType, ptheInput, ptheInputType, messageText, semanticEventName)
   {
      this.debug("logVideo ()");
      if(arguments.length < 7)
      {
         this.debug("EXCEPTION : The library method logVideo received only " + arguments.length + " arguments. It should have seven (7).");
         return undefined;
      }
      this.theTransactionID = this.getGuid();
      var _loc5_ = "";
      var _loc4_ = "";
      var _loc3_ = "";
      var _loc9_ = new Array();
      var _loc6_ = new Array();
      var _loc7_ = new Array();
      var _loc10_ = "";
      var _loc8_ = "";
      this.logVideoFull(this.theTransactionID,_loc5_,_loc4_,ptheSelection,ptheSelectionType,ptheAction,ptheActionType,ptheInput,ptheInputType,_loc3_,messageText,semanticEventName);
   }
   function logVideoFull(theTransactionID, theSemanticTrigger, theSemanticSubType, ptheSelection, ptheSelectionType, ptheAction, ptheActionType, ptheInput, ptheInputType, theActionEvaluation, messageText, theSemanticEventName)
   {
      this.debug("logVideoFull ()");
      if(arguments.length < 11)
      {
         this.debug("EXCEPTION The library method logVideoFull received only " + arguments.length + " arguments. It should have eleven (11).");
         return undefined;
      }
      var _loc3_ = new Array("media message");
      var _loc4_ = new Array(messageText);
      this.logToolMsgFull(theTransactionID,theSemanticTrigger,theSemanticSubType,ptheSelection,ptheSelectionType,ptheAction,ptheActionType,ptheInput,ptheInputType,theActionEvaluation,_loc3_,_loc4_,theSemanticEventName);
      return undefined;
   }
   function logToolMsgSimple(ptheSelection, ptheAction, ptheInput, pmessageName, pmessageText, catcher)
   {
      this.debug("logToolMsgSimple ()");
      this.theTransactionID = this.getGuid();
      var _loc12_ = "";
      var _loc9_ = "";
      var _loc2_ = "ATTEMPT";
      var _loc5_ = "";
      var _loc4_ = new Array(ptheSelection);
      var _loc8_ = new Array("");
      var _loc6_ = new Array(ptheAction);
      var _loc11_ = new Array("");
      var _loc7_ = new Array(ptheInput);
      var _loc3_ = new Array("");
      var _loc10_ = this.logToolMsgFull(this.theTransactionID,_loc12_,_loc9_,_loc4_,_loc8_,_loc6_,_loc11_,_loc7_,_loc3_,_loc5_,pmessageName,pmessageText,_loc2_);
      catcher.push(_loc10_);
      return this.theTransactionID;
   }
   function logToolMsgFull(theTransactionID, theSemanticTrigger, theSemanticSubType, ptheSelection, ptheSelectionType, ptheAction, ptheActionType, ptheInput, ptheInputType, theActionEvaluation, pmessageName, pmessageText, theSemanticEventName)
   {
      this.debug("logToolMsgFull ()");
      if(arguments.length < 13)
      {
         this.debug("EXCEPTION The library method logToolMsgFull received only " + arguments.length + " arguments. It should have thirteen (13).");
      }
      theTransactionID = this.escapeXML(theTransactionID);
      theSemanticTrigger = this.escapeXML(theSemanticTrigger);
      theSemanticSubType = this.escapeXML(theSemanticSubType);
      for(var _loc12_ in ptheSelection)
      {
         ptheSelection[_loc12_] = this.escapeXML(ptheSelection[_loc12_]);
      }
      for(var _loc12_ in ptheSelectionType)
      {
         ptheSelectionType[_loc12_] = this.escapeXML(ptheSelectionType[_loc12_]);
      }
      for(var _loc12_ in ptheAction)
      {
         ptheAction[_loc12_] = this.escapeXML(ptheAction[_loc12_]);
      }
      for(var _loc12_ in ptheActionType)
      {
         ptheActionType[_loc12_] = this.escapeXML(ptheActionType[_loc12_]);
      }
      for(var _loc12_ in ptheInput)
      {
         ptheInput[_loc12_] = this.escapeXML(ptheInput[_loc12_]);
      }
      for(var _loc12_ in ptheInputType)
      {
         ptheInputType[_loc12_] = this.escapeXML(ptheInputType[_loc12_]);
      }
      theActionEvaluation = this.escapeXML(theActionEvaluation);
      for(var _loc12_ in pmessageName)
      {
         pmessageName[_loc12_] = this.escapeXML(pmessageName[_loc12_]);
      }
      for(var _loc12_ in pmessageText)
      {
         pmessageText[_loc12_] = this.escapeXML(pmessageText[_loc12_]);
      }
      var _loc20_ = "TOOL_ACTION";
      this.infoString = edu.cmu.hcii.ctat.CTATCommLoggingLibrary.metaDataHeader;
      if(pmessageName == null)
      {
         this.debug("Incoming pmessage is null");
         pmessageName = new Array();
         pmessageText = new Array();
      }
      var _loc13_ = new Date();
      this.debug("server_adjusted_event_time - timeStamp.getTime(): " + _loc13_.getTime() + " _global.linkData.serviceInfo.ServerOffset: " + _global.linkData.serviceInfo.ServerOffset);
      var _loc15_ = new Date(_loc13_.getTime() - _global.linkData.serviceInfo.ServerOffset);
      pmessageName.push("tool_event_time");
      pmessageText.push(this.FormatTimeStamp(_loc13_) + " UTC");
      pmessageName.push("server_adjusted_event_time");
      pmessageText.push(this.FormatTimeStamp(_loc15_) + " UTC");
      this.infoString = this.infoString + this.createToolMessage(theTransactionID,this.getTheContextGuid(),ptheSelection,ptheSelectionType,ptheAction,ptheActionType,ptheInput,ptheInputType,this.getTheDataObj().getproblem_name(),theSemanticEventName,theSemanticTrigger,theSemanticSubType,pmessageName,pmessageText);
      this.infoString = this.infoString + "</tutor_related_message_sequence>\n";
      this.SendLog(this.infoString,this.getTheDataObj().getthe_action_msg_source() + " " + theSemanticEventName);
      return this.infoString;
   }
   function TutorCreateLog(theTransactionID, theActionMsgSource, theSemanticEventName, theSemanticTrigger, theSemanticSubType, theSelection, theAction, theInput, theActionEvaluation, theText, theHintLevel, theNumberOfHints, arSkillName, arSkillCategory, arSkillModelName, skillProbability, skillBuggy, brSkillArray)
   {
      this.debug("TutorCreateLog ()");
      theTransactionID = this.escapeXML(theTransactionID);
      theActionMsgSource = this.escapeXML(theActionMsgSource);
      theSemanticEventName = this.escapeXML(theSemanticEventName);
      theSemanticTrigger = this.escapeXML(theSemanticTrigger);
      theSemanticSubType = this.escapeXML(theSemanticSubType);
      theSelection = this.escapeXML(theSelection);
      theAction = this.escapeXML(theAction);
      theInput = this.escapeXML(theInput);
      this.debug("Input Action Evaluation Element: " + theActionEvaluation);
      theActionEvaluation = this.escapeXML(theActionEvaluation);
      var _loc10_ = theText;
      this.debug("Processing tutor advice: " + theText);
      if(theText.indexOf("<") != -1 || theText.indexOf(">") != -1 || theText.indexOf("\'") != -1 || theText.indexOf("\"") != -1 || theText.indexOf("&") != -1)
      {
         _loc10_ = "<![CDATA[";
         _loc10_ = _loc10_ + theText;
         _loc10_ = _loc10_ + "]]>";
      }
      theHintLevel = this.escapeXML(theHintLevel);
      theNumberOfHints = this.escapeXML(theNumberOfHints);
      for(var _loc11_ in arSkillName)
      {
         arSkillName[_loc11_] = this.escapeXML(arSkillName[_loc11_]);
      }
      for(var _loc11_ in arSkillCategory)
      {
         arSkillCategory[_loc11_] = this.escapeXML(arSkillCategory[_loc11_]);
      }
      for(var _loc11_ in arSkillModelName)
      {
         arSkillModelName[_loc11_] = this.escapeXML(arSkillModelName[_loc11_]);
      }
      skillProbability = this.escapeXML(skillProbability);
      skillBuggy = this.escapeXML(skillBuggy);
      this.infoString = edu.cmu.hcii.ctat.CTATCommLoggingLibrary.metaDataHeader;
      this.debug("theActionMsgSource = " + theActionMsgSource);
      if(theActionMsgSource == "TOOL_ACTION")
      {
         var _loc28_ = new Array(theSelection);
         var _loc31_ = new Array("");
         var _loc29_ = new Array(theAction);
         var _loc33_ = new Array("");
         var _loc30_ = new Array(theInput);
         var _loc27_ = new Array("");
         var _loc21_ = new Array("tool_event_time","server_adjusted_event_time");
         var _loc16_ = new Date();
         this.debug("server_adjusted_event_time - timeStamp.getTime(): " + _loc16_.getTime() + " _global.linkData.serviceInfo.ServerOffset: " + _global.linkData.serviceInfo.ServerOffset);
         var _loc25_ = new Date(_loc16_.getTime() - _global.linkData.serviceInfo.ServerOffset);
         var _loc23_ = new Array(this.FormatTimeStamp(_loc16_) + " UTC",this.FormatTimeStamp(_loc25_) + " UTC");
         this.debug("arMessageName.length= " + _loc21_.length + " arMessageName= " + _loc21_.toString());
         this.debug("arMessageText.length= " + _loc23_.length + " arMessageText= " + _loc23_.toString());
         this.infoString = this.infoString + this.createToolMessage(theTransactionID,this.getTheContextGuid(),_loc28_,_loc31_,_loc29_,_loc33_,_loc30_,_loc27_,this.getTheDataObj().getproblem_name(),theSemanticEventName,theSemanticTrigger,theSemanticSubType,_loc21_,_loc23_,brSkillArray);
      }
      else if(theActionMsgSource == "TUTOR_ACTION")
      {
         this.infoString = this.infoString + ("<tutor_message context_message_id=\"" + this.getTheContextGuid() + "\">\n");
         this.infoTrace = this.getTheContextGuid();
         this.infoString = this.infoString + "<semantic_event ";
         this.infoString = this.infoString + ("transaction_id=\"" + theTransactionID + "\"");
         this.infoString = this.infoString + (" name=\"" + theSemanticEventName + "\"");
         if(this.checkValid(theSemanticTrigger) == true)
         {
            this.infoString = this.infoString + (" trigger=\"" + theSemanticTrigger + "\"");
         }
         if(this.checkValid(theSemanticSubType) == true)
         {
            this.infoString = this.infoString + (" subtype=\"" + theSemanticSubType + "\"");
         }
         this.infoString = this.infoString + " />\n";
         this.debug("We have " + theSemanticEventName + " v.s. " + theActionEvaluation);
         if(theSemanticEventName == "HINT_MSG")
         {
            this.infoString = this.infoString + this.createSAIelements(theSelection,theAction,theInput);
            this.infoString = this.infoString + "<action_evaluation ";
            if(theHintLevel != null && theHintLevel != "" && theHintLevel != undefined)
            {
               this.infoString = this.infoString + ("current_hint_number=\"" + theHintLevel + "\"");
            }
            else
            {
               this.infoString = this.infoString + "current_hint_number=\"1\"";
            }
            if(theNumberOfHints != null && theNumberOfHints != undefined && theNumberOfHints != "")
            {
               this.infoString = this.infoString + (" total_hints_available=\"" + theNumberOfHints + "\"");
            }
            else
            {
               this.infoString = this.infoString + (" total_hints_available=\"" + _global.theShell.hintList.hints.length + "\"");
            }
            if(theActionEvaluation == "HINT" && theActionEvaluation != "" && theActionEvaluation != null && theActionEvaluation != undefined)
            {
               this.infoString = this.infoString + ">HINT</action_evaluation>\n";
               this.infoTrace = this.infoTrace + "  HINT  ";
            }
            else
            {
               this.infoString = this.infoString + (">" + theActionEvaluation + "</action_evaluation>\n");
               this.infoTrace = this.infoTrace + ("  " + theActionEvaluation + "  ");
            }
         }
         else
         {
            this.infoString = this.infoString + this.createSAIelements(theSelection,theAction,theInput);
            if(theActionEvaluation != null)
            {
               this.infoString = this.infoString + ("<action_evaluation>" + theActionEvaluation + "</action_evaluation>\n");
               this.infoTrace = this.infoTrace + (" " + theActionEvaluation + " ");
            }
         }
         if(theText != undefined && theText != null && theText != "undefined")
         {
            if(this.checkValid(_loc10_) == true)
            {
               this.infoString = this.infoString + ("<tutor_advice>" + _loc10_ + "</tutor_advice>\n");
            }
         }
         this.debug("We have a skill array but we\'re using the global skill set in the CommShell to obtain proper skills");
         var _loc4_ = _global.theShell.skillSet.getSkillSet();
         if(_loc4_ != null)
         {
            this.debug("Adding " + _loc4_.length + " skills");
            var _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               if(_loc4_[_loc3_].touched == true)
               {
                  this.infoString = this.infoString + "<skill probability=\"";
                  this.infoString = this.infoString + _loc4_[_loc3_].level;
                  this.infoString = this.infoString + "\">";
                  this.infoString = this.infoString + "<name>";
                  this.infoString = this.infoString + _loc4_[_loc3_].name;
                  this.infoString = this.infoString + "</name>";
                  this.infoString = this.infoString + "<category>";
                  this.infoString = this.infoString + _loc4_[_loc3_].category;
                  this.infoString = this.infoString + "</category>";
                  this.infoString = this.infoString + "</skill>";
               }
               _loc3_ = _loc3_ + 1;
            }
         }
         else
         {
            this.debug("Error, skillset object is null");
         }
         _loc16_ = new Date();
         this.debug("server_adjusted_event_time - timeStamp.getTime(): " + _loc16_.getTime() + " _global.linkData.serviceInfo.ServerOffset: " + _global.linkData.serviceInfo.ServerOffset);
         _loc25_ = new Date(_loc16_.getTime() - _global.linkData.serviceInfo.ServerOffset);
         var _loc26_ = this.FormatTimeStamp(_loc16_) + " UTC";
         var _loc32_ = this.FormatTimeStamp(_loc25_) + " UTC";
         this.infoString = this.infoString + this.createCustomToolField("tutor_event_time",_loc26_);
         this.infoString = this.infoString + this.createCustomToolField("server_adjusted_event_time",_loc32_);
         this.infoString = this.infoString + "</tutor_message>\n";
      }
      this.infoString = this.infoString + "</tutor_related_message_sequence>\n";
      return this.infoString;
   }
   function TutorLog(theTransactionID, theActionMsgSource, theSemanticEventName, theSemanticTrigger, theSemanticSubType, theSelection, theAction, theInput, theActionEvaluation, theText, theHintLevel, theNumberOfHints, arSkillName, arSkillCategory, arSkillModelName, skillProbability, skillBuggy, brSkillArray)
   {
      this.debug("TutorLog ()");
      this.infoString = this.TutorCreateLog(theTransactionID,theActionMsgSource,theSemanticEventName,theSemanticTrigger,theSemanticSubType,theSelection,theAction,theInput,theActionEvaluation,theText,theHintLevel,theNumberOfHints,arSkillName,arSkillCategory,arSkillModelName,skillProbability,skillBuggy,brSkillArray);
      this.SendLog(this.infoString,theActionMsgSource + " " + theSemanticEventName);
      return this.infoString;
   }
   function createToolMessage(ptheTransactionID, ptheContextMessageID, ptheSelection, ptheSelectionType, ptheAction, ptheActionType, ptheInput, ptheInputType, pproblem_name, ptheSemanticEventName, ptheSemanticTrigger, ptheSemanticSubType, pmessageName, pmessageText, brSkillsArray)
   {
      this.debug("createToolMessage ()");
      var _loc2_ = "<tool_message context_message_id =\"" + ptheContextMessageID + "\">\n";
      _loc2_ = _loc2_ + "<semantic_event ";
      _loc2_ = _loc2_ + ("transaction_id=\"" + ptheTransactionID + "\"");
      _loc2_ = _loc2_ + (" name=\"" + ptheSemanticEventName + "\"");
      if(this.checkValid(ptheSemanticTrigger) == true)
      {
         _loc2_ = _loc2_ + (" trigger=\"" + ptheSemanticTrigger + "\"");
      }
      if(this.checkValid(ptheSemanticSubType) == true)
      {
         _loc2_ = _loc2_ + (" subtype=\"" + ptheSemanticSubType + "\"");
      }
      _loc2_ = _loc2_ + " />\n";
      _loc2_ = _loc2_ + this.createSAIelementsAdv(ptheSelection,ptheSelectionType,ptheAction,ptheActionType,ptheInput,ptheInputType);
      var _loc5_ = "media message";
      _loc2_ = _loc2_ + this.createCustomFieldsElements(pmessageName,pmessageText);
      _loc2_ = _loc2_ + "</tool_message>\n";
      return _loc2_;
   }
   function createCustomFieldsElements(pmessageName, pmessageText)
   {
      this.debug("createCustomFieldsElements ()");
      var _loc4_ = "";
      var _loc2_ = 0;
      while(_loc2_ < pmessageName.length)
      {
         if(this.checkValid(pmessageName[_loc2_]) == true)
         {
            _loc4_ = _loc4_ + this.createCustomToolField(pmessageName[_loc2_],pmessageText[_loc2_]);
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function createCustomToolField(pmessageName, pmessageText)
   {
      this.debug("createCustomToolField ()");
      var _loc2_ = "";
      _loc2_ = _loc2_ + "<custom_field>\n";
      _loc2_ = _loc2_ + ("<name>" + pmessageName + "</name>\n");
      _loc2_ = _loc2_ + ("<value>" + pmessageText + "</value>\n");
      _loc2_ = _loc2_ + "</custom_field>\n";
      return _loc2_;
   }
   function createSAIelementsAdv(ptheSelection, ptheSelectionType, ptheAction, ptheActionType, ptheInput, ptheInputType)
   {
      this.debug("createSAIelementsAdv ()");
      var _loc2_ = "<event_descriptor>\n";
      if(this.checkValid(ptheSelection[0]) != false)
      {
         var _loc3_ = 0;
         while(_loc3_ < ptheSelection.length)
         {
            _loc2_ = _loc2_ + "<selection";
            if(this.checkValid(ptheSelectionType[_loc3_]) == true)
            {
               _loc2_ = _loc2_ + (" type=\"" + ptheSelectionType[_loc3_] + "\"");
            }
            _loc2_ = _loc2_ + ">";
            _loc2_ = _loc2_ + (ptheSelection[_loc3_] + "</selection>\n");
            _loc3_ = _loc3_ + 1;
         }
      }
      if(this.checkValid(ptheAction[0]) != false)
      {
         _loc3_ = 0;
         while(_loc3_ < ptheAction.length)
         {
            _loc2_ = _loc2_ + "<action";
            if(this.checkValid(ptheActionType[_loc3_]) == true)
            {
               _loc2_ = _loc2_ + (" type=\"" + ptheActionType[_loc3_] + "\"");
            }
            _loc2_ = _loc2_ + ">";
            _loc2_ = _loc2_ + (ptheAction[_loc3_] + "</action>\n");
            _loc3_ = _loc3_ + 1;
         }
      }
      if(this.checkValid(ptheInput[0]) != false)
      {
         _loc3_ = 0;
         while(_loc3_ < ptheInput.length)
         {
            _loc2_ = _loc2_ + "<input";
            if(this.checkValid(ptheInputType[_loc3_]) == true)
            {
               _loc2_ = _loc2_ + (" type=\"" + ptheInputType[_loc3_] + "\"");
            }
            _loc2_ = _loc2_ + ">";
            _loc2_ = _loc2_ + (ptheInput[_loc3_] + "</input>\n");
            _loc3_ = _loc3_ + 1;
         }
      }
      _loc2_ = _loc2_ + "</event_descriptor>\n";
      return _loc2_;
   }
   function createSAIelements(ptheSelection, ptheAction, ptheInput)
   {
      this.debug("createSAIelements ()");
      var _loc3_ = ptheSelection;
      if(this.utils.strstr(ptheSelection,"_level0.") != false)
      {
         _loc3_ = this.utils.strstr(ptheSelection,"_level0.");
      }
      var _loc2_ = "<event_descriptor>\n";
      if(this.checkValid(_loc3_) == true)
      {
         _loc2_ = _loc2_ + ("<selection>" + _loc3_ + "</selection>\n");
         this.infoTrace = this.infoTrace + (" " + _loc3_ + " ");
      }
      if(this.checkValid(ptheAction) == true)
      {
         _loc2_ = _loc2_ + ("<action>" + ptheAction + "</action>\n");
         this.infoTrace = this.infoTrace + (" " + ptheAction + " ");
      }
      if(this.checkValid(ptheInput) == true)
      {
         _loc2_ = _loc2_ + ("<input>" + ptheInput + "</input>\n");
         this.infoTrace = this.infoTrace + (" " + ptheInput + " ");
      }
      _loc2_ = _loc2_ + "</event_descriptor>\n";
      return _loc2_;
   }
   function detectOldShell()
   {
      if(_global.theShell == undefined)
      {
         for(var _loc3_ in _level0)
         {
            if(_level0[_loc3_].commType == "tutorShell")
            {
               this.shell = _loc3_;
               this.debug("startProblem : _level0[shell].version = " + _level0[this.shell].version + "  getDTDversion() = " + _level0[this.shell].getDTDversion());
               break;
            }
         }
         if(_level0[this.shell] == undefined)
         {
            return undefined;
         }
         if(_level0[this.shell].getDTDversion() == undefined)
         {
            this.warningCounter = 0;
            this.warningInterval = setInterval(this,"oldShellWarning",2000,_level0[this.shell]);
         }
      }
      else if(_global.theShell.getDTDversion() == undefined)
      {
         this.warningCounter = 0;
         this.warningInterval = setInterval(this,"oldShellWarning",2000,_global.theShell);
      }
   }
   function oldShellWarning(theShell)
   {
      if(this.warningCounter > 0)
      {
         clearInterval(this.warningInterval);
         this.warningCounter = 0;
         var _loc2_ = undefined;
         _loc2_ = _loc2_ + "The Logging Library that you are using (version 2) is not supported by the version of CommShell in your tutor (CTAT release 2.0 or previous). ";
         _loc2_ = _loc2_ + "Your tutor will NOT log correctly! ";
         _loc2_ = _loc2_ + "To log correctly, either update the CommShell to CTAT release 2.1 or higher. Or, use version 1 of the Flash Logging Library (see <font color=\'#0000FF\'><u><a href=\'http://snipurl.com/FlashLog\' target=\'_blank\'>Logging Instructions</a></u></font>) (http://snipurl.com/FlashLog)";
         var _loc3_ = false;
         theShell.Feedback(_loc2_,_loc3_);
         this.debug("EXCEPTION : " + _loc2_);
         return undefined;
      }
      this.warningCounter = this.warningCounter + 1;
   }
   function checkTutorCompatibility(theVersion)
   {
      var _loc4_ = undefined;
      var _loc2_ = undefined;
      if(theVersion == this.getClassVersion())
      {
         _loc2_ = "This version (" + this.getClassVersion() + ") of the library is compatible with the version that was passed (" + theVersion + "). ";
         _loc4_ = {compatible:true,description:_loc2_,CTATCode:"a1"};
      }
      else if(theVersion.substr(0,1) == "1" || theVersion.substr(0,1) == "2" && theVersion.substr(2,1) == "0")
      {
         _loc2_ = "This version (" + this.getClassVersion() + ") of the library is not compatible with the version that was passed (" + theVersion + ") ";
         _loc2_ = "because this library is version 2 which is not backward compatible with version 1 which your tutor requires.";
         _loc4_ = {compatible:false,description:_loc2_,CTATCode:"b1"};
      }
      else if(theVersion.substr(0,1) == "2" && theVersion.substr(2,1) == "3" && Number(theVersion.substr(4)) < Number(this.getClassVersion().substr(4)))
      {
         _loc2_ = "The passed version (" + theVersion + ") of the library is older than this version of the library (" + this.getClassVersion() + "). ";
         _loc2_ = _loc2_ + "The passed version is mostly compatible with the library . ";
         _loc2_ = _loc2_ + "But, we recommend that you get the latest version of the library to ensure optimal performance";
         _loc4_ = {compatible:false,description:_loc2_,CTATCode:"c1"};
      }
      else if(theVersion.substr(0,1) == "2" && theVersion.substr(2,1) == "3" && Number(theVersion.substr(4)) > Number(this.getClassVersion().substr(4)))
      {
         _loc2_ = "The passed version (" + theVersion + ") of the library is newer than this version of the library (" + this.getClassVersion() + "). ";
         _loc2_ = _loc2_ + "Since the tutor is expecting a newer version of the libraray, it is difficult to assess compatibility. ";
         _loc2_ = _loc2_ + "We recommend that you log with version of the library that matches your expectations to ensure optimal performance";
         _loc4_ = {compatible:true,description:_loc2_,CTATCode:"d1"};
      }
      else if(theVersion.substr(0,1) == "2" && theVersion.substr(2,1) == "1")
      {
         _loc2_ = "The passed version (" + theVersion + ") of the library is older than this version of the library (" + this.getClassVersion() + "). ";
         _loc2_ = _loc2_ + "The passed version is mostly compatible with the library. For example, both support V2 DTD4 logging. ";
         _loc2_ = _loc2_ + "But, the latest library has much richer support for media logging";
         _loc2_ = _loc2_ + "Therefore, we recommend that you get the latest version of the library to ensure optimal performance";
         _loc4_ = {compatible:false,description:_loc2_,CTATCode:"e1"};
      }
      return _loc4_;
   }
   function createCTATContextMessageTransferData()
   {
      return this.getDefaultDataObj();
   }
   function createSessionMessageTransferData()
   {
      return new edu.cmu.hcii.ctat.CTATSessionMessageTransferData();
   }
   function getDefaultDataObj()
   {
      var theDataObj = new edu.cmu.hcii.ctat.CTATContextMessageTransferData();
      var theGuid = this.getGuid();
      theDataObj.settheContextMessageID(theGuid);
      if(this.checkValid(_level0.question_file) == true)
      {
         theDataObj.setquestion_file(_level0.question_file);
      }
      else if(this.checkValid(_level0.media_file) == true)
      {
         theDataObj.setquestion_file(_level0.media_file);
      }
      else
      {
         theDataObj.setquestion_file("theDefaultaQustion_file.brd");
      }
      if(this.checkValid(_level0.media_file) == true)
      {
         theDataObj.setmedia_file(_level0.media_file);
      }
      if(this.checkValid(_level0.problem_name) == true)
      {
         theDataObj.setproblem_name(_level0.problem_name);
      }
      else if(this.checkValid(theDataObj.getquestion_file()) == true)
      {
         theDataObj.setproblem_name(theDataObj.getquestion_file());
      }
      else if(this.checkValid(theDataObj.getmedia_file()) == true)
      {
         theDataObj.setproblem_name(theDataObj.getmedia_file());
      }
      if(this.checkValid(_level0.problem_context) == true)
      {
         theDataObj.setproblem_context(_level0.problem_context);
      }
      if(this.checkValid(_level0.problem_tutorflag) == true)
      {
         theDataObj.setproblem_tutorflag(_level0.problem_tutorflag);
      }
      if(this.checkValid(_level0.problem_tutorflag) == true)
      {
         theDataObj.setproblem_tutorflag(_level0.problem_tutorflag);
      }
      if(this.checkValid(_level0.problem_otherproblemflag) == true)
      {
         theDataObj.setproblem_otherproblemflag(_level0.problem_otherproblemflag);
      }
      var aCustom_field_obj = new Object();
      aCustom_field_obj.name = new Array();
      aCustom_field_obj.value = new Array();
      var customFieldName;
      var customFieldValue;
      var jdx = 1;
      while(jdx < 10)
      {
         customFieldName = eval("_level0.custom_field_name" + jdx);
         if(this.checkValid(customFieldName) == true)
         {
            customFieldValue = eval("_level0.custom_field_value" + jdx);
            if(this.checkValid(customFieldName) == true)
            {
               aCustom_field_obj.name.push(customFieldName);
            }
            if(this.checkValid(customFieldValue) == true)
            {
               aCustom_field_obj.value.push(customFieldValue);
            }
         }
         jdx++;
      }
      var aCustom_field_objSerName = aCustom_field_obj.name.join();
      var aCustom_field_objSerValue = aCustom_field_obj.value.join();
      theDataObj.setcustom_field_obj(aCustom_field_objSerName,aCustom_field_objSerValue);
      var prefName = "dataset_name";
      var prefValue = eval("_level0." + prefName);
      if(this.checkValid(prefValue) == true)
      {
         theDataObj.setdataset_name(prefValue);
      }
      else if(this.checkValid(prefValue) == false)
      {
         prefName = "course_name";
         prefValue = eval("_level0." + prefName);
         if(this.checkValid(prefValue) == true)
         {
            theDataObj.setdataset_name(prefValue);
         }
      }
      var aDataset_level_obj = new Object();
      aDataset_level_obj.type = new Array();
      aDataset_level_obj.name = new Array();
      if(this.checkValid(_level0.unit_name) == true)
      {
         aDataset_level_obj.type.push("unit");
         aDataset_level_obj.name.push(_level0.unit_name);
      }
      if(this.checkValid(_level0.section_name) == true)
      {
         aDataset_level_obj.type.push("section");
         aDataset_level_obj.name.push(_level0.section_name);
      }
      var datasetLeveName;
      var datasetLeveType;
      var jdx = 1;
      while(jdx < 10)
      {
         datasetLeveName = eval("_level0.dataset_level_name" + jdx);
         if(this.checkValid(datasetLeveName) == true)
         {
            datasetLeveType = eval("_level0.dataset_level_type" + jdx);
            if(this.checkValid(datasetLeveName) == true)
            {
               aDataset_level_obj.name.push(datasetLeveName);
            }
            if(this.checkValid(datasetLeveType) == true)
            {
               aDataset_level_obj.type.push(datasetLeveType);
            }
         }
         jdx++;
      }
      var aDataset_level_objSerName = aDataset_level_obj.name.join();
      var aDataset_level_objSerType = aDataset_level_obj.type.join();
      theDataObj.setdataset_level_obj(aDataset_level_objSerName,aDataset_level_objSerType);
      if(this.checkValid(_level0.class_name) == true)
      {
         theDataObj.setclass_name(_level0.class_name);
      }
      if(this.checkValid(_level0.school_name) == true)
      {
         theDataObj.setschool_name(_level0.school_name);
      }
      if(this.checkValid(_level0.period_name) == true)
      {
         theDataObj.setperiod_name(_level0.period_name);
      }
      if(this.checkValid(_level0.class_description) == true)
      {
         theDataObj.setclass_description(_level0.class_description);
      }
      if(this.checkValid(_level0.instructor_name) == true)
      {
         theDataObj.setinstructor_name(_level0.instructor_name);
      }
      var aStudy_condition_obj = new Object();
      aStudy_condition_obj.name = new Array();
      aStudy_condition_obj.type = new Array();
      aStudy_condition_obj.description = new Array();
      var studyConditionName;
      var studyConditionType;
      var studyConditionDescription;
      var jdx = 0;
      while(jdx < 10)
      {
         studyConditionName = eval("_level0.study_condition_name" + jdx);
         if(this.checkValid(studyConditionName) == true)
         {
            studyConditionType = eval("_level0.study_condition_type" + jdx);
            studyConditionDescription = eval("_level0.study_condition_description" + jdx);
            if(this.checkValid(studyConditionName) == true)
            {
               aStudy_condition_obj.name.push(studyConditionName);
            }
            if(this.checkValid(studyConditionType) == true)
            {
               aStudy_condition_obj.type.push(studyConditionType);
            }
            if(this.checkValid(studyConditionDescription) == true)
            {
               aStudy_condition_obj.description.push(studyConditionDescription);
            }
         }
         jdx++;
      }
      var aStudy_condition_objSerName = aStudy_condition_obj.name.join();
      var aStudy_condition_objSerType = aStudy_condition_obj.type.join();
      var aStudy_condition_objSerDescription = aStudy_condition_obj.description.join();
      theDataObj.setstudy_condition_obj(aStudy_condition_objSerName,aStudy_condition_objSerType,aStudy_condition_objSerDescription);
      this.setTheDataObj(theDataObj);
      return theDataObj;
   }
   function setTheDataObj(theValue)
   {
      _theDataObj = theValue;
   }
   function getTheDataObj()
   {
      return _theDataObj;
   }
   function traceArguments(theArguments)
   {
      this.debug("traceArguments ()");
      var _loc2_ = 0;
      while(_loc2_ < theArguments.length)
      {
         this.debug("theArguments[" + _loc2_ + "] = " + theArguments[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
   }
   function traceDataObject(dataObj)
   {
      this.debug("traceDataObject : RAW LOGGING DATA    gettheContextMessageID = " + this.getTheContextGuid() + " " + "   getthe_action_msg_type = " + dataObj.getthe_action_msg_type() + " " + "   setthe_action_msg_source = " + dataObj.getthe_action_msg_source() + " " + "   getquestion_file = " + dataObj.getquestion_file() + " " + "   getproblem_name = " + dataObj.getproblem_name() + "" + "   getproblem_context = " + dataObj.getproblem_context() + " " + "   getproblem_tutorflag = " + dataObj.getproblem_tutorflag() + " " + "   getproblem_otherproblemflag = " + dataObj.getproblem_otherproblemflag() + " " + "   getdataset_name = " + dataObj.getdataset_name() + " " + "   getdataset_level_name1 = " + dataObj.getdataset_level_obj().name[0] + " " + "   getdataset_level_type1 = " + dataObj.getdataset_level_obj().type[0] + " " + "   getdataset_level_name2 = " + dataObj.getdataset_level_obj().name[1] + " " + "   getdataset_level_type2 = " + dataObj.getdataset_level_obj().type[1] + " " + "   getdataset_level_name3 = " + dataObj.getdataset_level_obj().name[2] + " " + "   getdataset_level_type3 = " + dataObj.getdataset_level_obj().type[2] + " " + "   getdataset_level_name4 = " + dataObj.getdataset_level_obj().name[3] + " " + "   getdataset_level_type4 = " + dataObj.getdataset_level_obj().type[3] + " " + "   getclass_name = " + dataObj.getclass_name() + " " + "   getschool_name = " + dataObj.getschool_name() + " " + "   getperiod_name = " + dataObj.getperiod_name() + " " + "   getclass_description = " + dataObj.getclass_description() + " " + "   getinstructor_name = " + dataObj.getinstructor_name() + " " + "   getstudy_condition_name1 = " + dataObj.getstudy_condition_obj().name[0] + " " + "   getstudy_condition_type1 = " + dataObj.getstudy_condition_obj().type[0] + " " + "   getstudy_condition_description1 = " + dataObj.getstudy_condition_obj().description[0] + " " + "   getstudy_condition_name1 = " + dataObj.getstudy_condition_obj().name[1] + " " + "   getstudy_condition_type1 = " + dataObj.getstudy_condition_obj().type[1] + " " + "   getstudy_condition_description1 = " + dataObj.getstudy_condition_obj().description[1] + " ");
   }
}
