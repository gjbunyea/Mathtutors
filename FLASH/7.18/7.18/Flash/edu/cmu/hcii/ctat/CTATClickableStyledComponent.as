class edu.cmu.hcii.ctat.CTATClickableStyledComponent extends edu.cmu.hcii.ctat.CTATTutorableComponent
{
   static var symbolName = "CTATClickableStyledComponent";
   static var symbolOwner = edu.cmu.hcii.ctat.CTATClickableStyledComponent;
   var className = "CTATClickableStyledComponent";
   var ParentClassName = "CTATTutorableComponent";
   var mouseDown = false;
   var mouseOver = false;
   var innerBorderColor = 13882323;
   var clipper = null;
   var sgAllowBlocking = true;
   var noMouse = false;
   function CTATClickableStyledComponent()
   {
      super();
   }
   function init()
   {
      super.init();
      this.debug("init");
   }
   function setNoMouse(a_val)
   {
      this.debug("setNoMouse ()");
      this.noMouse = a_val;
   }
   function getNoMouse()
   {
      return this.noMouse;
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
      mx.events.EventDispatcher.initialize(this);
      this.assignEventHandlers();
      this.debug("Adding tutor lock and unlock event handlers ...");
      this.addEventListener("tutorLock",mx.utils.Delegate.create(this,this.lock));
      this.addEventListener("tutorUnlock",mx.utils.Delegate.create(this,this.unlock));
      this.debug("createChildren () Done");
   }
   function assignEventHandlers()
   {
      this.debug("assignEventHandlers ()");
      if(this.getNoMouse() == true)
      {
         return undefined;
      }
      this.onMouseDown = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processOnMouseDown);
      this.onMouseUp = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processOnMouseUp);
      this.onMouseMove = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processOnMouseOver);
      this.onRollOver = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processOnRollOver);
      this.onRollOut = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.processOnRollOut);
      this.debug("assignEventHandlers () Done");
   }
   function removeEventHandlers()
   {
      this.debug("removeEventHandlers ()");
   }
   function draw()
   {
      super.draw();
   }
   function size()
   {
      super.size();
   }
   function processOnMouseDown()
   {
      if(this.tempBlocked == true)
      {
         return undefined;
      }
      if(this._visible == false)
      {
         return undefined;
      }
      if(this.windowing == true)
      {
         this.windowMouseDown(local.x,local.y);
         return undefined;
      }
      if(this.mouseOver == false)
      {
         return undefined;
      }
      var local = {x:_level0._xmouse,y:_level0._ymouse};
      this.target.globalToLocal(local);
      if(local.x > 0 && local.y > 0 && local.x < this.wFixed && local.y < this.hFixed)
      {
         this.mouseDown = true;
         if(this.autoGrade == true)
         {
            _root.theShell.setCurrentTabFocus(this);
         }
         this.imageOnMouseDown();
         this.dispatchEvent({type:"componentOnMouseDown"});
      }
   }
   function processOnMouseUp()
   {
      if(this.tempBlocked == true)
      {
         return undefined;
      }
      if(this._visible == false)
      {
         return undefined;
      }
      if(this.windowing == true)
      {
         var _loc2_ = {x:_level0._xmouse,y:_level0._ymouse};
         this.target.globalToLocal(_loc2_);
         this.windowMouseUp(_loc2_.x,_loc2_.y);
         return undefined;
      }
      if(this.mouseDown == true)
      {
         this.debug("processOnMouseUp ()");
         this.mouseDown = false;
         if(!(this.locked == true || this.blocked == true))
         {
            this.imageOnMouseUp();
            this.click();
            this.dispatchEvent({type:"componentOnMouseUp"});
         }
      }
   }
   function processOnMouseOver()
   {
      if(this.tempBlocked == true)
      {
         this.debug("Tempblocked==true");
         return undefined;
      }
      if(this._visible == false)
      {
         return undefined;
      }
      if(this.windowing == true)
      {
         var _loc2_ = {x:_level0._xmouse,y:_level0._ymouse};
         this.target.globalToLocal(_loc2_);
         this.windowMouseMove(_loc2_.x,_loc2_.y);
         return undefined;
      }
      this.dispatchEvent({type:"componentOnMouseOver"});
   }
   function processOnRollOver()
   {
      this.debug("processOnRollOver ()");
      if(this.tempBlocked == true)
      {
         this.debug("Tempblocked==true");
         return undefined;
      }
      if(this._visible == false)
      {
         return undefined;
      }
      if(this.windowing == true)
      {
         this.debug("windowing==true");
         return undefined;
      }
      if(this.mouseDown == true)
      {
         this.debug("mouseDown==true");
         return undefined;
      }
      if(this.mouseOver == true)
      {
         this.debug("mouseOver==true");
         return undefined;
      }
      this.mouseOver = true;
      this.imageOnRollOver();
      this.borderColor = 11987361;
      this.innerBorderColor = 12710062;
      if(this.sgRollOverHighlight == true)
      {
         if(this.getUseLabel() == true)
         {
            this.sgFontColor = this.sgHighlightColor;
            this.setLabelProps();
         }
      }
      this.dispatchEvent({type:"componentOnRollOver",target:this});
   }
   function processOnRollOut()
   {
      this.debug("processOnRollOut ()");
      if(this.tempBlocked == true)
      {
         this.debug("Tempblocked==true");
         return undefined;
      }
      if(this._visible == false)
      {
         return undefined;
      }
      if(this.windowing == true)
      {
         this.debug("windowing==true");
         return undefined;
      }
      if(this.mouseDown == true)
      {
         this.debug("mouseDown==true");
         return undefined;
      }
      var _loc2_ = {x:_level0._xmouse,y:_level0._ymouse};
      this.target.globalToLocal(_loc2_);
      if(this.getDrawBase() == true || this.getDrawImage() == true || this.getFullImageSet() == true)
      {
         if(_loc2_.x > 0 && _loc2_.y > 0 && _loc2_.x < this.wFixed && _loc2_.y < this.hFixed)
         {
            this.debug("False alarm [" + _loc2_.x + "][" + _loc2_.y + "] -> [" + this.wFixed + "][" + this.hFixed + "], chances are a hint message forced focus to another component, which triggered a OnRollOut");
         }
         else
         {
            this.mouseOver = false;
         }
      }
      else
      {
         this.debug("We\'re using a label, always turn off mouseOver on a processOnRollOut");
         this.mouseOver = false;
      }
      this.borderColor = this.sgOutterBorderColor;
      this.innerBorderColor = 13882323;
      this.imageOnRollOut();
      if(this.sgRollOverHighlight == true)
      {
         if(this.getUseLabel() == true)
         {
            this.sgFontColor = this.sgFontDefaultColor;
            this.setLabelProps();
         }
      }
      this.dispatchEvent({type:"componentOnRollOut",target:this});
   }
   function setDisabled(a_var)
   {
      this.debug("setDisabled (" + a_var + ")");
      if(this.sgAllowBlocking == false)
      {
         this.debug("sgAllowBlocking==false, aborting");
         return undefined;
      }
      if(a_var == true)
      {
         this.tempBlocked = true;
         this.updateState();
      }
      else
      {
         this.debug("Enabling component ...");
         this.tempBlocked = false;
         this.updateState();
      }
   }
   function lock()
   {
      this.debug("lock ()");
      if(this.sgAllowBlocking == false)
      {
         this.debug("sgAllowBlocking==false, aborting");
         return undefined;
      }
      this.locked = true;
      this.setDisabled(true);
   }
   function unlock()
   {
      this.debug("unlock ()");
      if(this.sgAllowBlocking == false)
      {
         this.debug("sgAllowBlocking==false, aborting");
         return undefined;
      }
      this.locked = false;
      this.setDisabled(false);
   }
   function block()
   {
      this.debug("block ()");
      if(this.sgAllowBlocking == false)
      {
         this.debug("sgAllowBlocking==false, aborting");
         return undefined;
      }
      if(this.locked == true)
      {
         this.debug("Component is locked, aborting blocking");
         return undefined;
      }
      this.blocked = true;
      this.setDisabled(true);
   }
   function unblock()
   {
      this.debug("unblock ()");
      if(this.sgAllowBlocking == false)
      {
         this.debug("sgAllowBlocking==false, aborting");
         return undefined;
      }
      if(this.locked == true)
      {
         this.debug("Component is locked, aborting unblocking");
         return undefined;
      }
      this.blocked = false;
      this.setDisabled(false);
   }
}
