class edu.cmu.hcii.ctat.CTATImageBasedComponent extends edu.cmu.hcii.ctat.CTATWindowingComponent
{
   static var symbolName = "CTATImageBasedComponent";
   static var symbolOwner = edu.cmu.hcii.ctat.CTATImageBasedComponent;
   var className = "CTATImageBasedComponent";
   var ParentClassName = "CTATWindowingComponent";
   var shoturlNormal = "";
   var shoturlClick = "";
   var shoturlHover = "";
   var shoturlDisabled = "";
   var shottype = "UNDEFINED";
   var bitmapDataNormal = null;
   var listenerNormal = null;
   var mcNormal = null;
   var mclNormal = null;
   var bitmapDataClick = null;
   var listenerClick = null;
   var mcClick = null;
   var mclClick = null;
   var bitmapDataHover = null;
   var listenerHover = null;
   var mcHover = null;
   var mclHover = null;
   var bitmapDataDisabled = null;
   var listenerDisabled = null;
   var mcDisabled = null;
   var mclDisabled = null;
   var drawImage = true;
   var loaded = false;
   var available = 0;
   var fullImageSet = true;
   var sgScaleToImage = false;
   function CTATImageBasedComponent()
   {
      super();
   }
   function setDrawImage(a_val)
   {
      this.debug("setDrawImage (" + a_val + ")");
      this.drawImage = a_val;
   }
   function getDrawImage()
   {
      return this.drawImage;
   }
   function setFullImageSet(a_val)
   {
      this.debug("setFullImageSet (" + a_val + ")");
      this.fullImageSet = a_val;
   }
   function getFullImageSet()
   {
      return this.fullImageSet;
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.available = 0;
      mx.events.EventDispatcher.initialize(this);
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.processShotType();
   }
   function draw()
   {
      super.draw();
      if(this.wFixed == 0 || this.hFixed == 0)
      {
         this.debug("No valid size info yet, aborting");
         return undefined;
      }
   }
   function size()
   {
      super.size();
      if(this.wFixed == 0 || this.hFixed == 0)
      {
         this.debug("No valid size info yet, aborting");
         return undefined;
      }
      if(this.isLivePreview() == false)
      {
         if(this.sgScaleToImage == false)
         {
            if(this._screenshotNormal != null)
            {
               this._screenshotNormal._width = this.wFixed;
               this._screenshotNormal._height = this.hFixed;
            }
            if(this._screenshotClick != null)
            {
               this._screenshotClick._width = this.wFixed;
               this._screenshotClick._height = this.hFixed;
            }
            if(this._screenshotHover != null)
            {
               this._screenshotHover._width = this.wFixed;
               this._screenshotHover._height = this.hFixed;
            }
            if(this._screenshotDisabled != null)
            {
               this._screenshotDisabled._width = this.wFixed;
               this._screenshotDisabled._height = this.hFixed;
            }
         }
      }
   }
   function loadScreenshots()
   {
      this.debug("loadScreenshots ()");
      this.debug("Loading " + this.shoturlNormal);
      var _loc3_ = new edu.cmu.hcii.ctat.CTATUtil();
      if(this.shoturlNormal == "")
      {
         this.debug("Image URL is not valid, aborting loading");
         return undefined;
      }
      if(_loc3_.isMassProductionVariable(this.shoturlNormal) == true)
      {
         this.debug("The url to be loaded is a mass production variable");
         return undefined;
      }
      if(this.loaded == true)
      {
         this.debug("The set is already loaded, aborting ...");
         return undefined;
      }
      if(this.target == null)
      {
         this.debug("Internal error: no target clip available as parent");
         return undefined;
      }
      var _loc2_ = _loc3_.createAbsoluteURL(this.shoturlNormal);
      this.debug("Loading using the url: " + _loc2_);
      this._screenshotNormal = this.target.createEmptyMovieClip("screenshotNormal",this.getNextHighestDepth());
      this.listenerNormal = new Object();
      this.mclNormal = new MovieClipLoader();
      this.mclNormal.addListener(this.listenerNormal);
      this.listenerNormal.onLoadInit = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.bitmapLoadedNormal);
      this.mclNormal.loadClip(_loc2_,this._screenshotNormal);
      this.loaded = true;
      this.debug("loadScreenshots () fired");
   }
   function bitmapLoadedNormal(mc)
   {
      this.debug("bitmapLoadedNormal (" + mc._width + "," + mc._height + ")");
      this.dispatchEvent({target:this,type:"imageLoaded"});
      this.size();
      this.updateState();
      if(this.fullImageSet == false)
      {
         this.debug("The component is configured for single image use, aborting ...");
         return undefined;
      }
      this.debug("Loading " + this.shoturlClick);
      var _loc3_ = new edu.cmu.hcii.ctat.CTATUtil();
      var _loc2_ = _loc3_.createAbsoluteURL(this.shoturlClick);
      this.debug("Loading using the url: " + _loc2_);
      this._screenshotClick = this.target.createEmptyMovieClip("screenshotClick",this.getNextHighestDepth());
      this.listenerClick = new Object();
      this.mclClick = new MovieClipLoader();
      this.mclClick.addListener(this.listenerClick);
      this.listenerClick.onLoadInit = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.bitmapLoadedClick);
      this.mclClick.loadClip(_loc2_,this._screenshotClick);
   }
   function bitmapLoadedClick(mc)
   {
      this.debug("bitmapLoadedClick (" + mc._width + "," + mc._height + ")");
      mc._visible = false;
      this.dispatchEvent({target:this,type:"imageLoaded"});
      this.size();
      this.updateState();
      this.debug("Loading " + this.shoturlHover);
      var _loc4_ = new edu.cmu.hcii.ctat.CTATUtil();
      var _loc2_ = _loc4_.createAbsoluteURL(this.shoturlHover);
      this.debug("Loading using the url: " + _loc2_);
      this._screenshotHover = this.target.createEmptyMovieClip("screenshotHover",this.getNextHighestDepth());
      this.listenerHover = new Object();
      this.mclHover = new MovieClipLoader();
      this.mclHover.addListener(this.listenerHover);
      this.listenerHover.onLoadInit = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.bitmapLoadedHover);
      this.mclHover.loadClip(_loc2_,this._screenshotHover);
   }
   function bitmapLoadedHover(mc)
   {
      this.debug("bitmapLoadedHover (" + mc._width + "," + mc._height + ")");
      mc._visible = false;
      this.dispatchEvent({target:this,type:"imageLoaded"});
      this.size();
      this.updateState();
      this.debug("Loading " + this.shoturlDisabled);
      var _loc4_ = new edu.cmu.hcii.ctat.CTATUtil();
      var _loc2_ = _loc4_.createAbsoluteURL(this.shoturlDisabled);
      this.debug("Loading using the url: " + _loc2_);
      this._screenshotDisabled = this.target.createEmptyMovieClip("screenshotDisabled",this.getNextHighestDepth());
      this.listenerDisabled = new Object();
      this.mclDisabled = new MovieClipLoader();
      this.mclDisabled.addListener(this.listenerDisabled);
      this.listenerDisabled.onLoadInit = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.bitmapLoadedDisabled);
      this.mclDisabled.loadClip(_loc2_,this._screenshotDisabled);
   }
   function bitmapLoadedDisabled(mc)
   {
      this.debug("bitmapLoadedDisabled (" + mc._width + "," + mc._height + ")");
      mc._visible = false;
      this.size();
      this._screenshotNormal._visible = false;
      this._screenshotHover._visible = false;
      this._screenshotClick._visible = false;
      if(this._screenshotDisabled != null)
      {
         this._screenshotDisabled._visible = true;
      }
      this.updateState();
   }
   function loadSymbols()
   {
      this.debug("loadSymbols ()");
      var _loc2_ = 1024;
      this.setDrawBase(false);
      this._screenshotNormal = this.target.attachMovie(this.shotsymbolNormal,this.createInstanceName(),this.getNextHighestDepth());
      if(this._screenshotNormal == null || this._screenshotNormal == undefined)
      {
         this.debug("Error loading default symbol: " + this.shotsymbolNormal);
      }
      else
      {
         this.debug("We have a default symbol");
      }
      this._screenshotClick = this.target.attachMovie(this.shotsymbolClick,this.createInstanceName(),this.getNextHighestDepth());
      if(this.fullImageSet == false)
      {
         this.debug("The component is configured for single image use, aborting ...");
         return undefined;
      }
      if(this._screenshotClick == null || this._screenshotClick == undefined)
      {
         this.debug("Error loading clicked symbol: " + this.shotsymbolClick);
      }
      else
      {
         this.debug("We have a clicked symbol");
      }
      this._screenshotHover = this.target.attachMovie(this.shotsymbolHover,this.createInstanceName(),this.getNextHighestDepth());
      if(this._screenshotHover == null || this._screenshotHover == undefined)
      {
         this.debug("Error loading hover symbol: " + this.shotsymbolHover);
      }
      else
      {
         this.debug("We have a hover symbol");
      }
      this._screenshotDisabled = this.target.attachMovie(this.shotsymbolDisabled,this.createInstanceName(),this.getNextHighestDepth());
      if(this._screenshotDisabled == null || this._screenshotDisabled == undefined)
      {
         this.debug("Error loading hover symbol: " + this.shotsymbolDisabled);
      }
      else
      {
         this.debug("We have a hover symbol");
      }
      this._screenshotNormal._visible = true;
      this._screenshotClick._visible = false;
      this._screenshotHover._visible = false;
      this._screenshotDisabled._visible = false;
      this.size();
   }
   function processShotType()
   {
      this.debug("processShotType (" + this.shottype + ")");
      if(this.isLivePreview() == true)
      {
         return undefined;
      }
      if(this.getDrawImage() == false)
      {
         this.debug("The developer has disabled the usage of images, aborting loading");
         return undefined;
      }
      if(this.shottype == "UNDEFINED")
      {
         this.debug("shottype hasn\'t been set yet");
         return undefined;
      }
      if(this.shottype == "URL")
      {
         this.loadScreenshots();
      }
      if(this.shottype == "Symbol")
      {
         this.loadSymbols();
      }
   }
   function imageOnMouseDown()
   {
      if(this.fullImageSet == false)
      {
         return undefined;
      }
      if(this.getDrawImage() == false)
      {
         return undefined;
      }
      this._screenshotNormal._visible = false;
      this._screenshotClick._visible = true;
      this._screenshotHover._visible = false;
   }
   function imageOnMouseUp()
   {
      if(this.fullImageSet == false)
      {
         return undefined;
      }
      if(this.getDrawImage() == false)
      {
         return undefined;
      }
      this._screenshotNormal._visible = true;
      this._screenshotClick._visible = false;
      this._screenshotHover._visible = false;
   }
   function imageOnRollOver()
   {
      if(this.getDrawImage() == false)
      {
         return undefined;
      }
      if(this.fullImageSet == false)
      {
         return undefined;
      }
      if(this.getHighlighted() == true)
      {
         return undefined;
      }
      this._screenshotNormal._visible = false;
      this._screenshotHover._visible = true;
      this._screenshotClick._visible = false;
   }
   function imageOnRollOut()
   {
      if(this.getDrawImage() == false)
      {
         return undefined;
      }
      if(this.fullImageSet == false)
      {
         return undefined;
      }
      if(this.getHighlighted() == true)
      {
         return undefined;
      }
      this._screenshotNormal._visible = true;
      this._screenshotHover._visible = false;
      this._screenshotClick._visible = false;
   }
   function showDisabled(a_var)
   {
      this.debug("showDisabled (" + a_var + ")");
      if(this.fullImageSet == false)
      {
         return undefined;
      }
      if(this.getDrawImage() == false)
      {
         return undefined;
      }
      if(a_var == true)
      {
         this._screenshotNormal._visible = false;
         this._screenshotHover._visible = false;
         this._screenshotClick._visible = false;
         if(this._screenshotDisabled != null)
         {
            this._screenshotDisabled._visible = true;
         }
      }
      else
      {
         if(this.getDrawBase() == true)
         {
            this.setDrawBase(false);
         }
         this._screenshotNormal._visible = true;
         this._screenshotHover._visible = false;
         this._screenshotClick._visible = false;
         this._screenshotDisabled._visible = false;
      }
      this.draw();
   }
   function updateState()
   {
      this.debug("updateState (" + this.tempBlocked + ")");
      if(this.getHighlighted() == true)
      {
         if(this._screenshotHover != null)
         {
            this._screenshotNormal._visible = false;
            this._screenshotHover._visible = true;
            this._screenshotClick._visible = false;
            this._screenshotDisabled._visible = false;
            if(this.sgScaleToImage == true)
            {
               this._width = this._screenshotNormal._width;
               this._height = this._screenshotNormal._height;
            }
         }
         return undefined;
      }
      if(this.tempBlocked == true || this.getLockStatus() == true || this.getBlockStatus() == true)
      {
         this.showDisabled(true);
      }
      else
      {
         this.showDisabled(false);
      }
      this.draw();
   }
}
