class edu.cmu.hcii.ctat.CTATFlashButtonReplacement extends edu.cmu.hcii.ctat.CTATAutomatedTesting
{
   static var symbolName = "CTATFlashButtonReplacement";
   static var symbolOwner = edu.cmu.hcii.ctat.CTATFlashButtonReplacement;
   var className = "CTATFlashButtonReplacement";
   var ParentClassName = "CTATAutomatedTesting";
   var showFlashBorder = true;
   function CTATFlashButtonReplacement()
   {
      super();
   }
   function setShowFlashBorder(a_val)
   {
      this.showFlashBorder = a_val;
   }
   function getShowFlashBorder()
   {
      return this.showFlashBorder;
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.setDrawImage(false);
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
   }
   function draw()
   {
      super.draw();
      if(this.isLivePreview() == false)
      {
         if(this.showFlashBorder == true)
         {
            this.debug("Drawing flash style inner border (" + this.wFixed + "," + this.hFixed + ")...");
            this.graphics.lineColor = this.innerBorderColor;
            this.graphics.drawRoundedRectangle(2,2,this.wFixed - 4,this.hFixed - 4,this.sgBorderRoundness);
         }
      }
      this.setLabelProps();
   }
   function size()
   {
      super.size();
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
   function __set__Label(theValue)
   {
      this.setText(theValue);
      this.draw();
      return this.__get__Label();
   }
   function __get__Label()
   {
      return this.getText();
   }
   function __set__Font(theValue)
   {
      this.sgFontName = theValue;
      return this.__get__Font();
   }
   function __get__Font()
   {
      return this.sgFontName;
   }
   function __set__FontSize(theValue)
   {
      this.sgFontSize = theValue;
      return this.__get__FontSize();
   }
   function __get__FontSize()
   {
      return this.sgFontSize;
   }
   function __set__FontBold(theValue)
   {
      this.sgFontBold = theValue;
      return this.__get__FontBold();
   }
   function __get__FontBold()
   {
      return this.sgFontBold;
   }
   function __set__FontItalic(theValue)
   {
      this.sgFontItalic = theValue;
      return this.__get__FontItalic();
   }
   function __get__FontItalic()
   {
      return this.sgFontItalic;
   }
   function __set__FontUnderline(theValue)
   {
      this.sgFontUnderline = theValue;
      return this.__get__FontUnderline();
   }
   function __get__FontUnderline()
   {
      return this.sgFontUnderline;
   }
}
