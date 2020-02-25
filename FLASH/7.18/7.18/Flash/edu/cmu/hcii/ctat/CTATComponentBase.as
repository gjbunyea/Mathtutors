class edu.cmu.hcii.ctat.CTATComponentBase extends mx.core.UIComponent
{
   static var symbolName = "CTATComponentBase";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATComponentBase);
   var className = "CTATComponentBase";
   var ParentClassName = "UIComponent";
   var isNewHierachy = "true";
   var eventArray = null;
   var clean = false;
   var createTag = false;
   var sizeTag = false;
   var drawTag = false;
   var componentTag = false;
   var tempBlocked = false;
   var tutorComponent = true;
   var autoGrade = true;
   var behaviorRecord = true;
   var evaluateComponent = true;
   var showFeedback = true;
   var locked = false;
   var blocked = false;
   function CTATComponentBase()
   {
      super();
   }
   function setClassType(a_type)
   {
      this.className = a_type;
   }
   function getClassType()
   {
      return this.className;
   }
   function classType()
   {
      return this.getClassType();
   }
   function isLivePreview()
   {
      return _root.contents.obj != null;
   }
   function init()
   {
      super.init();
      this.eventArray = new Array();
   }
   function createChildren()
   {
      super.createChildren();
      pact.datastructures.SingletonList.getInstance().insert(this);
      this.createTag = true;
      this.invalidate();
   }
   function draw()
   {
      this.drawTag = true;
      this.initEval();
   }
   function size()
   {
      super.size();
      this.debug("size ()");
      this.sizeTag = true;
      this.initEval();
   }
   function initEval()
   {
      this.debug("initEval (sizeTag:" + this.sizeTag + ")(createTag:" + this.createTag + ")(drawTag:" + this.drawTag + ")...");
      this.debug("className: " + this.className);
      if(this.className == "CommShellCode")
      {
         this.debug("We\'re artifically inducing the size event for the CommShell, which for some reason isn\'t called by Flash");
         this.sizeTag = true;
      }
      if(this.drawTag == true)
      {
         if(this.createTag == true)
         {
            if(this.sizeTag == true)
            {
               if(this.componentTag == false)
               {
                  this.debug("The component base is now in a solid state, calling componentInit () ...");
                  pact.datastructures.SingletonList.getInstance().update(this);
                  this.componentInit();
                  this.componentTag = true;
               }
            }
         }
      }
   }
   function componentInit()
   {
      this.debug("componentInit ()");
   }
   function componentsReady()
   {
      this.debug("componentsReady (" + this._name + ")");
   }
   function debug_raw(a_string)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug_raw(a_string);
   }
   function debug(a_string)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug(this.getClassType() + ":" + this._name,a_string);
   }
   static function dbg_remote(shell, a_source, a_message)
   {
      edu.cmu.hcii.ctat.CTATGlobal.dbg_remote(shell,a_source,a_message);
   }
   static function dbg(a_source, a_message)
   {
      edu.cmu.hcii.ctat.CTATGlobal.dbg(a_source,a_message);
   }
   static function internalDebug(a_class, a_message)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug(a_class,a_message);
   }
   function debugCurrentFrame()
   {
      this.debug("Current frame: " + _root.theShell._currentframe);
   }
   function safeAddEventListener(an_event, a_method)
   {
      this.debug("safeAddEventListener ()");
   }
   function getNextHighestDepth()
   {
      return edu.cmu.hcii.ctat.CTATGlobal.getNextHighestDepth();
   }
   function createInstanceName()
   {
      return edu.cmu.hcii.ctat.CTATGlobal.createInstanceName();
   }
   function Cleanup()
   {
      this.debug("Cleanup ()");
      _level0.onEnterFrame = null;
      _level0.onRelease = null;
      this.clean = true;
   }
}
