class edu.cmu.hcii.ctat.CTATSkillSet extends edu.cmu.hcii.ctat.CTATBase
{
   var skillset = null;
   function CTATSkillSet()
   {
      super();
      this.setClassType("CTATSkillSet");
      this.debug("CTATSkillSet ()");
      this.skillset = new Array();
   }
   function getSkillSet()
   {
      return this.skillset;
   }
   function fromXML(a_string)
   {
      this.debug("fromXML (" + a_string + ")");
      var _loc6_ = new XML();
      _loc6_.parseXML(a_string);
      var _loc5_ = _loc6_;
      this.debug("Root node name: " + _loc6_.nodeName + ", node value: " + _loc6_.nodeValue + " node type: " + this.debugXMLType(_loc5_) + " children: " + _loc5_.childNodes.length);
      _loc5_ = _loc6_.childNodes[0];
      this.debug("Root node name: " + _loc5_.nodeName + ", node value: " + _loc5_.nodeValue + " node type: " + this.debugXMLType(_loc5_) + " children: " + _loc5_.childNodes.length);
      this.debug("Processing [" + _loc5_.childNodes.length + "] skills");
      var _loc3_ = _loc5_.childNodes;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         this.debug("Examining xml node with name: " + _loc3_[_loc2_].nodeName + " with type: " + this.debugXMLType(_loc3_[_loc2_]));
         if(this.debugXMLType(_loc3_[_loc2_]) == "TEXT_NODE")
         {
            this.debug("Skipping text node");
         }
         else if(_loc3_[_loc2_].nodeName == "skill" || _loc3_[_loc2_].nodeName == "Skill")
         {
            this.debug("Adding skill: [" + _loc3_[_loc2_].attributes.name + "]");
            var _loc4_ = _loc3_[_loc2_].attributes.name.split(" ");
            this.debug("Split name value into: " + _loc4_[0] + "," + _loc4_[1]);
            this.addSkill(_loc4_[0],_loc3_[_loc2_].attributes.pKnown,0.95,_loc3_[_loc2_].attributes.description,_loc3_[_loc2_].attributes.label,_loc4_[1]);
         }
         else
         {
            this.debug("Internal error for skill index: " + _loc2_);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function processSkills(a_root)
   {
      this.debug("processSkills (" + a_root.toString() + ")");
      var _loc9_ = new Array();
      this.debug("Looking for skills info ...");
      this.debug("fromXML (" + a_root.toString() + ")");
      this.debug("Nr child nodes: " + a_root.childNodes.length);
      var _loc4_ = 0;
      while(_loc4_ < a_root.childNodes.length)
      {
         this.debug("Child node: " + a_root.childNodes[_loc4_].nodeName);
         if(a_root.childNodes[_loc4_].nodeName == "value" || a_root.childNodes[_loc4_].nodeName == "Value")
         {
            var _loc8_ = a_root.childNodes[_loc4_].firstChild.nodeValue;
            this.debug("Processing skill update: " + _loc8_);
            var _loc2_ = _loc8_.split("=");
            var _loc3_ = _loc2_[0].split(" ");
            this.debug("Skills: " + _loc3_[0] + " - " + _loc3_[1] + "," + _loc2_[1] + "," + _loc2_[2] + "," + _loc2_[3]);
            var _loc5_ = new Array();
            _loc5_.push(_loc3_[0]);
            _loc5_.push(_loc3_[1]);
            _loc5_.push(_loc2_[1]);
            _loc5_.push(_loc2_[2]);
            _loc5_.push(_loc2_[3]);
            var _loc7_ = this.setSkillLevel(_loc3_[0],_loc2_[1],_loc2_[2]);
            _loc7_.label = _loc2_[3];
            _loc7_.category = _loc3_[1];
         }
         _loc4_ = _loc4_ + 1;
      }
      return _loc9_;
   }
   function fromXMLData(a_root)
   {
      this.debug("fromXML (" + a_root.toString() + ")");
      this.debug("Nr child nodes: " + a_root.childNodes.length);
      var _loc5_ = 0;
      while(_loc5_ < a_root.childNodes.length)
      {
         this.debug("Child node: " + a_root.childNodes[_loc5_].nodeName);
         if(a_root.childNodes[_loc5_].nodeName == "Skills" || a_root.childNodes[_loc5_].nodeName == "Skills")
         {
            var _loc3_ = a_root.childNodes[_loc5_];
            this.debug("Processing [" + _loc3_.childNodes.length + "] skill(s)");
            var _loc2_ = 0;
            while(_loc2_ < _loc3_.childNodes.length)
            {
               if(_loc3_.childNodes[_loc2_].nodeName == "skill" || _loc3_.childNodes[_loc2_].nodeName == "Skill")
               {
                  this.debug("Adding skill: [" + _loc3_.childNodes[_loc2_].attributes.name + "] skills");
                  var _loc4_ = _loc3_.childNodes[_loc2_].attributes.name.split(" ");
                  this.debug("Split name value into: " + _loc4_[0] + "," + _loc4_[1]);
                  this.addSkill(_loc4_[0],_loc3_.childNodes[_loc2_].attributes.pKnown,0.95,_loc3_.childNodes[_loc2_].attributes.description,_loc3_.childNodes[_loc2_].attributes.label,_loc4_[1]);
               }
               _loc2_ = _loc2_ + 1;
            }
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function addSkill(a_name, a_level, a_mastery, a_description, a_label, a_category)
   {
      this.debug("addSkill (" + a_name + "," + a_level + "," + a_mastery + ")");
      var _loc2_ = this.setSkillLevel(a_name,a_level,a_mastery);
      if(a_mastery == 1)
      {
         _loc2_.level = 1;
      }
      else
      {
         _loc2_.level = a_level;
      }
      _loc2_.description = a_description;
      _loc2_.name = a_name;
      _loc2_.label = a_label;
      _loc2_.category = a_category;
      return _loc2_;
   }
   function setSkillLevel(a_name, a_level, a_mastery)
   {
      this.debug("setSkillLevel (" + a_name + "," + a_level + "," + a_mastery + ")");
      var _loc2_ = this.getSkill(a_name);
      if(_loc2_ == null)
      {
         this.debug("Unable to locate : " + a_name);
         _loc2_ = new edu.cmu.hcii.ctat.CTATSkill();
         _loc2_.name = a_name;
         _loc2_.level = a_level;
         if(a_mastery == 1)
         {
            _loc2_.level = 1;
         }
         else
         {
            _loc2_.level = a_level;
         }
         this.skillset.push(_loc2_);
      }
      else
      {
         this.debug("We found an existing skill, updating ...");
         if(a_mastery == 1)
         {
            _loc2_.level = 1;
         }
         else
         {
            _loc2_.level = a_level;
         }
      }
      _loc2_.touched = true;
      return _loc2_;
   }
   function getSkill(a_name)
   {
      this.debug("getSkill ()");
      if(a_name == undefined)
      {
         return null;
      }
      if(a_name == null)
      {
         return null;
      }
      var _loc2_ = 0;
      while(_loc2_ < this.skillset.length)
      {
         if(this.skillset[_loc2_].name == a_name)
         {
            return this.skillset[_loc2_];
         }
         _loc2_ = _loc2_ + 1;
      }
      return null;
   }
   function getSkillLevel(a_name)
   {
      this.debug("getSkillLevel ()");
      if(a_name == undefined)
      {
         return null;
      }
      if(a_name == null)
      {
         return null;
      }
      var _loc2_ = 0;
      while(_loc2_ < this.skillset.length)
      {
         if(this.skillset[_loc2_].name == a_name)
         {
            return this.skillset[_loc2_].level;
         }
         _loc2_ = _loc2_ + 1;
      }
      return null;
   }
   function debugSkills()
   {
      this.debug("debugSkills ()");
      var _loc2_ = 0;
      while(_loc2_ < this.skillset.length)
      {
         this.debug("Skill: " + this.skillset[_loc2_].name + "," + this.skillset[_loc2_].level);
         _loc2_ = _loc2_ + 1;
      }
   }
   function touchSkills()
   {
      this.debug("touchSkills ()");
      var _loc2_ = 0;
      while(_loc2_ < this.skillset.length)
      {
         this.skillset[_loc2_].touched = false;
         _loc2_ = _loc2_ + 1;
      }
   }
}
