class edu.cmu.hcii.ctat.CTATScrimInfo extends edu.cmu.hcii.ctat.CTATMovieClipBase
{
   function CTATScrimInfo()
   {
      super();
      this.setClassType("CTATScrimInfo");
      this.debug("CTATScrimInfo ()");
   }
   function setText(a_message)
   {
      this.debug("setText (" + a_message + ")");
      if(this.infotext == undefined)
      {
         this.debug("Internal error: textinfo field is undefined");
      }
      if(this.infotext == null)
      {
         this.debug("Internal error: textino field is null");
      }
      this.infotext.text = a_message;
   }
}
