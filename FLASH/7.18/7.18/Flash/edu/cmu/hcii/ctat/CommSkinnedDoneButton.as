class edu.cmu.hcii.ctat.CommSkinnedDoneButton extends edu.cmu.hcii.ctat.CTATImageBasedButton
{
   static var symbolName = "CommSkinnedDoneButton";
   static var symbolOwner = edu.cmu.hcii.ctat.CommSkinnedDoneButton;
   var className = "CommSkinnedDoneButton";
   var ParentClassName = "CTATImageBasedButton";
   static var version = "2.10.1";
   var publicVersion = "2.10.1";
   var commType = "doneButton";
   var gradedThePrevComp = false;
   function CommSkinnedDoneButton()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.setText("Done");
      mx.events.EventDispatcher.initialize(this);
      this.startSocketandNewProblem();
      this.setTutorComponent(false);
      this.setAutoGrade(false);
   }
   function updateVisuals()
   {
      this.draw();
   }
   function getCommType()
   {
      return this.commType;
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.debug("isLivePreview: " + this.isLivePreview());
      if(this.isLivePreview() == false)
      {
         this.background._visible = false;
      }
      this.addEventListener("componentOnMouseUp",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processParentClick));
   }
   function draw()
   {
      this.debug("draw ()");
      super.draw();
   }
   function size()
   {
      super.size();
      this.debug("size (" + this.__get__width() + "," + this.__get__height() + ")");
      if(this.isLivePreview() == true)
      {
         this.background._width = this.wFixed;
         this.background._height = this.hFixed;
      }
   }
   function processParentClick()
   {
      this.debug("processParentClick ()");
      this.handleDoneButton();
   }
   function startSocketandNewProblem()
   {
      if(this.isLivePreview() == false && (_global.theShell.BehaviorRecorder == "AuthorTime" || _global.theShell.BehaviorRecorderMode == "AuthorTime"))
      {
         _global.theShell.addEventListener("onSocketConnect",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.actOnSocketConnection));
         _global.theShell.addEventListener("onNewProblem",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.actOnNewProblem));
      }
   }
   function actOnSocketConnection()
   {
   }
   function actOnNewProblem()
   {
      if(this.getSendInterfDescMessages() == true)
      {
         this.sendJessInterfaceDescription();
      }
   }
   function sendJessInterfaceDescription()
   {
      var _loc5_ = "CommDoneButton";
      var _loc3_ = "done";
      var _loc4_ = "comboBox";
      var _loc6_ = this.buildJessInterfaceDescription(_loc3_,_loc5_,_loc4_);
      _global.theShell.sendInterfaceDescription(_loc6_);
   }
   function buildJessInterfaceDescription(componentName, componentType, defTemplateType)
   {
      var _loc1_ = "<message>";
      _loc1_ = _loc1_ + "<verb>SendNoteProperty</verb>";
      _loc1_ = _loc1_ + "<properties>";
      _loc1_ = _loc1_ + "<MessageType>InterfaceDescription</MessageType>";
      _loc1_ = _loc1_ + ("<WidgetType>" + componentType + "</WidgetType>");
      _loc1_ = _loc1_ + (" <DorminName>" + componentName + "</DorminName>");
      _loc1_ = _loc1_ + "<UpdateEachCycle>false</UpdateEachCycle>";
      _loc1_ = _loc1_ + "<jessDeftemplates>";
      _loc1_ = _loc1_ + "<value>(deftemplate button (slot name))</value>";
      _loc1_ = _loc1_ + "</jessDeftemplates>";
      _loc1_ = _loc1_ + "<jessInstances>";
      _loc1_ = _loc1_ + "<value>(assert (button (name done)))</value>";
      _loc1_ = _loc1_ + "</jessInstances>";
      _loc1_ = _loc1_ + "</properties>";
      _loc1_ = _loc1_ + "</message>";
      return _loc1_;
   }
   function handleDoneButton()
   {
      this.debug("handleDoneButton ()");
      if(this.blocked == true)
      {
         this.debug("We\'re blocked, can\'t grade right now");
         return undefined;
      }
      _global.theShell.checkme(this);
   }
   function showCorrect()
   {
      this.debug("showCorrect ()");
      super.showCorrect();
      _global.theShell.setIsDone(true);
   }
   function showIncorrect()
   {
      this.debug("showIncorrect ()");
      super.setIsCorrect(false);
      _global.theShell.setIsDone(false);
   }
   function showNull()
   {
      this.debug("showNull ()");
      super.setIsCorrect(false);
      _global.theShell.setIsDone(false);
   }
   function __set__ShowFeedbackforWidget(theValue)
   {
      this._showFeedbackforWidget = theValue;
      return this.__get__ShowFeedbackforWidget();
   }
   function __get__ShowFeedbackforWidget()
   {
      return this._showFeedbackforWidget;
   }
   function __set__AllowBlocking(theValue)
   {
      this.sgAllowBlocking = theValue;
      return this.__get__AllowBlocking();
   }
   function __get__AllowBlocking()
   {
      return this.sgAllowBlocking;
   }
   function __set__ScreenshotURLNormal(theValue)
   {
      this.available = this.available + 1;
      this.shoturlNormal = theValue;
      return this.__get__ScreenshotURLNormal();
   }
   function __get__ScreenshotURLNormal()
   {
      return this.shoturlNormal;
   }
   function __set__ScreenshotURLClick(theValue)
   {
      this.available = this.available + 1;
      this.shoturlClick = theValue;
      return this.__get__ScreenshotURLClick();
   }
   function __get__ScreenshotURLClick()
   {
      return this.shoturlClick;
   }
   function __set__ScreenshotURLHover(theValue)
   {
      this.available = this.available + 1;
      this.shoturlHover = theValue;
      return this.__get__ScreenshotURLHover();
   }
   function __get__ScreenshotURLHover()
   {
      return this.shoturlHover;
   }
   function __set__ScreenshotURLDisabled(theValue)
   {
      this.available = this.available + 1;
      this.shoturlDisabled = theValue;
      return this.__get__ScreenshotURLDisabled();
   }
   function __set__ScaleToImage(theValue)
   {
      this.sgScaleToImage = theValue;
      return this.__get__ScaleToImage();
   }
   function __get__ScaleToImage()
   {
      return this.sgScaleToImage;
   }
}
