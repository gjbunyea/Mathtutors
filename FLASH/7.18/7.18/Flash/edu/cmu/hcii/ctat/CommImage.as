class edu.cmu.hcii.ctat.CommImage extends edu.cmu.hcii.ctat.CTATAutomatedTesting
{
   static var symbolName = "CommImage";
   static var symbolOwner = edu.cmu.hcii.ctat.CommImage;
   var className = "CommImage";
   var ParentClassName = "CTATAutomatedTesting";
   static var version = "2.10.1";
   var publicVersion = "2.10.1";
   function CommImage()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("createChildren ()");
      this.debug("isLivePreview: " + this.isLivePreview());
      if(this.isLivePreview() == false)
      {
         this.background._visible = false;
      }
      this.setUseLabel(false);
      this.setFullImageSet(false);
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.debug("isLivePreview: " + this.isLivePreview());
      if(this.isLivePreview() == false)
      {
         this.debug("We\'re in the live player, hooking into the stage...");
         this.processShotType();
      }
      else
      {
         this.debug("We\'re in the preview mode, not hooking into the stage");
         this.size();
      }
   }
   function draw()
   {
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
   function __set__ImageURL(theValue)
   {
      this.shoturlNormal = theValue;
      this.setValues(this.shoturlNormal);
      if(this.isLivePreview() == false)
      {
         this.processShotType();
      }
      return this.__get__ImageURL();
   }
   function __get__ImageURL()
   {
      return this.shoturlNormal;
   }
   function __set__ImageSymbol(theValue)
   {
      this.shotsymbolNormal = theValue;
      if(this.isLivePreview() == false)
      {
         this.processShotType();
      }
      return this.__get__ImageSymbol();
   }
   function __get__ImageSymbol()
   {
      return this.shotsymbolNormal;
   }
   function __set__ImageSource(theValue)
   {
      this.shottype = theValue;
      if(this.isLivePreview() == false)
      {
         this.processShotType();
      }
      return this.__get__ImageSource();
   }
   function __get__ImageSource()
   {
      return this.shottype;
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
