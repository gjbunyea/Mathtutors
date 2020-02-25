class edu.cmu.hcii.ctat.CTATCommShellRoot extends edu.cmu.hcii.ctat.CTATComponentBase
{
   var reducedMode = "false";
   static var symbolName = "CTATCommShellRoot";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATCommShellRoot);
   var className = "CTATCommShellRoot";
   var ParentClassName = "CTATComponentBase";
   var version = "2.11.0";
   var publicVersion = "2.11.0";
   var DTDversion = "4";
   var expectedLogLibraryVersion = "2.3.12";
   var _socketAlive = false;
   var _prefsMsgNeedsToBeSent = true;
   var _socketConnectionAttempts = 0;
   var _socketConnectionActiveTime = 0;
   static var CONNECTED = "connected";
   static var TEMPDISCONNECTED = "tempdisconnected";
   static var FINALDISCONNECTED = "finaldisconnected";
   var connectFailedNotices = 0;
   var delayThenSendDoneLVmsgCounter = 0;
   var currentHintLevel = 0;
   var answerAudioCount = 0;
   var language = "ENG";
   var countLoad = 0;
   var connectDelayCounter = 0;
   var problemStarted = false;
   var logInited = false;
   var _currentTouchBottomedOut = false;
   var codeSetFocus = false;
   var nArrayDepth = 0;
   var inited = false;
   var commType = "tutorShell";
   var _hintColor = 16776960;
   var correctColor = 47872;
   var incorrectColor = 16711680;
   var bgColor = 16777215;
   var currentBRDindex = 1;
   var count = 0;
   var _initiallyConnected = false;
   var _forceQuit = false;
   var tutorTheStudent = true;
   var suppressStudentFeedback = false;
   var enforceDone = false;
   var isDone = false;
   var repetitionDone = false;
   var confirmDone = false;
   var _disableSuccessMsgAfterLastHint = false;
   var _MonitorLog = null;
   var use_logging = false;
   var internalLogger = null;
   var blocking = false;
   var blockrep = null;
   var waitclip = null;
   var indicator = null;
   var responseURL = "unassigned";
   var responseIndicated = false;
   var responseController = null;
   var volatile_response = null;
   var scrimuse = true;
   var scrim = null;
   var sumping = false;
   var sumcache = "empty";
   var alternativeHintButton = null;
   var ctat_skill_bar = null;
   var ctat_hint_window = null;
   var tutorState = "IDLE";
   var forcedDisconnect = false;
   var ShowHintButton = true;
   var enterCount = 0;
   var jsProxy = null;
   var clientLogger = null;
   var obtainSummary = true;
   var enterFrameDisabled = false;
   var studentSteps = null;
   var skillSet = null;
   var tabarranged = false;
   var tutorTabOrder = null;
   var internalTabFocus = null;
   var disableInput = false;
   var hintsBlocked = true;
   var forwardTransactionID = "undefined";
   var hintList = null;
   var shellTools = null;
   var processingStartState = false;
   var skindata = null;
   var sgLogMode = "HTTP";
   function CTATCommShellRoot()
   {
      super();
   }
   function disableShellInput(a_val)
   {
      this.debug("disableShellInput (" + a_val + ")");
      this.disableInput = a_val;
   }
   function getDisableShellInput()
   {
      return this.disableInput;
   }
   function setClassType(a_type)
   {
      this.className = a_type;
   }
   function init()
   {
      super.init();
      this.setClassType("CTATCommShellRoot");
      this.debug("init () - 1");
      mx.events.EventDispatcher.initialize(this);
      this.jsProxy = new edu.cmu.hcii.ctat.CTATJsProxy();
      this.clientLogger = new edu.cmu.hcii.ctat.CTATClientLogger();
      this.hintList = new edu.cmu.hcii.ctat.CTATHintList();
      this.shellTools = new edu.cmu.hcii.ctat.CTATShellTools();
      this.skindata = new edu.cmu.hcii.ctat.CTATSkinData();
      _global.skindata = this.skindata;
      if(_level0.skindata != undefined && _level0.skindata != null)
      {
         this.skindata.loadSkinData(_level0.skindata);
      }
      else
      {
         this.debug("No skin data provided, using default settings");
      }
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
      this.clientLogger.setupEventListeners();
      this.clientLogger.logTime("SWFrunning");
   }
   function setCurrentTabFocusEnabled(a_val)
   {
      this.debug("setCurrentTabFocusEnabled (" + a_val + ")");
   }
   function setCurrentTabFocus(an_object)
   {
      this.debug("setCurrentTabFocus (" + an_object._name + ")");
      this.internalTabFocus = an_object;
      this.debug("Recorded focus is now: " + this.internalTabFocus._name);
      if(an_object.commType == "textArea" || an_object.commType == "textInput")
      {
         this.debug("Asking Flash to set actual focus to text based component ...");
         this.debug("Returned: " + _root.focusManager.setFocus(an_object.textbox));
      }
      else
      {
         this.debug("Asking Flash to set actual focus to non-text based component ...");
         this.debug("Returned: " + _root.focusManager.setFocus(an_object));
      }
   }
   function getCurrentTabFocus()
   {
      this.debug("getCurrentTabFocus (" + this.internalTabFocus._name + ")");
      return this.internalTabFocus;
   }
   function setCurrentTouchBottomedOut(theValue)
   {
      this.debug("setCurrentTouchBottomedOut ()");
      this._currentTouchBottomedOut = theValue;
   }
   function getCurrentTouchBottomedOut()
   {
      return this._currentTouchBottomedOut;
   }
   function getInterfaceIdentifcationGUID()
   {
      this.debug("getInterfaceIdentifcationGUID (): " + this._InterfaceIdentificationGUID);
      return this._InterfaceIdentificationGUID;
   }
   function setStartStateEndHappened(theValue)
   {
      this._startStateEndHappened = theValue;
   }
   function getStartStateEndHappened()
   {
      return this._startStateEndHappened;
   }
   function setInitiallyConnected(bStatus)
   {
      this._initiallyConnected = bStatus;
   }
   function getInitiallyConnected()
   {
      return this._initiallyConnected;
   }
   function emitCorrectActionDetectedEvent()
   {
      this.debug("emitCorrectActionDetectedEvent ()");
      this.dispatchEvent({type:"correctActionDetected",target:this});
   }
   function emitInCorrectActionDetectedEvent()
   {
      this.debug("emitInCorrectActionDetectedEvent ()");
      this.dispatchEvent({type:"inCorrectActionDetected",target:this});
   }
   function getBRDFileName(arTheBRDFiles, nTheCurrentBRDindex)
   {
      if(arTheBRDFiles.length <= nTheCurrentBRDindex)
      {
         return null;
      }
      return this.theBRDFiles[nTheCurrentBRDindex];
   }
   function setTheCurrentBRDindex(nIndex)
   {
      this.currentBRDindex = nIndex;
   }
   function getTheCurrentBRDindex()
   {
      return this.currentBRDindex;
   }
   function setTheBRDFiles(arBRDFiles)
   {
      this.theBRDFiles = arBRDFiles;
   }
   function getTheBRDFiles()
   {
      return this.theBRDFiles;
   }
   function setUnorderedMode(theValue)
   {
      this._unorderedMode = theValue;
   }
   function getUnorderedMode()
   {
      return this._unorderedMode;
   }
   function setHighlightRightSelection(theValue)
   {
      this._highlightRightSelection = theValue;
   }
   function getHighlightRightSelection()
   {
      return this._highlightRightSelection;
   }
   function setEnforceDone(theValue)
   {
      this.enforceDone = theValue;
   }
   function getEnforceDone()
   {
      return this.enforceDone;
   }
   function setConfirmDone(theValue)
   {
      this.debug("Shell : setConfirmDone : " + theValue);
      this.confirmDone = theValue;
   }
   function getConfirmDone()
   {
      return this.confirmDone;
   }
   function startGrading()
   {
      if(this.scrimuse == true)
      {
         _global.theShell.scrim.setGrading(true);
      }
   }
   function endGrading()
   {
      if(this.scrimuse == true)
      {
         if(_global.theShell.scrim.getGrading() == true)
         {
            _global.theShell.scrim.setGrading(false);
         }
      }
   }
   function sendXML(textToSend)
   {
      this.debug("sendXML ()");
      this.timeoutDetector("sendXML");
      if(this.getForceQuitStatus() == true)
      {
         this.debug(this.getTimerS() + " sendXML : the socket has timedout so don\'t send.");
         return undefined;
      }
      this.debug("sendXML:  send to BR : " + textToSend);
      this.setSocketConnectionActiveTime(this.getTimerS());
      var _loc2_ = new XML(textToSend);
      _loc2_.xmlDecl = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
      this.myXMLSocket.send(_loc2_);
   }
   function setSocketCommStatus(theValue)
   {
      this._socketCommStatus = theValue;
   }
   function getSocketCommStatus()
   {
      return this._socketCommStatus;
   }
   function setSocketConnectionAttempts()
   {
      this.debug("SCA=" + this._socketConnectionAttempts);
      this._socketConnectionAttempts = this._socketConnectionAttempts + 1;
   }
   function getSocketConnectionAttempts()
   {
      return this._socketConnectionAttempts;
   }
   function setSocketConnectionActiveTime(theValue)
   {
      this.debug("setSocketConnectionActiveTime ()");
      this._socketConnectionActiveTime = theValue;
   }
   function getSocketConnectionActiveTime()
   {
      return this._socketConnectionActiveTime;
   }
   function setForceQuitStatus(bStatus)
   {
      this.debug("setForceQuitStatus ()");
      this.debug("See connectToSocket method : bStatus = " + bStatus);
      this.forceQuit(bStatus,"setForceQuitStatus");
   }
   function getForceQuitStatus()
   {
      return this._forceQuit;
   }
   function forceQuit(bStatus, mSource)
   {
      this.debug("forceQuit ()");
      this._forceQuit = bStatus;
      if(bStatus == true)
      {
         this.timeoutAndForceQuiteCloseConnection(mSource);
         this.setSocketCommStatus(edu.cmu.hcii.ctat.CTATCommShellRoot.FINALDISCONNECTED);
      }
   }
   function setCommonSocketSettings()
   {
      this.debug("setCommonSocketSettings ()");
      this.closeConnection("setCommonSocketSettings");
      this.debug("Connecting to Behavior Recorder or Tutoring Service at: " + this.__get__socketURL() + " with port: " + this.__get__socketPort());
      this.connectToSocket(this.__get__socketURL(),this.__get__socketPort());
   }
   function connectToSocket(theSocketURL, thePort)
   {
      this.debug("connectToSocket ()");
      this.debug("Creating new socket ...");
      this.myXMLSocket = new XMLSocket();
      this.myXMLSocket.onConnect = mx.utils.Delegate.create(this,this.handleConnect);
      this.myXMLSocket.onClose = mx.utils.Delegate.create(this,this.handleDisconnect);
      this.myXMLSocket.onData = mx.utils.Delegate.create(this.XMLmessageManager,this.XMLmessageManager.handleData);
      this.debug(this.getTimerS() + " shell : connectToSocket : isLivePreview() = " + this.isLivePreview() + "   getForceQuitStatus() = " + this.getForceQuitStatus() + "  getSocketAlive = " + this.getSocketAlive() + " getSocketCommStatus = " + this.getSocketCommStatus() + " getPrefsMsgNeedsToBeSent = " + this.getPrefsMsgNeedsToBeSent() + " getSocketConnectionAttempts = " + this.getSocketConnectionAttempts() + " getTimerS = " + this.getTimerS() + " getSocketConnectionActiveTime = " + this.getSocketConnectionActiveTime());
      this.timeoutDetector("connectToSocket");
      if(this.getForceQuitStatus() == true)
      {
         this.debug(this.getTimerS() + " shell : connectToSocket : show restartMessageFeedback :  isLivePreview() = " + this.isLivePreview() + "   getForceQuitStatus() = " + this.getForceQuitStatus() + "  getSocketAlive = " + this.getSocketAlive() + " getSocketCommStatus = " + this.getSocketCommStatus() + " getPrefsMsgNeedsToBeSent = " + this.getPrefsMsgNeedsToBeSent() + " getSocketConnectionAttempts = " + this.getSocketConnectionAttempts() + " getTimerS = " + this.getTimerS() + " getSocketConnectionActiveTime = " + this.getSocketConnectionActiveTime());
         this.restartMessageFeedback();
         return undefined;
      }
      if(this.isLivePreview() == true)
      {
         this.closeConnection("connectToSocket livePreview");
         return undefined;
      }
      if(this.isLivePreview() != true && this.getForceQuitStatus() == false)
      {
         this.connectInterval = setInterval(this,"connectToSocketKeepTryingWithDelay",5000,theSocketURL,thePort);
         this.myXMLSocket.connect(theSocketURL,thePort);
         return undefined;
      }
   }
   function connectToSocketKeepTryingWithDelay(theSocketURL, thePort)
   {
      this.debug("connectToSocketKeepTryingWithDelay ()");
      if(this.connectDelayCounter > 0 && this.isLivePreview() != true)
      {
         this.debug("Attempting connection!");
         this.setSocketConnectionAttempts();
         this.myXMLSocket.connect(theSocketURL,thePort);
      }
      this.connectDelayCounter = this.connectDelayCounter + 1;
   }
   function handleConnect(connectionStatus)
   {
      this.debug("handleConnect ()");
      this.clientLogger.logTime("ConnTS:" + connectionStatus + "GSA=" + this.getSocketAlive() + "GSCS=" + "SCA=" + this.getSocketConnectionAttempts() + "SCAT" + this.getSocketConnectionActiveTime() + "getTimers()=" + this.getTimerS() + "CFN=" + this.connectFailedNotices + "FD=" + this.forcedDisconnect + "setPref=" + this.getPrefsMsgNeedsToBeSent());
      if(connectionStatus == true)
      {
         this.debug("connectionStatus==true");
         clearInterval(this.connectInterval);
         this.connectDelayCounter = 0;
         this.setSocketAlive(true);
         this.setSocketCommStatus(edu.cmu.hcii.ctat.CTATCommShellRoot.CONNECTED);
         this.setSocketConnectionActiveTime(this.getTimerS());
         this.debug(this.getTimerS() + " shell : handleConnect(true)  : Connect Success :" + " connectionStatus = " + connectionStatus + " getForceQuitStatus() = " + this.getForceQuitStatus() + "  getSocketAlive = " + this.getSocketAlive() + " getSocketCommStatus = " + this.getSocketCommStatus() + " getPrefsMsgNeedsToBeSent = " + this.getPrefsMsgNeedsToBeSent() + " getSocketConnectionAttempts = " + this.getSocketConnectionAttempts() + " getSocketConnectionActiveTime = " + this.getSocketConnectionActiveTime());
         if(this.forcedDisconnect == true)
         {
            if(this.scrimuse == true)
            {
               this.scrim.setTutorService(true,true);
            }
         }
         else
         {
            this.dispatchEvent({type:"onSocketConnect",target:this});
            this.initTutoringService();
         }
         this.connectFailedNotices = 0;
         clearInterval(this.timeoutInterval);
         if(this.__get__BehaviorRecorder() == "AuthorTimeTutoring")
         {
            this.timeoutInterval = setInterval(this,"timeoutDetector",60000,"Interval started in handleConnect");
         }
      }
      else
      {
         this.debug("connectionStatus==false");
         if(this.connectFailedNotices == 0)
         {
            this.setSocketAlive(false);
            this.setSocketCommStatus(edu.cmu.hcii.ctat.CTATCommShellRoot.TEMPDISCONNECTED);
            this.debug(this.getTimerS() + " EXCEPTION : shell : handleConnect(false)  : Connect Fail :" + " connectionStatus = " + connectionStatus + " getForceQuitStatus() = " + this.getForceQuitStatus() + "  getSocketAlive = " + this.getSocketAlive() + " getSocketCommStatus = " + this.getSocketCommStatus() + " getPrefsMsgNeedsToBeSent = " + this.getPrefsMsgNeedsToBeSent() + " getSocketConnectionAttempts = " + this.getSocketConnectionAttempts() + " getSocketConnectionActiveTime = " + this.getSocketConnectionActiveTime());
            this.connectFailedNotices = 1;
         }
      }
   }
   function initTutoringService()
   {
      this.debug("initTutoringService ()");
      this.sendInterfaceIdentificationMsg();
      if(this.getPrefsMsgNeedsToBeSent() == true)
      {
         this.setStartStateEndHappened(false);
         this.authorTimeLoadProblem(this.getBRDFileName(this.getTheBRDFiles(),this.getTheCurrentBRDindex()));
      }
   }
   function authorTimeLoadProblem(theBRD)
   {
      this.debug("authorTimeLoadProblem (" + theBRD + ")");
      this.sendSetPreferencesMessage(theBRD);
   }
   function sendSetPreferencesMessage(aBRDFileName)
   {
      this.debug("sendSetPreferencesMessage ()");
      this.debug("aBRDFileName =  " + aBRDFileName + " getStartStateEndHappened = " + this.getStartStateEndHappened());
      if(this.getStartStateEndHappened() == false)
      {
         this.sendXML(edu.cmu.hcii.ctat.CTATMessageFormat.makeSetPreferencesMessage(aBRDFileName,_level0.skills));
         this.setInitiallyConnected(true);
         this.setPrefsMsgNeedsToBeSent(false);
      }
      else
      {
         this.debug("Shell : sendSetPreferencesMessage : Did not send setPreferences message because the system thinks it was already sent getStartStateEndHappened = " + this.getStartStateEndHappened());
      }
   }
   function timeoutDetector(msgSource)
   {
      if(this.__get__BehaviorRecorder() == "AuthorTimeTutoring")
      {
         var _loc2_ = this.getTimerS() - this.getSocketConnectionActiveTime();
         if(this.getNClientForceQuitTime(this.__get__ClientForceQuitTime()) == -1)
         {
            return undefined;
         }
         if(_loc2_ > this.getNClientForceQuitTime(this.__get__ClientForceQuitTime()))
         {
            this.clientLogger.logTime("Wtf:" + this.getTimerS() + "_" + this.getSocketConnectionActiveTime() + "_" + _loc2_ + "_" + this.getNClientForceQuitTime(this.__get__ClientForceQuitTime()));
            clearInterval(this.timeoutInterval);
            this.setForceQuitStatus(true);
         }
      }
   }
   function getNClientForceQuitTime(sCFQT)
   {
      var _loc1_ = undefined;
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(sCFQT,"1 min") == true || sCFQT == "1")
      {
         _loc1_ = 60;
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(sCFQT,"15") == true)
      {
         _loc1_ = 900;
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(sCFQT,"30") == true)
      {
         _loc1_ = 1800;
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(sCFQT,"60") == true)
      {
         _loc1_ = 3600;
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(sCFQT,"120") == true)
      {
         _loc1_ = 7200;
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(sCFQT,"No timeout") == true)
      {
         _loc1_ = -1;
      }
      else
      {
         _loc1_ = 1800;
      }
      return _loc1_;
   }
   function getTimerS()
   {
      return getTimer() / 1000;
   }
   function timeoutAndForceQuiteCloseConnection()
   {
      this.debug("timeoutAndForceQuiteCloseConnection ()");
      this.XMLmessageManager.resetInterface();
      this.restartMessageFeedback();
      this.closeConnection("timeoutAndForceQuiteCloseConnection");
   }
   function closeConnection(mSource)
   {
      this.debug("closeConnection (" + mSource + ")");
      if(this.myXMLSocket != null)
      {
         this.myXMLSocket.close();
      }
      this.setDisconnectStatus();
   }
   function handleDisconnect()
   {
      this.debug("handleDisconnect ()");
      this.clientLogger.logTime("HandleDisconnect GSA=" + this.getSocketAlive() + "GSCS=" + "SCA=" + this.getSocketConnectionAttempts() + "SCAT" + this.getSocketConnectionActiveTime() + "getTimers()=" + this.getTimerS() + "CFN=" + this.connectFailedNotices + "FD=" + this.forcedDisconnect);
      if(this.clean == true)
      {
         return undefined;
      }
      this.forcedDisconnect = true;
      this.setDisconnectStatus();
      this.connectToSocket(this.__get__socketURL(),this.__get__socketPort());
   }
   function setDisconnectStatus()
   {
      this.debug("setDisconnectStatus ()");
      if(this.clean == true)
      {
         this.debug("We\'re long gone, don\'t even think about showing the poor user something");
         return undefined;
      }
      if(this.scrimuse == true)
      {
         this.scrim.setTutorService(false,true);
      }
      this.setSocketAlive(false);
      this.debug("Going into timed re-connect mode ...");
   }
   function setSocketPort()
   {
      if(_level0.remoteSocketPort != undefined)
      {
         this.__set__socketPort(_level0.remoteSocketPort);
      }
   }
   function setSocketURL()
   {
      if(_level0.remoteSocketURL != undefined)
      {
         this.__set__socketURL(_level0.remoteSocketURL);
      }
   }
   function setSocketAlive(bStatus)
   {
      this._socketAlive = bStatus;
   }
   function getSocketAlive()
   {
      return this._socketAlive;
   }
   function setPrefsMsgNeedsToBeSent(bStatus)
   {
      this._prefsMsgNeedsToBeSent = bStatus;
   }
   function getPrefsMsgNeedsToBeSent()
   {
      return this._prefsMsgNeedsToBeSent;
   }
   function __set__socketURL(sSocketURL)
   {
      this._socketURL = sSocketURL;
      return this.__get__socketURL();
   }
   function __get__socketURL()
   {
      return this._socketURL;
   }
   function sendInterfaceIdentificationMsg()
   {
      this.debug("sendInterfaceIdentificationMsg ()");
      this.sendXML(edu.cmu.hcii.ctat.CTATMessageFormat.makeInterfaceIdentificationMessage(this.getInterfaceIdentifcationGUID()));
   }
   function restartMessageFeedback()
   {
      this.debug("restartMessageFeedback ()");
      var _loc3_ = undefined;
      _loc3_ = "You have been idle for more than 30 minutes. Please reload the tutor by clicking the \'Restart Tutor\' button";
      if(this.scrimuse == true)
      {
         this.scrim.showRestart(true);
      }
      var _loc2_ = false;
      this.Feedback(_loc3_,_loc2_);
      this.debug("EXCEPTION : shell : restartMessageFeedback : getForceQuitStatus() = " + this.getForceQuitStatus() + " : The Tutoring Service has sent the InterfaceForceQuit message. This happens when the client has been idle for a long time.  This is considered a Service Inactivity Timeout");
   }
   function showFeedbackinSuppressStudentFeedbackMode(widget, aBuggyMessage)
   {
      this.debug("showFeedbackinSuppressStudentFeedbackMode ()");
      if(this.effectivelyDone(widget) == true && this.getEnforceDone() == false)
      {
         this.CloseFeedbackWindow(false);
      }
      else if(this.brBuggyMessage)
      {
         this.Feedback(aBuggyMessage,false);
      }
   }
   function Feedback(userFeedback, userFeedbackCorrect)
   {
      this.debug("Feedback (" + userFeedback + "," + userFeedbackCorrect + ")");
      if(this.scrimuse == true)
      {
         if(_global.theShell.scrim.getGrading() == true)
         {
            this.scrim.setGrading(false);
         }
      }
      this.showIncorrectAudioIcon(false);
      this.stopIncorrectSound();
      this.debug("Feedback : 0  userFeedback = " + userFeedback + " userFeedbackCorrect = " + userFeedbackCorrect + " DisableSuccessMsgAfterLastHint = " + this._disableSuccessMsgAfterLastHint + " getCurrentTouchBottomedOut() = " + this.getCurrentTouchBottomedOut());
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(userFeedback) == false || edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(userFeedback,"NA") || userFeedback.substr(0,2) == "NA" && edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(userFeedback,"asfunction"))
      {
         this.debug("Feedback message is not valid : userFeedback =" + userFeedback);
         this.closeHintAndFeedbackWindows();
         return undefined;
      }
      if(userFeedbackCorrect == true && this._disableSuccessMsgAfterLastHint == true && this.getCurrentTouchBottomedOut() == true)
      {
         this.debug("Success message will not be shown because the current widget has already had a success message : userFeedback =" + userFeedback);
         this.closeHintAndFeedbackWindows();
         return undefined;
      }
      this.debug("Feedback : 1   userFeedback = " + userFeedback);
      userFeedback = edu.cmu.hcii.ctat.CTATUtil.escapeLoneXML(userFeedback);
      this.debug("Feedback : 2   userFeedback = " + userFeedback);
      this.dispatchFeedbackShownEvent(userFeedback);
      this.prevFeedback = this.theFeedback;
      this.prevFeedbackCorrect = this.theFeedbackCorrect;
      this.theFeedback = userFeedback;
      this.theFeedbackCorrect = userFeedbackCorrect;
      this.CloseHintWindow(true);
      if(this.theFeedbackCorrect)
      {
         this.feedback_window.feedback_text1.green_check._visible = true;
         this.feedback_window.feedback_text1.red_x._visible = false;
      }
      else
      {
         this.feedback_window.feedback_text1.green_check._visible = false;
         this.feedback_window.feedback_text1.red_x._visible = true;
      }
      if(this.prevFeedbackCorrect)
      {
         this.feedback_window.feedback_text2.green_check._visible = true;
         this.feedback_window.feedback_text2.red_x._visible = false;
      }
      else
      {
         this.feedback_window.feedback_text2.green_check._visible = false;
         this.feedback_window.feedback_text2.red_x._visible = true;
      }
      this.debug("Feedback :   FeedbackAndHintFormat = " + this.__get__FeedbackAndHintFormat());
      this.feedback_window.feedback_text1.tween11.hinttext.html = true;
      this.feedback_window.feedback_text2.tween11.hinttext.html = true;
      if(this.feedback_window._currentframe != 10)
      {
         this.feedback_window.gotoAndPlay(2);
         if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(this.__get__FeedbackAndHintFormat(),"Text"))
         {
            this.feedback_window.feedback_text1.tween11.hinttext.htmlText = this.theFeedback;
         }
         this.feedback_window.feedback_text1.gotoAndStop(10);
         this.feedback_window.refreshScrollBar();
      }
      else
      {
         if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(this.__get__FeedbackAndHintFormat(),"Text"))
         {
            this.feedback_window.feedback_text2.tween11.hinttext.htmlText = this.prevFeedback;
            this.feedback_window.feedback_text2.tween11.hinttext.scroll = this.feedback_window.feedback_text1.tween11.hinttext.scroll;
            this.feedback_window.feedback_text1.tween11.hinttext.htmlText = this.theFeedback;
         }
         this.feedback_window.feedback_text1.gotoAndPlay(2);
         this.feedback_window.feedback_text2.gotoAndPlay(11);
         this.feedback_window.refreshScrollBar();
      }
      this.processAsfunction(this.theFeedback);
      this.debug("Feedback () done");
      if(this.ctat_hint_window != null)
      {
         this.debug("Showing feedback in hintwindow component");
         this.ctat_hint_window.setHintsMax(1);
         this.ctat_hint_window.disableButtons(true);
         this.ctat_hint_window.showFeedback(userFeedback,userFeedbackCorrect);
      }
   }
   function showFeedbackForRadioButtons(basePathOfClip, groupName, widget, gradeCorrectIncorrect)
   {
      this.debug("showFeedbackForRadioButtons ()");
      var pathOfClip = eval(basePathOfClip);
      for(var p in eval(pathOfClip))
      {
         if(pathOfClip[p] instanceof mx.core.UIObject || pathOfClip[p] instanceof mx.core.UIComponent)
         {
            if(pathOfClip[p] != widget && pathOfClip[p].getGroupName() == groupName && pathOfClip[p].commType == "radioButton")
            {
               this.showNullForWidget(pathOfClip[p]);
               if(gradeCorrectIncorrect == true)
               {
                  this.lockTheWidget(pathOfClip[p]);
               }
            }
            if(pathOfClip[p].compositeCommWidget == true)
            {
               this.showFeedbackForRadioButtons(pathOfClip[p],groupName,widget,gradeCorrectIncorrect);
            }
         }
         else if(typeof pathOfClip[p] == "movieclip")
         {
            this.showFeedbackForRadioButtons(pathOfClip[p],groupName,widget,gradeCorrectIncorrect);
         }
      }
   }
   function showNullForWidget(theWidget)
   {
      this.debug("showFeedbackForRadioButtons ()");
      theWidget.showNull();
   }
   function lockTheWidget(theWidget)
   {
      this.debug("lockTheWidget ()");
      if(this.__get__LockCorrectAnswers() == true)
      {
         theWidget.lock();
      }
   }
   function dispatchFeedbackShownEvent(sFeedback)
   {
      this.debug("dispatchFeedbackShownEvent ()");
      this.dispatchEvent({type:"FeedbackShown",target:this,theFeedback:sFeedback});
   }
   function dispatchFeedbackHideEvent()
   {
      this.debug("dispatchFeedbackHideEvent ()");
      this.dispatchEvent({type:"FeedbackHidden",target:this});
   }
   function closeHintAndFeedbackWindows()
   {
      this.dispatchFeedbackHideEvent();
      this.CloseHintWindow(false);
      this.CloseFeedbackWindow(false);
   }
   function CloseHintWindow(a_show)
   {
      this.debug("CloseHintWindow (" + a_show + ")");
      if(this.ctat_hint_window != null)
      {
         this.debug("Calling reset on hint window ...");
         this.ctat_hint_window.reset();
      }
      if(this.hint_window._currentframe > 1 and this.hint_window._currentframe <= 10)
      {
         this.debug("Closing hint window ...");
         if(a_show == true)
         {
            this.debug("Show argument is true, asking client hint visualizers to hide or reset ...");
            this.dispatchFeedbackHideEvent();
         }
         else
         {
            this.debug("Show argument is false, not propagating close event to hint visualizers");
         }
         this.hintsBlocked = true;
         this.hint_window.gotoAndPlay(11);
         this.currentHintLevel = 0;
         if(this.theCurrentHighlight.commType == "radioButton")
         {
            this.highlightRadio("_level0",this.theCurrentHighlight.getGroupName(),this.theCurrentHighlight,false);
         }
         else
         {
            this.theCurrentHighlight.unHighlight();
         }
         this.debug("CloseHintWindow : 1 : Open, return true : theCurrentHighlight name = " + this.theCurrentHighlight._name + " theCurrentHighlight = " + this.theCurrentHighlight);
         return true;
      }
      this.debug("Nothing to close");
      return false;
   }
   function CloseFeedbackWindow(a_show)
   {
      this.debug("CloseFeedbackWindow (" + a_show + ")");
      if(this.feedback_window._currentframe > 1 and this.feedback_window._currentframe <= 10)
      {
         if(a_show == true)
         {
            this.debug("Show argument is true, asking client hint visualizers to hide or reset ...");
            this.dispatchFeedbackHideEvent();
         }
         else
         {
            this.debug("Show argument is false, not propagating close event to hint visualizers");
         }
         this.hintsBlocked = true;
         this.dispatchEvent();
         this.feedback_window.gotoAndPlay(11);
      }
      else
      {
         this.debug("Looks like the feedback window is not open.");
      }
   }
   function resetHints()
   {
      this.debug("resetHints ()");
      if(this.ctat_hint_window != null)
      {
         this.debug("Calling reset on hint window ...");
         this.ctat_hint_window.reset();
      }
      this.dispatchFeedbackHideEvent();
   }
   function showHintAudioIcon(bStatus)
   {
      this.hint_window.audioIcon._visible = bStatus;
   }
   function showIncorrectAudioIcon(bStatus)
   {
      this.feedback_window.audioIcon._visible = bStatus;
   }
   function showCorrectAudioIcon(bStatus)
   {
      this.feedback_window.audioIcon._visible = bStatus;
   }
   function stopHintSound()
   {
      this.debug("stopHintSound ()");
      this.hint_window.audioIcon.stopSound();
      if(this.feedback_window.audioIcon.getAudioPlaying() == true)
      {
         this.debug("Shell: stopIncorrectSound  audioIcon.getAudioPlaying = " + this.feedback_window.audioIcon.getAudioPlaying());
         this.feedback_window.audioIcon.stopSound();
      }
   }
   function stopIncorrectSound()
   {
      this.debug("stopIncorrectSound ()");
      this.debug("audioIcon.getAudioPlaying = " + this.feedback_window.audioIcon.getAudioPlaying());
      if(this.feedback_window.audioIcon.getAudioPlaying() == true)
      {
         this.feedback_window.audioIcon.stopSound();
      }
      if(this.hint_window.audioIcon.getAudioPlaying() == true)
      {
         this.debug("Shell: stopHintSound ");
         this.hint_window.audioIcon.stopSound();
      }
   }
   function processAsfunction(functionString)
   {
      this.debug("processAsfunction ()");
      var _loc6_ = functionString.indexOf("asfunction:");
      var _loc4_ = functionString.indexOf(",",_loc6_);
      if((functionString.indexOf("asfunction:playHint") != -1 || functionString.indexOf("asfunction:playCorrect") != -1 || functionString.indexOf("asfunction:playIncorrect") != -1) && functionString.indexOf("mp3",_loc4_) == -1)
      {
         var _loc5_ = "It appears that the message contains instruction to play a audio file but it has a misnamed mp3 audio file, missing the mp3 extension. ";
         _loc5_ = _loc5_ + ("The hint is " + functionString + ". ");
         this.audioExceptionFeedback(_loc5_);
         this.debug("EXCEPTION : " + _loc5_);
         return undefined;
      }
      var _loc7_ = functionString.indexOf("mp3",_loc4_);
      var _loc3_ = functionString.substring(_loc6_ + 11,_loc4_);
      var _loc8_ = functionString.substring(_loc4_ + 1,_loc7_ + 3);
      this.debug("processAsfunction : methodName = " + _loc3_ + " this = " + this + " FeedbackAndHintFormat = " + this.__get__FeedbackAndHintFormat());
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(this.__get__FeedbackAndHintFormat(),"Audio"))
      {
         this.debug("processAsfunction : Audio feedback is supported :  methodName = " + _loc3_ + " this = " + this + " FeedbackAndHintFormat = " + this.__get__FeedbackAndHintFormat());
         if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(_loc3_,"playHint") || edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(_loc3_,"playCorrect") || edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(_loc3_,"playIncorrect"))
         {
            this[_loc3_].call(this,_loc8_);
         }
      }
      return undefined;
   }
   function highlightRadio(basePathOfClip, groupName, widget, highlightValue)
   {
      this.debug("highlightRadio ()");
      var pathOfClip = eval(basePathOfClip);
      for(var p in eval(pathOfClip))
      {
         if(pathOfClip[p] instanceof mx.core.UIObject || pathOfClip[p] instanceof mx.core.UIComponent)
         {
            if(highlightValue == true && pathOfClip[p].getGroupName() == groupName)
            {
               pathOfClip[p].highlight();
            }
            else if(highlightValue == false && pathOfClip[p].getGroupName() == groupName)
            {
               pathOfClip[p].unHighlight();
            }
            if(pathOfClip[p].compositeCommWidget == true)
            {
               this.highlightRadio(pathOfClip[p],groupName,widget,highlightValue);
            }
         }
         else if(typeof pathOfClip[p] == "movieclip")
         {
            this.highlightRadio(pathOfClip[p],groupName,widget,highlightValue);
         }
      }
   }
   function audioExceptionFeedback(sMsg)
   {
      this.debug("audioExceptionFeedback ()");
      var _loc3_ = undefined;
      _loc3_ = sMsg;
      var _loc2_ = false;
      this.Feedback(_loc3_,_loc2_);
      this.debug("EXCEPTION : shell : audioExceptionFeedback : " + sMsg);
   }
   function effectivelyDone(widget)
   {
      this.debug("effectivelyDone ()");
      if(widget == null)
      {
         return true;
      }
      if(widget.commType == "doneButton" || widget.commType == "multiMediaSelection" && widget.treatCheckAsDone == true || widget.commType == "mediaMultipleSelection" && widget.treatCheckAsDone == true || widget.commType == "multipleSelection" && widget.treatCheckAsDone == true || widget.commType == "base" && widget.treatCheckAsDone == true || widget.commType == "jumble" && widget.treatCheckAsDone == true || widget.commType == "CommButton" && widget.treatCheckAsDone == true || widget.treatComponentActionAsDone() == true)
      {
         return true;
      }
      return false;
   }
   function __set__LockCorrectAnswers(theValue)
   {
      this.lockWidget = theValue;
      return this.__get__LockCorrectAnswers();
   }
   function __get__LockCorrectAnswers()
   {
      return this.lockWidget;
   }
   function __set__BRDFileName(theValue)
   {
      this.theBRDFileName = theValue;
      this.invalidate();
      return this.__get__BRDFileName();
   }
   function __get__BRDFileName()
   {
      return this.theBRDFileName;
   }
   function __set__FeedbackAndHintFormat(theValue)
   {
      this._feedbackAndHintFormat = theValue;
      return this.__get__FeedbackAndHintFormat();
   }
   function __get__FeedbackAndHintFormat()
   {
      return this._feedbackAndHintFormat;
   }
   function __set__socketPort(sSocketPort)
   {
      this._socketPort = sSocketPort;
      return this.__get__socketPort();
   }
   function __get__socketPort()
   {
      return this._socketPort;
   }
   function __set__LVMethodForSendDone(theValue)
   {
      this.debug("set LVMethodForSendDone (" + theValue + ")");
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"new") == true || edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theValue,"send"))
      {
         this._SendDoneLVMethod = "send";
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"rep") == true || edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theValue,"sendandload"))
      {
         this._SendDoneLVMethod = "sendandload";
      }
      else
      {
         this._SendDoneLVMethod = "send";
      }
      this.debug(this._SendDoneLVMethod);
      this.debug(this.__get__LVMethodForSendDone());
      return this.__get__LVMethodForSendDone();
   }
   function __get__LVMethodForSendDone()
   {
      return this._SendDoneLVMethod;
   }
   function __set__BehaviorRecorder(userBehaviorRecorder)
   {
      this._BehaviorRecorder = userBehaviorRecorder;
      this.invalidate();
      return this.__get__BehaviorRecorder();
   }
   function __get__BehaviorRecorder()
   {
      return this._BehaviorRecorder;
   }
   function __set__ClientForceQuitTime(theValue)
   {
      this._clientForceQuitTime = theValue;
      return this.__get__ClientForceQuitTime();
   }
   function __get__ClientForceQuitTime()
   {
      return this._clientForceQuitTime;
   }
   function __set__DisableSuccessMsgAfterLastHint(theValue)
   {
      this.debug("Setting _disableSuccessMsgAfterLastHint to: " + theValue);
      this._disableSuccessMsgAfterLastHint = theValue;
      return this.__get__DisableSuccessMsgAfterLastHint();
   }
   function __get__DisableSuccessMsgAfterLastHint()
   {
      return this._disableSuccessMsgAfterLastHint;
   }
}
