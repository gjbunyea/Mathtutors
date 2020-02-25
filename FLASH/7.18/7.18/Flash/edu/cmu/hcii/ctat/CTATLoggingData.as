class edu.cmu.hcii.ctat.CTATLoggingData extends edu.cmu.hcii.ctat.CTATBase
{
   function CTATLoggingData()
   {
      super();
      this.setClassType("CTATLoggingData");
      this.debug("CTATLoggingData()");
   }
   function checkValid(aVaraible)
   {
      if(aVaraible == null || aVaraible == undefined || aVaraible == "")
      {
         return false;
      }
      return true;
   }
   function getDefaultDataObj(theDataObj)
   {
      this.debug("CommShell.LoggingData Class : getDefaultDataObj : ");
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.log_service_url) == true)
      {
         theDataObj.setlog_service_url(_level0.log_service_url);
      }
      else
      {
         theDataObj.setlog_service_url("http://pslc-qa.andrew.cmu.edu/log/server");
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.question_file) == true)
      {
         theDataObj.setquestion_file(_level0.question_file);
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.media_file) == true)
      {
         theDataObj.setquestion_file(_level0.media_file);
      }
      else
      {
         theDataObj.setquestion_file("theDefaultaQustion_file.brd");
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.media_file) == true)
      {
         theDataObj.setmedia_file(_level0.media_file);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.problem_name) == true)
      {
         theDataObj.setproblem_name(_level0.problem_name);
      }
      else
      {
         theDataObj.setproblem_name(theDataObj.getquestion_file());
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.problem_context) == true)
      {
         theDataObj.setproblem_context(_level0.problem_context);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.problem_tutorflag) == true)
      {
         theDataObj.setproblem_tutorflag(_level0.problem_tutorflag);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.problem_tutorflag) == true)
      {
         theDataObj.setproblem_tutorflag(_level0.problem_tutorflag);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.problem_otherproblemflag) == true)
      {
         theDataObj.setproblem_otherproblemflag(_level0.problem_otherproblemflag);
      }
      var aCustom_field_obj = new Object();
      aCustom_field_obj.name = new Array();
      aCustom_field_obj.value = new Array();
      var customFieldName;
      var customFieldValue;
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.custom_field_name) == true)
      {
         aCustom_field_obj.name.push(_level0.custom_field_name);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.custom_field_value) == true)
      {
         aCustom_field_obj.value.push(_level0.custom_field_value);
      }
      var jdx = 1;
      while(jdx < 10)
      {
         customFieldName = eval("_level0.custom_field_name" + jdx);
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(customFieldName) == true)
         {
            customFieldValue = eval("_level0.custom_field_value" + jdx);
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(customFieldName) == true)
            {
               aCustom_field_obj.name.push(customFieldName);
            }
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(customFieldValue) == true)
            {
               aCustom_field_obj.value.push(customFieldValue);
            }
            this.debug("LoggingData : customFieldName = " + customFieldName + " customFieldValue = " + customFieldValue);
         }
         jdx++;
      }
      var aCustom_field_objSerName = aCustom_field_obj.name.join();
      var aCustom_field_objSerValue = aCustom_field_obj.value.join();
      theDataObj.setcustom_field_obj(aCustom_field_objSerName,aCustom_field_objSerValue);
      this.debug("LoggingData : getDefaultDataObj :  aCustom_field_obj : name[0] = " + aCustom_field_obj.name[0] + " value[0] = " + aCustom_field_obj.value[0] + " theDataObj name[0] = " + theDataObj.getcustom_field_obj().name[0] + " aCustom_field_objSerName = " + aCustom_field_objSerName + " aCustom_field_objSerValue = " + aCustom_field_objSerValue);
      var prefName = "dataset_name";
      var prefValue = eval("_level0." + prefName);
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(prefValue) == true)
      {
         theDataObj.setdataset_name(prefValue);
      }
      else if(edu.cmu.hcii.ctat.CTATUtil.checkValid(prefValue) == false)
      {
         prefName = "course_name";
         prefValue = eval("_level0." + prefName);
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(prefValue) == true)
         {
            theDataObj.setdataset_name(prefValue);
         }
      }
      var aDataset_level_obj = new Object();
      aDataset_level_obj.type = new Array();
      aDataset_level_obj.name = new Array();
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.unit_name) == true)
      {
         aDataset_level_obj.type.push("unit");
         aDataset_level_obj.name.push(_level0.unit_name);
         this.debug("Dataset Levels :  _level0.unit_name = " + _level0.unit_name + "  aDataset_level_obj.name[0] = " + aDataset_level_obj.name[0]);
      }
      else
      {
         this.debug("Dataset Levels : not valid ");
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.section_name) == true)
      {
         aDataset_level_obj.type.push("section");
         aDataset_level_obj.name.push(_level0.section_name);
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
               aDataset_level_obj.name.push(datasetLeveName);
            }
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(datasetLeveType) == true)
            {
               aDataset_level_obj.type.push(datasetLeveType);
            }
            this.debug("newPRoblem : datasetLeveName = " + datasetLeveName + " datasetLeveType = " + datasetLeveType);
         }
         jdx++;
      }
      var aDataset_level_objSerName = aDataset_level_obj.name.join();
      var aDataset_level_objSerType = aDataset_level_obj.type.join();
      theDataObj.setdataset_level_obj(aDataset_level_objSerName,aDataset_level_objSerType);
      this.debug("2 getDefaultDataObj : aDataset_level_obj : name[0] = " + aDataset_level_obj.name[0] + "  type[0] = " + aDataset_level_obj.type[0] + " theDataObj name[0] = " + theDataObj.getdataset_level_obj().name[0]);
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.user_guid) == true)
      {
         theDataObj.setuser_guid(_level0.user_guid);
      }
      else
      {
         theDataObj.setuser_guid("theUserName");
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.class_name) == true)
      {
         theDataObj.setclass_name(_level0.class_name);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.school_name) == true)
      {
         theDataObj.setschool_name(_level0.school_name);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.period_name) == true)
      {
         theDataObj.setperiod_name(_level0.period_name);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.class_description) == true)
      {
         theDataObj.setclass_description(_level0.class_description);
      }
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.instructor_name) == true)
      {
         theDataObj.setinstructor_name(_level0.instructor_name);
      }
      var aStudy_condition_obj = new Object();
      aStudy_condition_obj.name = new Array();
      aStudy_condition_obj.type = new Array();
      aStudy_condition_obj.description = new Array();
      var studyConditionName;
      var studyConditionType;
      var studyConditionDescription;
      var jdx = 0;
      while(jdx < 10)
      {
         studyConditionName = eval("_level0.study_condition_name" + jdx);
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(studyConditionName) == true)
         {
            studyConditionType = eval("_level0.study_condition_type" + jdx);
            studyConditionDescription = eval("_level0.study_condition_description" + jdx);
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(studyConditionName) == true)
            {
               aStudy_condition_obj.name.push(studyConditionName);
            }
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(studyConditionType) == true)
            {
               aStudy_condition_obj.type.push(studyConditionType);
            }
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(studyConditionDescription) == true)
            {
               aStudy_condition_obj.description.push(studyConditionDescription);
            }
         }
         jdx++;
      }
      var aStudy_condition_objSerName = aStudy_condition_obj.name.join();
      var aStudy_condition_objSerType = aStudy_condition_obj.type.join();
      var aStudy_condition_objSerDescription = aStudy_condition_obj.description.join();
      theDataObj.setstudy_condition_obj(aStudy_condition_objSerName,aStudy_condition_objSerType,aStudy_condition_objSerDescription);
      return theDataObj;
   }
}
