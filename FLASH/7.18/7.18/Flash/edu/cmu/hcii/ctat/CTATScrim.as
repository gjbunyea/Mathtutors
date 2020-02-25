class edu.cmu.hcii.ctat.CTATScrim extends edu.cmu.hcii.ctat.CTATBase
{
   static var disconnectedText = "The tutor is currently disconnected from the Tutoring Service";
   static var gradingText = "Please wait while the tutor fetches the next problem";
   static var connLoggingText = "Please wait until the tutor is connected to Datashop";
   static var connTSText = "Please wait until the tutor is connected to the tutoring service";
   var className = "CommShellCode";
   var sht = null;
   var tttipShown = false;
   var tltipShown = false;
   var tdtipShown = false;
   var tgtipShown = false;
   var scrimuse = true;
   var scrimavailable = false;
   var tutoravailable = false;
   var tutordisconnected = false;
   var loggeravailable = false;
   var grading = false;
   var uselogging = true;
   var shown = false;
   var adjusted = false;
   var scrimZ = 0;
   var infoshown = false;
   function CTATScrim()
   {
      super();
      this.setClassType("CTATScrim");
      this.debug("CTATScrim ()");
      this.sht = new edu.cmu.hcii.ctat.CTATShellTools();
      mx.events.EventDispatcher.initialize(this);
   }
   function setUseLogging(a_val)
   {
      this.uselogging = a_val;
      if(this.scrimavailable == true)
      {
         this.showLogIcon(false);
      }
   }
   function getScrimAvailable()
   {
      return this.scrimavailable;
   }
   function useScrim(a_val)
   {
      this.debug("useScrim (" + a_val + ")");
      this.scrimuse = a_val;
      if(this.scrimuse == false)
      {
         if(this.scrimavailable == true)
         {
            this.showBaseLayer(false);
            this.showTutorIcon(false);
            this.showLogIcon(false);
            this.showRestartIcon(false);
            this.showGradeIcon(false);
         }
      }
   }
   function createScrim2(a_force)
   {
      _global.background.visible = false;
      _global.theShell.visible = false;
      this.debug("Creating scrim2");
      edu.cmu.hcii.ctat.CTATScrim.scrimcontainer = _root.createEmptyMovieClip(this.createInstanceName(),this.getNextHighestDepth());
      if(edu.cmu.hcii.ctat.CTATScrim.scrimcontainer == undefined)
      {
         this.debug("Error: the scrimcontainer is undefined");
         return false;
      }
      if(edu.cmu.hcii.ctat.CTATScrim.scrimcontainer == null)
      {
         this.debug("Error: the scrimcontainer is null");
         return false;
      }
      this.scrimavailable = true;
      var _loc4_ = new flash.filters.DropShadowFilter();
      _loc4_.blurx = 5;
      _loc4_.blury = 5;
      _loc4_.alpha = 0.45;
      _loc4_.quality = 3;
      _loc4_.angle = 45;
      _loc4_.distance = 5;
      edu.cmu.hcii.ctat.CTATScrim.scrimmer = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.createEmptyMovieClip(this.createInstanceName(),this.getNextHighestDepth());
      edu.cmu.hcii.ctat.CTATScrim.scrimmer.moveTo(0,0);
      edu.cmu.hcii.ctat.CTATScrim.scrimmer.beginFill(16711680);
      edu.cmu.hcii.ctat.CTATScrim.scrimmer.lineTo(Stage.width,0);
      edu.cmu.hcii.ctat.CTATScrim.scrimmer.lineTo(Stage.width,Stage.height);
      edu.cmu.hcii.ctat.CTATScrim.scrimmer.lineTo(0,Stage.height);
      edu.cmu.hcii.ctat.CTATScrim.scrimmer.lineTo(0,0);
      edu.cmu.hcii.ctat.CTATScrim.scrimmer.endFill();
      edu.cmu.hcii.ctat.CTATScrim.scrimmer._alpha = 30;
      this.tttip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.createEmptyMovieClip(this.createInstanceName(),this.getNextHighestDepth());
      this.tttip._visible = true;
      this.tltip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.createEmptyMovieClip(this.createInstanceName(),this.getNextHighestDepth());
      this.tltip._visible = true;
      this.tdtip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.createEmptyMovieClip(this.createInstanceName(),this.getNextHighestDepth());
      this.tdtip._visible = true;
      this.tgtip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.createEmptyMovieClip(this.createInstanceName(),this.getNextHighestDepth());
      this.tgtip._visible = true;
      var _loc10_ = Stage.width;
      var _loc9_ = Stage.height;
      var _loc11_ = 5;
      var _loc8_ = 8;
      var _loc7_ = _loc9_ / _loc8_;
      var _loc6_ = _loc10_ / _loc11_;
      this.debug("w = " + _loc10_ + " h = " + _loc9_ + " hSeg = " + _loc7_ + " wSeg = " + _loc6_);
      this.tutorServiceToolTip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.createTextField("tutorServiceToolTip",this.getNextHighestDepth(),0,0,0,0);
      this.loggingToolTip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.createTextField("loggingToolTip",this.getNextHighestDepth(),0,0,0,0);
      this.loggingToolTip._width = this.tutorServiceToolTip._width = _loc6_;
      this.loggingToolTip._height = this.tutorServiceToolTip._height = _loc7_;
      this.loggingToolTip._y = this.tutorServiceToolTip._y = _loc7_ * (_loc8_ / 2 - 1);
      this.loggingToolTip._x = 3 * _loc6_;
      this.tutorServiceToolTip._x = 1 * _loc6_;
      this.loggingToolTip.border = true;
      this.tutorServiceToolTip.border = true;
      this.debug("logging tool tip vars" + this.loggingToolTip._width + " " + this.loggingToolTip._height + " " + this.loggingToolTip._y + " " + this.loggingToolTip._x);
      this.tutorServiceToolTip.text = "Should be set by event...internal error";
      this.loggingToolTip.text = edu.cmu.hcii.ctat.CTATScrim.connLoggingText;
      this.tutorServiceToolTip.wordWrap = this.loggingToolTip.wordWrap = true;
      this.loggingToolTip.backgroundColor = this.tutorServiceToolTip.backgroundColor = 16777215;
      this.loggingToolTip._alpha = this.tutorServiceToolTip._alpha = 60;
      this.loggingToolTip.background = this.tutorServiceToolTip.background = true;
      var _loc5_ = this.tutorServiceToolTip.filters;
      _loc5_.push(_loc4_);
      this.tutorServiceToolTip.filters = _loc5_;
      _loc5_ = this.loggingToolTip.filters;
      _loc5_.push(_loc4_);
      this.loggingToolTip.filters = _loc5_;
      _loc5_ = edu.cmu.hcii.ctat.CTATScrim.scrimmer.filters;
      _loc5_.push(_loc4_);
      edu.cmu.hcii.ctat.CTATScrim.scrimmer.filters = _loc5_;
      this.tutorServiceToolTip._visible = true;
      this.loggingToolTip._visible = true;
      edu.cmu.hcii.ctat.CTATScrim.scrimmer._visible = false;
      return true;
   }
   function createScrim(a_force)
   {
      this.debug("createScrim ()");
      if(this.scrimuse == false)
      {
         this.debug("A developer has indicated we do not need a scrim, aborting");
         return false;
      }
      if(this.scrimavailable == true)
      {
         this.debug("Scrim already created");
         return false;
      }
      if(a_force == false)
      {
         if(this.isLivePreview() == undefined)
         {
            this.debug("No live preview status available yet, aborting creation ...");
            return false;
         }
         if(this.isLivePreview() == true)
         {
            this.debug("Commshell is operating in live preview mode");
            return false;
         }
         this.debug("Commshell is operating in full player mode, creating scrim objects ...");
      }
      if(_global.theShell.reducedMode == "true")
      {
         this.createScrim2();
         return true;
      }
      this.debug("Creating scrim objects ...");
      this.debugNextHighestDepth();
      edu.cmu.hcii.ctat.CTATScrim.scrimcontainer = _root.createEmptyMovieClip(this.createInstanceName(),this.getNextHighestDepth());
      if(edu.cmu.hcii.ctat.CTATScrim.scrimcontainer == undefined)
      {
         this.debug("Error: the scrimcontainer is undefined");
         return false;
      }
      if(edu.cmu.hcii.ctat.CTATScrim.scrimcontainer == null)
      {
         this.debug("Error: the scrimcontainer is null");
         return false;
      }
      edu.cmu.hcii.ctat.CTATScrim.scrimmer = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.attachMovie("DisableOverlay",this.createInstanceName(),this.getNextHighestDepth());
      if(edu.cmu.hcii.ctat.CTATScrim.scrimmer == undefined)
      {
         this.debug("Error: the scrim is undefined");
         return false;
      }
      if(edu.cmu.hcii.ctat.CTATScrim.scrimmer == null)
      {
         this.debug("Error: the scrim is null");
         return false;
      }
      this.debug("Create the status tooltips ...");
      this.tttip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.attachMovie("TutorServiceTooltip",this.createInstanceName(),this.getNextHighestDepth());
      this.tltip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.attachMovie("LoggerTooltip",this.createInstanceName(),this.getNextHighestDepth());
      this.tdtip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.attachMovie("DisconnectedTooltip",this.createInstanceName(),this.getNextHighestDepth());
      this.tgtip = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.attachMovie("GradingTooltip",this.createInstanceName(),this.getNextHighestDepth());
      if(this.tttip == undefined)
      {
         this.debug("Error: the tutoring service tooltip is undefined");
      }
      if(this.tttip == null)
      {
         this.debug("Error: the tutoring service tooltip is null");
      }
      if(this.tltip == undefined)
      {
         this.debug("Error: the logging service tooltip is undefined");
      }
      if(this.tltip == null)
      {
         this.debug("Error: the logging service tooltip is null");
      }
      if(this.tdtip == undefined)
      {
         this.debug("Error: the disconnected service tooltip is undefined");
      }
      if(this.tdtip == null)
      {
         this.debug("Error: the disconnected service tooltip is null");
      }
      if(this.tgtip == undefined)
      {
         this.debug("Error: the grading tooltip is undefined");
      }
      if(this.tgtip == null)
      {
         this.debug("Error: the grading tooltip is null");
      }
      var _loc5_ = new flash.filters.DropShadowFilter();
      _loc5_.blurx = 5;
      _loc5_.blury = 5;
      _loc5_.alpha = 0.45;
      _loc5_.quality = 3;
      _loc5_.angle = 45;
      _loc5_.distance = 5;
      var _loc4_ = this.tttip.filters;
      _loc4_.push(_loc5_);
      this.tttip.filters = _loc4_;
      _loc4_ = this.tltip.filters;
      _loc4_.push(_loc5_);
      this.tltip.filters = _loc4_;
      _loc4_ = this.tdtip.filters;
      _loc4_.push(_loc5_);
      this.tdtip.filters = _loc4_;
      _loc4_ = this.tgtip.filters;
      _loc4_.push(_loc5_);
      this.tgtip.filters = _loc4_;
      this.debug("Create the restart widgets ...");
      this.restart = edu.cmu.hcii.ctat.CTATScrim.scrimcontainer.attachMovie("Button",this.createInstanceName(),this.getNextHighestDepth(),{_x:0,_y:0});
      if(this.restart == null)
      {
         this.debug("Error: unable to create restart button instance");
      }
      else
      {
         this.debug("Info: we have a restart button!");
         this.restart.label = "Restart Tutor";
         this.restart.onPress = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processReset);
      }
      this.placeBaseLayer();
      this.placeGradeIcon();
      this.placeTutorIcon();
      this.placeTutorDisconnectedIcon();
      this.placeLogIcon();
      this.placeRestartIcon();
      edu.cmu.hcii.ctat.CTATScrim.scrimmer._visible = false;
      this.tttip._visible = false;
      this.tltip._visible = false;
      this.tdtip._visible = false;
      this.tgtip._visible = false;
      this.restart._visible = false;
      this.scrimavailable = true;
      return true;
   }
   function showScrim(a_show)
   {
      this.debug("showScrim (" + a_show + ")");
      if(this.scrimuse == false)
      {
         this.debug("A developer has indicated we do not need a scrim, aborting");
         return undefined;
      }
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      this.debug("Actually updating scrim ...");
      if(a_show == true)
      {
         this.showBaseLayer(true);
         this.showTutorIcon(true);
         this.showLogIcon(true);
      }
      else
      {
         this.showBaseLayer(false);
         this.showTutorIcon(false);
         this.showLogIcon(false);
      }
   }
   function showRestart(a_show)
   {
      this.debug("showRestart (" + a_show + ")");
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      if(a_show == true)
      {
         if(this.scrimuse == false)
         {
            this.debug("A developer has indicated we do not need a scrim, aborting");
            return undefined;
         }
         if(this.shown == true)
         {
            return undefined;
         }
         this.showBaseLayer(true);
         this.debug("Updating restart button ... ");
         this.restart._visible = true;
         this.restart.swapDepths(this.getNextHighestDepth());
         this.shown = true;
      }
      else
      {
         if(this.shown == false)
         {
            return undefined;
         }
         this.restart._visible = false;
         this.showBaseLayer(false);
         this.shown = false;
      }
   }
   function placeBaseLayer()
   {
      var _loc2_ = Stage.width;
      var _loc1_ = Stage.height;
      edu.cmu.hcii.ctat.CTATScrim.scrimmer._x = 0;
      edu.cmu.hcii.ctat.CTATScrim.scrimmer._y = 0;
      edu.cmu.hcii.ctat.CTATScrim.scrimmer._width = _loc2_;
      edu.cmu.hcii.ctat.CTATScrim.scrimmer._height = _loc1_;
   }
   function showBaseLayer(a_show, a_blocked)
   {
      this.debug("showBaseLayer (" + a_show + ")");
      var _loc2_ = false;
      if(a_blocked != undefined)
      {
         if(a_blocked != null)
         {
            _loc2_ = a_blocked;
         }
      }
      this.debug("Using blocked: " + _loc2_);
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      this.debug("Actually updating base layer ...");
      if(a_show == true)
      {
         this.debug("Making base layer visible ...");
         if(this.shown == true)
         {
            this.debug("Base layer already shown, aborting ...");
            return undefined;
         }
         if(this.scrimuse == false)
         {
            this.debug("A developer has indicated we do not need a scrim, aborting");
            return undefined;
         }
         this.sht.disableDisplayList(_loc2_);
         this.scrimZ = this.getNextHighestDepth();
         edu.cmu.hcii.ctat.CTATScrim.scrimmer._visible = true;
         edu.cmu.hcii.ctat.CTATScrim.scrimmer.swapDepths(this.scrimZ);
         this.shown = true;
         this.dispatchEvent({target:this,type:"signalScrimDown"});
      }
      else
      {
         this.debug("Hiding base layer ...");
         if(this.shown == false)
         {
            this.debug("Base layer already hidden, aborting ...");
            return undefined;
         }
         if(this.infoshown == true)
         {
            this.debug("Something triggered a fatal message to be displayed, keeping the scrim up");
            return undefined;
         }
         this.sht.enableDisplayList(_loc2_);
         edu.cmu.hcii.ctat.CTATScrim.scrimmer._visible = false;
         this.shown = false;
         this.dispatchEvent({target:this,type:"signalScrimUp"});
      }
   }
   function placeGradeIcon()
   {
      var _loc4_ = _root._width / 2;
      var _loc3_ = _root._height / 2;
      this.tgtip._x = _loc4_ - this.tgtip._width / 2;
      this.tgtip._y = _loc3_ - this.tgtip._height / 2;
   }
   function showGradeIcon(a_show)
   {
      this.debug("showGradeIcon (" + a_show + ")");
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      if(a_show == true)
      {
         if(this.scrimuse == false)
         {
            this.debug("A developer has indicated we do not need a scrim, aborting");
            return undefined;
         }
         if(this.tgtipShown == true)
         {
            this.debug("Icon already visible, aborting ...");
            return undefined;
         }
         this.tgtip._visible = true;
         this.tgtip.swapDepths(this.getNextHighestDepth());
         this.tutorServiceToolTip.text = edu.cmu.hcii.ctat.CTATScrim.gradingText;
         this.tutorServiceToolTip._visible = true;
         this.tgtipShown = true;
      }
      else
      {
         this.tutorServiceToolTip._visible = false;
         this.tgtip._visible = false;
         this.tgtipShown = false;
      }
   }
   function placeTutorIcon()
   {
      var _loc5_ = _root._width / 3;
      var _loc4_ = _root._height / 2;
      var _loc3_ = this.tttip._width;
      var _loc6_ = this.tttip._height;
      this.tttip._x = _loc5_ - _loc3_ / 2;
      this.tttip._y = _loc4_ - _loc3_ / 2;
   }
   function placeTutorDisconnectedIcon()
   {
      var _loc5_ = _root._width / 2;
      var _loc4_ = _root._height / 2;
      var _loc3_ = this.tdtip._width;
      var _loc6_ = this.tdtip._height;
      this.tdtip._x = _loc5_ - _loc3_ / 2;
      this.tdtip._y = _loc4_ - _loc3_ / 2;
   }
   function showTutorIcon(a_show)
   {
      this.debug("showTutorIcon (" + a_show + ")");
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      if(a_show == true)
      {
         if(this.scrimuse == false)
         {
            this.debug("A developer has indicated we do not need a scrim, aborting");
            return undefined;
         }
         if(this.tdtipShown == true || this.tttipShown == true)
         {
            this.debug("Icon already visible, aborting ...");
            return undefined;
         }
         if(this.tutordisconnected == true)
         {
            this.debug("Showing disconnected tutor icon ...");
            this.tdtip._visible = true;
            this.tdtip.swapDepths(this.getNextHighestDepth());
            this.tutorServiceToolTip.text = edu.cmu.hcii.ctat.CTATScrim.disconnectedText;
            this.tutorServiceToolTip._visible = true;
            this.tdtipShown = true;
         }
         else
         {
            this.debug("Showing regular tutor icon ...");
            this.tutorServiceToolTip.text = edu.cmu.hcii.ctat.CTATScrim.connTSText;
            this.tutorServiceToolTip._visible = true;
            this.tttip._visible = true;
            this.tttip.swapDepths(this.getNextHighestDepth());
            this.tttipShown = true;
         }
      }
      else
      {
         this.debug("Hiding all tutoring icons ...");
         this.tttip._visible = false;
         this.tdtip._visible = false;
         this.tutorServiceToolTip._visible = false;
         this.loggingToolTip._visible = false;
         this.tdtipShown = false;
         this.tttipShown = false;
      }
   }
   function placeLogIcon()
   {
      var _loc5_ = _root._width / 3;
      var _loc4_ = _root._height / 2;
      var _loc3_ = this.tltip._width;
      var _loc6_ = this.tltip._height;
      this.tltip._x = _loc5_ * 2 - _loc3_ / 2;
      this.tltip._y = _loc4_ - _loc3_ / 2;
   }
   function showLogIcon(a_show)
   {
      this.debug("showLogIcon (" + a_show + ")");
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      if(a_show == true)
      {
         if(this.scrimuse == false)
         {
            this.debug("A developer has indicated we do not need a scrim, aborting");
            return undefined;
         }
         if(this.tltipShown == true)
         {
            this.debug("Icon already visible, aborting ...");
            return undefined;
         }
         this.loggingToolTip._visible = true;
         this.tltip._visible = true;
         this.tltip.swapDepths(this.getNextHighestDepth());
         this.tltipShown = true;
      }
      else
      {
         this.loggingToolTip._visible = true;
         this.tltip._visible = false;
         this.tltipShown = false;
      }
   }
   function placeRestartIcon()
   {
      var _loc4_ = _root._width / 2;
      var _loc3_ = _root._height / 2;
      var _loc5_ = this.restart._width;
      var _loc6_ = this.restart._height;
      this.restart._x = _loc4_ - this.restart._width / 2;
      this.restart._y = _loc3_ - this.restart._height / 2;
   }
   function showRestartIcon(a_show)
   {
      this.debug("showRestartIcon (" + a_show + ")");
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      if(a_show == true)
      {
         if(this.scrimuse == false)
         {
            this.debug("A developer has indicated we do not need a scrim, aborting");
            return undefined;
         }
         this.restart._visible = true;
         this.restart.swapDepths(this.getNextHighestDepth());
      }
      else
      {
         this.restart._visible = false;
      }
   }
   function setLogging(a_val)
   {
      this.debug("setLogging (" + a_val + ")");
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      this.loggeravailable = a_val;
      this.updateScrim();
   }
   function getLogging()
   {
      return this.loggeravailable;
   }
   function setGrading(a_val)
   {
      this.debug("setGrading (" + a_val + ")");
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      if(this.grading == a_val)
      {
         this.debug("Nothing to do, we weren\'t grading anyway");
         return undefined;
      }
      this.grading = a_val;
      if(this.scrimuse == false)
      {
         this.debug("A developer has indicated we do not need a scrim, aborting");
         return undefined;
      }
      if(this.grading == true)
      {
         this.debug("Showing grading icon ...");
         this.showBaseLayer(true,true);
         this.showGradeIcon(true);
      }
      else
      {
         this.debug("Hiding grading icon ...");
         this.showBaseLayer(false);
         this.showGradeIcon(false);
      }
   }
   function getGrading()
   {
      return this.grading;
   }
   function setTutorService(a_val, a_force)
   {
      this.debug("setTutorService (" + a_val + ")");
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      if(this.scrimuse == false)
      {
         this.debug("A developer has indicated we do not need a scrim, aborting");
         return undefined;
      }
      this.tutoravailable = a_val;
      this.tutordisconnected = a_force;
      this.updateScrim();
   }
   function getTutorService()
   {
      return this.tutoravailable;
   }
   function updateScrim()
   {
      this.debug("updateScrim ()");
      if(this.scrimavailable == false)
      {
         this.debug("No scrim object available yet, aborting ...");
         return undefined;
      }
      if(this.scrimuse == false)
      {
         this.debug("A developer has indicated we do not need a scrim, aborting");
         return undefined;
      }
      if(this.uselogging == true)
      {
         this.debug("uselogging==true");
         if(this.tutoravailable == false || this.loggeravailable == false)
         {
            this.debug("(tutoravailable==false) || (loggeravailable==false)");
            this.showBaseLayer(true);
         }
         else
         {
            this.debug("NOT: (tutoravailable==false) || (loggeravailable==false)");
            this.showBaseLayer(false);
         }
      }
      else
      {
         this.debug("uselogging==false");
         if(this.tutoravailable == false)
         {
            this.showBaseLayer(true);
         }
         else
         {
            this.showBaseLayer(false);
         }
      }
      if(this.tutoravailable == true)
      {
         this.showTutorIcon(false);
      }
      else
      {
         this.showTutorIcon(true);
      }
      if(this.loggeravailable == true)
      {
         this.showLogIcon(false);
      }
      else
      {
         this.showLogIcon(true);
      }
   }
   function processReset()
   {
      this.debug("processReset ()");
      this.dispatchEvent({target:this,type:"restart"});
   }
   function tutorAvailable()
   {
      this.debug("tutorAvailable ()");
      this.dispatchEvent({target:this,type:"tutorAvailable"});
   }
   function tutorUnavailable()
   {
      this.debug("tutorUnavailable ()");
      this.dispatchEvent({target:this,type:"tutorUnavailable"});
   }
   function centerIcon(a_clip)
   {
      var _loc4_ = _root._width / 2;
      var _loc3_ = _root._height / 2;
      a_clip._x = _loc4_ - a_clip._width / 2;
      a_clip._y = _loc3_ - a_clip._height / 2;
   }
   function debugState()
   {
      this.debug("debugState ()");
      this.debug("scrimmer._visible: " + edu.cmu.hcii.ctat.CTATScrim.scrimmer._visible);
      this.debug("tttip._visible: " + this.tttip._visible);
      this.debug("tltip._visible: " + this.tltip._visible);
      this.debug("tdtip._visible: " + this.tdtip._visible);
      this.debug("tgtip._visible: " + this.tgtip._visible);
   }
   function confirmDone()
   {
      this.debug("confirmDone ()");
      this.infoshown = false;
      this.showBaseLayer(false);
      this.sht.enableDoneButton();
      this.infoshown = false;
   }
}
