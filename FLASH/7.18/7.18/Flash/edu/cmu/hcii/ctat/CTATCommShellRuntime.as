class edu.cmu.hcii.ctat.CTATCommShellRuntime extends edu.cmu.hcii.ctat.CTATCommShellGrading
{
   static var symbolName = "CTATCommShellRuntime";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATCommShellRuntime);
   var className = "CTATCommShellRuntime";
   var ParentClassName = "CTATCommShellGrading";
   function CTATCommShellRuntime()
   {
      super();
   }
   function init()
   {
      super.init();
      this.setClassType("CTATCommShellRuntime");
      this.debug("init ()");
   }
   function draw()
   {
      super.draw();
      this.debug("draw ()");
   }
   function size()
   {
      super.size();
      this.debug("size ()");
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
   }
   function setInitialBRDFileName()
   {
      this.debug("setInitialBRDFileName ()");
      try
      {
         if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.question_file) == false && edu.cmu.hcii.ctat.CTATUtil.checkValid(this.__get__BRDFileName()) == false)
         {
            throw new Error("The question file is undefined or not valid.  Check flashvars or the \'BRD File Name\' property in the CommShell");
         }
         else
         {
            if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.question_file) == true)
            {
               if(edu.cmu.hcii.ctat.CTATUtil.checkValid(_level0.problem_name) == true)
               {
                  this.createProblemList(_level0.question_file,_level0.problem_name);
               }
               else
               {
                  this.createProblemList(_level0.question_file,_level0.question_file);
               }
            }
            else
            {
               this.createProblemList(this.__get__BRDFileName(),this.__get__BRDFileName());
            }
            this.setTheCurrentBRDindex(0);
            this.__set__BRDFileName(this.getBRDFileName(this.getTheBRDFiles(),this.getTheCurrentBRDindex()));
            this.setQuestionFile(this.getBRDFileName(this.getTheBRDFiles(),this.getTheCurrentBRDindex()));
            this.setProblemName(this.getProblemName(this.getTheProblemNames(),this.getTheCurrentBRDindex()));
         }
      }
      catch(myError:Error)
      {
         this.debug("EXCEPTION : " + myError);
      }
   }
   function createProblemList(fileList, problemList)
   {
      this.debug("createProblemList ()");
      var _loc4_ = fileList.split(":");
      var _loc6_ = problemList.split(":");
      var _loc8_ = new Array();
      var _loc11_ = new Array();
      edu.cmu.hcii.ctat.CTATUtil.printArray(_loc4_,"createFileList : Before");
      edu.cmu.hcii.ctat.CTATUtil.printArray(_loc6_,"createProblemList : Before");
      if(this.getRepetitionOrder() == "Random")
      {
         var _loc3_ = new Array();
         var _loc7_ = undefined;
         var _loc5_ = undefined;
         var _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc7_ = _loc4_[_loc2_];
            if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(_loc6_[_loc2_]) == true)
            {
               _loc5_ = _loc6_[_loc2_];
            }
            else
            {
               _loc5_ = _loc4_[_loc2_];
            }
            _loc3_.push({file:_loc7_,problem:_loc5_});
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = edu.cmu.hcii.ctat.CTATUtil.randomizeStringArray(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc8_.push(_loc3_[_loc2_].file);
            _loc11_.push(_loc3_[_loc2_].problem);
            _loc2_ = _loc2_ + 1;
         }
      }
      else
      {
         _loc8_ = _loc4_;
         _loc11_ = _loc6_;
      }
      edu.cmu.hcii.ctat.CTATUtil.printArray(_loc8_,"createFileList : After");
      edu.cmu.hcii.ctat.CTATUtil.printArray(_loc11_,"createProblemList : After");
      var _loc12_ = _loc8_.length;
      this.setTheBRDFiles(_loc8_);
      this.setTheRepetitionProblemLength(_loc12_);
      this.setTheProblemNames(_loc11_);
      this.debug("createProblemList  :  finfileListLength = " + _loc12_ + " getTheBRDFiles().toString() = " + this.getTheBRDFiles().toString());
   }
   function getRepetitionOrder()
   {
      this.debug("base class");
      return "";
   }
   function detectBRDExtension(sBRDFileName)
   {
      this.debug("detectBRDExtension ()");
      if(sBRDFileName.indexOf(".brd") == -1)
      {
         sBRDFileName = sBRDFileName + ".brd";
      }
      return sBRDFileName;
   }
   function setTheRepetitionProblemLength(theValue)
   {
      this.debug("setTheRepetitionProblemLength () : theValue = " + theValue);
      this.theRepetitionProblemLength = theValue;
   }
   function getTheRepetitionProblemLength()
   {
      return this.theRepetitionProblemLength;
   }
   function setTheProblemNames(arProblemNames)
   {
      this.debug("setTheProblemNames ()");
      this.theProblemNames = arProblemNames;
      this.debug("CommShellCode : setTheProblemNames :  theBRDFiles.length = " + this.theBRDFiles.length + " arProblemNames = " + arProblemNames.toString());
      var _loc2_ = 0;
      while(_loc2_ < this.theBRDFiles.length)
      {
         if(this.theProblemNames[_loc2_] == undefined)
         {
            this.theProblemNames.push(edu.cmu.hcii.ctat.CTATUtil.stripExtension(this.theBRDFiles[_loc2_]));
            this.debug("CommShellCode : setTheProblemNames : theProblemNames[" + _loc2_ + "] = " + this.theProblemNames[_loc2_] + " theBRDFiles[" + _loc2_ + "] = " + this.theBRDFiles[_loc2_]);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function getTheProblemNames()
   {
      return this.theProblemNames;
   }
   function getAllFilesComplete()
   {
      return undefined;
   }
   function buildModelProgressEvent1a(success)
   {
      this.debug("buildModelProgressEvent1a ()");
      this.debug("T = " + getTimer() / 1000);
      if(success)
      {
         this.buildEventIntervalIDa = setInterval(this,"buildModelProgressEvent2",100);
      }
   }
   function buildModelProgressEvent1b(success)
   {
      this.debug("buildModelProgressEvent1b ()");
      this.debug("T = " + getTimer() / 1000);
      if(success)
      {
         this.buildEventIntervalIDb = setInterval(this,"buildModelProgressEvent2a",100);
      }
   }
   function buildModelProgressEvent2b()
   {
      this.debug("buildModelProgressEvent2b ()");
      this.dispatchEvent({type:"onBrdBuilding",target:this});
   }
   function dispatchOnBrdParse()
   {
      this.debug("dispatchOnBrdParse ()");
      this.dispatchEvent({type:"onBrdParse",target:this});
   }
   function assignTheSkillArray(vBrdSkill)
   {
      this.debug("assignTheSkillArray ()");
      var _loc5_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < vBrdSkill.size())
      {
         var _loc3_ = vBrdSkill.elementAt(_loc2_);
         _loc5_[_loc2_] = _loc3_;
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   function setFirstCheckAllStates(theValue)
   {
      this._firstCheckAllStates = theValue;
   }
   function getFirstCheckAllStates()
   {
      return this._firstCheckAllStates;
   }
   function setCaseInsensitive(theValue)
   {
      this._caseInsensitive = theValue;
   }
   function getCaseInsensitive()
   {
      return this._caseInsensitive;
   }
   function setQuestionFile(sBRDFileName)
   {
      _level0.question_file = sBRDFileName;
   }
   function getQuestionFile()
   {
      return _level0.question_file;
   }
   function setProblemName(sBRDFileName)
   {
      this.debug("setProblemName ()");
      this.debug("sBRDFileName = " + sBRDFileName + "   _level0.problem_name = " + _level0.problem_name + "  sBRDFileName.length = " + sBRDFileName.length);
      _level0.problem_name = edu.cmu.hcii.ctat.CTATUtil.stripExtension(sBRDFileName);
   }
   function getProblemName(arTheProblemNames, nTheCurrentBRDindex)
   {
      if(arTheProblemNames.length <= nTheCurrentBRDindex)
      {
         return null;
      }
      return arTheProblemNames[nTheCurrentBRDindex];
   }
   function applyFeedbackForGradedComponnets(widget, correctStatus, selectionValue, actionValue, inputValue, theMessage, lockWidget)
   {
      this.debug("applyFeedbackForGradedComponnets ()");
      this.debug("correctStatus  = " + correctStatus + " selectionValue = " + selectionValue + " inputValue = " + inputValue + " theMessage = " + theMessage + " lockWidget = " + lockWidget);
      var _loc4_ = undefined;
      if(correctStatus == "Correct Action")
      {
         widget.setResults("Correct",selectionValue,actionValue,inputValue,"Correct",lockWidget);
         _loc4_ = true;
         if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(theMessage) == false || edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theMessage,"NA") || theMessage.substr(0,2) == "NA" && edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theMessage,"asfunction"))
         {
            this.debug("applyFeedbackForGradedComponnets : NO Feedback : close hint and feedback window. theMessage = " + theMessage);
            this.closeHintAndFeedbackWindows();
         }
         else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(theMessage) == true)
         {
            this.debug("applyFeedbackForGradedComponnets : show Feedback  theMessage = " + theMessage);
            this.Feedback(theMessage,true);
         }
      }
      else
      {
         _loc4_ = false;
         widget.setResults("Incorrect",selectionValue,actionValue,inputValue,"Incorrect",lockWidget);
         if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(theMessage) == false || edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(theMessage,"NA") || theMessage.substr(0,2) == "NA" && edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theMessage,"asfunction"))
         {
            this.debug("applyFeedbackForGradedComponnets : NO Feedback : close hint and feedback window. theMessage = " + theMessage);
            this.closeHintAndFeedbackWindows();
         }
         else if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(theMessage) == true)
         {
            this.debug("applyFeedbackForGradedComponnets : show Feedback  theMessage = " + theMessage);
            this.Feedback(theMessage,false);
         }
      }
      if(widget.commType == "radioButton")
      {
         var _loc10_ = _loc4_;
         this.showFeedbackForRadioButtons("_level0",widget.getGroupName(),widget,_loc10_);
      }
      if(widget.commType == "checkBox")
      {
         _loc10_ = _loc4_;
      }
      if(this.getUnorderedMode() == false)
      {
      }
   }
}
