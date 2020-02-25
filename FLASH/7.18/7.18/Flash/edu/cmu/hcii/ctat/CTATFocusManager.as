class edu.cmu.hcii.ctat.CTATFocusManager extends edu.cmu.hcii.ctat.CTATBase
{
   function CTATFocusManager()
   {
      super();
      this.setClassType("CTATFocusManager");
      this.debug("CTATFocusManager ()");
   }
   function restoreFocus()
   {
      this.debug("restoreFocus ()");
      if(_global.theShell.getLastFocus() != null)
      {
         this.debug("Restoring focus ...");
         Selection.setFocus(_global.theShell.getLastFocus());
      }
      else
      {
         this.debug("Error: none of the components currently has focus");
      }
   }
}
