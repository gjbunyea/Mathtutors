class edu.cmu.hcii.ctat.CTATContextMessageTransferData extends edu.cmu.hcii.ctat.CTATBase
{
   function CTATContextMessageTransferData()
   {
      super();
      this.setClassType("CTATContextMessageTransferData");
      this.debug("CTATContextMessageTransferData ()");
   }
   function setTheCMID(newValue)
   {
      this._theContextMessageID = newValue;
   }
   function getTheCMID()
   {
      return this._theContextMessageID;
   }
   function settheContextMessageID(newValue)
   {
      this._theContextMessageID = newValue;
      this.debug("settheContextMessageID :   newValue = " + newValue + "  _theContextMessageID = " + this._theContextMessageID);
   }
   function gettheContextMessageID()
   {
      this.debug("gettheContextMessageID :  _theContextMessageID = " + this._theContextMessageID);
      return this._theContextMessageID;
   }
   function setthe_action_msg_type(newValue)
   {
      this._the_action_msg_type = newValue;
   }
   function getthe_action_msg_type()
   {
      return this._the_action_msg_type;
   }
   function setthe_action_msg_source(newValue)
   {
      this._the_action_msg_source = newValue;
   }
   function getthe_action_msg_source()
   {
      return this._the_action_msg_source;
   }
   function setquestion_file(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._question_file = newValue;
   }
   function getquestion_file()
   {
      return this._question_file;
   }
   function setproblem_name(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._problem_name = newValue;
   }
   function getproblem_name()
   {
      return this._problem_name;
   }
   function setmedia_file(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._media_file = newValue;
   }
   function getmedia_file()
   {
      return this._media_file;
   }
   function setproblem_context(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._problem_context = newValue;
   }
   function getproblem_context()
   {
      return this._problem_context;
   }
   function setproblem_tutorflag(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._problem_tutorflag = newValue;
   }
   function getproblem_tutorflag()
   {
      return this._problem_tutorflag;
   }
   function setproblem_otherproblemflag(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._problem_otherproblemflag = newValue;
   }
   function getproblem_otherproblemflag()
   {
      return this._problem_otherproblemflag;
   }
   function setcustom_field_obj(aCustom_field_objSerName, aCustom_field_objSerValue)
   {
      this.debug("setcustom_field_obj (" + aCustom_field_objSerName + "," + aCustom_field_objSerValue + ")");
      aCustom_field_objSerName = this.escapeXML(aCustom_field_objSerName);
      aCustom_field_objSerValue = this.escapeXML(aCustom_field_objSerValue);
      var _loc2_ = new Object();
      _loc2_.name = new Array();
      _loc2_.value = new Array();
      _loc2_.name = aCustom_field_objSerName.split(",");
      _loc2_.value = aCustom_field_objSerValue.split(",");
      if(this._custom_field_obj == undefined)
      {
         this._custom_field_obj = _loc2_;
      }
      else
      {
         this._custom_field_obj = new Object();
         this._custom_field_obj.value = new Array();
         this._custom_field_obj.name = new Array();
         for(var _loc3_ in _loc2_.name)
         {
            this._custom_field_obj.name.push(_loc2_.name[_loc3_]);
         }
         for(var _loc3_ in _loc2_.value)
         {
            this._custom_field_obj.value.push(_loc2_.value[_loc3_]);
         }
      }
      this.debug("setcustom_field_obj :  custom_field_obj.name[0] = " + this._custom_field_obj.name[0] + " custom_field_obj.value[0] = " + this._custom_field_obj.value[0] + " aCustom_field_objSerName = " + aCustom_field_objSerName + " aCustom_field_objSerValue = " + aCustom_field_objSerValue);
   }
   function getcustom_field_obj()
   {
      return this._custom_field_obj;
   }
   function setdataset_name(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._dataset_name = newValue;
   }
   function getdataset_name()
   {
      return this._dataset_name;
   }
   function setdataset_level_obj(aDataset_level_objSerName, aDataset_level_objSerType)
   {
      this.printArray(this._dataset_level_obj.name,"setdataset_level_obj : 1 : ");
      aDataset_level_objSerName = this.escapeXML(aDataset_level_objSerName);
      aDataset_level_objSerType = this.escapeXML(aDataset_level_objSerType);
      var _loc2_ = new Object();
      _loc2_.type = new Array();
      _loc2_.name = new Array();
      _loc2_.name = aDataset_level_objSerName.split(",");
      _loc2_.type = aDataset_level_objSerType.split(",");
      this.debug("setdataset_level_obj :  _dataset_level_obj.name[0] = " + this._dataset_level_obj.name[0] + " aDataset_level_obj.name[0] = " + _loc2_.name[0] + "  this._dataset_level_obj = " + this._dataset_level_obj);
      this._dataset_level_obj = _loc2_;
      this.printArray(this._dataset_level_obj.name,"setdataset_level_obj : 2 : ");
   }
   function getdataset_level_obj()
   {
      this.debug("ContextMessageTransferData : getdataset_level_obj : _dataset_level_obj.name[0] = " + this._dataset_level_obj.name[0]);
      return this._dataset_level_obj;
   }
   function printArray(theArray, cSource)
   {
      var _loc2_ = 0;
      while(_loc2_ < theArray.length)
      {
         this.debug(cSource + ": idx = " + _loc2_ + " theArray[" + _loc2_ + "] = " + theArray[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
   }
   function setclass_name(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._class_name = newValue;
   }
   function getclass_name()
   {
      return this._class_name;
   }
   function setschool_name(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._school_name = newValue;
   }
   function getschool_name()
   {
      return this._school_name;
   }
   function setperiod_name(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._period_name = newValue;
   }
   function getperiod_name()
   {
      return this._period_name;
   }
   function setclass_description(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._class_description = newValue;
   }
   function getclass_description()
   {
      return this._class_description;
   }
   function setinstructor_name(newValue)
   {
      newValue = this.escapeXML(newValue);
      this._instructor_name = newValue;
   }
   function getinstructor_name()
   {
      return this._instructor_name;
   }
   function setstudy_condition_obj(aStudy_condition_objSerName, aStudy_condition_objSerType, aStudy_condition_objSerDescription)
   {
      aStudy_condition_objSerName = this.escapeXML(aStudy_condition_objSerName);
      aStudy_condition_objSerType = this.escapeXML(aStudy_condition_objSerType);
      aStudy_condition_objSerDescription = this.escapeXML(aStudy_condition_objSerDescription);
      var _loc2_ = new Object();
      _loc2_.name = new Array();
      _loc2_.type = new Array();
      _loc2_.description = new Array();
      _loc2_.name = aStudy_condition_objSerName.split(",");
      _loc2_.type = aStudy_condition_objSerType.split(",");
      _loc2_.description = aStudy_condition_objSerDescription.split(",");
      this._study_condition_obj = _loc2_;
      if(this._study_condition_obj == undefined)
      {
         this._study_condition_obj = _loc2_;
         this.debug("setcustom_field_obj : _study_condition_obj.name[0] = " + this._study_condition_obj.name[0]);
      }
      else
      {
         this._study_condition_obj = new Object();
         this._study_condition_obj.type = new Array();
         this._study_condition_obj.name = new Array();
         this._study_condition_obj.description = new Array();
         for(var _loc3_ in _loc2_.name)
         {
            this._study_condition_obj.name.push(_loc2_.name[_loc3_]);
         }
         for(var _loc3_ in _loc2_.type)
         {
            this._study_condition_obj.type.push(_loc2_.type[_loc3_]);
         }
         for(var _loc3_ in _loc2_.description)
         {
            this._study_condition_obj.description.push(_loc2_.description[_loc3_]);
         }
      }
   }
   function getstudy_condition_obj()
   {
      return this._study_condition_obj;
   }
   function setTheCM(newValue)
   {
      this._theCM = newValue;
      this.debug("setTheCM :   newValue = " + newValue + "  _theCM = " + this._theCM);
   }
   function getTheCM()
   {
      this.debug("gettheContextMessageID :  _theCM = " + this._theCM);
      return this._theCM;
   }
   function escapeXML(xmlToEscape)
   {
      xmlToEscape = xmlToEscape.split("&amp;").join("&");
      xmlToEscape = xmlToEscape.split("&").join("&amp;");
      xmlToEscape = xmlToEscape.split("<").join("&lt;");
      xmlToEscape = xmlToEscape.split(">").join("&gt;");
      xmlToEscape = xmlToEscape.split("=").join("&#61;");
      return xmlToEscape;
   }
}
