class edu.cmu.hcii.ctat.CTATAS2Processor extends edu.cmu.hcii.ctat.CTATBase
{
   function CTATAS2Processor()
   {
      super();
      this.setClassType("CTATAS2Processor");
      this.debug("CTATAS2Processor ()");
   }
   function isTutorPerformedAction(brAction)
   {
      this.debug("isTutorPerformedAction ()");
      var _loc3_ = false;
      var _loc2_ = new Array("SetVisible","SetText","LockWidget","SetLabel","GotoAndStop","LoadMovie","MoveCompoent","RemoveComponent","SetParameter");
      for(var _loc5_ in _loc2_)
      {
         if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(brAction,_loc2_[_loc5_]) == true)
         {
            _loc3_ = true;
         }
      }
      return _loc3_;
   }
   function handleTutorPerformedAction(brTransaction_id, brSelection, brAction, brInput, Evaluation, brSuccessMessage, arEdgeSkills, brMessageType)
   {
      this.debug("handleTutorPerformedAction ()");
      var _loc2_ = "_root";
      if(brSelection != "_level0")
      {
         _loc2_ = brSelection;
      }
      switch(brAction.toLowerCase())
      {
         case "SetVisible".toLowerCase():
            this.handleSetVisibleTPA(_loc2_,brInput);
            break;
         case "SetText".toLowerCase():
            this.handleSetTextTPA(_loc2_,brInput);
            break;
         case "LockWidget".toLowerCase():
            this.handleLockWidgetTPA(_loc2_,brInput);
            break;
         case "UnlockWidget".toLowerCase():
            this.handleUnlockWidgetTPA(_loc2_,brInput);
            break;
         case "SetLabel".toLowerCase():
            this.handleSetLabelTPA(_loc2_,brInput);
            break;
         case "GotoAndStop".toLowerCase():
            this.handleGotoAndStopTPA(_loc2_,brInput);
            break;
         case "GotoAndPlay".toLowerCase():
            this.handleGotoAndPlayTPA(_loc2_,brInput);
            break;
         case "LoadMovie".toLowerCase():
            this.handleLoadMovieTPA(_loc2_,brInput);
            break;
         case "MoveComponent".toLowerCase():
            this.handleMoveComponentTPA(_loc2_,brInput);
            break;
         case "RemoveComponent".toLowerCase():
            this.handleRemoveComponentTPA(_loc2_,brInput);
            break;
         case "SetParameter".toLowerCase():
            this.handleSetParameterTPA(_loc2_,brInput);
      }
   }
   function handleSetVisibleTPA(brSelection, brInput)
   {
      this.debug("handleSetVisibleTPA ()");
      this.debug("Recieved SetVisible Tutor Performed Action brSelection = " + brSelection + " brInput = " + brInput);
      eval(brSelection)._visible = edu.cmu.hcii.ctat.CTATUtil.convertStringToBoolean(String(brInput));
      eval(brSelection).setVisible(edu.cmu.hcii.ctat.CTATUtil.convertStringToBoolean(String(brInput)));
      _global.theShell.dispatchSetVisibleTPA(brSelection,brInput);
   }
   function handleSetTextTPA(brSelection, brInput)
   {
      this.debug("handleSetTextTPA ()");
      this.debug("Recieved SetText Tutor Performed Action brSelection = " + brSelection + " brInput = " + brInput);
      if(eval(brSelection).commType != "textArea" && eval(brSelection).commType != "textInput")
      {
         this.debug("EXCEPTION : SetText tutor-peforemd action : the selection is not a text input or text area : the function will probably not do anything : brSelection = " + brSelection);
      }
      eval(brSelection).setText(brInput);
      _global.theShell.dispatchSetTextTPA(brSelection,brInput);
   }
   function handleLockWidgetTPA(brSelection, brInput)
   {
      this.debug("handleLockWidgetTPA ()");
      this.debug("Recieved LockWidget Tutor Performed Action brSelection = " + brSelection + " brInput = " + brInput);
      eval(brSelection).lock();
      _global.theShell.dispatchLockWidgetTPA(brSelection,brInput);
   }
   function handleUnlockWidgetTPA(brSelection, brInput)
   {
      this.debug("handleUnlockWidgetTPA ()");
      this.debug("Recieved UnlockWidget Tutor Performed Action brSelection = " + brSelection + " brInput = " + brInput);
      eval(brSelection).unlock();
      _global.theShell.dispatchUnlockWidgetTPA(brSelection,brInput);
   }
   function handleSetLabelTPA(brSelection, brInput)
   {
      this.debug("handleSetLabelTPA ()");
      this.debug("Recieved SetLabel Tutor Performed Action :  this emits an event SetLabelTPA");
      _global.theShell.dispatchSetLabelTPA(brSelection,brInput);
   }
   function handleGotoAndPlayTPA(brSelection, brInput)
   {
      this.debug("handleGotoAndPlayTPA ()");
      this.debug("Recieved SetText Tutor Performed Action brSelection = " + brSelection + " brInput = " + brInput);
      if(this.isaNumber(brInput) == false)
      {
         this.debug("EXCEPTION : gotoAndPlay tutor-peforemd action : the input is not a number : the function will probably not work : brInput = " + brInput);
      }
      eval(brSelection).gotoAndPlay(Number(brInput));
      _global.theShell.dispatchGotoAndPlayTPA(brSelection,brInput);
   }
   function handleGotoAndStopTPA(brSelection, brInput)
   {
      this.debug("handleGotoAndStopTPA ()");
      this.debug("Recieved SetText Tutor Performed Action brSelection = " + brSelection + " brInput = " + brInput);
      if(this.isaNumber(brInput) == false)
      {
         this.debug("EXCEPTION : gotoAndStop tutor-peforemd action : the input is not a number : the function will probably not work : brInput = " + brInput);
      }
      eval(brSelection).gotoAndStop(Number(brInput));
      _global.theShell.dispatchGotoAndStopTPA(brSelection,brInput);
   }
   function isaNumber(sValue)
   {
      this.debug("isaNumber ()");
      var _loc2_ = new pact.utils.RegExp("^([.0-9](E|\\)?[0-9]?","i");
      this.debug("isaNumber : myRE.test(" + sValue + ") = " + _loc2_.test(sValue) + "  t=" + getTimer() / 1000);
      return _loc2_.test(sValue);
   }
   function handleLoadMovieTPA(brSelection, brInput)
   {
      this.debug("handleLoadMovieTPA ()");
      this.debug("Recieved LoadMovie Tutor Performed Action : this emits an event LoadMovieTPA");
      _global.theShell.dispatchLoadMovieTPA(brSelection,brInput);
   }
   function handleMoveComponentTPA(brSelection, brInput)
   {
      this.debug("handleMoveComponentTPA ()");
      this.debug("Recieved MoveCompoent Tutor Performed Action : this doesn\'t do anything yet");
      _global.theShell.dispatchMoveComponentTPA(brSelection,brInput);
   }
   function handleRemoveComponentTPA(brSelection, brInput)
   {
      this.debug("handleRemoveComponentTPA ()");
      this.debug("Received RemoveComponent Tutor Performed Action : this doesn\'t do anything yet");
      _global.theShell.dispatchRemoveComponentTPA(brSelection,brInput);
   }
   function handleSetParameterTPA(brSelection, brInput)
   {
      this.debug("handleSetParameterTPA ()");
      this.debug("Received SetParameter Tutor Performed Action : this doesn\'t do anything yet");
      _global.theShell.dispatchSetParameterTPA(brSelection,brInput);
   }
   function logTutorPerformedToolMsg(brTransaction_id, brSelection, brAction, brInput)
   {
      this.debug("logTutorPerformedToolMsg ()");
      var _loc5_ = "DATA";
      var _loc4_ = "tutor-performed";
      var _loc3_ = "ATTEMPT";
      _global.theShell.toolLogAttemptFull(brTransaction_id,brSelection,brAction,brInput,_loc5_,_loc4_,_loc3_);
   }
}
