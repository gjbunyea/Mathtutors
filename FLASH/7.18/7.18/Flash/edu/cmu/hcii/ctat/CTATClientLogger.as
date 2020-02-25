class edu.cmu.hcii.ctat.CTATClientLogger extends edu.cmu.hcii.ctat.CTATBase
{
   function CTATClientLogger()
   {
      super();
      this.setClassType("CTATClientLogger");
      this.debug("CTATClientLogger () logging level set to : " + _root.session_log);
      this.doneBtnTime = "";
   }
   function doneButtonTimeStamp()
   {
      if(_root.session_log == "on" || _root.session_log == "verbose")
      {
         this.doneBtnTime = edu.cmu.hcii.ctat.CTATPerformanceMetrics.getPaddedTime();
         this.debug("DoneButtonStamped time = " + this.doneBtnTime);
      }
   }
   function logTimeVerbose(logLabel)
   {
      this.debug("LogTime verbose" + logLabel);
      if(_global.theShell.BehaviorRecorder == "AuthorTimeTutoring")
      {
         this.debug("We\'re in author time mode and connected to the BR, not logging events");
         return undefined;
      }
      if(_root.session_log == "verbose")
      {
         flash.external.ExternalInterface.call("logTimeFromFlash(\'" + logLabel + "\')");
      }
   }
   function logTime(logLabel)
   {
      this.debug("LogTime " + logLabel);
      if(_global.theShell.BehaviorRecorder == "AuthorTimeTutoring")
      {
         this.debug("We\'re in author time mode and connected to the BR, not logging events");
         return undefined;
      }
      if(_root.session_log == "on" || _root.session_log == "verbose")
      {
         flash.external.ExternalInterface.call("logTimeFromFlash(\'" + logLabel + "\')");
      }
   }
   function logProblemComplete()
   {
      var _loc4_ = edu.cmu.hcii.ctat.CTATPerformanceMetrics.getPaddedTime();
      this.debug("LogTime ProblemComplete " + this.doneBtnTime + " vs " + _loc4_);
      if(_global.theShell.BehaviorRecorder == "AuthorTimeTutoring")
      {
         this.debug("We\'re in author time mode and connected to the BR, not logging events");
         return undefined;
      }
      if(_root.session_log == "on" || _root.session_log == "verbose")
      {
         flash.external.ExternalInterface.call("logGivenTimeFromFlash(\'ProblemComplete:" + _loc4_ + "\',\'" + this.doneBtnTime + "\')");
      }
   }
   function setupEventListeners()
   {
      if(_global.theShell.BehaviorRecorder == "AuthorTimeTutoring")
      {
         this.debug("We\'re in author time mode and connected to the BR, not logging events");
         return undefined;
      }
      if(_root.session_log == "on" || _root.session_log == "verbose")
      {
         _global.theShell.addEventListener("onStartStateEndEvent",mx.utils.Delegate.create(this,this.logStartStateEnd));
         _global.theShell.addEventListener("restart",mx.utils.Delegate.create(this,this.logRestartEvent));
         _global.theShell.addEventListener("tutorServiceAvailable",mx.utils.Delegate.create(this,this.logTutorServiceAvailable));
         _global.theShell.addEventListener("tutorServiceUnavailable",mx.utils.Delegate.create(this,this.logTutorServiceUnavailable));
         _global.theShell.addEventListener("processSummaryPing",mx.utils.Delegate.create(this,this.logProcessSummaryPingEvent));
      }
      if(_root.session_log == "verbose")
      {
      }
   }
   function logProcessSummaryPingEvent()
   {
      this.debug("logProcessSummaryPingEvent()");
      this.logTime("ProblemSummaryPing");
   }
   function logRestartEvent()
   {
      this.debug("logRestartEvent ()");
      this.logTime("RestartEvent");
   }
   function logTutorServiceAvailable()
   {
      this.debug("logTutorServiceAvailable ()");
      this.logTime("TutorServiceAvailable");
   }
   function logTutorServiceUnavailable()
   {
      this.debug("logTutorServiceUnavailable ()");
      this.logTime("TutorServiceUnavailable");
   }
   function logStartStateEnd()
   {
      this.debug("logStartStateEnd ()");
      this.logTime("StartStateEnd");
   }
}
