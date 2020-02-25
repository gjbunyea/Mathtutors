class edu.cmu.hcii.ctat.CommImageButton extends edu.cmu.hcii.ctat.CTATImageBasedButton
{
   static var symbolName = "CommImageButton";
   static var symbolOwner = edu.cmu.hcii.ctat.CommImageButton;
   var className = "CommImageButton";
   var ParentClassName = "CTATImageBasedButton";
   static var version = "2.10.1";
   var publicVersion = "2.10.1";
   function CommImageButton()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
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
   function __set__callThisMethodonCorrect(sCallThisMethodonCorrect)
   {
      this._callThisMethodonCorrect = sCallThisMethodonCorrect;
      return this.__get__callThisMethodonCorrect();
   }
   function __get__callThisMethodonCorrect()
   {
      return this._callThisMethodonCorrect;
   }
   function __set__callThisMethodonInCorrect(sCallThisMethodonInCorrect)
   {
      this._callThisMethodonInCorrect = sCallThisMethodonInCorrect;
      return this.__get__callThisMethodonInCorrect();
   }
   function __get__callThisMethodonInCorrect()
   {
      return this._callThisMethodonInCorrect;
   }
   function __set__callThisMethodonNull(sCallThisMethodonNull)
   {
      this._callThisMethodonNull = sCallThisMethodonNull;
      return this.__get__callThisMethodonNull();
   }
   function __get__callThisMethodonNull()
   {
      return this._callThisMethodonNull;
   }
   function __set__showHighlight(theValue)
   {
      this._showHighlight = theValue;
      return this.__get__showHighlight();
   }
   function __get__showHighlight()
   {
      return this._showHighlight;
   }
   function __set__treatCheckAsDone(bCheckDone)
   {
      this._checkDone = bCheckDone;
      return this.__get__treatCheckAsDone();
   }
   function __get__treatCheckAsDone()
   {
      return this._checkDone;
   }
   function __set__TutorThisComponent(theValue)
   {
      this.tutorComponent = theValue;
      return this.__get__TutorThisComponent();
   }
   function __get__TutorThisComponent()
   {
      return this.tutorComponent;
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
}
