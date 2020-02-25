class edu.cmu.hcii.ctat.CTATCommShellOLI extends edu.cmu.hcii.ctat.CTATCommShellCode
{
   static var symbolName = "CTATCommShellOLI";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATCommShellOLI);
   var className = "CTATCommShellOLI";
   var ParentClassName = "CTATCommShellCode";
   function CTATCommShellOLI()
   {
      super();
   }
   function init()
   {
      super.init();
      this.setClassType("CommShellCodeOLI");
      this.debug("init ()");
      this.debug("Loading ...");
      this.superActivityClient = _level0.superactivity;
      this.debug("superActivityClient is " + this.superActivityClient);
      mx.events.EventDispatcher.initialize(this);
      this.loadSuperActivityClient();
      this.addEventListener("scrimUp",mx.utils.Delegate.create(this,this.listentoScrimUp));
      this.addEventListener("scrimDown",mx.utils.Delegate.create(this,this.listentoScrimDown));
      this.addEventListener("tutorServiceAvailable",mx.utils.Delegate.create(this,this.listentoTutorServiceAvailable));
      this.addEventListener("tutorServiceUnavailable",mx.utils.Delegate.create(this,this.listentoTutorServiceUnavailable));
   }
   function listentoScrimUp()
   {
      this.debug("listentoScrimUp ()");
   }
   function listentoScrimDown()
   {
      this.debug("listentoScrimDown ()");
   }
   function listentoTutorServiceAvailable()
   {
      this.debug("listentoTutorServiceAvailable ()");
   }
   function listentoTutorServiceUnavailable()
   {
      this.debug("listentoTutorServiceUnavailable ()");
   }
   function listentoRestartEvent()
   {
      this.debug("listentoRestartEvent ()");
   }
   function getSuperActivityClass()
   {
      return _level999.SuperActivityClass;
   }
   function loadSuperActivityClient()
   {
      _root.createEmptyMovieClip("SuperActivityClient_mc",999);
      _root.loadMovie(this.superActivityClient,this.SuperActivityClient_mc);
   }
   function onLoadOLIInit(target_mc)
   {
      this.debug("onLoadOLIInit ()");
      this.getSuperActivityClass().loadClientConfig();
   }
   function onLoadOLIError(target_mc)
   {
      this.debug("onLoadOLIError ()");
   }
   function loadClientConfigComplete(result)
   {
      this.debug("loadClientConfigComplete ()");
      this.getSuperActivityClass().beginSession();
   }
   function beginSessionComplete(result)
   {
      this.debug("beginSessionComplete ()");
      if(this.checkValid(result.fileRecords[0].fileName.toString()) == true)
      {
      }
      if(this.checkValid(result.dateActivityStarted.toString()) == true)
      {
      }
      if(this.checkValid(result.dateActivityCompleted.toString()) == true)
      {
      }
      if(this.checkValid(result.dateActivityStarted.toString()) == true)
      {
      }
      if(this.checkValid(result.attempts[0].number.toString()) == true)
      {
         if(this.checkValid(result.attempts[0].dateCompleted.toString()) == true)
         {
         }
         if(this.checkValid(result.attempts[0].scores[0].scoreID.toString()) == true)
         {
         }
      }
   }
   function loadContentFileComplete(result)
   {
      this.debug("loadContentFileComplete ()");
   }
   function startAttemptComplete(result)
   {
      this.debug("startAttemptComplete ()");
   }
   function scoreAttemptComplete(result)
   {
      this.debug("scoreAttemptComplete ()");
   }
   function scoreAttemptInstructorComplete(result)
   {
      this.debug("scoreAttemptInstructorComplete ()");
   }
   function endAttemptComplete(result)
   {
      this.debug("endAttemptComplete ()");
   }
   function loadFileDirectoryComplete(result)
   {
      this.debug("loadFileDirectoryComplete ()");
      if(this.checkValid(result.fileRecords[0].fileName.toString()) == true)
      {
      }
   }
   function loadFileRecordComplete(result)
   {
      this.debug("loadFileRecordComplete ()");
      if(this.checkValid(result.fileRecord.toString()) == true)
      {
      }
   }
   function writeFileRecordComplete(result)
   {
      this.debug("writeFileRecordComplete ()");
   }
   function deleteFileRecordComplete(result)
   {
      this.debug("deleteFileRecordComplete ()");
   }
   function checkValid(theVariable)
   {
      this.debug("checkValid ()");
      if(theVariable == null || theVariable == undefined || theVariable == "" || theVariable.length <= 0)
      {
         return false;
      }
      return true;
   }
}
