class edu.cmu.hcii.ctat.CTATHintWindowBase extends edu.cmu.hcii.ctat.CTATStyledBase
{
   static var symbolName = "CTATHintWindowBase";
   static var symbolOwner = edu.cmu.hcii.ctat.CTATHintWindowBase;
   var className = "CTATHintWindowBase";
   var ParentClassName = "CTATStyledBase";
   var hintText = null;
   var fitted = false;
   var hintgraphics = null;
   var eventsCreated = false;
   var buttonWidth = 83;
   var buttonHeight = 21;
   function CTATHintWindowBase()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.setTutorComponent(false);
      this.setAutoGrade(false);
   }
   function updateVisuals()
   {
      this.draw();
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      this.debug("Assigning hint window to global variable ...");
      _global.hintWindow = this;
      if(this.isLivePreview() == false)
      {
         this.backgr._visible = false;
         if(_global.theShell != null && _global.theShell != undefined)
         {
            _global.theShell.setAlternativeHintWindow(this);
         }
         else
         {
            this.debug("Error: no shell object available yet, can\'t set alternative hint window");
         }
      }
      this.testHintSurface();
      this.size();
   }
   function testHintSurface()
   {
      this.debug("testHintSurface");
      this.scroller = this.hintwindow.content;
      if(this.scroller != null)
      {
         this.debug("Assigning scroll canvas ...");
         this.scroller.innertube._visible = false;
         if(this.fitted == false)
         {
            this.hintgraphics = new edu.cmu.hcii.ctat.CTATGraphicsTools(this.scroller);
            this.hintwindow.swapDepths(this.getNextHighestDepth());
            this.previous.swapDepths(this.getNextHighestDepth());
            this.next.swapDepths(this.getNextHighestDepth());
            this.up.swapDepths(this.getNextHighestDepth());
            this.down.swapDepths(this.getNextHighestDepth());
            if(this.isLivePreview() == false)
            {
               this.hintwindow.setStyle("borderStyle","none");
            }
            this.badComponentInit();
            this.fitted = true;
         }
      }
      else
      {
         this.debug("Error obtaining ScrollPane background");
      }
   }
   function badComponentInit()
   {
      this.debug("badComponentInit ()");
   }
   function draw()
   {
      super.draw();
      this.debug("draw ()");
   }
   function size()
   {
      super.size();
      this.debug("size (" + this.wFixed + "," + this.hFixed + ")");
      this.backgr._width = this.wFixed;
      this.backgr._height = this.hFixed;
      this.previous._x = 5;
      this.previous._y = this.hFixed - this.buttonHeight - 3;
      this.previous._width = this.buttonWidth;
      this.previous._height = this.buttonHeight;
      this.next._x = this.previous._width + 10;
      this.next._y = this.hFixed - this.buttonHeight - 3;
      this.next._width = this.buttonWidth;
      this.next._height = this.buttonHeight;
      this.up._x = this.wFixed - this.up._width - 10;
      this.up._y = 10;
      this.up._width = 12;
      this.up._height = 14;
      this.down._x = this.wFixed - this.down._width - 10;
      this.down._y = this.previous._y - this.down._height - 10;
      this.down._width = 12;
      this.down._height = 14;
      this.hintwindow._x = 5;
      this.hintwindow._y = 5;
      this.hintwindow._width = this.wFixed - this.down._width - 10 - 10;
      this.hintwindow._height = this.previous._y - 10;
      this.draw();
   }
   function disableButtons(a_val)
   {
      this.debug("disableButtons (" + a_val + ")");
      return undefined;
   }
}
