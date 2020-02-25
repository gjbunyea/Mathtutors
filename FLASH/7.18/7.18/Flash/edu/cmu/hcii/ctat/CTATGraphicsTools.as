class edu.cmu.hcii.ctat.CTATGraphicsTools extends edu.cmu.hcii.ctat.CTATMovieClipBase
{
   var lineWidth = 1;
   var lineColor = 0;
   var fillColor = 15658734;
   var fillshape = true;
   var canvas = null;
   function CTATGraphicsTools(a_canvas)
   {
      super();
      this.setClassType("CTATGraphicsTools");
      this.debug("CTATGraphicsTools ()");
      this.setCanvas(a_canvas);
   }
   function setCanvas(a_canvas)
   {
      this.debug("setCanvas ()");
      if(a_canvas != undefined)
      {
         if(a_canvas != null)
         {
            this.canvas = a_canvas;
         }
         else
         {
            this.debug("Error: canvas is null");
         }
      }
      else
      {
         this.debug("Error: canvas is undefined");
      }
   }
   function getCanvas()
   {
      return this.canvas;
   }
   function magicTrigFunctionX(pointRatio)
   {
      return Math.cos(pointRatio * 2 * 3.141592653589793);
   }
   function magicTrigFunctionY(pointRatio)
   {
      return Math.sin(pointRatio * 2 * 3.141592653589793);
   }
   function onEnterframe()
   {
      this.debug("onEnterFrame ()");
      this.draw();
   }
   function reset()
   {
      if(this.canvas != null)
      {
         this.canvas.clear();
      }
   }
   function drawLine(x1, y1, x2, y2, c, w)
   {
      var _loc2_ = this;
      if(this.canvas != null)
      {
         _loc2_ = this.canvas;
      }
      else
      {
         this.debug("Error: canvas is NULL");
      }
      this.canvas.lineStyle(w,c,100);
      this.canvas.beginFill(c,0);
      this.canvas.moveTo(x1,y1);
      this.canvas.lineTo(x2,y2);
      this.canvas.endFill();
   }
   function drawCircle(centerX, centerY, radius, sides)
   {
      var _loc12_ = this;
      if(this.canvas != null)
      {
         _loc12_ = this.canvas;
      }
      else
      {
         this.debug("Error: canvas is NULL");
      }
      this.canvas.lineStyle(this.lineWidth,this.lineColor,100);
      this.canvas.beginFill(16777215,0);
      this.canvas.moveTo(centerX + radius,centerY);
      var _loc2_ = 0;
      while(_loc2_ <= sides)
      {
         var _loc3_ = _loc2_ / sides;
         var _loc6_ = this.magicTrigFunctionX(_loc3_);
         var _loc4_ = this.magicTrigFunctionY(_loc3_);
         var _loc7_ = centerX + _loc6_ * radius;
         var _loc5_ = centerY + _loc4_ * radius;
         this.canvas.lineTo(_loc7_,_loc5_);
         _loc2_ = _loc2_ + 1;
      }
      this.canvas.endFill();
   }
   function drawCircleFilled(centerX, centerY, radius, sides, target)
   {
      if(target == undefined || target == null)
      {
         target = this;
      }
      if(this.canvas != null && target != undefined)
      {
         target = this.canvas;
      }
      else
      {
         this.debug("Error: canvas is NULL");
      }
      this.canvas.lineStyle(this.lineWidth,this.lineColor,100);
      this.canvas.beginFill(this.fillColor,100);
      this.canvas.moveTo(centerX + radius,centerY);
      var _loc2_ = 0;
      while(_loc2_ <= sides)
      {
         var _loc3_ = _loc2_ / sides;
         var _loc6_ = this.magicTrigFunctionX(_loc3_);
         var _loc4_ = this.magicTrigFunctionY(_loc3_);
         var _loc7_ = centerX + _loc6_ * radius;
         var _loc5_ = centerY + _loc4_ * radius;
         this.canvas.lineTo(_loc7_,_loc5_);
         _loc2_ = _loc2_ + 1;
      }
      this.canvas.endFill();
   }
   function drawWedge(target, centerX, centerY, radius, bAngle, eAngle, wedgeSpacing)
   {
      var _loc17_ = 0.017453292519943295;
      bAngle = bAngle - 90;
      eAngle = eAngle - 90;
      var _loc19_ = radius * 2 * Math.sin(wedgeSpacing / 2 * _loc17_) / 2 / Math.sin((eAngle - bAngle) / 2 * _loc17_);
      var _loc20_ = eAngle - bAngle <= 359?true:false;
      bAngle = bAngle + wedgeSpacing / 2;
      eAngle = eAngle - wedgeSpacing / 2;
      if(eAngle < bAngle)
      {
         eAngle = eAngle + 360;
      }
      var _loc4_ = radius;
      var _loc16_ = Math.ceil((eAngle - bAngle) / 45);
      var _loc11_ = (eAngle - bAngle) / _loc16_ * _loc17_;
      var _loc12_ = radius / Math.cos(_loc11_ / 2);
      var _loc1_ = bAngle * _loc17_;
      var _loc18_ = (bAngle + (eAngle - bAngle) / 2) * _loc17_;
      var _loc3_ = _loc1_ - _loc11_ / 2;
      if(_loc20_)
      {
         target.moveTo(centerX,centerY);
         target.moveTo(centerX + _loc19_ * Math.cos(_loc18_),centerY + _loc19_ * Math.sin(_loc18_));
         target.lineTo(centerX + _loc4_ * Math.cos(_loc1_),centerY + _loc4_ * Math.sin(_loc1_));
      }
      else
      {
         target.moveTo(centerX + _loc4_ * Math.cos(_loc1_),centerY + _loc4_ * Math.sin(_loc1_));
      }
      var _loc2_ = 0;
      while(_loc2_ < _loc16_)
      {
         _loc1_ = _loc1_ + _loc11_;
         _loc3_ = _loc3_ + _loc11_;
         var _loc8_ = _loc4_ * Math.cos(_loc1_);
         var _loc7_ = _loc4_ * Math.sin(_loc1_);
         var _loc6_ = _loc12_ * Math.cos(_loc3_);
         var _loc5_ = _loc12_ * Math.sin(_loc3_);
         target.curveTo(centerX + _loc6_,centerY + _loc5_,centerX + _loc8_,centerY + _loc7_);
         _loc2_ = _loc2_ + 1;
      }
      if(_loc20_)
      {
         target.lineTo(centerX + _loc19_ * Math.cos(_loc18_),centerY + _loc19_ * Math.sin(_loc18_));
      }
   }
   function drawPieChart(centerX, centerY, radius, items, lineThickness, movieclip)
   {
      var _loc5_ = this;
      if(this.canvas != null)
      {
         _loc5_ = this.canvas;
      }
      else
      {
         this.debug("Error: canvas is NULL");
      }
      if(!(movieclip == null || movieclip == undefined))
      {
         _loc5_ = movieclip;
      }
      if(items[0].drawbackground)
      {
         this.lineWidth = 0;
         this.fillColor = 16777215;
         this.lineColor = 13421772;
         this.drawCircleFilled(centerX,centerY,radius,45);
      }
      items[0].spacing = !(items.length > 12 && items[0].spacing > 1)?items[0].spacing:1;
      var _loc12_ = 0;
      var _loc3_ = 0;
      while(_loc3_ < items.length)
      {
         var _loc9_ = items[_loc3_].ratio;
         var _loc17_ = _loc12_;
         var _loc20_ = _loc12_ + _loc9_ * 360;
         var _loc18_ = radius;
         var _loc6_ = items[_loc3_].color;
         if(items[_loc3_].showdeactive == "outline" && !items[_loc3_].active)
         {
            _loc5_.lineStyle(1,10066329,50);
         }
         else if(lineThickness > 0)
         {
            _loc5_.lineStyle(lineThickness,0,100);
         }
         else
         {
            _loc5_.lineStyle(0,0,0);
         }
         if(items[_loc3_].showdeactive == "outline" && !items[_loc3_].active)
         {
            _loc5_.beginFill(16777215,items[_loc3_].alpha);
         }
         else if(_loc6_ == "image")
         {
            if(items[0].image != null)
            {
               var _loc7_ = items[0].image;
               var _loc11_ = new flash.display.BitmapData(radius * 2,radius * 2);
               var _loc10_ = new flash.geom.Matrix();
               var _loc8_ = new flash.geom.Matrix();
               _loc10_.scale(radius * 2 / _loc7_._width,radius * 2 / _loc7_._height);
               _loc8_.translate(centerX - radius,centerY - radius);
               var _loc21_ = new flash.geom.ColorTransform(1,1,1,items[_loc3_].alpha / 100,0,0,0,0);
               _loc11_.draw(_loc7_,_loc10_,_loc21_);
               _loc5_.beginBitmapFill(_loc11_,_loc8_);
            }
            else
            {
               _loc5_.beginFill(16777215,items[_loc3_].alpha);
            }
         }
         else if(_loc6_ != "transparent")
         {
            if(items[0].gradient)
            {
               var _loc19_ = [_loc6_,_loc6_,_loc6_];
               var _loc15_ = [items[_loc3_].alpha,items[_loc3_].alpha / 2.5 + (items[_loc3_].alpha <= 6?0:20),items[_loc3_].alpha / 3 + (items[_loc3_].alpha <= 6?0:10)];
               var _loc22_ = [40,210,250];
               var _loc16_ = {matrixType:"box",x:centerX - radius,y:centerY - radius,w:radius * 2,h:radius * 2,r:2.0943951023931953};
               _loc5_.beginGradientFill("radial",_loc19_,_loc15_,_loc22_,_loc16_);
            }
            else
            {
               _loc5_.beginFill(_loc6_,items[_loc3_].alpha);
            }
         }
         if(items[_loc3_].showdeactive != "hide" || items[_loc3_].active)
         {
            this.drawWedge(_loc5_,centerX,centerY,_loc18_,_loc17_,_loc20_,items[0].spacing);
         }
         if(items[0].color != "transparent")
         {
            _loc5_.endFill();
         }
         _loc12_ = _loc12_ + _loc9_ * 360;
         items[_loc3_].alpha = items[_loc3_].alpha + (items[_loc3_].talpha - items[_loc3_].alpha) / 2;
         _loc3_ = _loc3_ + 1;
      }
   }
   function drawFractionBar(barWidth, barHeigth, items, lineThickness, movieclip)
   {
      var _loc5_ = this;
      if(this.canvas != null)
      {
         _loc5_ = this.canvas;
      }
      else
      {
         this.debug("Error: canvas is NULL");
      }
      if(!(movieclip == null || movieclip == undefined))
      {
         _loc5_ = movieclip;
      }
      if(items[0].drawbackground)
      {
         this.lineWidth = 0;
         this.fillColor = 16777215;
         this.lineColor = 13421772;
         this.drawRectangleFilled(0,0,barWidth - items[0].spacing,barHeigth - items[0].spacing);
      }
      this.fillshape = false;
      var _loc21_ = 0;
      var _loc20_ = 0;
      var _loc8_ = barWidth;
      var _loc12_ = barHeigth;
      var _loc4_ = 0;
      while(_loc4_ < items.length)
      {
         _loc21_ = 0;
         var _loc3_ = 0;
         while(_loc3_ < items[0].length)
         {
            _loc8_ = items[_loc4_][_loc3_].hratio * barWidth;
            _loc12_ = items[_loc4_][_loc3_].vratio * barHeigth;
            var _loc6_ = items[_loc4_][_loc3_].color;
            if(items[_loc4_][_loc3_].showdeactive == "outline" && !items[_loc4_][_loc3_].active)
            {
               _loc5_.lineStyle(1,10066329,50);
            }
            else if(lineThickness > 0)
            {
               _loc5_.lineStyle(lineThickness,0,100);
            }
            else
            {
               _loc5_.lineStyle(0,0,0);
            }
            if(items[_loc4_][_loc3_].showdeactive == "outline" && !items[_loc4_][_loc3_].active)
            {
               _loc5_.beginFill(16777215,items[_loc4_][_loc3_].alpha);
            }
            else if(items[_loc4_][_loc3_].color == "image")
            {
               if(items[0].image != null)
               {
                  var _loc7_ = items[0].image;
                  var _loc11_ = new flash.display.BitmapData(barWidth,barHeigth);
                  var _loc10_ = new flash.geom.Matrix();
                  var _loc9_ = new flash.geom.Matrix();
                  _loc10_.scale(barWidth / _loc7_._width,barHeigth / _loc7_._height);
                  if(!(movieclip == null || movieclip == undefined))
                  {
                     _loc9_.translate(- items[_loc4_][_loc3_].imageOffsetX,- items[_loc4_][_loc3_].imageOffsetY);
                  }
                  var _loc18_ = new flash.geom.ColorTransform(1,1,1,items[_loc4_][_loc3_].alpha / 100,0,0,0,0);
                  _loc11_.draw(_loc7_,_loc10_,_loc18_);
                  _loc5_.beginBitmapFill(_loc11_,_loc9_);
               }
               else
               {
                  _loc5_.beginFill(16777215,items[_loc4_][_loc3_].alpha);
               }
            }
            else if(items[_loc4_][_loc3_].color != "transparent")
            {
               if(items[0].gradient)
               {
                  var _loc17_ = [_loc6_,_loc6_,_loc6_];
                  var _loc15_ = [items[_loc4_][_loc3_].alpha,items[_loc4_][_loc3_].alpha / 2.5 + (items[_loc4_][_loc3_].alpha <= 6?0:20),items[_loc4_][_loc3_].alpha / 3 + (items[_loc4_][_loc3_].alpha <= 6?0:10)];
                  var _loc19_ = [40,210,250];
                  var _loc16_ = {matrixType:"box",x:0,y:_loc20_,w:_loc8_,h:_loc12_,r:4.71238898038469};
                  _loc5_.beginGradientFill("linear",_loc17_,_loc15_,_loc19_,_loc16_);
               }
               else
               {
                  _loc5_.beginFill(_loc6_,items[_loc4_][_loc3_].alpha);
               }
            }
            if(items[_loc4_][_loc3_].showdeactive != "hide" || items[_loc4_][_loc3_].active)
            {
               this.drawRectangle(_loc21_ - items[0].Xoffset,_loc20_ - items[0].Yoffset,_loc8_ - items[0].spacing,_loc12_ - items[0].spacing,_loc5_);
            }
            if(items[0][0].color != "transparent")
            {
               _loc5_.endFill();
            }
            items[_loc4_][_loc3_].alpha = items[_loc4_][_loc3_].alpha + (items[_loc4_][_loc3_].talpha - items[_loc4_][_loc3_].alpha) / 2;
            _loc21_ = _loc21_ + _loc8_;
            _loc3_ = _loc3_ + 1;
         }
         _loc20_ = _loc20_ + _loc12_;
         _loc4_ = _loc4_ + 1;
      }
   }
   function drawRectangle(x, y, w, h, target)
   {
      if(arguments.length < 4)
      {
         return undefined;
      }
      var _loc5_ = x;
      var _loc4_ = y;
      var _loc7_ = x + w;
      var _loc6_ = y + h;
      if(target == undefined || target == null)
      {
         target = this;
         if(this.canvas != null)
         {
            target = this.canvas;
         }
         else
         {
            this.debug("Error: canvas is NULL");
         }
      }
      if(this.fillshape)
      {
         target.lineStyle(this.lineWidth,this.lineColor,100);
         target.beginFill(this.fillColor,0);
      }
      target.moveTo(_loc5_,_loc4_);
      target.lineTo(_loc5_,_loc6_);
      target.lineTo(_loc7_,_loc6_);
      target.lineTo(_loc7_,_loc4_);
      target.lineTo(_loc5_,_loc4_);
      if(this.fillshape)
      {
         target.endFill();
      }
   }
   function drawRectangleFilled(x, y, w, h)
   {
      if(arguments.length < 4)
      {
         return undefined;
      }
      var _loc7_ = this;
      var _loc4_ = x;
      var _loc3_ = y;
      var _loc6_ = x + w;
      var _loc5_ = y + h;
      if(this.canvas != null)
      {
         _loc7_ = this.canvas;
      }
      else
      {
         this.debug("Error: canvas is NULL");
      }
      this.canvas.lineStyle(this.lineWidth,this.lineColor,100);
      this.canvas.beginFill(this.fillColor,100);
      this.canvas.moveTo(_loc4_,_loc3_);
      this.canvas.lineTo(_loc4_,_loc5_);
      this.canvas.lineTo(_loc6_,_loc5_);
      this.canvas.lineTo(_loc6_,_loc3_);
      this.canvas.lineTo(_loc4_,_loc3_);
      this.canvas.endFill();
   }
   function drawRoundedRectangle(x, y, w, h, a_radius)
   {
      var _loc14_ = this;
      if(arguments.length < 4)
      {
         return undefined;
      }
      this.canvas.lineStyle(this.lineWidth,this.lineColor,100);
      this.canvas.beginFill(16777215,0);
      if(a_radius > 0)
      {
         var _loc4_ = undefined;
         var _loc5_ = undefined;
         var _loc9_ = undefined;
         var _loc8_ = undefined;
         var _loc11_ = undefined;
         var _loc10_ = undefined;
         if(a_radius > Math.min(w,h) / 2)
         {
            a_radius = Math.round(Math.min(w,h) / 2);
         }
         _loc4_ = 0.7853981633974483;
         this.canvas.moveTo(x + a_radius,y);
         this.canvas.lineTo(x + w - a_radius,y);
         _loc5_ = -1.5707963267948966;
         _loc9_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         this.canvas.lineTo(x + w,y + h - a_radius);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         this.canvas.lineTo(x + a_radius,y + h);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         this.canvas.lineTo(x,y + a_radius);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
      }
      else
      {
         this.canvas.moveTo(x,y);
         this.canvas.lineTo(x + w,y);
         this.canvas.lineTo(x + w,y + h);
         this.canvas.lineTo(x,y + h);
         this.canvas.lineTo(x,y);
      }
      this.canvas.endFill();
   }
   function drawRoundedRectangleFilled(x, y, w, h, a_radius)
   {
      var _loc14_ = this;
      if(arguments.length < 4)
      {
         return undefined;
      }
      this.canvas.lineStyle(this.lineWidth,this.lineColor,100);
      this.canvas.beginFill(this.fillColor,100);
      if(a_radius > 0)
      {
         var _loc4_ = undefined;
         var _loc5_ = undefined;
         var _loc9_ = undefined;
         var _loc8_ = undefined;
         var _loc11_ = undefined;
         var _loc10_ = undefined;
         if(a_radius > Math.min(w,h) / 2)
         {
            a_radius = Math.round(Math.min(w,h) / 2);
         }
         _loc4_ = 0.7853981633974483;
         this.canvas.moveTo(x + a_radius,y);
         this.canvas.lineTo(x + w - a_radius,y);
         _loc5_ = -1.5707963267948966;
         _loc9_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         this.canvas.lineTo(x + w,y + h - a_radius);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + w - a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         this.canvas.lineTo(x + a_radius,y + h);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + h - a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         this.canvas.lineTo(x,y + a_radius);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
         _loc5_ = _loc5_ + _loc4_;
         _loc9_ = x + a_radius + Math.cos(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc8_ = y + a_radius + Math.sin(_loc5_ + _loc4_ / 2) * a_radius / Math.cos(_loc4_ / 2);
         _loc11_ = x + a_radius + Math.cos(_loc5_ + _loc4_) * a_radius;
         _loc10_ = y + a_radius + Math.sin(_loc5_ + _loc4_) * a_radius;
         this.canvas.curveTo(_loc9_,_loc8_,_loc11_,_loc10_);
      }
      else
      {
         this.canvas.moveTo(x,y);
         this.canvas.lineTo(x + w,y);
         this.canvas.lineTo(x + w,y + h);
         this.canvas.lineTo(x,y + h);
         this.canvas.lineTo(x,y);
      }
      this.canvas.endFill();
   }
   function drawTriangle(x1, y1, x2, y2, x3, y3)
   {
      var _loc2_ = this;
      if(this.canvas != null)
      {
         _loc2_ = this.canvas;
      }
      else
      {
         this.debug("Error: canvas is NULL");
      }
      this.canvas.lineStyle(this.lineWidth,this.lineColor,100);
      this.canvas.beginFill(this.fillColor,0);
      this.canvas.moveTo(x1,y1);
      this.canvas.lineTo(x2,y2);
      this.canvas.lineTo(x3,y3);
      this.canvas.lineTo(x1,y1);
      this.canvas.endFill();
   }
   function drawTriangleFilled(x1, y1, x2, y2, x3, y3)
   {
      var _loc2_ = this;
      if(this.canvas != null)
      {
         _loc2_ = this.canvas;
      }
      else
      {
         this.debug("Error: canvas is NULL");
      }
      this.canvas.lineStyle(this.lineWidth,this.lineColor,100);
      this.canvas.beginFill(this.fillColor,100);
      this.canvas.moveTo(x1,y1);
      this.canvas.lineTo(x2,y2);
      this.canvas.lineTo(x3,y3);
      this.canvas.lineTo(x1,y1);
      this.canvas.endFill();
   }
   function placeClip(a_clip, a_x, a_y, a_location)
   {
      if(a_clip == undefined)
      {
         this.debug("Internal error: target movieclip is undefined");
         return undefined;
      }
      if(a_clip == null)
      {
         this.debug("Internal error: target movieclip is null");
         return undefined;
      }
      if(a_location != undefined)
      {
         if(a_location == "TL")
         {
            a_clip._x = a_x;
            a_clip._y = a_y;
            return undefined;
         }
         if(a_location == "BL")
         {
            a_clip._x = a_x;
            a_clip._y = a_y - a_clip._height;
            return undefined;
         }
         if(a_location == "BR")
         {
            a_clip._x = a_x - a_clip._width;
            a_clip._y = a_y - a_clip._height;
            return undefined;
         }
         if(a_location == "TR")
         {
            a_clip._x = a_x - a_clip._width;
            a_clip._y = a_y;
            return undefined;
         }
         if(a_location == "CT")
         {
            a_clip._x = a_x;
            a_clip._y = a_y;
            return undefined;
         }
         if(a_location == "CL")
         {
            a_clip._x = a_x;
            a_clip._y = a_y;
            return undefined;
         }
         if(a_location == "CB")
         {
            a_clip._x = a_x;
            a_clip._y = a_y - a_clip._height;
            return undefined;
         }
         if(a_location == "CR")
         {
            a_clip._x = a_x - a_clip._width;
            a_clip._y = a_y;
            return undefined;
         }
      }
      a_clip._x = a_x;
      a_clip._y = a_y;
   }
   function placeClipCenter(a_clip, a_x, a_y)
   {
      if(a_clip == undefined)
      {
         this.debug("Internal error: target movieclip is undefined");
         return undefined;
      }
      if(a_clip == null)
      {
         this.debug("Internal error: target movieclip is null");
         return undefined;
      }
      a_clip._x = a_x - a_clip._width / 2;
      a_clip._y = a_y - a_clip._height / 2;
   }
}
