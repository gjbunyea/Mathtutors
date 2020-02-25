class edu.cmu.hcii.ctat.CTATcTabOrder extends edu.cmu.hcii.ctat.CTATBase
{
   function CTATcTabOrder()
   {
      super();
      this.setClassType("CTATcTabOrder");
      this.debug("CTATcTabOrder ()");
   }
   function setTabOrder(theOrder)
   {
      this.debug("setTabOrder ()");
      var _loc2_ = new Array();
      _loc2_ = this.buildWidgetArray("_level0");
      var _loc3_ = new Array();
      _loc3_ = this.createTabOrderWidgetArray(_loc2_,theOrder);
      return _loc3_;
   }
   function prepareBasicTabOrder()
   {
      this.debug("prepareBasicTabOrdery ()");
      var _loc2_ = new Array();
      _loc2_ = this.buildWidgetArray("_level0");
      return _loc2_;
   }
   function buildWidgetArray(basePathOfClip)
   {
      this.debug("buildWidgetArray ()");
      var theClip = eval(basePathOfClip);
      var widgetArray = new Array();
      var comp = edu.cmu.hcii.ctat.CTATComponentList.getComponents();
      for(var i in comp)
      {
         var ref = comp[i];
         this.debug("Adding component to tab array: " + ref.refname);
         if(ref.refcomm != "table")
         {
            widgetArray.push({name:ref.refname,clipX:ref.reference._x,clipY:ref.reference._y,compRef:ref.reference});
         }
         else
         {
            this.debug("Skipping container component: " + ref.refcomm);
         }
      }
      return widgetArray;
   }
   function createTabOrderWidgetArray(theArray, sortBy)
   {
      this.debug("createTabOrderWidgetArray ()");
      var _loc7_ = theArray.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc7_)
      {
         if(theArray[_loc2_] instanceof Array)
         {
            var _loc4_ = new Array();
            _loc4_ = theArray[_loc2_];
            var _loc5_ = this.createTabOrderWidgetArray(_loc4_,sortBy);
            theArray[_loc2_] = _loc5_;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(sortBy == "Down Columns")
      {
         theArray.sortOn(["clipX","clipY"],Array.NUMERIC);
         return theArray;
      }
      if(sortBy == "Across Rows")
      {
         theArray.sortOn(["clipY","clipX"],Array.NUMERIC);
         return theArray;
      }
      if(sortBy == "Author Defined")
      {
         return theArray;
      }
      return theArray;
   }
   function walkTheTabWidgetArray(theWidgetArray, initialTabPosition)
   {
      this.debug("walkTheTabWidgetArray ()");
      return undefined;
   }
   function assignTabIndex(evalWidget, nTabOrder)
   {
      this.debug("assignTabIndex ()");
      if(evalWidget.commType == "textInput" || evalWidget.commType == "textArea")
      {
         evalWidget.textbox.tabIndex = nTabOrder;
         nTabOrder = nTabOrder + 1;
         return nTabOrder;
      }
      if(evalWidget.commType != undefined && evalWidget.commType != "tutorShell" && evalWidget.commType != "table" && evalWidget.commType != "jumble" && evalWidget.commType != "multiMediaSelection")
      {
         evalWidget.tabIndex = nTabOrder;
         nTabOrder = nTabOrder + 1;
         if(evalWidget.commType == "Done")
         {
            _level0.focusManager.defaultPushButton = evalWidget;
         }
         return nTabOrder;
      }
      if(evalWidget.commType == "jumble" || evalWidget.commType == "multiMediaSelection")
      {
         evalWidget.checkBtn.tabIndex = nTabOrder;
         return nTabOrder;
      }
      return nTabOrder;
   }
   function printObjectArray(theArray, callerMethod)
   {
      this.debug("printObjectArray ()");
      var _loc2_ = 0;
      while(_loc2_ < theArray.length)
      {
         this.debug(callerMethod + " : theArray[" + _loc2_ + "].name = " + theArray[_loc2_].name + "  clipX = " + theArray[_loc2_].clipX + "  clipY = " + theArray[_loc2_].clipY);
         if(theArray[_loc2_] instanceof Array)
         {
            this.debug(callerMethod + " : type array :  theArray[" + _loc2_ + "][0].name = " + theArray[_loc2_][0].name + "  clipX = " + theArray[_loc2_][0].clipX + "  clipY = " + theArray[_loc2_][0].clipY);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
