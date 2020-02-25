class edu.cmu.hcii.ctat.CTATMovieClipBase extends mx.core.UIObject
{
   var className = "CTATMovieClipBase";
   function CTATMovieClipBase()
   {
      super();
      this.setClassType("CTATMovieClipBase");
      this.debug("CTATMovieClipBase ()");
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
      this.__set__visible(true);
      this.swapDepths(this.getNextHighestDepth());
   }
   function hide()
   {
      this.__set__visible(false);
   }
   function showChildren()
   {
      this.debug("showChildren ()");
      this.debug("Nr objects: " + this.length);
      for(var _loc2_ in this)
      {
         this.debug("Child: " + _loc2_);
      }
   }
}
