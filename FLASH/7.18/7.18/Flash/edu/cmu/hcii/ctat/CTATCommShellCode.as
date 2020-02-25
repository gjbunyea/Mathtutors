class edu.cmu.hcii.ctat.CTATCommShellCode extends edu.cmu.hcii.ctat.CTATCommShellBase
{
   static var symbolName = "CTATCommShellCode";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATCommShellCode);
   var className = "CTATCommShellCode";
   var ParentClassName = "CTATCommShellBase";
   var infoMessages = null;
   function CTATCommShellCode()
   {
      super();
   }
   function init()
   {
      super.init();
      this.setClassType("CommShellCode");
      this.debug("init ()");
      this.infoMessages = new Array();
      this.linkData = new edu.cmu.hcii.ctat.CTATLinkData();
      this.performanceLog = new Array();
      this.serviceURL = _level0.curriculum_service_url;
      this.hint_button.onRelease = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.handlonHintClick);
      _global.theShell = this;
      this.debug("Initializing event dispatcher ...");
      mx.events.EventDispatcher.initialize(this);
      this.debug("Creating scrim object ...");
      this.createScrimInstance();
      this.debug("Setting up bounding box ...");
      this.boundingBox_mc._visible = false;
      this.boundingBox_mc._width = this.boundingBox_mc._height = 0;
      this.Connected_SymbolBGColor = new Color(this.menuBarBG.Connected_Symbol_mc);
      this.Connected_Dbg_SymbolBGColor = new Color(this.menuBarBG.Connected_Dbg_Symbol_mc);
      this.drawFocus(false);
      this.tabEnabled = false;
      this.debug("Enabling keyboard listener ...");
      var _loc4_ = new Object();
      this.setBehaviorRecorderMode();
      _loc4_.realThis = this;
      _loc4_.onKeyDown = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.handleKeyInput);
      Key.addListener(_loc4_);
      this.debug("Setting logging destination ...");
      this.setLoggingSourceAndDestination();
      this.doLater(this,"loadLoggingLibrary");
      this.debug("Setting security properties ...");
      System.security.allowInsecureDomain("*");
      System.security.allowInsecureDomain("pslc-qa.andrew.cmu.edu");
      System.security.allowInsecureDomain("localhost");
      System.security.allowInsecureDomain("127.0.0.1");
      System.security.allowInsecureDomain("learnlab.web.cmu.edu");
      System.security.allowDomain("*");
      System.security.allowDomain("pslc-qa.andrew.cmu.edu");
      System.security.allowDomain("localhost");
      System.security.allowDomain("127.0.0.1");
      System.security.allowDomain("learnlab.web.cmu.edu");
      this.__set__LockCorrectAnswers(true);
      this.debug("Indicating tutor version ...");
      this.debug("Setting up mouse listener ...");
      this.setMouseListener();
      this.debug("Initializing socket settings ...");
      this.setSocketPort();
      this.setSocketURL();
      this.debug("Creating our main XML parser ...");
      this.XMLmessageManager = new edu.cmu.hcii.ctat.CTATparseXML(this);
      this.debug("Setting interface GUID ...");
      this.setInterfaceIdentifcationGUID(null);
      this.debug("Setting up BRD finish event listener ...");
      this.__set__brdFinishedParsing(false);
      this.addEventListener("onBrdParse",this.setShellStatus);
      this.buildModelProgressEvent1b(true);
      this.debug("Setting up skinnable GUI ...");
      this.assignUI();
      this.debug("Initializing behavior recorder mode ...");
      this.initBehaviorRecorderMode();
      this.debug("Clearing interval ...");
      clearInterval(this.buildEventIntervalIDb);
      this.debug("New skill array ...");
      this.arTheSkillArray = new Array();
      this.debug("Listening for repetition ready ...");
      this.assignRepetitionReadyHandler();
      this.debug("Create interface description message list ...");
      this.createInterfaceDescriptionMsglist();
      this.debug("Assigning initial data structures ...");
      this.assignInitialDataStructures();
      this.debug("Setting up context menu ...");
      this.displayContextMenu();
      this.debug("init finished");
   }
   function componentInit()
   {
      this.debug("componentInit ()");
      if(!this.inited)
      {
         this.initTabOrder();
         this.rearrangeTabIndex();
         this.inited = true;
      }
   }
   function draw()
   {
      super.draw();
      this.debug("draw ()");
      if(this.isLivePreview() == false)
      {
         this.debug("No scrim available, forcing the issue ...");
         this.checkInitScrim(true);
      }
      this.adjustSize();
   }
   function size()
   {
      super.size();
      this.debug("size ()");
      this.invalidate();
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.debug("Live Preview: " + this.isLivePreview());
      if(this.isLivePreview() == false)
      {
         this.green_check._visible = false;
         this.red_x._visible = false;
         this.scrinfo._visible = false;
         this.hourglass._visible = false;
         this.tgradtt._visible = false;
         this.tlogtt._visible = false;
         this.tdisctt._visible = false;
         this.tservicett._visible = false;
         this.scrimoverlay._visible = false;
         this.infok._visible = false;
      }
      this.checkInitScrim(false);
      this.checkAlternativeHintButton();
      this.checkAlternativeHintWindow();
   }
   function addPerformanceEntry(a_type, a_delta, a_measure)
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.suppressDebug == true)
      {
         return undefined;
      }
      this.debug("addPerformanceLog ()");
      var _loc2_ = new edu.cmu.hcii.ctat.CTATPerformanceMeasure();
      _loc2_.type = a_type;
      _loc2_.delta = a_delta;
      _loc2_.measure = a_measure;
      this.performanceLog.push(_loc2_);
   }
   function showPerformanceLog()
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.suppressDebug == true)
      {
         return undefined;
      }
      this.debug("showPerformanceLog ()");
      var _loc2_ = 0;
      while(_loc2_ < this.performanceLog.length)
      {
         this.debug_raw(this.performanceLog[_loc2_].type + "\t" + this.performanceLog[_loc2_].delta + "\t" + this.performanceLog[_loc2_].measure);
         _loc2_ = _loc2_ + 1;
      }
   }
   function getPerformanceString()
   {
      this.debug("displayContextComponents ()");
      var _loc3_ = "";
      var _loc2_ = 0;
      while(_loc2_ < this.performanceLog.length)
      {
         _loc3_ = _loc3_ + (this.performanceLog[_loc2_].type + "-" + this.performanceLog[_loc2_].delta + "-" + this.performanceLog[_loc2_].measure);
         if(_loc2_ != this.performanceLog.length - 1)
         {
            _loc3_ = _loc3_ + ",";
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function adjustSize()
   {
      this.debug("adjustSize ()");
      this.positionGraphics(false);
   }
   function displayMessage(a_message, a_trace, a_mode)
   {
      this.debug("DEPRECATED SHOULD BE DELETED displayMessage ()");
      return undefined;
   }
   function confirmDone()
   {
      this.debug("confirmDone ()");
   }
   function checkAlternativeHintWindow()
   {
      this.debug("checkAlternativeHintWindow ()");
      if(_global.hintWindow != undefined && _global.hintWindow != null)
      {
         this.setAlternativeHintWindow(_global.hintWindow);
      }
   }
   function setAlternativeHintWindow(a_window)
   {
      this.debug("setAlternativeHintWindow ()");
      this.ctat_hint_window = a_window;
      if(this.ctat_hint_window == null || this.ctat_hint_window == undefined)
      {
         this.debug("Error, alternative hint window is null");
      }
   }
   function checkAlternativeHintButton()
   {
      this.debug("checkAlternativeHintButton ()");
      if(_global.hintButton != undefined && _global.hintButton != null && _global.theShell.alternativeHintButton == null)
      {
         this.debug("Assigning alternative hint button ...");
         this.setAlternativeHintButton(_global.hintButton);
      }
      else
      {
         this.debug("Alternative hint button already assigned");
      }
   }
   function setAlternativeHintButton(a_clip)
   {
      this.debug("setAlternativeHintButton ()");
      if(_global.theShell.alternativeHintButton == null)
      {
         this.debug("Hiding regular hint button and assigning new one ...");
         _global.theShell.hint_button.enabled = false;
         _global.theShell.hint_button._visible = false;
         _global.theShell.ctat_hint_button._visible = false;
         _global.theShell.alternativeHintButton = a_clip;
         _global.theShell.alternativeHintButton.onRelease = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.handlonHintClick);
         if(this.ShowHintButton == false)
         {
            _global.theShell.alternativeHintButton._visible = false;
         }
      }
   }
   function useScrim(a_val)
   {
      this.debug("userScrim (" + a_val + ")");
      this.scrimuse = a_val;
      if(this.scrimuse == false)
      {
         if(this.scrim != null)
         {
            this.scrim.useScrim(false);
         }
      }
   }
   function createScrimInstance()
   {
      this.debug("createScrimInstance ()");
      if(this.isLivePreview() == true)
      {
         this.scrimuse = false;
      }
      if(this.scrimuse == true)
      {
         this.scrim = new edu.cmu.hcii.ctat.CTATScrim();
         this.scrim.addEventListener("restart",mx.utils.Delegate.create(this,this.processScrimRestartEvent));
         this.scrim.addEventListener("tutorAvailable",mx.utils.Delegate.create(this,this.processTutorAvailable));
         this.scrim.addEventListener("tutorUnavailable",mx.utils.Delegate.create(this,this.processTutorUnavailable));
         this.scrim.addEventListener("signalScrimUp",mx.utils.Delegate.create(this,this.processScrimUp));
         this.scrim.addEventListener("signalScrimDown",mx.utils.Delegate.create(this,this.processScrimDown));
      }
   }
   function checkInitScrim(a_force)
   {
      this.debug("checkInitScrim ()");
      this.debug("Checking BehaviorRecorderMode: " + _level0.BehaviorRecorderMode);
      if(_level0.BehaviorRecorderMode != undefined)
      {
         if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(_level0.BehaviorRecorderMode,"AuthorTime") == true)
         {
            this.debug("Disabling use of scrim altogether");
            this.scrimuse = false;
         }
      }
      else
      {
         this.scrimuse = false;
      }
      if(this.scrimuse == false)
      {
         return undefined;
      }
      if(a_force == false)
      {
         if(this.scrim.getScrimAvailable() == false)
         {
            if(this.isLivePreview() != undefined)
            {
               if(this.isLivePreview() == false)
               {
                  this.scrim.createScrim(false);
                  this.scrim.showScrim(true);
               }
               else
               {
                  this.debug("Info: we\'re in live preview mode");
               }
            }
            else
            {
               this.debug("Info: isLivePreview is not available yet");
            }
         }
         else
         {
            this.debug("Info: we already have a scrim");
         }
      }
      else
      {
         this.debug("Forcing scrim creation ...");
         if(this.scrim.getScrimAvailable() == false)
         {
            this.scrim.createScrim(true);
            this.scrim.showScrim(true);
         }
         else
         {
            this.debug("Info: we already have a scrim");
         }
      }
   }
   function positionGraphics(showMenu)
   {
      this.debug("positionGraphics ()");
      if(this.__get__height() < 200)
      {
         this.theHeight = 200;
      }
      else
      {
         this.theHeight = this.height;
      }
      if(this.__get__width() < 500)
      {
         this.theWidth = 500;
      }
      else
      {
         this.theWidth = this.width;
      }
      this.menuBarBG._visible = showMenu;
      var _loc2_ = undefined;
      if(showMenu == true)
      {
         _loc2_ = 14;
      }
      else
      {
         _loc2_ = -2;
      }
      this.menuBarBG._width = this.theWidth - 5;
      this.background_window._y = 0;
      this.background_window._height = this.theHeight - 90;
      this.background_window._width = this.theWidth - 5;
      this.background_shadow._y = 0;
      this.background_shadow._height = this.theHeight - 85;
      this.background_shadow._width = this.theWidth;
      if(this.feedback_window_orientation == "up")
      {
         this.feedback_window._y = -215;
         this.feedback_window._x = this.theWidth / 2 - this.feedback_window._width / 2 - 18;
      }
      else
      {
         this.feedback_window._y = this.theHeight - 290;
         this.feedback_window._x = this.theWidth / 2 - this.feedback_window._width / 2 - 18;
      }
      this.hint_window._y = this.theHeight - 290;
      this.hint_window._x = this.theWidth / 2 - this.hint_window._width / 2 - 10;
      this.hint_button._y = _loc2_;
      this.hint_button._x = 373.3 + this.theWidth - 500;
      this.ctat_hint_button._y = _loc2_ + 3;
      this.ctat_hint_button._x = 373.3 + this.theWidth - 500;
      this.waitclip._x = this._x + this._width - 25 + 1;
      this.waitclip._y = _loc2_;
   }
   function getexpectedLogLibraryVersion()
   {
      return this.expectedLogLibraryVersion;
   }
   function setexpectedLogLibraryVersion(theValue)
   {
      this.expectedLogLibraryVersion = theValue;
   }
   function getDTDversion()
   {
      return this.DTDversion;
   }
   function getClassVersion()
   {
      return this.publicVersion;
   }
   function handlonEnterFrame()
   {
      this.debug("handleonEnterFrame ()");
      if(this.enterCount > 0)
      {
         if(this.isLivePreview() == undefined || this.isLivePreview() == false)
         {
            this.debug("No scrim available, forcing the issue ...");
            this.checkInitScrim(true);
         }
      }
      if(this.enterCount > 0)
      {
         this.debug("Disabling event handler for onEnterFrame (" + this.enterCount + ")");
         _level0.onEnterFrame = null;
      }
      this.enterCount = this.enterCount + 1;
   }
   function handlonRelease()
   {
      this.debug("handleonRelease ()");
      this.Cleanup();
   }
   function assignInitialDataStructures()
   {
      this.debug("assignInitialDataStructures ()");
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.TutSvcTimeout) == true)
      {
         this.__set__ClientForceQuitTime(_level0.TutSvcTimeout);
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.TutoringServiceTimeout) == true)
      {
         this.__set__ClientForceQuitTime(_level0.TutoringServiceTimeout);
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.tutsvctimeout) == true)
      {
         this.__set__ClientForceQuitTime(_level0.tutsvctimeout);
      }
      this.debug("assignInitialDataStructures :  _level0.TutSvcTimeout = " + _level0.TutSvcTimeout + " ClientForceQuitTime = " + this.__get__ClientForceQuitTime());
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.FeedbackAndHintFormat) == true)
      {
         this.__set__FeedbackAndHintFormat(this.fixFeedbackAndHintFormatErrors(_level0.FeedbackAndHintFormat));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.feedbackandhintformat) == true)
      {
         this.__set__FeedbackAndHintFormat(this.fixFeedbackAndHintFormatErrors(_level0.feedbackandhintformat));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.feedback_hint_format) == true)
      {
         this.__set__FeedbackAndHintFormat(this.fixFeedbackAndHintFormatErrors(_level0.feedback_hint_format));
      }
      this.debug("assignInitialDataStructures :  _level0.FeedbackAndHintFormat = " + _level0.FeedbackAndHintFormat + " FeedbackAndHintFormat = " + this.__get__FeedbackAndHintFormat());
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.ShowShellUI) == true)
      {
         this.__set__ShowShellUI(edu.cmu.hcii.ctat.CTATUtil.convertStringToBoolean(_level0.ShowShellUI));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.showshellui) == true)
      {
         this.__set__ShowShellUI(edu.cmu.hcii.ctat.CTATUtil.convertStringToBoolean(_level0.showshellui));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.show_shell_ui) == true)
      {
         this.__set__ShowShellUI(edu.cmu.hcii.ctat.CTATUtil.convertStringToBoolean(_level0.show_shell_ui));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.ShowShell) == true)
      {
         this.__set__ShowShellUI(edu.cmu.hcii.ctat.CTATUtil.convertStringToBoolean(_level0.ShowShell));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.ShellVisible) == true)
      {
         this.__set__ShowShellUI(edu.cmu.hcii.ctat.CTATUtil.convertStringToBoolean(_level0.ShellVisible));
      }
      this.debug("assignInitialDataStructures :  _level0.ShowShellUI = " + _level0.ShowShellUI + " ShowShellUI = " + this.__get__ShowShellUI());
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.student_interface) == true)
      {
         this.setLastTutorInterface(_level0.student_interface);
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.TutorInterface) == true)
      {
         this.setLastTutorInterface(_level0.TutorInterface);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.RepetitionOrder) == true)
      {
         this.setRepetitionOrder(this.fixRepetitionOrderFormatErrors(_level0.RepetitionOrder));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.repetitionOrder) == true)
      {
         this.setRepetitionOrder(this.fixRepetitionOrderFormatErrors(_level0.repetitionOrder));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.repetition_order) == true)
      {
         this.setRepetitionOrder(this.fixRepetitionOrderFormatErrors(_level0.repetition_order));
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.TutorShopDeliveryMethod) == true)
      {
         this.__set__LVMethodForSendDone(this.setTutorShopDeliveryMethod(_level0.TutorShopDeliveryMethod));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.tutorshopdeliverymethod) == true)
      {
         this.__set__LVMethodForSendDone(this.setTutorShopDeliveryMethod(_level0.tutorshopdeliverymethod));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.tutorshop_delivery_method) == true)
      {
         this.__set__LVMethodForSendDone(this.setTutorShopDeliveryMethod(_level0.tutorshop_delivery_method));
      }
      this.debug("assignInitialDataStructures :  _level0.RepetitionOrder = " + _level0.RepetitionOrder + " getRepetitionOrder = " + this.getRepetitionOrder());
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.show_debug_traces) == true)
      {
         this.__set__includeTraces(edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultTrue(_level0.show_debug_traces));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.traces) == true)
      {
         this.__set__includeTraces(edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultTrue(_level0.traces));
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.ShowDebugTraces) == true)
      {
         this.__set__includeTraces(edu.cmu.hcii.ctat.CTATUtil.convertStringToBooleanDefaultTrue(_level0.ShowDebugTraces));
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.MediaPath) == true)
      {
         this.__set__theMediaPath(_level0.MediaPath);
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.media_path) == true)
      {
         this.__set__theMediaPath(_level0.media_path);
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_level0.mediapath) == true)
      {
         this.__set__theMediaPath(_level0.mediapath);
      }
      else
      {
         this.__set__theMediaPath("");
      }
      if(_level0.problem_started_url != undefined)
      {
         this.responseURL = _level0.problem_started_url;
      }
   }
   function setTutorShopDeliveryMethod(theValue)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"new") == true || theValue == "send")
      {
         return "New Page (bundles)";
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"rep") == true || theValue == "sendandload")
      {
         return "Repetition";
      }
      return "New Page (bundles)";
   }
   function fixFeedbackAndHintFormatErrors(theFHF)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theFHF,"t") == true && edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theFHF,"on"))
      {
         return "Text Only";
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theFHF,"t") == true && edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theFHF,"au"))
      {
         return "Text + Audio";
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theFHF,"au") == true && edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theFHF,"on"))
      {
         return "Audio Only";
      }
      return "Text + Audio";
   }
   function fixRepetitionOrderFormatErrors(theROF)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theROF,"l") == true)
      {
         return "Linear";
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theROF,"r") == true)
      {
         return "Random";
      }
      return "Linear";
   }
   function createInterfaceDescriptionMsglist()
   {
      this._InterfaceDescriptionMsglist = new edu.cmu.hcii.ctat.CTATSimpleList();
   }
   function getInterfaceDescriptionMsglist()
   {
      return this._InterfaceDescriptionMsglist;
   }
   function lockWidgets(widgetList)
   {
      this.debug("Shell : lockWidgets : ");
      var _loc3_ = widgetList.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         this.lockTheWidget(widgetList[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
   }
   function unLockWidgets(widgetList)
   {
      this.debug("unLockWidgets ()");
      var _loc3_ = widgetList.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         widgetList[_loc2_].unlock();
         _loc2_ = _loc2_ + 1;
      }
   }
   function loadLoggingLibrary()
   {
      this.debug("loadLoggingLibrary ()");
      this.debug("Using internal logging library ... logging = : ");
      this.internalLogger = new edu.cmu.hcii.ctat.CTATCommLoggingLibrary(this.serviceURL);
      this.getLogClass().setShell(this);
      var _loc2_ = _level0.log_service_url.split(",");
      if(_level0.Logging == "None" || this._sLoggingDefinition == "None")
      {
         this.getLogClass().setNoLog(true);
      }
      this.getLogClass().init(_loc2_);
      this.getLogClass().addEventListener("LoggingInitialized",mx.utils.Delegate.create(this,this.onLoggingEstablished));
      this.onLoadInit();
      this.debug("Logging should now be available");
      return undefined;
   }
   function onLoadInit(target_mc)
   {
      this.debug("onLoadInit ()");
      this.debug(" : Logging should be available now : _level999.LogClass.getClassVersion() = " + this.getLogClass().getClassVersion());
      var _loc2_ = this.getLogClass().checkTutorCompatibility(this.getexpectedLogLibraryVersion());
      if(_loc2_.compatible == false)
      {
         this.debug(_loc2_.description);
      }
      if(this.getLogClass().getClassVersion().substr(0,1) == "1" || this.getLogClass().getClassVersion().substr(0,1) == "2" && this.getLogClass().getClassVersion().substr(2,1) == "0")
      {
         var _loc3_ = "The tutor loaded an old version (" + this.getLogClass().getClassVersion() + ") of the Logging Library and the tutor will NOT log correctly! You need the version 2.1.0.1 or later. ";
         if(this.isLivePreview() != true)
         {
            var _loc4_ = false;
            this.Feedback(_loc3_,_loc4_);
            this.setInitWarning(true);
         }
      }
      else if(this.getLogClass().getClassVersion().substr(0,1) == "2" && this.getLogClass().getClassVersion().substr(2,1) == "3" && Number(this.getLogClass().getClassVersion().substr(4)) < 12)
      {
         _loc3_ = "The tutor loaded an old version (" + this.getLogClass().getClassVersion() + ") of the Logging Library and the tutor will NOT log tool messages correctly! You need the version 2.3.12 or later which has added support for custom fields in the tool messages. ";
         this.debug(_loc3_ + "3rd level : " + Number(this.getLogClass().getClassVersion().substr(4,1)));
         if(this.isLivePreview() != true)
         {
            _loc4_ = false;
            this.Feedback(_loc3_,_loc4_);
            this.setInitWarning(true);
         }
      }
   }
   function onLoggingEstablished()
   {
      this.debug("onLoggingEstablished ()");
      if(this.scrimuse == true)
      {
         this.scrim.setLogging(true);
      }
   }
   function setLoggingSourceAndDestination()
   {
      this.debug("setLoggingSourceAndDestination ()");
      if(_level0.logging == undefined)
      {
         this.debug("Info: _level0.logging==undefined");
      }
      if(_level0.Logging == undefined)
      {
         this.debug("Info: _level0.Logging==undefined");
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.logging) == true && edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.Logging) == false)
      {
         _level0.Logging = _level0.logging;
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.Logging) == false && edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.logging) == false)
      {
         if(this.__get__loggingDefinition() == "Client To Log Server")
         {
            _level0.Logging = "ClientToLogServer";
         }
         if(this.__get__loggingDefinition() == "Service To Log Server")
         {
            _level0.Logging = "Service To Log Server";
         }
         if(this.__get__loggingDefinition() == "Service To Disk")
         {
            _level0.Logging = "Service To Disk";
         }
         if(this.__get__loggingDefinition() == "Service To Disk and Log Server")
         {
            _level0.Logging = "Service To Disk and Log Server";
         }
         if(this.__get__loggingDefinition() == "None")
         {
            _level0.Logging = "None";
         }
         this.debug("1 setLoggingSourceAndDestination : Logging specs Not Defined in Flashvars so define it here :\n loggingDefinition =" + this.__get__loggingDefinition() + "\n _level0.Logging =" + _level0.Logging + "\n _level0.log_to_remote_server =" + _level0.log_to_remote_server + "\n _level0.log_to_disk =" + _level0.log_to_disk);
      }
      if(_level0.Logging == "ClientToLogServer")
      {
         this.__set__loggingDefinition("Client To Log Server");
         _level0.log_to_remote_server = "false";
         _level0.log_to_disk = "false";
      }
      else if(_level0.Logging == "ServiceToLogServer")
      {
         this.__set__loggingDefinition("Service to Log Server");
         _level0.log_to_remote_server = "true";
         _level0.log_to_disk = "false";
      }
      else if(_level0.Logging == "ServiceToDisk")
      {
         this.__set__loggingDefinition("Service to Disk");
         _level0.log_to_remote_server = "false";
         _level0.log_to_disk = "true";
      }
      else if(_level0.Logging == "ServiceToDiskAndLogServer")
      {
         this.__set__loggingDefinition("Service to Disk And Log Server");
         _level0.log_to_remote_server = "true";
         _level0.log_to_disk = "true";
      }
      else if(_level0.Logging == "None")
      {
         if(this.scrimuse == true)
         {
            this.scrim.setUseLogging(false);
         }
         this.__set__loggingDefinition("None");
         _level0.log_to_remote_server = "false";
         _level0.log_to_disk = "false";
      }
      else
      {
         this.displayMessage("Fatal error, no valid log parameter provided. You supplied: " + this.__get__loggingDefinition(),null,"FAIL");
         return undefined;
      }
      if(_level0.Logging == "None")
      {
         this.displayMessage("Warning: you\'ve chosen not to log data",null,"INFO");
         return undefined;
      }
      if(_level0.Logging != "None" && _level0.Logging != "ServiceToDisk")
      {
         if(_level0.log_service_url == "" || _level0.log_service_url == undefined)
         {
            this.displayMessage("Fatal error, no primary log server url provided",null,"FAIL");
            return undefined;
         }
         if(_level0.log_service_url != "localhost")
         {
            if(_level0.log_service_url.indexOf(".") == -1)
            {
               this.displayMessage("Fatal error, invalid log url provided",null,"FAIL");
               return undefined;
            }
         }
      }
      else
      {
         this.debug("2 setLoggingSourceAndDestination :  loggingDefinition =" + this.__get__loggingDefinition() + " _level0.Logging =" + _level0.Logging + " _level0.log_to_remote_server =" + _level0.log_to_remote_server + " _level0.log_to_disk =" + _level0.log_to_disk);
      }
   }
   function setInitWarning(bStatus)
   {
      this._initWarning = bStatus;
   }
   function getInitWarning()
   {
      return this._initWarning;
   }
   function setMouseListener()
   {
      var _loc2_ = new Object();
      _loc2_.realThis = this;
      _loc2_.onMouseUp = this.handleMouseInput;
      Mouse.addListener(_loc2_);
   }
   function handleMouseInput()
   {
      this.realThis.escHandleMouseInput();
   }
   function escHandleMouseInput()
   {
      this.clickInsideNextOrPreviousHint();
   }
   function clickInsideNextOrPreviousHint()
   {
      if(this.hint_window.get_next_hint_button_mc.hitTest(this._parent._xmouse,this._parent._ymouse))
      {
         this.debug("clickInsideNextOrPreviousHint : hitTest is true for NEXT");
         this.onKillFocusHandler(this.hint_window.get_next_hint_button_mc);
         this.getHint("get_next_hint_button_mc");
         return undefined;
      }
      if(this.hint_window.get_previous_hint_button_mc.hitTest(this._parent._xmouse,this._parent._ymouse))
      {
         this.debug("clickInsideNextOrPreviousHint : hitTest is true for PREVIOUS");
         this.onKillFocusHandler(this.hint_window.get_previous_hint_button_mc);
         this.getHint("get_previous_hint_button_mc");
         return undefined;
      }
      return undefined;
   }
   function loadNextBRDFile(widget)
   {
      this.debug("loadNextBRDFile ()");
      try
      {
         if(this.getTheCurrentBRDindex() < this.getTheBRDFiles().length - 1)
         {
            this.CloseFeedbackWindow();
            widget.disassembleInterface();
            this.incrementBRDIndex();
            this.__set__BRDFileName(this.getBRDFileName(this.getTheBRDFiles(),this.getTheCurrentBRDindex()));
            this.resetLoggingParameters(this.__get__BRDFileName(),this.getProblemName(this.getTheProblemNames(),this.getTheCurrentBRDindex()));
            this.setStartStateEndHappened(false);
            this.detectModeAndLoad(this.__get__BRDFileName(),this.__get__BehaviorRecorder());
            return undefined;
         }
         throw new Error("Trying to load the next brd file but none remain");
      }
      catch(myError:Error)
      {
         this.debug("EXCEPTION : " + myError);
      }
   }
   function resetLoggingParameters(question, problem)
   {
      this.debug("resetLoggingParameters ()");
      this.getLogClass().setsessionEstablished(false);
      this.getLogClass().setProblemStarted(false);
      this.setQuestionFile(question);
      this.setProblemName(problem);
      this.debug("Shell : resetLoggingParameters : Called from :    :  getQuestionFile = " + this.getQuestionFile() + " problemName = " + problem);
   }
   function detectModeAndLoad(theBRD, theBRmode)
   {
      this.debug("detectModeAndLoad ()");
      this.debug("Shell : detectModeAndLoad :   theBRD =  " + theBRD + "  theBRmode = :  " + theBRmode);
      if(theBRmode == "AuthorTimeTutoring")
      {
         this.authorTimeLoadProblem(theBRD);
      }
      if(theBRmode == "RunTime")
      {
         this.debug("RUNTIME OH NO");
      }
   }
   function incrementBRDIndex()
   {
      this.setTheCurrentBRDindex(this.getTheCurrentBRDindex() + 1);
      return undefined;
   }
   function incrementAnIndex(theIndex)
   {
      return theIndex = theIndex + 1;
   }
   function redrawInterface(widget)
   {
      this.CloseFeedbackWindow();
      widget.disassembleInterface();
      widget.assembleInterface();
   }
   function resetStudentInterface()
   {
      this.XMLmessageManager.resetInterface();
   }
   function assignRepetitionReadyHandler()
   {
      this.addEventListener("repetitionReady",mx.utils.Delegate.create(this,this.onRepetitionReady));
   }
   function onRepetitionReady()
   {
      return undefined;
   }
   function startPreloader()
   {
      this.debug("Shell : startPreloader :");
      _global.CTATPreloader.startRepetitionLoading();
   }
   function setLastTutorInterface(aTutorInterface)
   {
      this._lastTutorInterface = aTutorInterface;
   }
   function getLastTutorInterface()
   {
      return this._lastTutorInterface;
   }
   function loadNextProblemViaTutorShop(theBRD, theProblemName)
   {
      this.CloseFeedbackWindow();
      this.debug("Shell : loadNextProblemViaTutorShop :  theBRD = " + theBRD + " theProblemName = " + theProblemName);
      try
      {
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(theBRD) == false)
         {
            throw new Error("loadNextProblemViaTutorShop : the BRD (" + theBRD + ") is invalid. The problem name is " + theProblemName + ". ");
         }
         else
         {
            this.debug("loadNextProblemViaTutorShop : \n  _level0.question_file = " + _level0.question_file);
            var _loc3_ = edu.cmu.hcii.ctat.CTATUtil.getBRDPath(_level0.question_file);
            this.incrementBRDIndex();
            this.resetLoggingParameters(_loc3_ + "/" + theBRD,theProblemName);
            this.setStartStateEndHappened(false);
            this.detectModeAndLoad(_loc3_ + "/" + theBRD,this.__get__BehaviorRecorder());
         }
      }
      catch(myError:Error)
      {
         this.debug("EXCEPTION : " + myError);
         return undefined;
      }
   }
   function handlonHintClick()
   {
      this.debug("handlonHintClick ()");
      this.getHint("hint_button");
   }
   function getHintExternal(widget)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(widget) == false)
      {
         widget = "hint_button";
      }
      this.getHint(widget);
   }
   function getHint(widget)
   {
      this.debug("getHint (" + widget + ")");
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(widget) == false)
      {
         widget = "hint_button";
         this.debug("EXCEPTION : widget parameter is not valid. Default to \'hint_button\'");
      }
      this.dispatchHintRequestedEvent();
      this.sourceWidgetName = widget;
      this.CloseFeedbackWindow();
      this.debug("getHint :  widget = " + widget);
      if(this.ctat_hint_window == null)
      {
         if(this.sourceWidgetName == "hint_button")
         {
            var _loc5_ = this.CloseHintWindow();
            if(_loc5_ == true)
            {
               return undefined;
            }
         }
      }
      if(widget == "hint_button")
      {
         if(this.__get__BehaviorRecorder() != "RunTime")
         {
            if(this.__get__BehaviorRecorder() == "AuthorTime" || this.__get__BehaviorRecorder() == "AuthorTimeTutoring")
            {
               var _loc3_ = this.getAppropriateHintFocus(this.theCurrentFocus);
               if(_loc3_ == null)
               {
                  _loc3_ = null;
               }
               else if(this.theCurrentFocus.commType == "radioButton")
               {
                  _loc3_ = this.theCurrentFocus.getGroupName();
               }
               else
               {
                  _loc3_ = String(this.theCurrentFocus);
               }
               this.forwardTransactionID = edu.cmu.hcii.ctat.CTATGuid.create();
               this.debug("getHint : AT : theCurrentFocus = " + this.theCurrentFocus + "  appropriateHintFocus = " + _loc3_);
               var _loc4_ = edu.cmu.hcii.ctat.CTATMessageFormat.makeHintMessage(this.getAppropriateHintFocus(this.theCurrentFocus),this.forwardTransactionID);
               this.debug("Sending hint request: " + _loc4_);
               this.myXMLSocket.send(_loc4_);
               this.debug("Hint dead end!");
            }
         }
      }
      else if(widget == "get_next_hint_button_mc" || widget == "get_previous_hint_button_mc")
      {
         this.forwardTransactionID = edu.cmu.hcii.ctat.CTATGuid.create();
         this.debug("2 getHint : Next or Previous Hint : call showHint : widget = " + widget + " this.theCurrentHighlight = " + this.theCurrentHighlight + " theHintArray.length = " + this.theHintArray.length + " this.arTheSkillArray = " + this.arTheSkillArray + " this.currentHintLevel = " + this.currentHintLevel + " this.theHintSelection =  " + this.theHintSelection + " this.theHintAction = " + this.theHintAction + " this.theHintInput  = " + this.theHintInput);
         this.showHint(widget,this.theCurrentHighlight,this.theHintArray,this.arTheSkillArray,this.currentHintLevel,this.theHintSelection,this.theHintAction,this.theHintInput,true);
      }
   }
   function getAppropriateHintFocus(oTheCurrentFocus)
   {
      this.debug("getAppropriateHintFocus (" + oTheCurrentFocus + ")");
      var _loc2_ = undefined;
      var _loc3_ = edu.cmu.hcii.ctat.CTATUtil.removeLevel(String(oTheCurrentFocus));
      this.debug("getAppropriateHintFocus : sTheCurrentFocus = " + _loc3_ + "  getLastClickedComponent = " + this.getLastClickedComponent() + "  oTheCurrentFocus.getTextHasChanged = " + oTheCurrentFocus.getTextHasChanged());
      if(oTheCurrentFocus.commType == "radioButton")
      {
         _loc2_ = oTheCurrentFocus.getGroupName();
      }
      else if(_loc3_ == null || _loc3_ == undefined)
      {
         _loc2_ = null;
      }
      else
      {
         _loc2_ = _loc3_;
      }
      this.debug("getAppropriateHintFocus : sHintFocus = " + _loc2_);
      return _loc2_;
   }
   function assembleHintsforShowHint(theSelection, theAction, theInput, theHints, theRules)
   {
      this.debug("assembleHintsforShowHint ()");
      this.debug("3 assembleHintsforShowHint : call showHint : widget = " + this.sourceWidgetName + " theSelection = " + theSelection + " theHints[0] = " + theHints[0] + " theHints.length = " + theHints.length + " this.arTheSkillArray = " + this.arTheSkillArray + " this.currentHintLevel = " + this.currentHintLevel + " theSelection Name =  " + theSelection._name + " theAction = " + theAction + " theInput  = " + theInput);
      this.debug("assembleHintsforShowHint : getIsDone = " + this.getIsDone());
      if(this.getIsDone() == false)
      {
         var _loc7_ = 0;
         this.setHints(theHints);
         this.theHintSelection = theSelection._name;
         this.theHintAction = theAction;
         this.theHintInput = theInput;
         if(theRules != null && theRules != undefined)
         {
            this.arTheSkillArray = theRules;
         }
         this.showHint(this.sourceWidgetName,theSelection,this.getHints(),this.arTheSkillArray,_loc7_,theSelection._name,theAction,theInput,false);
      }
   }
   function showHint(widget, oHighlightedWidget, arEdgeHints, arEdgeSkills, nHintLevel, sHintSelection, sHintAction, sHintInput, logTutorMessage)
   {
      this.debug("showHint ()");
      this.debug("widget = " + widget + "  oHighlightedWidget = " + oHighlightedWidget + " nHintLevel = " + nHintLevel + " arEdgeHints[" + nHintLevel + "] = " + arEdgeHints[nHintLevel] + "  theCurrentFocus = " + this.theCurrentFocus + " typeof theCurrentFocus = " + typeof this.theCurrentFocus);
      this.showHintAudioIcon(false);
      this.stopHintSound();
      var newhint;
      var hintLevel = nHintLevel;
      if(this.feedback_window._currentframe > 1 && this.feedback_window._currentframe < 10)
      {
         this.debug("showHint : feedback window is all the way down so just close");
         return undefined;
      }
      if(this.ctat_hint_window != null)
      {
         this.ctat_hint_window.setHintsMax(arEdgeHints.length);
      }
      if(widget == "get_previous_hint_button_mc")
      {
         hintLevel = hintLevel - 2;
         newhint = arEdgeHints[hintLevel];
      }
      else
      {
         newhint = arEdgeHints[hintLevel];
      }
      this.debug("showHint : 1 newhint = " + newhint);
      newhint = edu.cmu.hcii.ctat.CTATUtil.escapeLoneXML(newhint);
      this.debug("showHint : 2 newhint = " + newhint);
      if(!newhint)
      {
         this.debug("EXCEPTION : showHint :  NO NEW HINTS (!newhint ) :  return here :  hintLevel = " + hintLevel);
         return undefined;
      }
      this.debug("showHint :  dispatch a hint event hintLevel =" + hintLevel + " arEdgeHints[" + hintLevel + "] = " + arEdgeHints[hintLevel]);
      this.dispatchHintShownEvent(arEdgeHints[hintLevel]);
      var shellerToolerings = new edu.cmu.hcii.ctat.CTATShellTools();
      shellerToolerings.unhighlightComponents();
      if(oHighlightedWidget.commType == "checkBox")
      {
         this.debug("Checking highlight applicability for checkBox ...");
         if(eval(oHighlightedWidget.getGroupName()) != null && eval(oHighlightedWidget.getGroupName()) != undefined)
         {
            this.debug("Activating radio button highlight code for valid group ...");
            this.highlightRadio("_level0",oHighlightedWidget.getGroupName(),oHighlightedWidget,true);
         }
         else
         {
            this.debug("Calling highlight directly on the checkbox ...");
            oHighlightedWidget.highlight();
            this.debug("Done highlighting");
         }
      }
      else if(oHighlightedWidget.commType == "radioButton")
      {
         this.debug("Applying highlight rules for radiobutton ...");
         this.highlightRadio("_level0",oHighlightedWidget.getGroupName(),oHighlightedWidget,true);
      }
      else
      {
         this.debug("Applying default highlight rules to: [" + oHighlightedWidget + "] ...");
         oHighlightedWidget.highlight();
      }
      hintLevel++;
      if(hintLevel > 1)
      {
         this.showNextPrevHintButton(true,this.hint_window.get_previous_hint_button_mc);
         this.get_previous_hint_button_visible = true;
      }
      else
      {
         this.showNextPrevHintButton(false,this.hint_window.get_previous_hint_button_mc);
         this.get_previous_hint_button_visible = false;
      }
      if(hintLevel < arEdgeHints.length)
      {
         this.showNextPrevHintButton(true,this.hint_window.get_next_hint_button_mc);
         this.get_next_hint_button_visible = true;
      }
      else
      {
         this.showNextPrevHintButton(false,this.hint_window.get_next_hint_button_mc);
         this.get_next_hint_button_visible = false;
      }
      this.debug("showHint :   FeedbackAndHintFormat = " + this.__get__FeedbackAndHintFormat());
      if(this.ctat_hint_window != null)
      {
         this.debug("Showing hint in hintwindow component");
         if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(this.__get__FeedbackAndHintFormat(),"Text"))
         {
            this.debug("Giving hint text to hintwindow component ...");
            this.ctat_hint_window.showFeedback(newhint,false);
         }
      }
      else
      {
         this.debug("No alternative hint window available!");
      }
      if(this.hint_window._currentframe != 10)
      {
         this.hint_window.gotoAndPlay(2);
         if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(this.__get__FeedbackAndHintFormat(),"Text"))
         {
            this.hint_window.hint_text1.tween11.hinttext.htmlText = newhint;
         }
         this.hint_window.hint_text1.gotoAndStop(10);
         this.hint_window.refreshScrollBar();
      }
      else
      {
         if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(this.__get__FeedbackAndHintFormat(),"Text"))
         {
            this.hint_window.hint_text2.tween11.hinttext.htmlText = this.getPrevHint();
            this.hint_window.hint_text2.tween11.hinttext.scroll = this.hint_window.hint_text1.tween11.hinttext.scroll;
            this.hint_window.hint_text1.tween11.hinttext.htmlText = newhint;
         }
         this.hint_window.hint_text1.gotoAndPlay(2);
         this.hint_window.hint_text2.gotoAndPlay(11);
         this.hint_window.refreshScrollBar();
      }
      this.processAsfunction(newhint);
      this.debug("showHint 2:   typeof(hint_window.hint_text1.tween11) = " + typeof this.hint_window.hint_text1.tween11);
      this.CloseFeedbackWindow();
      this.debug("Finally here");
      if(this.__get__BehaviorRecorder() == "RunTime" || this.__get__BehaviorRecorder() == "AuthorTimeTutoring" && this.__get__loggingDefinition() == "Client To Log Server")
      {
         this.debug("RUNTIME OH NO");
      }
      else
      {
         this.debug("We\'re either not in tutor mode or we\'re not logging to server, not sending tool message!");
      }
      this.setPrevHint(newhint);
      this.currentHintLevel = hintLevel;
      this.detectCurrentTouchBottomedOut(hintLevel,arEdgeHints);
   }
   function detectCurrentTouchBottomedOut(hintLevel, arEdgeHints)
   {
      if(hintLevel == arEdgeHints.length)
      {
         this.setCurrentTouchBottomedOut(true);
      }
      this.debug("detectCurrentTouchBottomedOut : \n  hintLevel = " + hintLevel + "\n arEdgeHints.length = " + arEdgeHints.length + "\n getCurrentTouchBottomedOut = " + this.getCurrentTouchBottomedOut());
   }
   function makeText(AString)
   {
      this.debug("Shell: makeText  : AString = " + AString);
      return "makeText method string = " + AString;
   }
   function showNextPrevHintButton(turn, oBtnName)
   {
      oBtnName._visible = turn;
   }
   function dispatchHintShownEvent(sHint)
   {
      this.dispatchEvent({type:"onHintShown",target:this,theHint:sHint});
   }
   function dispatchHintRequestedEvent()
   {
      this.dispatchEvent({type:"onHintRequested",target:this});
   }
   function __set__Hints(userHints)
   {
      this.theHintArray = userHints;
      return this.__get__Hints();
   }
   function __get__Hints()
   {
      return this.theHintArray;
   }
   function setHints(userHints)
   {
      var _loc2_ = this.removeInvalidHints(userHints);
      this.theHintArray = _loc2_;
   }
   function getHints()
   {
      return this.theHintArray;
   }
   function removeInvalidHints(userHints)
   {
      var _loc1_ = userHints;
      for(var _loc2_ in _loc1_)
      {
         if(_loc1_[_loc2_] == "NA" || _loc1_[_loc2_] == "")
         {
            _loc1_.splice(Number(_loc2_),1);
         }
         else if(_loc1_[_loc2_].substr(0,2) == "NA" && edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(_loc1_[_loc2_],"asfunction"))
         {
            _loc1_[_loc2_] = _loc1_[_loc2_].substring(2);
         }
      }
      return _loc1_;
   }
   function __set__ShowShellUI(theValue)
   {
      this._visible = theValue;
      return this.__get__ShowShellUI();
   }
   function __get__ShowShellUI()
   {
      return this._visible;
   }
   function setShowShellUI(theValue)
   {
      this.__set__ShowShellUI(theValue);
   }
   function getShowShellUI()
   {
      return this.__get__ShowShellUI();
   }
   function __set__ShowShellHintButton(theValue)
   {
      this.debug("ShowShellHintButton: " + theValue);
      this.ShowHintButton = theValue;
      if(this.alternativeHintButton != null && this.alternativeHintButton != undefined)
      {
         this.alternativeHintButton._visible = theValue;
      }
      this.hint_button._visible = theValue;
      return this.__get__ShowShellHintButton();
   }
   function __get__ShowShellHintButton()
   {
      return this.ShowHintButton;
   }
   function setShowShellHintButton(theValue)
   {
      this.ShowHintButton = theValue;
      if(this.alternativeHintButton != null && this.alternativeHintButton != undefined)
      {
         this.alternativeHintButton._visible = theValue;
      }
      this.hint_button._visible = theValue;
   }
   function getShowShellHintButton()
   {
      this.debug("getShowShellHintButton (" + this.ShowHintButton + ")");
      return this.ShowHintButton;
   }
   function __set__UseHourGlass(theValue)
   {
      this.debug("UseHourGlass: " + theValue);
      this.bgUseHourGlass = theValue;
      return this.__get__UseHourGlass();
   }
   function __get__UseHourGlass()
   {
      return this.bgUseHourGlass;
   }
   function __set__RepetitionOrder(theValue)
   {
      this._repetitionOrder = theValue;
      return this.__get__RepetitionOrder();
   }
   function __get__RepetitionOrder()
   {
      return this._repetitionOrder;
   }
   function setRepetitionOrder(theValue)
   {
      this.__set__RepetitionOrder(theValue);
   }
   function getRepetitionOrder()
   {
      return this.__get__RepetitionOrder();
   }
   function __set__LogMode(theValue)
   {
      this.sgLogMode = theValue;
      return this.__get__LogMode();
   }
   function __get__LogMode()
   {
      return this.sgLogMode;
   }
   function playHint(audioFile)
   {
      this.debug("playHint ()");
      this.showHintAudioIcon(true);
      var _loc2_ = "";
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(this.__get__theMediaPath()) == true)
      {
         if(this.__get__theMediaPath().indexOf("/") == -1)
         {
            _loc2_ = this.__get__theMediaPath() + "/";
         }
         else
         {
            _loc2_ = this.theMediaPath;
         }
      }
      this.debug("Shell: playHint  : audioFile = " + _loc2_ + audioFile);
      var _loc3_ = _loc2_ + audioFile;
      this.hint_window.audioIcon.playNewSound(_loc3_);
   }
   function playIncorrect(audioFile)
   {
      this.debug("playIncorrect ()");
      this.showIncorrectAudioIcon(true);
      var _loc2_ = "";
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(this.__get__theMediaPath()) == true)
      {
         if(this.__get__theMediaPath().indexOf("/") == -1)
         {
            _loc2_ = this.__get__theMediaPath() + "/";
         }
         else
         {
            _loc2_ = this.theMediaPath;
         }
      }
      this.debug("Shell: feedback_window  : audioFile = " + _loc2_ + audioFile);
      var _loc3_ = _loc2_ + audioFile;
      this.feedback_window.audioIcon.playNewSound(_loc3_);
   }
   function playCorrect(audioFile)
   {
      this.debug("playCorrect ()");
      this.showIncorrectAudioIcon(true);
      var _loc2_ = "";
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(this.__get__theMediaPath()) == true)
      {
         if(this.__get__theMediaPath().indexOf("/") == -1)
         {
            _loc2_ = this.__get__theMediaPath() + "/";
         }
         else
         {
            _loc2_ = this.theMediaPath;
         }
      }
      this.debug("Shell: playCorrect  : audioFile = " + _loc2_ + audioFile);
      var _loc3_ = _loc2_ + audioFile;
      this.feedback_window.audioIcon.playNewSound(_loc3_);
   }
   function authorTimeInit()
   {
      this.debug("authorTimeInit ()");
      this.setCommonSocketSettings();
   }
   function authorTimeTutoringInit()
   {
      this.debug("authorTimeTutoringInit (" + this.__get__BRDFileName() + ")");
      this.setInitialBRDFileName();
      this.__set__BRDFileName(this.detectBRDExtension(this.__get__BRDFileName()));
      this.setCommonSocketSettings();
   }
   function getCrossDomainPolicyFile(theSocketURL, thePort)
   {
      this.debug("getCrossDomainPolicyFile ()");
      if(this.isLivePreview() != true)
      {
         var _loc2_ = "xmlsocket://" + theSocketURL + ":" + thePort;
         System.security.loadPolicyFile(_loc2_);
      }
   }
   function getCrossDomainPolicyFileLater()
   {
      this.getCrossDomainPolicyFile(this.__get__socketURL(),1504);
   }
   function reInitAuthorTimeTutoringTutor()
   {
      this.debug("reInitAuthorTimeTutoringTutor ()");
      this.debug("Shell : BEFORE : reInitAuthorTimeTutoringTutor : getForceQuitStatus = " + this.getForceQuitStatus() + " getSocketConnectionActiveTime = " + this.getSocketConnectionActiveTime());
      this.setSocketConnectionActiveTime(this.getTimerS());
      this.setForceQuitStatus(false);
      this.setPrefsMsgNeedsToBeSent(true);
      this.setStartStateEndHappened(false);
      this.debug("Shell : AFTER : reInitAuthorTimeTutoringTutor : getForceQuitStatus = " + this.getForceQuitStatus() + " getSocketConnectionActiveTime = " + this.getSocketConnectionActiveTime());
      this.connectToSocket(this.__get__socketURL(),this.__get__socketPort());
   }
   function setTheCurrentHighlight(sTheCurrentHighlight)
   {
      this.theCurrentHighlight = sTheCurrentHighlight;
   }
   function getTheCurrentHighlight()
   {
      return this.theCurrentHighlight;
   }
   function setIsDone(bIsDone)
   {
      this.isDone = bIsDone;
   }
   function getIsDone()
   {
      return this.isDone;
   }
   function dispatchNewProblemEvent()
   {
      this.debug("dispatchNewProblemEvent ()");
      this.dispatchEvent({type:"onNewProblem",target:this});
   }
   function dispatchGotXMLMessageEvent(xmlObject)
   {
      this.debug("dispatchGotXMLMessageEvent ()");
      this.dispatchEvent({type:"GotXMLMessage",target:this,message:xmlObject.toString()});
   }
   function dispatchStartStateCreatedEvent()
   {
      this.debug("dispatchStartStateCreatedEvent ()");
      this.dispatchEvent({type:"onStartStateCreated",target:this});
   }
   function dispatchForceQuitStatusEvent()
   {
      this.debug("dispatchForceQuitStatusEvent ()");
      this.dispatchEvent({type:"onForceQuitStatusEvent",target:this});
   }
   function dispatchResetActionEvent()
   {
      this.debug("dispatchResetActionEvent ()");
      this.dispatchEvent({type:"onResetActionEvent",target:this});
   }
   function dispatchStartProblemEvent()
   {
      this.debug("dispatchStartProblemEvent ()");
      this.dispatchEvent({type:"onStartProblem",target:this});
   }
   function dispatchStartStateEndEvent()
   {
      this.debug("dispatchStartStateEndEvent ()");
      if(this.scrimuse == true)
      {
         if(_global.theShell.scrim.getGrading() == true)
         {
            this.scrim.setGrading(false);
         }
         this.scrim.setTutorService(true,false);
      }
      this.scrim.setLogging(true);
      this.dispatchEvent({type:"onStartStateEndEvent",target:this});
      this.setStartStateEndHappened(true);
      this.newSession();
      this.newProblem();
      this.rearrangeTabIndex();
      this.requestTutorServiceVersion();
      _global.linkData.serviceInfo.SendServerTimeStamp = true;
   }
   function dispatchHighlightMessageEvent()
   {
      this.debug("dispatchHighlightMessageEvent : Shell");
      this.dispatchEvent({type:"onHighlightMessageEvent",target:this});
   }
   function dispatchSuccessMessageEvent()
   {
      this.debug("dispatchHighlightMessageEvent : Shell");
      this.dispatchEvent({type:"onSuccessMessageEvent",target:this});
   }
   function dispatchBuggyMessageEvent()
   {
      this.debug("dispatchBuggyMessageEvent : Shell");
      this.dispatchEvent({type:"onBuggyMessageEvent",target:this});
   }
   function dispatchIsTutorVisibleEvent()
   {
      this.debug("dispatchIsTutorVisibleEvent : Shell");
      this.dispatchEvent({type:"onIsTutorVisibleEvent",target:this});
   }
   function dispatchLoadBRDFileSuccessEvent()
   {
      this.debug("dispatchLoadBRDFileSuccessEvent : Shell");
      this.dispatchEvent({type:"LoadBRDFileSuccessEvent",target:this});
   }
   function dispatchSendWidgetLockEvent()
   {
      this.debug("dispatchSendWidgetLockEvent : Shell");
      this.dispatchEvent({type:"onSendWidgetLockEvent",target:this});
   }
   function dispatchShowLoginWindowEvent()
   {
      this.debug("dispatchShowLoginWindowEvent : Shell");
      this.dispatchEvent({type:"onShowLoginWindowEvent",target:this});
   }
   function dispatchSetLabelTPA(brSelection, brInput)
   {
      this.debug("dispatchSetLabelTPA : Shell");
      this.dispatchEvent({type:"SetLabelTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchLoadMovieTPA(brSelection, brInput)
   {
      this.debug("dispatchLoadMovieTPA : Shell");
      this.dispatchEvent({type:"LoadMovieTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchMoveComponentTPA(brSelection, brInput)
   {
      this.debug("dispatchMoveComponentTPA : Shell");
      this.dispatchEvent({type:"MoveComponentTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchRemoveComponentTPA(brSelection, brInput)
   {
      this.debug("dispatchRemoveComponentTPA : Shell");
      this.dispatchEvent({type:"RemoveComponentTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchSetParameterTPA(brSelection, brInput)
   {
      this.debug("dispatchSetParameterTPA : Shell");
      this.dispatchEvent({type:"SetParameterTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchSetVisibleTPA(brSelection, brInput)
   {
      this.debug("dispatchSetVisibleTPA : Shell");
      this.dispatchEvent({type:"SetVisibleTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchSetTextTPA(brSelection, brInput)
   {
      this.debug("dispatchSetTextTPA : Shell");
      this.dispatchEvent({type:"SetTextTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchUnlockWidgetTPA(brSelection, brInput)
   {
      this.debug("dispatchUnlockWidgetTPA : Shell");
      this.dispatchEvent({type:"UnlockWidgetTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchLockWidgetTPA(brSelection, brInput)
   {
      this.debug("dispatchLockWidgetTPA : Shell");
      this.dispatchEvent({type:"LockWidgetTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchGotoAndPlayTPA(brSelection, brInput)
   {
      this.debug("dispatchGotoAndPlayTPA : Shell");
      this.dispatchEvent({type:"GotoAndPlayTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function dispatchGotoAndStopTPA(brSelection, brInput)
   {
      this.debug("dispatchGotoAndStopTPA : Shell");
      this.dispatchEvent({type:"GotoAndStopTPA",target:this,theSelection:brSelection,theInput:brInput});
   }
   function ShellTrace(theMsg)
   {
      this.dispatchEvent({type:"ShellTraceMsg",target:this,msg:theMsg});
   }
   function displayContextMenu()
   {
      this.debug("displayContextMenu ()");
      var _loc2_ = new ContextMenu();
      var _loc4_ = new ContextMenuItem("Show Your Tutor Information",this.displayContextComponents);
      var _loc3_ = new ContextMenuItem("Show Your Tutor\'s Performance",this.displayPerformance);
      _loc2_.customItems.push(_loc4_);
      _loc2_.customItems.push(_loc3_);
      _level0.menu = _loc2_;
   }
   function displayContextComponents()
   {
      this.debug("displayContextComponents ()");
      var _loc2_ = new edu.cmu.hcii.ctat.CTATShellTools();
      _loc2_.displayContextComponents(null);
   }
   function displayPerformance()
   {
      this.debug("displayPerformance ()");
      var _loc2_ = new edu.cmu.hcii.ctat.CTATShellTools();
      _loc2_.displayPerformance(null);
   }
   function processScrimRestartEvent()
   {
      this.debug("processScrimRestartEvent ()");
      if(this.scrimuse == true)
      {
         this.scrim.showRestart(false);
      }
      this.reInitAuthorTimeTutoringTutor();
   }
   function processTutorAvailable()
   {
      this.debug("processTutorAvailable ()");
      this.dispatchEvent({target:this,type:"tutorServiceAvailable"});
   }
   function processTutorUnavailable()
   {
      this.debug("processTutorUnavailable ()");
      this.dispatchEvent({target:this,type:"tutorServiceUnavailable"});
   }
   function processScrimUp()
   {
      this.debug("processScrimUp ()");
      this.gotoFirstTabIndex(this.getClassTabWidgetArray());
      this.dispatchEvent({target:this,type:"scrimUp"});
   }
   function processScrimDown()
   {
      this.debug("processScrimDown ()");
      this.dispatchEvent({target:this,type:"scrimDown"});
   }
   function Cleanup()
   {
      this.debug("Cleanup ()");
      this.displayCriticalStatus();
      super.Cleanup();
      edu.cmu.hcii.ctat.CTATGlobal.doneMsg = null;
      edu.cmu.hcii.ctat.CTATGlobal.result_lv = null;
      edu.cmu.hcii.ctat.CTATGlobal.bailout_lv = null;
      this.myXMLSocket.close();
      clearInterval(this.delayThenSendDoneLVmsgInterval);
      clearInterval(this.connectInterval);
      clearInterval(this.timeoutInterval);
      this.debug("Cleanup () done");
   }
   function enableComponents(enable)
   {
      this.debug("enableComponents ()");
      var _loc2_ = new edu.cmu.hcii.ctat.CTATShellTools();
      if(enable == true)
      {
         _loc2_.enableDisplayList();
      }
      else
      {
         _loc2_.disableDisplayList();
      }
   }
   function displayCriticalStatus()
   {
      this.debug("displayCriticalStatus ()");
      this.debug("Timers CommShellBase, buildIntervalID: " + this.buildIntervalID + " buildEventIntervalIDa: " + this.buildEventIntervalIDa + " buildEventIntervalIDb: " + this.buildEventIntervalIDb);
      this.debug("Timers CommShellCode, delayThenSendDoneLVmsgInterval: " + this.delayThenSendDoneLVmsgInterval + " connectInterval: " + this.connectInterval + " timeoutInterval: " + this.timeoutInterval);
   }
   function setShellMode(oldMode, newMode)
   {
      this.debug("setShellMode (" + oldMode + "," + newMode + ")");
      if(newMode == "Set Start State")
      {
         var _loc3_ = new edu.cmu.hcii.ctat.CTATShellTools();
         _loc3_.unlockDisplayList();
      }
      if(newMode == "Demonstrate" || newMode == "Set Start State")
      {
      }
      if(newMode == "Test Tutor")
      {
      }
   }
   function processAssociatedRules(theTransaction_id, theSelection, theAction, theInput, theIndicator, theRules, theTutorAdvice, theEvaluation, theToolSelection)
   {
      this.debug("processAssociatedRules ()");
      this.lastTransaction = theTransaction_id;
      this.lastAction = theAction;
      this.lastSelection = theSelection;
      this.lastIndicator = theIndicator;
      this.lastToolSelection = theToolSelection;
      this.dispatchEvent({type:"processAssociatedRules",target:this});
   }
}
