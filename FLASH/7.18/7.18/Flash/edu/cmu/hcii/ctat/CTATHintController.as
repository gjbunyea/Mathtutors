class edu.cmu.hcii.ctat.CTATHintController extends edu.cmu.hcii.ctat.CTATBase
{
   var widget = null;
   var y_scroll = 0;
   var index = -1;
   var instantiated = false;
   var scrollable = false;
   var vPosA = 0;
   var vPosB = 0;
   function CTATHintController()
   {
      super();
      this.setClassType("CTATHintController");
      this.debug("CTATHintController ()");
   }
}
