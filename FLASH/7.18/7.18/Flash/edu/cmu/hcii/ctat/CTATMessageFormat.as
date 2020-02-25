class edu.cmu.hcii.ctat.CTATMessageFormat extends edu.cmu.hcii.ctat.CTATUtil
{
   function CTATMessageFormat()
   {
      super();
      this.setClassType("CTATMessageFormat");
      this.debug("CTATMessageFormat ()");
   }
   static function makeHintMessage(sAppropriateHintFocus, theTransactionID)
   {
      var _loc1_ = "<message>";
      _loc1_ = _loc1_ + "<verb>NotePropertySet</verb>";
      _loc1_ = _loc1_ + "<properties>";
      _loc1_ = _loc1_ + "<MessageType>InterfaceAction</MessageType>";
      _loc1_ = _loc1_ + "<Selection><value>";
      _loc1_ = _loc1_ + "hint";
      _loc1_ = _loc1_ + "</value>";
      _loc1_ = _loc1_ + "<value>";
      _loc1_ = _loc1_ + sAppropriateHintFocus;
      _loc1_ = _loc1_ + "</value>";
      _loc1_ = _loc1_ + "</Selection>";
      _loc1_ = _loc1_ + "<Action>";
      _loc1_ = _loc1_ + "<value>ButtonPressed</value><value>PreviousFocus</value>";
      _loc1_ = _loc1_ + "</Action>";
      _loc1_ = _loc1_ + "<Input>";
      _loc1_ = _loc1_ + "<value>-1</value>";
      _loc1_ = _loc1_ + "</Input>";
      _loc1_ = _loc1_ + ("<transaction_id>" + theTransactionID + "</transaction_id>");
      _loc1_ = _loc1_ + "</properties></message>";
      return _loc1_;
   }
   static function makeInteractionMessage(selectionValue, actionValue, inputValue, theTransactionID)
   {
      var _loc1_ = "<message>";
      _loc1_ = _loc1_ + "<verb>NotePropertySet</verb>";
      _loc1_ = _loc1_ + "<properties>";
      _loc1_ = _loc1_ + "<MessageType>InterfaceAction</MessageType>";
      _loc1_ = _loc1_ + ("<transaction_id>" + theTransactionID + "</transaction_id>");
      _loc1_ = _loc1_ + ("<Selection><value>" + selectionValue + "</value></Selection>");
      _loc1_ = _loc1_ + ("<Action><value>" + actionValue + "</value></Action>");
      _loc1_ = _loc1_ + ("<Input><value>" + edu.cmu.hcii.ctat.CTATUtil.escapeXML(inputValue) + "</value></Input>");
      _loc1_ = _loc1_ + "</properties>";
      _loc1_ = _loc1_ + "</message>";
      return _loc1_;
   }
   static function makeInterfaceIdentificationMessage(theInterfaceIdentifcationGUID)
   {
      var _loc1_ = "<message>";
      _loc1_ = _loc1_ + "<verb>NotePropertySet</verb>";
      _loc1_ = _loc1_ + "<properties>";
      _loc1_ = _loc1_ + "<MessageType>InterfaceIdentification</MessageType>";
      _loc1_ = _loc1_ + ("<Guid>" + theInterfaceIdentifcationGUID + "</Guid>");
      _loc1_ = _loc1_ + "</properties>";
      _loc1_ = _loc1_ + "</message>";
      return _loc1_;
   }
   static function makeLoadProblemMessage(aBRDFileName)
   {
      var _loc1_ = "<message>";
      _loc1_ = _loc1_ + "<verb>NotePropertySet</verb>";
      _loc1_ = _loc1_ + "<properties>";
      _loc1_ = _loc1_ + "<MessageType>LoadProblem</MessageType>";
      _loc1_ = _loc1_ + ("<ProblemName>" + aBRDFileName + "</ProblemName>");
      _loc1_ = _loc1_ + "</properties>";
      _loc1_ = _loc1_ + "</message>";
      return _loc1_;
   }
   static function makeSetPreferencesMessage(aBRDFileName, aSkillArray)
   {
      var preferencesArray = new Array("log_service_url","log_to_remote_server","log_to_disk","log_to_disk_directory","cognitive_model_folder","user_guid","problem_name","problem_context","problem_tutorflag","problem_otherproblemflag","question_file","class_name","school_name","period_name","class_description","instructor_name","session_id","auth_token","source_id","container_id","external_object_id");
      var log_service_url;
      var log_to_remote_server;
      var log_to_disk;
      var log_to_disk_directory;
      var user_guid;
      var course_name;
      var dataset_name;
      var study_condition_name;
      var study_condition_type;
      var study_condition_description;
      var problem_name;
      var problem_context;
      var problem_tutorflag;
      var question_file;
      var class_name;
      var school_name;
      var period_name;
      var class_description;
      var instructor_name;
      var session_id;
      var auth_token;
      var source_id;
      var cognitive_model_folder;
      var xmlStringToSend = "<message>";
      xmlStringToSend = xmlStringToSend + "<verb>NotePropertySet</verb>";
      xmlStringToSend = xmlStringToSend + "<properties>";
      xmlStringToSend = xmlStringToSend + "<MessageType>SetPreferences</MessageType>";
      var prefName;
      var prefValue;
      var i = 0;
      while(i < preferencesArray.length)
      {
         prefName = preferencesArray[i];
         prefValue = eval("_level0." + prefName);
         if(prefValue.length > 0 && edu.cmu.hcii.ctat.CTATUtil.checkValid(prefValue) == true)
         {
            xmlStringToSend = xmlStringToSend + ("<" + prefName + ">" + prefValue + "</" + prefName + ">");
         }
         i++;
      }
      prefName = "dataset_name";
      prefValue = eval("_level0." + prefName);
      if(prefValue.length < 1 || edu.cmu.hcii.ctat.CTATUtil.checkValid(prefValue) == false)
      {
         prefName = "course_name";
         prefValue = eval("_level0." + prefName);
      }
      if(prefValue.length > 0 && edu.cmu.hcii.ctat.CTATUtil.checkValid(prefValue) == true)
      {
         xmlStringToSend = xmlStringToSend + ("<dataset_name>" + prefValue + "</dataset_name>");
      }
      var studyConditionName;
      var studyConditionType;
      var studyConditionDescription;
      var jdx = 1;
      while(jdx < 10)
      {
         studyConditionName = eval("_level0.study_condition_name" + jdx);
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(studyConditionName) == true)
         {
            studyConditionType = eval("_level0.study_condition_type" + jdx);
            studyConditionDescription = eval("_level0.study_condition_description" + jdx);
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(studyConditionName) == true)
            {
               xmlStringToSend = xmlStringToSend + ("<study_condition_name" + jdx + ">" + studyConditionName + "</study_condition_name" + jdx + ">");
            }
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(studyConditionType) == true)
            {
               xmlStringToSend = xmlStringToSend + ("<study_condition_type" + jdx + ">" + studyConditionType + "</study_condition_type" + jdx + ">");
            }
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(studyConditionDescription) == true)
            {
               xmlStringToSend = xmlStringToSend + ("<study_condition_description" + jdx + ">" + studyConditionDescription + "</study_condition_description" + jdx + ">");
            }
         }
         jdx++;
      }
      var datasetLeveName;
      var datasetLeveType;
      var jdx = 1;
      while(jdx < 10)
      {
         datasetLeveName = eval("_level0.dataset_level_name" + jdx);
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(datasetLeveName) == true)
         {
            datasetLeveType = eval("_level0.dataset_level_type" + jdx);
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(datasetLeveName) == true)
            {
               xmlStringToSend = xmlStringToSend + ("<dataset_level_name" + jdx + ">" + datasetLeveName + "</dataset_level_name" + jdx + ">");
            }
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(datasetLeveType) == true)
            {
               xmlStringToSend = xmlStringToSend + ("<dataset_level_type" + jdx + ">" + datasetLeveType + "</dataset_level_type" + jdx + ">");
            }
         }
         jdx++;
      }
      var customFieldName;
      var customFieldValue;
      var jdx = 1;
      while(jdx < 10)
      {
         customFieldName = eval("_level0.custom_field_name" + jdx);
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(customFieldName) == true)
         {
            customFieldValue = eval("_level0.custom_field_value" + jdx);
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(customFieldName) == true)
            {
               xmlStringToSend = xmlStringToSend + ("<custom_field_name" + jdx + ">" + customFieldName + "</custom_field_name" + jdx + ">");
            }
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(customFieldValue) == true)
            {
               xmlStringToSend = xmlStringToSend + ("<custom_field_value" + jdx + ">" + customFieldValue + "</custom_field_value" + jdx + ">");
            }
         }
         jdx++;
      }
      if(aSkillArray != null && aSkillArray != undefined)
      {
         trace("Using the following skills string: " + aSkillArray);
         xmlStringToSend = xmlStringToSend + aSkillArray;
      }
      if(aBRDFileName != null && aBRDFileName != undefined)
      {
         xmlStringToSend = xmlStringToSend + ("<ProblemName>" + aBRDFileName + "</ProblemName>");
      }
      xmlStringToSend = xmlStringToSend + ("<CommShellVersion>" + _global.theShell.version + "</CommShellVersion>");
      xmlStringToSend = xmlStringToSend + "</properties>";
      xmlStringToSend = xmlStringToSend + "</message>";
      return xmlStringToSend;
   }
   static function makeInterfaceDescriptionMessage(componentName, componentType, defTemplateType, valueString, slots)
   {
      var _loc2_ = "<message>";
      _loc2_ = _loc2_ + "<verb>SendNoteProperty</verb>";
      _loc2_ = _loc2_ + "<properties>";
      _loc2_ = _loc2_ + "<MessageType>InterfaceDescription</MessageType>";
      _loc2_ = _loc2_ + ("<WidgetType>" + componentType + "</WidgetType>");
      _loc2_ = _loc2_ + ("<DorminName>" + edu.cmu.hcii.ctat.CTATUtil.escapeXML(componentName) + "</DorminName>");
      _loc2_ = _loc2_ + "<UpdateEachCycle>false</UpdateEachCycle>";
      _loc2_ = _loc2_ + "<jessDeftemplates>";
      _loc2_ = _loc2_ + ("<value>(deftemplate " + defTemplateType + " (slot name)");
      var _loc1_ = 0;
      while(_loc1_ < slots.length)
      {
         _loc2_ = _loc2_ + (" (slot " + slots[_loc1_] + ")");
         _loc1_ = _loc1_ + 1;
      }
      _loc2_ = _loc2_ + ")</value>";
      _loc2_ = _loc2_ + "</jessDeftemplates>";
      _loc2_ = _loc2_ + "<jessInstances>";
      _loc2_ = _loc2_ + ("<value>(assert (" + defTemplateType + " (name " + edu.cmu.hcii.ctat.CTATUtil.escapeXML(componentName) + ")" + " (value \"" + edu.cmu.hcii.ctat.CTATUtil.escapeXML(valueString) + "\" )))</value>");
      _loc2_ = _loc2_ + "</jessInstances>";
      _loc2_ = _loc2_ + "</properties>";
      _loc2_ = _loc2_ + "</message>";
      return _loc2_;
   }
   static function makeUntutoredActionMessage(selectionValue, actionValue, inputValue, theTransactionID)
   {
      var _loc1_ = "<message>";
      _loc1_ = _loc1_ + "<verb>NotePropertySet</verb>";
      _loc1_ = _loc1_ + "<properties>";
      _loc1_ = _loc1_ + "<MessageType>UntutoredAction</MessageType>";
      _loc1_ = _loc1_ + ("<transaction_id>" + theTransactionID + "</transaction_id>");
      _loc1_ = _loc1_ + ("<Selection><value>" + selectionValue + "</value></Selection>");
      _loc1_ = _loc1_ + ("<Action><value>" + actionValue + "</value></Action>");
      _loc1_ = _loc1_ + ("<Input><value>" + edu.cmu.hcii.ctat.CTATUtil.escapeXML(inputValue) + "</value></Input>");
      _loc1_ = _loc1_ + "</properties>";
      _loc1_ = _loc1_ + "</message>";
      return _loc1_;
   }
   static function makeInterfaceActionMessage(selectionValues, actionValues, inputValues, theTransactionID)
   {
      var _loc1_ = "<message>";
      _loc1_ = _loc1_ + "<verb>NotePropertySet</verb><properties>";
      _loc1_ = _loc1_ + ("<MessageType>InterfaceAction</MessageType><transaction_id>" + theTransactionID + "</transaction_id>");
      for(var _loc4_ in selectionValues)
      {
         _loc1_ = _loc1_ + ("<Selection><value>" + String(selectionValues[_loc4_]) + "</value></Selection><Action><value>" + String(actionValues[_loc4_]) + "</value></Action><Input><value>" + edu.cmu.hcii.ctat.CTATUtil.escapeXML(String(inputValues[_loc4_])) + "</value></Input>");
         trace("3. " + _loc1_);
      }
      _loc1_ = _loc1_ + "</properties></message>";
      return _loc1_;
   }
   static function makeUntutoredActionMessageA(selectionValues, actionValues, inputValues, theTransactionID)
   {
      var _loc2_ = "<message>";
      _loc2_ = _loc2_ + "<verb>NotePropertySet</verb><properties>";
      _loc2_ = _loc2_ + ("<MessageType>UntutoredAction</MessageType><transaction_id>" + theTransactionID + "</transaction_id>");
      for(var _loc4_ in selectionValues)
      {
         _loc2_ = _loc2_ + ("<Selection><value>" + String(selectionValues[_loc4_]) + "</value></Selection><Action><value>" + String(actionValues[_loc4_]) + "</value></Action><Input><value>" + edu.cmu.hcii.ctat.CTATUtil.escapeXML(String(inputValues[_loc4_])) + "</value></Input>");
      }
      _loc2_ = _loc2_ + "</properties></message>";
      return _loc2_;
   }
}
