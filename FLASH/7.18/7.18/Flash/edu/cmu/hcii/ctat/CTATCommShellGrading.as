class edu.cmu.hcii.ctat.CTATCommShellGrading extends edu.cmu.hcii.ctat.CTATCommShellLogging
{
   static var symbolName = "CTATCommShellGrading";
   static var symbolOwner = Object(edu.cmu.hcii.ctat.CTATCommShellGrading);
   var className = "CTATCommShellGrading";
   var ParentClassName = "CTATCommShellLogging";
   function CTATCommShellGrading()
   {
      super();
   }
   function init()
   {
      super.init();
      this.setClassType("CTATCommShellGrading");
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
}
