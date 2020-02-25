class edu.cmu.hcii.ctat.CTATIndicator extends edu.cmu.hcii.ctat.CTATMovieClipBase
{
   function CTATIndicator()
   {
      super();
      this.setClassType("CTATIndicator");
      this.debug("CTATIndicator ()");
   }
   function draw()
   {
      this.lineStyle(1,13421772,100);
      this.moveTo(0,0);
      this.lineTo(0,this._height);
      this.lineTo(this._width,this._height);
      this.lineTo(this._width,0);
      this.lineTo(0,0);
   }
   function place(a_x, a_y, a_width, a_height)
   {
      this._x = a_x;
      this._y = a_y;
      this._width = a_width;
      this._height = a_height;
      this.invalidate();
   }
}
