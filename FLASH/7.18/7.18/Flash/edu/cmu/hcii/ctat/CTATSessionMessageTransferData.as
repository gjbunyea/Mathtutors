class edu.cmu.hcii.ctat.CTATSessionMessageTransferData extends edu.cmu.hcii.ctat.CTATBase
{
   var _auth_token = "not_found";
   var _session_id = "aSessionID";
   var _user_guid = "WeirdCMUUser_default";
   var _container_id = "";
   var _source_id = "PACT_CTAT";
   var _external_object_id = "";
   var _class_id = "";
   var _treatment_id = "";
   var _assignment_id = "";
   var _info_type = "tutor_message.dtd";
   function CTATSessionMessageTransferData()
   {
      super();
      this.setClassType("CTATSessionMessageTransferData");
      this.debug("CTATSessionMessageTransferData ()");
      this.setlog_service_url("");
      this.setauth_token("");
      var _loc3_ = this.setsession_id("");
      this.debug("SessionMessageTransferData :  sessionSetBy  = " + _loc3_ + " getsession_id() = " + this.getsession_id());
      var _loc4_ = this.setuser_guid("");
      this.setcontainer_id("");
      this.setsource_id("");
      this.setexternal_object_id("");
      this.setclass_id("");
      this.settreatment_id("");
      this.setassignment_id("");
      this.setinfo_type("");
   }
   function setlog_service_url(newValue)
   {
      if(this.checkValid(newValue) == true)
      {
         this._log_service_url = newValue;
      }
      else if(this.checkValid(_level0.log_service_url) == true)
      {
         this._log_service_url = _level0.log_service_url;
      }
      else
      {
         this._log_service_url = null;
      }
   }
   function getlog_service_url()
   {
      return this._log_service_url;
   }
   function setauth_token(newValue)
   {
      if(this.checkValid(newValue) == true)
      {
         this._auth_token = newValue;
      }
      else if(this.checkValid(_level0.auth_token) == true)
      {
         this._auth_token = _level0.auth_token;
      }
      else
      {
         this._auth_token = "not_found";
      }
   }
   function getauth_token()
   {
      return this._auth_token;
   }
   function setsession_id(newValue)
   {
      this.debug("setsession_id ()");
      this._session_id = newValue;
      return this._session_id;
   }
   function getsession_id()
   {
      return this._session_id;
   }
   function setuser_guid(newValue)
   {
      this._user_guid = newValue;
      return this._user_guid;
   }
   function getuser_guid()
   {
      return this._user_guid;
   }
   function setcontainer_id(newValue)
   {
      if(this.checkValid(newValue) == true)
      {
         this._container_id = newValue;
      }
      else if(this.checkValid(_level0.container_id) == true)
      {
         this._container_id = _level0.container_id;
      }
      else
      {
         this._container_id = "";
      }
   }
   function getcontainer_id()
   {
      return this._container_id;
   }
   function setsource_id(newValue)
   {
      if(this.checkValid(newValue) == true)
      {
         this._source_id = newValue;
      }
      else if(this.checkValid(_level0.source_id) == true)
      {
         this._source_id = _level0.source_id;
      }
      else
      {
         this._source_id = "PACT_CTAT";
      }
   }
   function getsource_id()
   {
      return this._source_id;
   }
   function setexternal_object_id(newValue)
   {
      if(this.checkValid(newValue) == true)
      {
         this._external_object_id = newValue;
      }
      else if(this.checkValid(_level0.external_object_id) == true)
      {
         this._external_object_id = _level0.external_object_id;
      }
      else
      {
         this._external_object_id = "";
      }
   }
   function getexternal_object_id()
   {
      return this._external_object_id;
   }
   function setclass_id(newValue)
   {
      if(this.checkValid(newValue) == true)
      {
         this._class_id = newValue;
      }
      else if(this.checkValid(_level0.class_id) == true)
      {
         this._class_id = _level0.class_id;
      }
      else
      {
         this._class_id = "";
      }
   }
   function getclass_id()
   {
      return this._class_id;
   }
   function settreatment_id(newValue)
   {
      if(this.checkValid(newValue) == true)
      {
         this._treatment_id = newValue;
      }
      else if(this.checkValid(_level0.treatment_id) == true)
      {
         this._treatment_id = _level0.treatment_id;
      }
      else
      {
         this._treatment_id = "";
      }
   }
   function gettreatment_id()
   {
      return this._treatment_id;
   }
   function setassignment_id(newValue)
   {
      if(this.checkValid(newValue) == true)
      {
         this._assignment_id = newValue;
      }
      else if(this.checkValid(_level0.assignment_id) == true)
      {
         this._assignment_id = _level0.assignment_id;
      }
      else
      {
         this._assignment_id = "";
      }
   }
   function getassignment_id()
   {
      return this._assignment_id;
   }
   function setinfo_type(newValue)
   {
      if(this.checkValid(newValue) == true)
      {
         this._info_type = newValue;
      }
      else if(this.checkValid(_level0.info_type) == true)
      {
         this._info_type = _level0.info_type;
      }
      else
      {
         this._info_type = "tutor_message.dtd";
      }
   }
   function getinfo_type()
   {
      return this._info_type;
   }
   function checkValid(aVaraible)
   {
      if(aVaraible == null || aVaraible == undefined || aVaraible == "")
      {
         return false;
      }
      return true;
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
   function printArray(theArray, cSource)
   {
      var _loc1_ = 0;
      while(_loc1_ < theArray.length)
      {
         trace(cSource + ": idx = " + _loc1_ + " theArray[" + _loc1_ + "] = " + theArray[_loc1_]);
         _loc1_ = _loc1_ + 1;
      }
   }
}
