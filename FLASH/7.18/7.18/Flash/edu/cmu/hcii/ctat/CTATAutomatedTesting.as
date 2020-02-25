class edu.cmu.hcii.ctat.CTATAutomatedTesting extends edu.cmu.hcii.ctat.CTATClickableStyledComponent
{
   static var symbolName = "CTATAutomatedTesting";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATAutomatedTesting);
   var className = "CTATAutomatedTesting";
   var ParentClassName = "CTATClickableStyledComponent";
   function CTATAutomatedTesting()
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
   }
   function draw()
   {
      super.draw();
   }
   function size()
   {
      super.size();
   }
   function ATclick()
   {
      this.debug("ATclick ()");
   }
   function ATclickValue(val)
   {
      this.debug("ATclickValue (" + val + ")");
   }
   function ATselect(item)
   {
      this.debug("ATselect (" + item + ")");
   }
   function ATtype(val)
   {
      this.debug("ATtype (" + val + ")");
   }
   function ATkeyPress(key)
   {
      this.debug("ATkeyPress (" + key + ")");
   }
   function ATgetText()
   {
      this.debug("ATgetText ()");
      return this.getValues();
   }
   function ATgetTextItem(item)
   {
      this.debug("ATgetTextItem (" + item + ")");
      return this.getValues();
   }
   function ATgetForegroundColor()
   {
      this.debug("ATgetForegroundColor ()");
      return this.fontColor.toString();
   }
   function ATgetForegroundColorItem(item)
   {
      this.debug("ATgetForegroundColorItem (" + item + ")");
      return "undefined";
   }
   function ATgetBackgroundColor()
   {
      this.debug("ATgetBackgroundColor ()");
      return this.sgBackgroundColor.toString();
   }
   function ATgetBackgroundColorItem(item)
   {
      this.debug("ATgetBackgroundColorItem ()");
      return this.sgBackgroundColor.toString();
   }
   function ATisSelected()
   {
      this.debug("ATisSelected ()");
      return "false";
   }
   function ATisSelectedItem(item)
   {
      this.debug("ATisSelectedItem ()");
      return "false";
   }
   function ATisHighlighted()
   {
      this.debug("ATisHighlighted ()");
      if(this.getHighlighted() == true)
      {
         return "true";
      }
      return "false";
   }
   function ATisHighlightedItem(item)
   {
      this.debug("ATisHighlightedItemItem ()");
      if(this.getHighlighted() == true)
      {
         return "true";
      }
      return "false";
   }
}
