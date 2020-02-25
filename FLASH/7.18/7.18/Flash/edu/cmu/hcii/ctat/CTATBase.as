class edu.cmu.hcii.ctat.CTATBase extends edu.cmu.hcii.ctat.CTATRoot
{
   var className = "CTATBase";
   function CTATBase()
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
   function debugXMLType(a_node)
   {
      switch(a_node.nodeType)
      {
         case 1:
            return "ELEMENT_NODE";
         case 2:
            return "ATTRIBUTE_NODE";
         case 3:
            return "TEXT_NODE";
         case 4:
            return "CDATA_SECTION_NODE";
         case 5:
            return "ENTITY_REFERENCE_NODE";
         case 6:
            return "ENTITY_NODE";
         case 7:
            return "PROCESSING_INSTRUCTION_NODE";
         case 8:
            return "COMMENT_NODE";
         case 9:
            return "DOCUMENT_NODE";
         case 10:
            return "DOCUMENT_TYPE_NODE";
         case 11:
            return "DOCUMENT_FRAGMENT_NODE";
         case 12:
            return "NOTATION_NODE";
         default:
            return "UNKNOWN";
      }
   }
   function debug_raw(a_string)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug_raw(a_string);
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
      this.debug("Next Highest Depth: " + _root.getNextHighestDepth());
   }
}
