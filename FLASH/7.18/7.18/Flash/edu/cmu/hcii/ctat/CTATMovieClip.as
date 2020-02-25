class edu.cmu.hcii.ctat.CTATMovieClip extends MovieClip
{
   var className = "CTATMovieClip";
   static var _symbolClass = edu.cmu.hcii.ctat.CTATMovieClip;
   static var _symbolPackage = "__Packages.edu.cmu.hcii.ctat.CTATMovieClip";
   function CTATMovieClip()
   {
      super();
      mx.events.EventDispatcher.initialize(this);
      this.onEnterFrame = this.__$_init;
      this.debug("CTATMovieClip ()");
   }
   function onInitialize()
   {
      this.debug("onInitialize ()");
   }
   function __$_init()
   {
      this.debug("__$_init()");
      delete this.onEnterFrame;
      this.onInitialize();
   }
   static function createInstance(symbolClass, parent, instance, depth, init)
   {
      if(symbolClass._symbolPackage.indexOf("__Packages") >= 0)
      {
         Object.registerClass(symbolClass._symbolPackage,symbolClass);
      }
      if(depth == undefined)
      {
         depth = parent.getNextHighestDepth();
      }
      if(instance == undefined)
      {
         instance = "__$_" + depth;
      }
      return parent.attachMovie(symbolClass._symbolPackage,instance,depth,init);
   }
   static function create(parent, instance, depth, init)
   {
      return (edu.cmu.hcii.ctat.CTATMovieClip)edu.cmu.hcii.ctat.CTATMovieClip.createInstance(edu.cmu.hcii.ctat.CTATMovieClip._symbolClass,parent,instance,depth,init);
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
   function debug(a_string)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug(this.getClassType(),a_string);
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
   function getNextHighestDepth()
   {
      return edu.cmu.hcii.ctat.CTATGlobal.getNextHighestDepth();
   }
   function createInstanceName()
   {
      return edu.cmu.hcii.ctat.CTATGlobal.createInstanceName();
   }
   function debugNextHighestDepth()
   {
      this.debug("Next Highest Depth: (_root) " + _root.getNextHighestDepth() + " internal: " + this.getNextHighestDepth());
   }
   function show()
   {
      this._visible = true;
   }
   function hide()
   {
      this._visible = false;
   }
}
