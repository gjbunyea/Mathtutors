class edu.cmu.hcii.ctat.CommStyledButton extends edu.cmu.hcii.ctat.CTATFlashButtonReplacement
{
   static var symbolName = "CommStyledButton";
   static var symbolOwner = edu.cmu.hcii.ctat.CommStyledButton;
   var className = "CommStyledButton";
   var ParentClassName = "CTATFlashButtonReplacement";
   static var version = "2.8";
   var publicVersion = "2.8";
   function CommStyledButton()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.sgCentered = true;
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
   function __set__AllowBlocking(theValue)
   {
      this.sgAllowBlocking = theValue;
      return this.__get__AllowBlocking();
   }
   function __get__AllowBlocking()
   {
      return this.sgAllowBlocking;
   }
}
