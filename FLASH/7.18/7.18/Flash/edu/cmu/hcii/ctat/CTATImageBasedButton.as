class edu.cmu.hcii.ctat.CTATImageBasedButton extends edu.cmu.hcii.ctat.CTATAutomatedTesting
{
   static var symbolName = "CTATImageBasedButton";
   static var symbolOwner = edu.cmu.hcii.ctat.CTATImageBasedButton;
   var className = "CTATImageBasedButton";
   var ParentClassName = "CTATAutomatedTesting";
   function CTATImageBasedButton()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.setText("Button");
      if(this.isLivePreview() == true)
      {
         this.setDrawBase(false);
         this.setUseLabel(false);
      }
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.debug("isLivePreview: " + this.isLivePreview());
      this.addEventListener("imageLoaded",com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.configureBackupVisuals));
   }
   function configureBackupVisuals()
   {
      this.debug("configureBackupVisuals ()");
      this.setDrawBase(false);
      this.setUseLabel(false);
      this.draw();
   }
   function draw()
   {
      super.draw();
   }
   function size()
   {
      super.size();
      this.debug("size (" + this.__get__width() + "," + this.__get__height() + ")");
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
   function __get__ScreenshotURLDisabled()
   {
      return this.shoturlDisabled;
   }
   function __set__ScreenshotType(theValue)
   {
      this.available = this.available + 1;
      this.shottype = theValue;
      return this.__get__ScreenshotType();
   }
   function __get__ScreenshotType()
   {
      return this.shottype;
   }
   function __set__ScreenshotSymbolNormal(theValue)
   {
      this.available = this.available + 1;
      this.shotsymbolNormal = theValue;
      return this.__get__ScreenshotSymbolNormal();
   }
   function __get__ScreenshotSymbolNormal()
   {
      return this.shotsymbolNormal;
   }
   function __set__ScreenshotSymbolClick(theValue)
   {
      this.available = this.available + 1;
      this.shotsymbolClick = theValue;
      return this.__get__ScreenshotSymbolClick();
   }
   function __get__ScreenshotSymbolClick()
   {
      return this.shotsymbolClick;
   }
   function __set__ScreenshotSymbolHover(theValue)
   {
      this.available = this.available + 1;
      this.shotsymbolHover = theValue;
      return this.__get__ScreenshotSymbolHover();
   }
   function __get__ScreenshotSymbolHover()
   {
      return this.shotsymbolHover;
   }
   function __set__ScreenshotSymbolDisabled(theValue)
   {
      this.available = this.available + 1;
      this.shotsymbolDisabled = theValue;
      return this.__get__ScreenshotSymbolDisabled();
   }
   function __get__ScreenshotSymbolDisabled()
   {
      return this.shotsymbolDisabled;
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
