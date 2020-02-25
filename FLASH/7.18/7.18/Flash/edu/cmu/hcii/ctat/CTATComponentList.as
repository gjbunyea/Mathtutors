class edu.cmu.hcii.ctat.CTATComponentList extends edu.cmu.hcii.ctat.CTATBase
{
   static var complist = null;
   static var lastInput = "";
   function CTATComponentList()
   {
      super();
      this.setClassType("CTATComponentList");
      edu.cmu.hcii.ctat.CTATGlobal.debug("CTATComponentList","CTATComponentList ()");
      edu.cmu.hcii.ctat.CTATComponentList.internalInit();
   }
   static function internalInit()
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug("CTATComponentList","internalInit ()");
      if(edu.cmu.hcii.ctat.CTATComponentList.complist == null)
      {
         edu.cmu.hcii.ctat.CTATComponentList.complist = new Array();
      }
   }
   static function addComponent(comp)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug("CTATComponentList","addComponent ()");
      edu.cmu.hcii.ctat.CTATComponentList.internalInit();
      var _loc1_ = new edu.cmu.hcii.ctat.CTATComponentRef();
      _loc1_.reference = comp;
      _loc1_.reftype = comp.classType();
      _loc1_.refcomm = comp.commType;
      _loc1_.refname = comp._name;
      _loc1_.refversion = comp.publicVersion;
      _loc1_.setState("create");
      edu.cmu.hcii.ctat.CTATComponentList.complist.push(_loc1_);
   }
   static function updateComponent(comp)
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug("CTATComponentList","updateComponent ()");
      var _loc1_ = edu.cmu.hcii.ctat.CTATComponentList.findComponentRef(comp);
      _loc1_.setState("ready");
      edu.cmu.hcii.ctat.CTATComponentList.checkList();
   }
   static function findComponentRef(comp)
   {
      var _loc2_ = edu.cmu.hcii.ctat.CTATComponentList.complist.length;
      var _loc1_ = 0;
      while(_loc1_ < _loc2_)
      {
         if(edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].refname == comp._name)
         {
            return edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_];
         }
         _loc1_ = _loc1_ + 1;
      }
      return null;
   }
   static function checkList()
   {
      edu.cmu.hcii.ctat.CTATGlobal.debug("CTATComponentList","checkList ()");
      var _loc4_ = edu.cmu.hcii.ctat.CTATComponentList.complist.length;
      var _loc6_ = true;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         if(edu.cmu.hcii.ctat.CTATComponentList.complist[_loc2_].reference.isNewHierachy != undefined && edu.cmu.hcii.ctat.CTATComponentList.complist[_loc2_].reference.isNewHierachy != null)
         {
            _loc6_ = false;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(_loc6_ == true)
      {
         edu.cmu.hcii.ctat.CTATGlobal.debug("CTATComponentList","There are no components of the new type, aborting ...");
         return undefined;
      }
      var _loc5_ = true;
      var _loc1_ = 0;
      while(_loc1_ < _loc4_)
      {
         if(edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].reference.isNewHierachy != undefined && edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].reference.isNewHierachy != null)
         {
            edu.cmu.hcii.ctat.CTATGlobal.debug("CTATComponentList","Processing new style component: " + edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].refname + ", " + edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].reference.isNewHierachy);
            if(edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].refState != "ready")
            {
               _loc5_ = false;
            }
         }
         else
         {
            edu.cmu.hcii.ctat.CTATGlobal.debug("CTATComponentList","Detected an old style component: " + edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].refname);
         }
         _loc1_ = _loc1_ + 1;
      }
      if(_loc5_ == true)
      {
         var _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            edu.cmu.hcii.ctat.CTATComponentList.complist[_loc3_].reference.componentsReady();
            _loc3_ = _loc3_ + 1;
         }
      }
   }
   static function getComponents()
   {
      edu.cmu.hcii.ctat.CTATComponentList.internalInit();
      return edu.cmu.hcii.ctat.CTATComponentList.complist;
   }
   static function updateComponentValue(compName, newInput, newAction)
   {
      edu.cmu.hcii.ctat.CTATComponentList.lastTouched = compName;
      edu.cmu.hcii.ctat.CTATComponentList.lastInput = newInput;
      var _loc2_ = edu.cmu.hcii.ctat.CTATComponentList.complist.length;
      var _loc1_ = 0;
      while(_loc1_ < _loc2_)
      {
         if(edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].rename.equals(compName))
         {
            edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].refinput = newInput;
            edu.cmu.hcii.ctat.CTATComponentList.complist[_loc1_].refinput = newAction;
            _loc1_ = _loc2_;
         }
         _loc1_ = _loc1_ + 1;
      }
   }
}
