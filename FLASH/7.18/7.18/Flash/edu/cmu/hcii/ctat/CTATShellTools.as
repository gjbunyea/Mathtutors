class edu.cmu.hcii.ctat.CTATShellTools extends edu.cmu.hcii.ctat.CTATBase
{
   var hooked = false;
   var reporter = null;
   var fmanager = null;
   function CTATShellTools()
   {
      super();
      this.setClassType("CTATShellTools");
      this.debug("CTATShellTools ()");
      this.fmanager = new edu.cmu.hcii.ctat.CTATFocusManager();
      mx.events.EventDispatcher.initialize(this);
   }
   function findShell()
   {
      this.debug("findShell ()");
      var _loc3_ = "";
      for(var _loc4_ in _root)
      {
         if(_root[_loc4_].commType == "tutorShell")
         {
            _loc3_ = _loc4_;
            return _loc3_;
         }
      }
      return null;
   }
   function showCapabilities()
   {
      this.debug("showCapabilities ()");
      for(var _loc2_ in System.capabilities)
      {
         this.debug("Your " + _loc2_ + " is: " + System.capabilities[_loc2_]);
      }
   }
   function debugFlashVars()
   {
      this.debug(" debugFlashVars ()");
      this.debug(" curriculum_service_url: " + _level0.curriculum_service_url);
      this.debug(" user_guid: " + _level0.user_guid);
      this.debug(" session_id: " + _level0.session_id);
      this.debug(" student_problem_id: " + _level0.student_problem_id);
      this.debug(" school_name: " + _level0.school_name);
      this.debug(" admit_code: " + _level0.admit_code);
      this.debug(" BehaviorRecorderMode: " + _level0.BehaviorRecorderMode);
      this.debug(" remoteSocketPort: " + _level0.remoteSocketPort);
      this.debug(" remoteSocketURL: " + _level0.remoteSocketURL);
      this.debug(" question_file: " + _level0.question_file);
      this.debug(" problem_name: " + _level0.problem_name);
      this.debug(" log_service_url: " + _level0.log_service_url);
      this.debug(" auth_token: " + _level0.auth_token);
      this.debug(" course_name: " + _level0.course_name);
      this.debug(" unit_name: " + _level0.unit_name);
      this.debug(" section_name: " + _level0.section_name);
      this.debug(" school_name: " + _level0.school_name);
      this.debug(" session_id: " + _level0.session_id);
      this.debug(" container_id: " + _level0.container_id);
      this.debug(" source_id: " + _level0.source_id);
      this.debug(" external_object_id: " + _level0.external_object_id);
      this.debug(" auth_token: " + _level0.auth_token);
      this.debug(" TutorShopDeliveryMethod: " + _level0.TutorShopDeliveryMethod);
   }
   function enableHintButton()
   {
      this.debug("enableHintButton (" + _global.theShell.getShowShellHintButton() + ")");
      if(_global.theShell.getShowShellHintButton() == true)
      {
         if(_global.theShell.suppressStudentFeedback == false)
         {
            this.debug("The shell indicates that the user hasn\'t hidden and disabled the hint button, processing ...");
            if(_global.theShell.alternativeHintButton != null && _global.theShell.alternativeHintButton != undefined)
            {
               _global.theShell.alternativeHintButton.enabled = true;
            }
            else
            {
               _global.theShell.hint_button.enabled = true;
               _global.theShell.hint_button._visible = true;
               _global.theShell.ctat_hint_button._visible = false;
               _global.theShell.waitclip.stop();
               _global.theShell.waitclip._visible = false;
            }
         }
      }
      else
      {
         this.debug("The user has indicated that the hint button should not be visible, aborting ...");
      }
   }
   function disableHintButton()
   {
      this.debug("disableHintButton ()");
      if(_global.theShell.getShowShellHintButton() == true)
      {
         if(_global.theShell.alternativeHintButton != null && _global.theShell.alternativeHintButton != undefined)
         {
            _global.theShell.alternativeHintButton.enabled = false;
         }
         else
         {
            _global.theShell.hint_button.enabled = false;
            _global.theShell.hint_button._visible = false;
            _global.theShell.ctat_hint_button._visible = true;
            _global.theShell.waitclip._visible = true;
            _global.theShell.waitclip.swapDepths(this.getNextHighestDepth());
            _global.theShell.waitclip.play();
         }
      }
      else
      {
         this.debug("The user has indicated that the hint button should not be visible, aborting ...");
      }
   }
   function enableAll(an_object)
   {
      this.debug("enableAll ()");
      for(var _loc3_ in an_object)
      {
         if(an_object[_loc3_])
         {
            this.debug("Enabling " + an_object[_loc3_]._name);
            an_object[_loc3_].enabled = true;
         }
      }
   }
   function disableAll(an_object)
   {
      this.debug("disableAll ()");
      for(var _loc3_ in an_object)
      {
         if(an_object[_loc3_])
         {
            this.debug("Disabling " + an_object[_loc3_]._name);
            an_object[_loc3_].enabled = false;
         }
      }
   }
   function enableComponents()
   {
      this.enableDisplayList();
   }
   function unlockDisplayList()
   {
      this.debug("unlockDisplayList ()");
      var _loc3_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var _loc4_ in _loc3_)
      {
         var _loc2_ = _loc3_[_loc4_];
         _loc2_.reference.unlock();
      }
   }
   function enableDisplayList()
   {
      this.debug("enableDisplayList ()");
      this.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      var _loc3_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      this.debug("Enabling hint button ...");
      this.enableHintButton();
      this.debug("Enabling all regular components ...");
      for(var _loc4_ in _loc3_)
      {
         var _loc2_ = _loc3_[_loc4_];
         _loc2_.unblock();
      }
      this.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> (end)");
   }
   function disableComponents(a_blocked)
   {
      this.debug("disableComponents ()");
      var _loc2_ = false;
      if(a_blocked != undefined)
      {
         if(a_blocked != null)
         {
            _loc2_ = a_blocked;
         }
      }
      this.disableDisplayList(_loc2_);
   }
   function disableDisplayList(a_blocked)
   {
      this.debug("disableDisplayList ()");
      this.debug("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
      var _loc4_ = false;
      if(a_blocked != undefined && a_blocked != null)
      {
         _loc4_ = a_blocked;
      }
      this.debug("Blocking var: " + _loc4_);
      var _loc3_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var _loc5_ in _loc3_)
      {
         var _loc2_ = _loc3_[_loc5_];
         this.debug("Locking for class: " + _loc2_.reftype);
         if(_loc2_.reftype == "CommDoneButtonClass")
         {
            this.debug("Examining special case for CommDoneButtonClass");
            if(_loc4_ == false)
            {
               this.debug("We\'re not blocking so it\'s safe to block the Done Button");
               _loc2_.block();
            }
         }
         else
         {
            this.debug("Normal case, locking ...");
            _loc2_.block();
         }
      }
      this.debug("Disabling hint button ...");
      this.disableHintButton();
      this.debug("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< (end)");
   }
   function lockDisplayList()
   {
      this.debug("lockDisplayList ()");
      var _loc3_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var _loc4_ in _loc3_)
      {
         var _loc2_ = _loc3_[_loc4_];
         _loc2_.reference.lock();
      }
   }
   function disableDoneButton()
   {
      this.debug("disableDoneButton ()");
      var _loc3_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var _loc4_ in _loc3_)
      {
         var _loc2_ = _loc3_[_loc4_];
         if(_loc2_.reftype == "CommDoneButtonClass")
         {
            this.debug("Disabling done button ...");
            _loc2_.block();
         }
      }
   }
   function enableDoneButton()
   {
      this.debug("enableDoneButton ()");
      var _loc3_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var _loc4_ in _loc3_)
      {
         var _loc2_ = _loc3_[_loc4_];
         if(_loc2_.reftype == "CommDoneButtonClass")
         {
            this.debug("Enabling done button ...");
            _loc2_.unblock();
         }
      }
   }
   function hideComponents()
   {
      this.hideDisplayList();
   }
   function hideDisplayList()
   {
      this.debug("hideDisplayList ()");
      var _loc3_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var _loc4_ in _loc3_)
      {
         var _loc2_ = _loc3_[_loc4_];
         _loc2_.unFocus();
         _loc2_.setVisible(false);
      }
   }
   function showComponents(a_blocked)
   {
      this.disableDisplayList(a_blocked);
   }
   function showDisplayList()
   {
      this.debug("showDisplayList ()");
      var _loc3_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var _loc4_ in _loc3_)
      {
         var _loc2_ = _loc3_[_loc4_];
         _loc2_.setVisible(true);
      }
      this.fmanager.restoreFocus();
   }
   function hideTutor(a_value)
   {
      if(a_value == true)
      {
         _global.theShell.indicator._visible = false;
         _global.theShell._visible = false;
         this.hideDisplayList();
      }
      else
      {
         _global.theShell._visible = true;
         this.showDisplayList();
      }
   }
   function displayContextComponents(theLogger)
   {
      this.debug("displayContextComponents ()");
      var _loc10_ = null;
      var _loc11_ = null;
      var _loc3_ = new edu.cmu.hcii.ctat.CTATConnectionProxy();
      this.debug("Building shell info ...");
      if(_global.theShell == null)
      {
         _loc3_.shellinfo[0] = "Shell reference unavailable";
      }
      else
      {
         _loc3_.shellinfo[0] = "version = <b>" + _global.theShell.version + "</b>";
         _loc3_.shellinfo[1] = "public version = <b>" + _global.theShell.publicVersion + "</b>";
         _loc3_.shellinfo[2] = "DTD version = <b>" + _global.theShell.DTDversion + "</b>";
      }
      _loc3_.serviceinfo[0] = "Version = <b>" + _global.linkData.serviceInfo.serviceVersion + "</b>";
      _loc3_.serviceinfo[1] = "Build Number = <b>" + _global.linkData.serviceInfo.buildNumber + "</b>";
      _loc3_.serviceinfo[2] = "Build Date = <b>" + _global.linkData.serviceInfo.buildDate + "</b>";
      _loc3_.serviceinfo[3] = "Transaction ID = <b>" + _global.linkData.serviceInfo.transaction_id + "</b>";
      this.debug("Building shell properties ...");
      if(_global.theShell == null)
      {
         _loc3_.shelldata[0] = "Shell reference unavailable";
      }
      else
      {
         var _loc5_ = 0;
         for(var _loc7_ in _global.theShell)
         {
            _loc3_.shelldata[_loc5_] = _loc7_ + " with type: <b>" + typeof _global.theShell[_loc7_] + "</b>";
            _loc5_ = _loc5_ + 1;
         }
      }
      this.debug("Building logging library properties ...");
      if(_global.theShell.getLogClass() == null)
      {
         _loc3_.loggingdata[0] = "Logging library reference unavailable";
      }
      else
      {
         var _loc8_ = _global.theShell.getLogClass();
         _loc3_.loggingdata[0] = "Logging library version: <b>" + _loc8_.getClassVersion() + "</b>";
         _loc3_.loggingdata[1] = "Logging DTD version: <b>" + _loc8_.getDTDversion() + "</b>";
      }
      this.debug("Building component info ...");
      var _loc6_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var _loc7_ in _loc6_)
      {
         var _loc4_ = _loc6_[_loc7_];
         _loc3_.tutorinfo[_loc7_] = "Component: <b>" + _loc4_.reftype + "</b> with instance name: <b>" + _loc4_.refname + "</b> and version: <b>" + _loc4_.refversion + "</b>";
      }
      this.debug("Extracting _globals ...");
      if(_global != undefined)
      {
         this.debug("_global: " + _global);
         for(var _loc7_ in _global)
         {
            _loc3_.globals[_loc7_] = _loc7_ + " with type: <b>" + typeof _global[_loc7_] + "</b>";
            this.debug("global: " + _loc7_ + " with type: <b>" + typeof _global[_loc7_]);
         }
      }
      else
      {
         _loc3_.globals.Error = "Error: _global is undefined in the flash tutor!";
         this.debug("Error: _global is undefined in the flash tutor!");
      }
      this.debug("Building flashvars info ...");
      var _loc9_ = "curriculum_service_url: <b>" + _level0.curriculum_service_url + "</b>";
      _loc3_.flashvars[0] = _loc9_;
      _loc3_.flashvars[1] = "Logging: <b>" + _level0.Logging + "</b>";
      _loc3_.flashvars[3] = "log_service_url: <b>" + _level0.log_service_url + "</b>";
      _loc3_.flashvars[4] = "VideoPath: <b>" + _level0.VideoPath + "</b>";
      _loc3_.flashvars[5] = "MediaPath: <b>" + _level0.MediaPath + "</b>";
      _loc3_.flashvars[6] = "TutorCuePointTime: <b>" + _level0.TutorCuePointTime + "</b>";
      _loc3_.flashvars[7] = "TutorCuePointName: <b>" + _level0.TutorCuePointName + "</b>";
      _loc3_.flashvars[8] = "media_file: <b>" + _level0.media_file + "</b>";
      _loc3_.flashvars[9] = "RandomizeAnswers: <b>" + _level0.RandomizeAnswers + "</b>";
      _loc3_.flashvars[10] = "BehaviorRecorderMode: <b>" + _level0.BehaviorRecorderMode + "</b>";
      _loc3_.flashvars[11] = "dataset_level_name1: <b>" + _level0.dataset_level_name1 + "</b>";
      _loc3_.flashvars[12] = "dataset_level_type1: <b>" + _level0.dataset_level_type1 + "</b>";
      _loc3_.flashvars[13] = "dataset_level_name2: <b>" + _level0.dataset_level_name2 + "</b>";
      _loc3_.flashvars[14] = "dataset_level_type2: <b>" + _level0.dataset_level_type2 + "</b>";
      _loc3_.flashvars[15] = "problem_name: <b>" + _level0.problem_name + "</b>";
      _loc3_.flashvars[16] = "user_guid: <b>" + _level0.user_guid + "</b>";
      _loc3_.flashvars[17] = "session_id: <b>" + _level0.session_id + "</b>";
      _loc3_.flashvars[18] = "DeliverUsingOLI: <b>" + _level0.DeliverUsingOLI + "</b>";
      _loc3_.flashvars[19] = "problem_context: <b>" + _level0.problem_context + "</b>";
      _loc3_.flashvars[20] = "problem_tutorflag: <b>" + _level0.problem_tutorflag + "</b>";
      _loc3_.flashvars[21] = "problem_otherproblemflag: <b>" + _level0.problem_otherproblemflag + "</b>";
      _loc3_.flashvars[22] = "dataset_name: <b>" + _level0.dataset_name + "</b>";
      _loc3_.flashvars[23] = "dataset_level_name: <b>" + _level0.dataset_level_name + "</b>";
      _loc3_.flashvars[24] = "dataset_level_type: <b>" + _level0.dataset_level_type + "</b>";
      _loc3_.flashvars[25] = "course_name: <b>" + _level0.course_name + "</b>";
      _loc3_.flashvars[26] = "unit_name: <b>" + _level0.unit_name + "</b>";
      _loc3_.flashvars[27] = "section_name: <b>" + _level0.section_name + "</b>";
      _loc3_.flashvars[28] = "school_name: <b>" + _level0.school_name + "</b>";
      _loc3_.flashvars[29] = "class_name: <b>" + _level0.class_name + "</b>";
      _loc3_.flashvars[30] = "period_name: <b>" + _level0.period_name + "</b>";
      _loc3_.flashvars[31] = "class_description: <b>" + _level0.class_description + "</b>";
      _loc3_.flashvars[32] = "instructor_name: <b>" + _level0.instructor_name + "</b>";
      _loc3_.flashvars[33] = "study_condition_name: <b>" + _level0.study_condition_name + "</b>";
      _loc3_.flashvars[34] = "study_condition_type: <b>" + _level0.study_condition_type + "</b>";
      _loc3_.flashvars[35] = "auth_token: <b>" + _level0.auth_token + "</b>";
      _loc3_.flashvars[36] = "container_id: <b>" + _level0.container_id + "</b>";
      _loc3_.flashvars[37] = "source_id: <b>" + _level0.source_id + "</b>";
      _loc3_.flashvars[38] = "external_object_id: <b>" + _level0.external_object_id + "</b>";
      _loc3_.flashvars[39] = "log_to_disk_directory: <b>" + _level0.log_to_disk_directory + "</b>";
      _loc3_.flashvars[40] = "cognitive_model_folder: <b>" + _level0.cognitive_model_folder + "</b>";
      _loc3_.flashvars[41] = "remoteSocketURL: <b>" + _level0.remoteSocketURL + "</b>";
      _loc3_.flashvars[42] = "remoteSocketPort: <b>" + _level0.remoteSocketPort + "</b>";
      _loc3_.flashvars[43] = "study_name: <b>" + _level0.study_name + "</b>";
      _loc3_.flashvars[44] = "curriculum_service_url: <b>" + _level0.curriculum_service_url + "</b>";
      _loc3_.flashvars[45] = "admit_code: <b>" + _level0.admit_code + "</b>";
      _loc3_.flashvars[46] = "student_problem_id: <b>" + _level0.student_problem_id + "</b>";
      this.debug("Building environment data info ...");
      _loc5_ = 0;
      for(var _loc7_ in System.capabilities)
      {
         _loc3_.envvars[_loc5_] = _loc7_ + " is: <b>" + System.capabilities[_loc7_] + "</b>";
         _loc5_ = _loc5_ + 1;
      }
      this.debug("Making the call ...");
      _loc3_.SafeGetURL("http://digger.pslc.cs.cmu.edu/tutorinfo.php","_blank","POST");
   }
   function displayPerformance()
   {
      this.debug("displayPerformance ()");
      this.debug("Making the call ...");
      var _loc3_ = new edu.cmu.hcii.ctat.CTATConnectionProxy();
      _loc3_.performanceString = _global.theShell.getPerformanceString();
      _loc3_.SafeGetURL("http://digger.pslc.cs.cmu.edu/tutorperformance.php","_blank","POST");
   }
   function setComponentsToBlank()
   {
      this.debug("setComponentsToBlank ()");
      var _loc4_ = pact.datastructures.SingletonList.getInstance();
      this.debug("Resetting [" + _loc4_.getLength() + "] components ...");
      var _loc3_ = 0;
      while(_loc3_ < _loc4_.getLength())
      {
         var _loc2_ = _loc4_.getAtIndex(_loc3_);
         if(_loc2_ != undefined)
         {
            if(_loc2_ != null)
            {
               this.debug("Resetting component with instance name [" + _loc3_ + "]: " + _loc2_._name);
               if(_loc2_.getClassType() == "CommTextInput" || _loc2_.getClassType() == "CommTextArea")
               {
                  if(_loc2_.textbox.editable == false)
                  {
                     if(_loc2_.resetComponent != undefined && _loc2_.resetComponent != null)
                     {
                        _loc2_.resetComponent();
                     }
                     else
                     {
                        this.debug("Target method \'resetComponent\' is undefined or null");
                     }
                  }
                  else
                  {
                     this.debug("We\'ve got a text component here that has editable set to false, skipping");
                  }
               }
               else if(_loc2_.resetComponent != undefined)
               {
                  _loc2_.resetComponent();
               }
               else
               {
                  this.debug("Target method \'resetComponent\' component is undefined");
               }
            }
            else
            {
               this.debug("Target component is null");
            }
         }
         else
         {
            this.debug("Target component is undefined");
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function unhighlightComponents()
   {
      this.debug("unhighlightComponents ()");
      var _loc5_ = pact.datastructures.SingletonList.getInstance().getLength();
      var _loc4_ = pact.datastructures.SingletonList.getInstance();
      var _loc3_ = 0;
      while(_loc3_ < _loc5_)
      {
         var _loc2_ = _loc4_.getAtIndex(_loc3_);
         if(_loc2_ != undefined)
         {
            if(_loc2_ != null)
            {
               _loc2_.unHighlight();
            }
            else
            {
               this.debug("Target component is null");
            }
         }
         else
         {
            this.debug("Target component is undefined");
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function getComponentList(a_type)
   {
      this.debug("getComponentList ()");
      this.reporter = new Array();
      var _loc6_ = pact.datastructures.SingletonList.getInstance().getLength();
      var _loc5_ = pact.datastructures.SingletonList.getInstance();
      var _loc3_ = 0;
      while(_loc3_ < _loc6_)
      {
         var _loc2_ = _loc5_.getAtIndex(_loc3_);
         if(_loc2_ != undefined)
         {
            if(_loc2_ != null)
            {
               if(a_type == null || a_type == _loc2_.getClassType())
               {
                  this.reporter.push(_loc2_);
               }
            }
         }
         _loc3_ = _loc3_ + 1;
      }
      return this.reporter;
   }
   function hookup()
   {
      this.debug("hookup ()");
      if(this.hooked == false)
      {
         if(_global.theShell != undefined && _global.theShell != null)
         {
            this.debug("Setting summary event handler ...");
            _global.theShell.addEventListener("processSummaryPing",mx.utils.Delegate.create(this,this.processSummaryPing));
            this.hooked = true;
         }
      }
   }
   function requestSummary()
   {
      this.debug("requestSummary ()");
      this.hookup();
      _global.theShell.pingSummary();
   }
   function processSummaryPing()
   {
      this.debug("processSummaryPing ()");
      this.dispatchEvent({target:this,type:"processSummary"});
   }
   function getSummary()
   {
      this.debug("getSummary ()");
      return _global.theShell.getSummary();
   }
   function displayMessage(a_message, a_trace, a_mode)
   {
      this.debug("displayMessage ()");
      this.debug(a_message);
      _global.theShell.displayMessage(a_message,a_trace,a_mode);
   }
   function getTutorMode()
   {
      return _global.theShell._BehaviorRecorder;
   }
   function debugDisplayList()
   {
      this.debug("debugDisplayList ()");
      var _loc3_ = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var _loc4_ in _loc3_)
      {
         var _loc2_ = _loc3_[_loc4_];
         this.debug("Component: [" + _loc2_.reftype + "] and instance name: " + _loc2_.refname);
      }
      this.debug("debugDisplayList () Done");
   }
   function getInstanceFromNamespace(a_namespace)
   {
      this.debug("getInstanceFromNameSpace (" + a_namespace + ")");
      var splitter = a_namespace.split(".");
      if(splitter.length == 0)
      {
         this.debug("Error: no elements found in namespace");
         return null;
      }
      var result = splitter[splitter.length - 1];
      this.debug("Resolved to instance name: " + result);
      var target = eval(result);
      if(target == null)
      {
         this.debug("The eval method call can\'t resolve this instance, we will have to use the component list ...");
         var comp = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
         for(var i in comp)
         {
            var ref = comp[i];
            if(result == ref.refname)
            {
               this.debug("We\'ve found a component, yay!");
               target = ref.reference;
            }
         }
      }
      return target;
   }
}
