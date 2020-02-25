class edu.cmu.hcii.ctat.CTATComponentRef extends edu.cmu.hcii.ctat.CTATBase
{
   var className = "ComponentRef";
   var refname = "unassigned";
   var reftype = "movieclip";
   var refcomm = "undefined";
   var refversion = "x.xx.xx";
   var reference = null;
   var refState = "undefined";
   var refinput = "undefined";
   var refaction = "undefined";
   function CTATComponentRef()
   {
      super();
      this.setClassType("CTATComponentRef");
      this.debug("CTATComponentRef ()");
   }
   function setState(aState)
   {
      this.debug("setState (" + aState + "):" + this.refname);
      this.refState = aState;
   }
   function lock()
   {
      this.debug("lock ()");
      if(this.reference == undefined)
      {
         this.debug("Reference object is undefined, can\'t lock");
      }
      else if(this.reference == null)
      {
         this.debug("Reference object is null, can\'t lock");
      }
      else
      {
         this.reference.lock();
      }
   }
   function unlock()
   {
      this.debug("unlock ()");
      if(this.reference == undefined)
      {
         this.debug("Reference object is undefined, can\'t lock");
      }
      else if(this.reference == null)
      {
         this.debug("Reference object is null, can\'t unlock");
      }
      else
      {
         this.reference.unlock();
      }
   }
   function block()
   {
      this.debug("block ()");
      if(this.reference == undefined)
      {
         this.debug("Reference object is undefined, can\'t block");
      }
      else if(this.reference == null)
      {
         this.debug("Reference object is null, can\'t block");
      }
      else if(this.reference.block != undefined)
      {
         this.reference.block();
      }
      else
      {
         this.debug("Method block does not exist in component");
      }
   }
   function unblock()
   {
      this.debug("unblock ()");
      if(this.reference == undefined)
      {
         this.debug("Reference object is undefined, can\'t block");
      }
      else if(this.reference == null)
      {
         this.debug("Reference object is null, can\'t unblock");
      }
      else if(this.reference.unblock != undefined)
      {
         this.reference.unblock();
      }
      else
      {
         this.debug("Method unblock does not exist in component");
      }
   }
   function unFocus()
   {
      this.debug("unFocus ()");
      if(this.reference == undefined)
      {
         this.debug("Reference object is undefined, can\'t unfocus");
      }
      else if(this.reference == null)
      {
         this.debug("Reference object is null, can\'t unfocus");
      }
      else
      {
         this.debug("Removing focus ...");
         Selection.setFocus(null);
      }
   }
   function setFocus()
   {
      this.debug("setFocus ()");
      if(this.reference == undefined)
      {
         this.debug("Reference object is undefined, can\'t unfocus");
      }
      else if(this.reference == null)
      {
         this.debug("Reference object is null, can\'t unfocus");
      }
      else if(this.reftype == "CommTextAreaClass")
      {
         this.debug("unFocus special case for CommTextAreaClass");
         Selection.setFocus(this.reference.textbox);
      }
      else
      {
         Selection.setFocus(this.reference);
      }
   }
   function hasFocus()
   {
      this.debug("hasFocus ()");
      if(this.reference == null)
      {
         return false;
      }
      if(this.reftype == "CommTextAreaClass")
      {
         this.debug("unFocus special case for CommTextAreaClass");
         if(this.reference.textbox.getFocus() != null)
         {
            return true;
         }
      }
      else if(this.reference.getFocus() != null)
      {
         return true;
      }
      return false;
   }
   function setVisible(a_val)
   {
      this.debug("setVisible (" + a_val + ")");
      if(this.reference == undefined)
      {
         this.debug("Reference object is undefined, can\'t change visible settings");
      }
      else if(this.reference == null)
      {
         this.debug("Reference object is null, can\'t change visible settings");
      }
      else if(a_val == true)
      {
         this.reference._visible = true;
      }
      else
      {
         this.reference._visible = false;
      }
   }
}
