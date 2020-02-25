class edu.cmu.hcii.ctat.CTATTutorShopManage extends edu.cmu.hcii.ctat.CTATTutorServiceBase
{
   var className = "tutorShopManage";
   function CTATTutorShopManage(theShell)
   {
      super();
      this.setClassType("CTATTutorShopManage");
      this.debug("CTATTutorShopManage ()");
      this.theSource = theShell;
      edu.cmu.hcii.ctat.CTATGlobal.doneMsg = new LoadVars();
      edu.cmu.hcii.ctat.CTATGlobal.result_lv = new LoadVars();
      edu.cmu.hcii.ctat.CTATGlobal.bailout_lv = new LoadVars();
      edu.cmu.hcii.ctat.CTATGlobal.doneMsg.position = 0;
      edu.cmu.hcii.ctat.CTATGlobal.result_lv.position = 0;
      edu.cmu.hcii.ctat.CTATGlobal.result_lv.onLoad = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.getResults);
      edu.cmu.hcii.ctat.CTATGlobal.bailout_lv.onLoad = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.getBailoutResults);
   }
   function classType()
   {
      return this.className;
   }
   function generateLoadVars()
   {
      this.debug("<CTATTutorShopManage> generateLoadVars ()");
      edu.cmu.hcii.ctat.CTATGlobal.doneMsg = new LoadVars();
   }
   function copyLoadVars(fixer, cmd)
   {
      this.debug("<CTATTutorShopManage> copyLoadVars (position: " + fixer.position + ",lcId: " + _root.lcId + ",summary: " + this.sSummary + ",cmd: " + cmd + ")");
      edu.cmu.hcii.ctat.CTATGlobal.doneMsg.position = fixer.position;
      edu.cmu.hcii.ctat.CTATGlobal.doneMsg.lcId = _root.lcId;
      edu.cmu.hcii.ctat.CTATGlobal.doneMsg.summary = this.sSummary;
      edu.cmu.hcii.ctat.CTATGlobal.doneMsg.cmd = cmd;
   }
   function sendDoneLVmsg(curriculum_service_url, user_guid, session_id, student_problem_id, school_name, admit_code, cmd, lvType, Summary)
   {
      this.debug("sendDoneLVmsg ()");
      this.debug("cmd: " + cmd);
      this.debug("lvType: " + lvType);
      this.debugFlashVars();
      this.sCurriculum_service_url = curriculum_service_url;
      this.sUser_guid = user_guid;
      this.sSession_id = session_id;
      this.sStudent_problem_id = student_problem_id;
      this.sSchool_name = school_name;
      this.sAdmit_code = admit_code;
      this.sSummary = Summary;
      this.setTheDoneMsg(curriculum_service_url,user_guid,session_id,student_problem_id,school_name,admit_code,cmd,lvType,Summary);
      this.sendMsg(curriculum_service_url,lvType);
   }
   function setTheDoneMsg(curriculum_service_url, user_guid, session_id, student_problem_id, school_name, admit_code, cmd, lvType, Summary)
   {
      this.debug("setTheDoneMsg ()");
      var _loc4_ = curriculum_service_url;
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_loc4_) == true)
      {
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(user_guid) == true)
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.user_guid = user_guid;
         }
         else
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.user_guid = "FOO_user";
         }
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(session_id) == true)
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.session_id = session_id;
         }
         else
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.session_id = "FOO_session";
         }
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(student_problem_id) == true)
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.student_problem_id = student_problem_id;
         }
         else
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.student_problem_id = "FOO_student";
         }
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(school_name) == true)
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.school_name = school_name;
         }
         else
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.school_name = "FOO_school";
         }
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(admit_code) == true)
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.admit_code = admit_code;
         }
         else
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.admit_code = "FOO_admit";
         }
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(Summary) == true)
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.summary = escape(Summary);
            this.debug("Assigning the following summary message: " + edu.cmu.hcii.ctat.CTATGlobal.doneMsg.summary);
         }
         else
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.summary = "FOO_summary";
         }
         if(lvType == "sendandload")
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.cmd = "doneNextData";
         }
         else
         {
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.cmd = "doneNext";
         }
      }
      else
      {
         this.debug("EXCEPTION : tutorShopManage : sendDoneLVmsg : The Curriculum Service URL is not defined and so no tutorShop message can be sent : Method   curriculum_service_url = " + curriculum_service_url + " user_guid =" + user_guid + " session_id =" + session_id + " student_problem_id = " + student_problem_id + " school_name =" + school_name + " admit_code =" + admit_code + " cmd = " + cmd);
      }
   }
   function sendMsg(curriculum_service_url, lvType)
   {
      this.debug("sendMsg ()");
      this.debug("lvType: " + lvType);
      this.debugFlashVars();
      this.debug("curriculum_service_url: " + curriculum_service_url);
      var _loc3_ = new edu.cmu.hcii.ctat.CTATURL(curriculum_service_url);
      var _loc4_ = new LoadVars();
      _loc4_.decode(_loc3_.getQueryString());
      edu.cmu.hcii.ctat.CTATGlobal.doneMsg.position = _loc4_.position;
      if(_level0.authenticity_token != undefined && _level0.authenticity_token != null)
      {
         edu.cmu.hcii.ctat.CTATGlobal.doneMsg.authenticity_token = _level0.authenticity_token;
      }
      else
      {
         edu.cmu.hcii.ctat.CTATGlobal.doneMsg.authenticity_token = edu.cmu.hcii.ctat.CTATGuid.create();
      }
      _loc4_ = null;
      this.debug("Creating and configuring new results LoadVars object ...");
      edu.cmu.hcii.ctat.CTATGlobal.result_lv = new LoadVars();
      edu.cmu.hcii.ctat.CTATGlobal.result_lv.onLoad = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.getResults);
      this.debug("Recovered URL: " + _loc3_.toString());
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_loc3_.toString()) == true)
      {
         this.debug("lvType : " + lvType + ", using url: " + _loc3_.toString());
         if(lvType == "send" || lvType == undefined)
         {
            this.debug("Calling \'send\' on doneMsg and returning control to the browser ...");
            edu.cmu.hcii.ctat.CTATGlobal.doneMsg.send(_loc3_.toString(),"_self","POST");
            _global.theShell.Cleanup();
         }
         else
         {
            this.debug("Calling \'sendandload\' on doneMsg, assuming we need to further investigate");
            if(lvType == "sendandload")
            {
               edu.cmu.hcii.ctat.CTATGlobal.doneMsg.sendAndLoad(_loc3_.toString(),edu.cmu.hcii.ctat.CTATGlobal.result_lv,"POST");
            }
         }
      }
      else
      {
         this.debug("Invalid URL provided");
      }
      this.debug("At this point loadVars has been called and we should be idling now");
   }
   function getResults(success)
   {
      this.debug("getResults ()");
      this.debug("success: " + success);
      if(success)
      {
         this.debug("result_lv (raw): " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.toString());
         this.debug("result_lv (unescape): " + unescape(edu.cmu.hcii.ctat.CTATGlobal.result_lv.toString()));
      }
      if(!success)
      {
         this.debug("EXCEPTION : tutorShopManage : getResults : Failed in loading data from TutorShop using the sendandload command.");
      }
      else
      {
         this.debug("Calling info method with string [" + edu.cmu.hcii.ctat.CTATGlobal.result_lv.info + "]...");
         _global.theShell.jsProxy.jsMessage(edu.cmu.hcii.ctat.CTATGlobal.result_lv.info);
         var _loc3_ = edu.cmu.hcii.ctat.CTATUtil.checkValid(edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_interface);
         this.debug("chckval: " + _loc3_);
         if(_loc3_ == true && this.isSameInterface(edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_interface,this.theSource.getLastTutorInterface()) == true)
         {
            this.handleTutorShopRepetition();
         }
         else
         {
            this.handleTutorShopNextPage();
         }
      }
   }
   function getBailoutResults(success)
   {
      this.debug("getBailoutResults ()");
      this.debug("success: " + success);
      if(success)
      {
         this.debug("result_lv (raw): " + edu.cmu.hcii.ctat.CTATGlobal.bailout_lv.toString());
         this.debug("result_lv (unescape): " + unescape(edu.cmu.hcii.ctat.CTATGlobal.bailout_lv.toString()));
      }
   }
   function handleTutorShopRepetition()
   {
      this.debug("handleTutorShopRepetition ()");
      try
      {
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(edu.cmu.hcii.ctat.CTATGlobal.result_lv.question_file) == false)
         {
            throw new Error("tutorShopManage : handleTutorShopRepetition : TutorShop Repetition portion of the code :   No question file found :   the BRD (" + edu.cmu.hcii.ctat.CTATGlobal.result_lv.question_file + ") is invalid.   The problem name is " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.problem_name + ". ");
         }
         else if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(edu.cmu.hcii.ctat.CTATGlobal.result_lv.question_file,"brd") == false)
         {
            throw new Error("tutorShopManage : handleTutorShopRepetition : TutorShop Repetition portion of the code :  no .brd extension on the BRD file.    the BRD (" + edu.cmu.hcii.ctat.CTATGlobal.result_lv.question_file + ") is invalid.   The problem name is " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.problem_name + ". ");
         }
         else
         {
            this.debug("tutorShopManage : handleTutorShopRepetition :   Call loadNextProblemViaTutorShop =   result_lv.question_file = " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.question_file + "  result_lv.problem_name = " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.problem_name + "  result_lv.student_interface = " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_interface + "  theSource.getLastTutorInterface() = " + this.theSource.getLastTutorInterface() + "  _level0.student_problem_id = " + _level0.student_problem_id + "  result_lv.student_problem_id = " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_problem_id);
            this.updateFlashvarsVariables();
            this.debug("  :   _level0.student_problem_id = " + _level0.student_problem_id + "  sStudent_problem_id = " + this.sStudent_problem_id);
            this.theSource.resetStudentInterface();
            this.theSource.startPreloader();
            this.theSource.loadNextProblemViaTutorShop(this.cleanQuestionFile(edu.cmu.hcii.ctat.CTATGlobal.result_lv.question_file),edu.cmu.hcii.ctat.CTATGlobal.result_lv.problem_name);
            this.theSource.initTab();
         }
      }
      catch(myError:Error)
      {
         this.debug("EXCEPTION : " + myError + "   result_lv.toString = " + unescape(edu.cmu.hcii.ctat.CTATGlobal.result_lv.toString()));
         this.handleTutorShopNextPage();
         return undefined;
      }
   }
   function debugFlashVars()
   {
      this.debug("debugFlashVars ()");
      this.debug("_level0.student_problem_id: " + _level0.student_problem_id);
      this.debug("_level0.student_interface: " + _level0.student_interface);
      this.debug("_level0.problem_name: " + _level0.problem_name);
      this.debug("_level0.question_file: " + _level0.question_file);
      this.debug("_level0.curriculum_service_url: " + _level0.curriculum_service_url);
   }
   function updateFlashvarsVariables()
   {
      this.debug("updateFlashvarsVariables ()");
      this.sStudent_problem_id = edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_problem_id;
      _level0.student_problem_id = edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_problem_id;
      _level0.student_interface = edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_interface;
      _level0.problem_name = edu.cmu.hcii.ctat.CTATGlobal.result_lv.problem_name;
      _level0.question_file = edu.cmu.hcii.ctat.CTATGlobal.result_lv.question_file;
      _level0.info = edu.cmu.hcii.ctat.CTATGlobal.result_lv.info;
      _level0.session_id = edu.cmu.hcii.ctat.CTATGlobal.result_lv.session_id;
      var _loc3_ = edu.cmu.hcii.ctat.CTATGlobal.result_lv.skills;
      if(_loc3_ == null || _loc3_ == undefined)
      {
         _loc3_ = edu.cmu.hcii.ctat.CTATGlobal.result_lv.Skills;
      }
      _level0.skills = _loc3_;
      _global.theShell.skillSet.fromXML(_loc3_);
      _global.theShell.resetHints();
      if(edu.cmu.hcii.ctat.CTATGlobal.result_lv.curriculum_service_url != undefined)
      {
         this.debug("Storing new url: " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.curriculum_service_url);
         _level0.curriculum_service_url = edu.cmu.hcii.ctat.CTATGlobal.result_lv.curriculum_service_url;
      }
      _global.theShell.setInterfaceIdentifcationGUID(null);
      this.debug("Calling javascript proxy ...");
      if(_global.theShell.jsProxy != null && _global.theShell.jsProxy != undefined)
      {
         if(_level0.info != null)
         {
            _global.theShell.jsProxy.jsMessage(_level0.info);
         }
         else
         {
            this.debug("Error: no message to display");
         }
      }
      else
      {
         this.debug("Error: no javascript proxy object available!");
      }
   }
   function handleTutorShopNextPage()
   {
      this.debug("handleTutorShopNextPage ()");
      this.debug("tutorShopManage : handleTutorShopNextPage :   Call sendDoneNextPageLVmsg =   result_lv.question_file = " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.question_file + "  result_lv.problem_name = " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.problem_name + "  result_lv.student_interface = " + edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_interface + "  theSource.getLastTutorInterface() = " + this.theSource.getLastTutorInterface());
      if(edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_interface != undefined)
      {
         this.theSource.setLastTutorInterface(edu.cmu.hcii.ctat.CTATGlobal.result_lv.student_interface);
      }
      else
      {
         this.theSource.setLastTutorInterface("NotDefinedLastCycle");
      }
      this.sendDoneNextPageLVmsg(this.sCurriculum_service_url,"resume","send");
   }
   function cleanQuestionFile(theQuestion)
   {
      this.debug("cleanQuestionFile ()");
      theQuestion = theQuestion.split("\r\n").join();
      return theQuestion.substring(theQuestion.lastIndexOf("/") + 1);
   }
   function isSameInterface(nextInterface, currentInterface)
   {
      this.debug("isSameInterface ()");
      nextInterface = nextInterface.split("\r\n").join();
      currentInterface = currentInterface.split("\r\n").join();
      var _loc4_ = nextInterface == currentInterface;
      this.debug("tutorShopManage 1 : isSameInterface :  nextInterface = " + nextInterface + " currentInterface = " + currentInterface + " isSame = " + _loc4_);
      var _loc6_ = nextInterface.substring(nextInterface.lastIndexOf("/") + 1);
      var _loc5_ = currentInterface.substring(currentInterface.lastIndexOf("/") + 1);
      _loc4_ = _loc6_ == _loc5_;
      this.debug("tutorShopManage 2 : isSameInterface :  nextInterface = " + nextInterface + " rootnextInterface = " + _loc6_ + " currentInterface = " + currentInterface + " rootcurrentInterface = " + _loc5_ + " isSame = " + _loc4_);
      return _loc4_;
   }
   function sendDoneNextPageLVmsg(curriculum_service_url, cmd, lvType)
   {
      this.debug("sendDoneNextPageLVmsg ()");
      this.generateLoadVars();
      this.copyLoadVars(edu.cmu.hcii.ctat.CTATGlobal.result_lv,cmd);
      this.sendMsg(curriculum_service_url,lvType);
   }
}
