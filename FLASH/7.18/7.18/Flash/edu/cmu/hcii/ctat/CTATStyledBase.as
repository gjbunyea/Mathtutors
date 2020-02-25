class edu.cmu.hcii.ctat.CTATStyledBase extends edu.cmu.hcii.ctat.CTATAutomatedTesting
{
   static var symbolName = "CTATStyledBase";
   static var symbolOwner = edu.cmu.hcii.ctat.CTATStyledBase;
   var className = "CTATStyledBase";
   var ParentClassName = "CTATAutomatedTesting";
   function CTATStyledBase()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.setNoMouse(true);
      this.setTutorComponent(false);
      this.setAutoGrade(false);
      this.setUseLabel(false);
      this.setDrawImage(false);
      this.setFullImageSet(false);
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.debug("isLivePreview: " + this.isLivePreview());
      this.size();
   }
   function draw()
   {
      super.draw();
      this.debug("draw (" + this.wFixed + "," + this.hFixed + ")");
   }
   function size()
   {
      super.size();
      this.debug("size (" + this.wFixed + "," + this.hFixed + ")");
   }
   function __set__OutterBorderColor(theValue)
   {
      this.sgOutterBorderColor = theValue;
      this.borderColor = theValue;
      this.draw();
      return this.__get__OutterBorderColor();
   }
   function __get__OutterBorderColor()
   {
      return this.sgOutterBorderColor;
   }
   function __set__BackgroundColor(theValue)
   {
      this.sgBackgroundColor = theValue;
      this.backgroundColor = theValue;
      this.draw();
      return this.__get__BackgroundColor();
   }
   function __get__BackgroundColor()
   {
      return this.sgBackgroundColor;
   }
   function __set__BorderRoundness(theValue)
   {
      this.sgBorderRoundness = theValue;
      this.draw();
      return this.__get__BorderRoundness();
   }
   function __get__BorderRoundness()
   {
      return this.sgBorderRoundness;
   }
}
