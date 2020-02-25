class pact.utils.RegExp
{
   var const = null;
   var source = null;
   var global = false;
   var ignoreCase = false;
   var multiline = false;
   var lastIndex = null;
   static var _xrStatic = null;
   var _xr = null;
   static var _xp = null;
   static var _xxa = null;
   static var _xxlp = null;
   var _xq = null;
   var _xqc = null;
   static var d = null;
   static var _xiStatic = null;
   var _xi = 0;
   static var _xxlm = null;
   static var _xxlc = null;
   static var _xxrc = null;
   static var lastMatch = null;
   static var leftContext = null;
   static var rightContext = null;
   static var _xa = new Array();
   static var lastParen = null;
   static var _xaStatic = new Array();
   static var $1 = null;
   static var $2 = null;
   static var $3 = null;
   static var $4 = null;
   static var $5 = null;
   static var $6 = null;
   static var $7 = null;
   static var $8 = null;
   static var $9 = null;
   static var _setString = pact.utils.RegExp.setStringMethods();
   function RegExp()
   {
      if(arguments[0] != null)
      {
         this.const = "RegExp";
         this.compile.apply(this,arguments);
      }
   }
   function invStr(sVal)
   {
      var _loc5_ = sVal;
      var _loc4_ = length(_loc5_);
      var _loc1_ = undefined;
      var _loc3_ = undefined;
      var _loc6_ = "";
      var _loc2_ = 1;
      while(_loc2_ < 255)
      {
         _loc3_ = chr(_loc2_);
         _loc1_ = 0;
         while(_loc1_ <= _loc4_ && _loc5_.substr(1 + _loc1_++,1) != _loc3_)
         {
         }
         if(_loc1_ > _loc4_)
         {
            _loc6_ = _loc6_ + _loc3_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   function compile()
   {
      this.source = arguments[0];
      if(arguments.length > 1)
      {
         var _loc17_ = (arguments[1] + "").toLowerCase();
         var _loc11_ = 0;
         while(_loc11_ < length(_loc17_))
         {
            if(_loc17_.substr(_loc11_ + 1,1) == "g")
            {
               this.global = true;
            }
            if(_loc17_.substr(_loc11_ + 1,1) == "i")
            {
               this.ignoreCase = true;
            }
            if(_loc17_.substr(_loc11_ + 1,1) == "m")
            {
               this.multiline = true;
            }
            _loc11_ = _loc11_ + 1;
         }
      }
      if(arguments.length < 3)
      {
         var _loc20_ = true;
         pact.utils.RegExp._xrStatic = 1;
         _loc11_ = 0;
      }
      else
      {
         _loc20_ = false;
         pact.utils.RegExp._xrStatic = pact.utils.RegExp._xrStatic + 1;
         this._xr = pact.utils.RegExp._xrStatic;
         _loc11_ = arguments[2];
      }
      this.lastIndex = 0;
      var _loc9_ = this.source;
      var _loc21_ = undefined;
      var _loc14_ = length(_loc9_);
      var _loc5_ = [];
      var _loc4_ = 0;
      var _loc6_ = undefined;
      var _loc8_ = false;
      var _loc16_ = undefined;
      var _loc15_ = undefined;
      var _loc18_ = false;
      var _loc19_ = undefined;
      _loc11_;
      for(; _loc11_ < _loc14_; _loc11_ = _loc11_ + 1)
      {
         var _loc3_ = _loc9_.substr(_loc11_ + 1,1);
         if(_loc3_ == "\\")
         {
            _loc11_ = _loc11_ + 1;
            _loc19_ = false;
            _loc3_ = _loc9_.substr(_loc11_ + 1,1);
         }
         else
         {
            _loc19_ = true;
         }
         var _loc13_ = _loc9_.substr(_loc11_ + 2,1);
         _loc5_[_loc4_] = new Object();
         _loc5_[_loc4_].t = 0;
         _loc5_[_loc4_].a = 0;
         _loc5_[_loc4_].b = 999;
         _loc5_[_loc4_].c = -10;
         if(_loc19_)
         {
            if(_loc3_ == "(")
            {
               _loc21_ = new pact.utils.RegExp(_loc9_,!this.ignoreCase?"g":"gi",_loc11_ + 1);
               _loc11_ = pact.utils.RegExp._xiStatic;
               _loc5_[_loc4_].t = 3;
               _loc3_ = _loc21_;
               _loc13_ = _loc9_.substr(_loc11_ + 2,1);
            }
            else
            {
               if(!_loc20_ && _loc3_ == ")")
               {
                  break;
               }
               if(_loc3_ == "^")
               {
                  if(_loc4_ == 0 || _loc5_[_loc4_ - 1].t == 7)
                  {
                     _loc5_[_loc4_].t = 9;
                     _loc5_[_loc4_].a = 1;
                     _loc5_[_loc4_].b = 1;
                     _loc4_ = _loc4_ + 1;
                  }
                  continue;
               }
               if(_loc3_ == "$")
               {
                  if(_loc20_)
                  {
                     _loc18_ = true;
                  }
                  continue;
               }
               if(_loc3_ == "[")
               {
                  _loc11_ = _loc11_ + 1;
                  if(_loc13_ == "^")
                  {
                     _loc5_[_loc4_].t = 2;
                     _loc11_ = _loc11_ + 1;
                  }
                  else
                  {
                     _loc5_[_loc4_].t = 1;
                  }
                  _loc3_ = "";
                  _loc8_ = false;
                  while(_loc11_ < _loc14_ && (_loc6_ = _loc9_.substr(1 + _loc11_++,1)) != "]")
                  {
                     if(_loc8_)
                     {
                        if(_loc6_ == "\\")
                        {
                        }
                        if(_loc6_ != "\\")
                        {
                           §§push(_loc6_);
                        }
                        else if(_loc6_ != "b")
                        {
                           _loc11_;
                           §§push(_loc9_.substr(1 + _loc11_++,1));
                        }
                        else
                        {
                           §§push("\b");
                        }
                        _loc15_ = §§pop();
                        _loc16_ = ord(_loc3_.substr(length(_loc3_),1)) + 1;
                        while(true)
                        {
                           _loc16_;
                           if(_loc15_ >= (_loc6_ = chr(_loc16_++)))
                           {
                              _loc3_ = _loc3_ + _loc6_;
                              continue;
                           }
                           break;
                        }
                        _loc8_ = false;
                     }
                     else if(_loc6_ == "-" && length(_loc3_) > 0)
                     {
                        _loc8_ = true;
                     }
                     else if(_loc6_ == "\\")
                     {
                        _loc11_;
                        _loc6_ = _loc9_.substr(1 + _loc11_++,1);
                        if(_loc6_ == "d")
                        {
                           _loc3_ = _loc3_ + "0123456789";
                        }
                        else if(_loc6_ == "D")
                        {
                           _loc3_ = _loc3_ + this.invStr("0123456789");
                        }
                        else if(_loc6_ == "s")
                        {
                           _loc3_ = _loc3_ + " \\\\\\\\\\\\\\\\f\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\t\\\\\\\\\\\\\\\\v";
                        }
                        else if(_loc6_ == "S")
                        {
                           _loc3_ = _loc3_ + this.invStr(" \\\\\\\\\\\\\\\\f\\\\\\\\\\\\\\\\n\\\\\\\\\\\\\\\\r\\\\\\\\\\\\\\\\t\\\\\\\\\\\\\\\\v");
                        }
                        else if(_loc6_ == "w")
                        {
                           _loc3_ = _loc3_ + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
                        }
                        else if(_loc6_ == "W")
                        {
                           _loc3_ = _loc3_ + this.invStr("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_");
                        }
                        else if(_loc6_ == "b")
                        {
                           _loc3_ = _loc3_ + "\b";
                        }
                     }
                     else
                     {
                        _loc3_ = _loc3_ + _loc6_;
                     }
                  }
                  _loc11_ = _loc11_ - 1;
                  _loc13_ = _loc9_.substr(_loc11_ + 2,1);
               }
               else
               {
                  if(_loc3_ == "|")
                  {
                     if(_loc18_)
                     {
                        _loc5_[_loc4_].t = 10;
                        _loc5_[_loc4_].a = 1;
                        _loc5_[_loc4_].b = 1;
                        _loc4_ = _loc4_ + 1;
                        _loc5_[_loc4_] = new Object();
                        _loc18_ = false;
                     }
                     _loc5_[_loc4_].t = 7;
                     _loc5_[_loc4_].a = 1;
                     _loc5_[_loc4_].b = 1;
                     _loc4_ = _loc4_ + 1;
                     continue;
                  }
                  if(_loc3_ == ".")
                  {
                     _loc5_[_loc4_].t = 2;
                     _loc3_ = "\n";
                  }
                  else if(_loc3_ == "*" || _loc3_ == "?" || _loc3_ == "+")
                  {
                     continue;
                  }
               }
            }
         }
         else if(_loc3_ >= "1" && _loc3_ <= "9")
         {
            _loc5_[_loc4_].t = 4;
         }
         else if(_loc3_ == "b")
         {
            _loc5_[_loc4_].t = 1;
            _loc3_ = "--wb--";
         }
         else if(_loc3_ == "B")
         {
            _loc5_[_loc4_].t = 2;
            _loc3_ = "--wb--";
         }
         else if(_loc3_ == "d")
         {
            _loc5_[_loc4_].t = 1;
            _loc3_ = "0123456789";
         }
         else if(_loc3_ == "D")
         {
            _loc5_[_loc4_].t = 2;
            _loc3_ = "0123456789";
         }
         else if(_loc3_ == "s")
         {
            _loc5_[_loc4_].t = 1;
            _loc3_ = " \f\n\r\t\\";
         }
         else if(_loc3_ == "S")
         {
            _loc5_[_loc4_].t = 2;
            _loc3_ = " \f\n\r\t\\";
         }
         else if(_loc3_ == "w")
         {
            _loc5_[_loc4_].t = 1;
            _loc3_ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
         }
         else if(_loc3_ == "W")
         {
            _loc5_[_loc4_].t = 2;
            _loc3_ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
         }
         if(_loc13_ == "*")
         {
            _loc5_[_loc4_].s = _loc3_;
            _loc4_ = _loc4_ + 1;
            _loc11_ = _loc11_ + 1;
         }
         else if(_loc13_ == "?")
         {
            _loc5_[_loc4_].s = _loc3_;
            _loc5_[_loc4_].b = 1;
            _loc4_ = _loc4_ + 1;
            _loc11_ = _loc11_ + 1;
         }
         else if(_loc13_ == "+")
         {
            _loc5_[_loc4_].s = _loc3_;
            _loc5_[_loc4_].a = 1;
            _loc4_ = _loc4_ + 1;
            _loc11_ = _loc11_ + 1;
         }
         else if(_loc13_ == "{")
         {
            var _loc12_ = false;
            var _loc7_ = 0;
            _loc8_ = "";
            _loc11_ = _loc11_ + 1;
            while(_loc11_ + 1 < _loc14_ && (_loc6_ = _loc9_.substr(2 + _loc11_++,1)) != "}")
            {
               if(!_loc12_ && _loc6_ == ",")
               {
                  _loc12_ = true;
                  _loc7_ = Number(_loc8_);
                  _loc7_ = Math.floor(!isNaN(_loc7_)?_loc7_:0);
                  if(_loc7_ < 0)
                  {
                     _loc7_ = 0;
                  }
                  _loc8_ = "";
               }
               else
               {
                  _loc8_ = _loc8_ + _loc6_;
               }
            }
            var _loc10_ = Number(_loc8_);
            _loc10_ = Math.floor(!isNaN(_loc10_)?_loc10_:0);
            if(_loc10_ < 1)
            {
               _loc10_ = 999;
            }
            if(_loc10_ < _loc7_)
            {
               _loc10_ = _loc7_;
            }
            _loc5_[_loc4_].s = _loc3_;
            _loc5_[_loc4_].b = _loc10_;
            _loc5_[_loc4_].a = !_loc12_?_loc10_:_loc7_;
            _loc4_ = _loc4_ + 1;
         }
         else
         {
            _loc5_[_loc4_].s = _loc3_;
            _loc5_[_loc4_].a = 1;
            _loc5_[_loc4_].b = 1;
            _loc4_ = _loc4_ + 1;
         }
      }
      if(_loc20_ && _loc18_)
      {
         _loc5_[_loc4_] = new Object();
         _loc5_[_loc4_].t = 10;
         _loc5_[_loc4_].a = 1;
         _loc5_[_loc4_].b = 1;
         _loc4_ = _loc4_ + 1;
      }
      if(!_loc20_)
      {
         pact.utils.RegExp._xiStatic = _loc11_;
         this.source = _loc9_.substr(arguments[2] + 1,_loc11_ - arguments[2]);
      }
      if(pact.utils.RegExp.d)
      {
         _loc11_ = 0;
         while(_loc11_ < _loc4_)
         {
            trace("xr" + this._xr + " " + _loc5_[_loc11_].t + " : " + _loc5_[_loc11_].a + " : " + _loc5_[_loc11_].b + " : " + _loc5_[_loc11_].s);
            _loc11_ = _loc11_ + 1;
         }
      }
      this._xq = _loc5_;
      this._xqc = _loc4_;
      pact.utils.RegExp._xp = 0;
   }
   function test()
   {
      pact.utils.RegExp._xp = pact.utils.RegExp._xp + 1;
      if(pact.utils.RegExp._xp == 0)
      {
         pact.utils.RegExp._xxa = [];
         pact.utils.RegExp._xxlp = 0;
      }
      var _loc11_ = arguments[0] + "";
      var _loc15_ = undefined;
      var _loc4_ = this._xq;
      var _loc18_ = this._xqc;
      var _loc14_ = undefined;
      var _loc7_ = undefined;
      var _loc8_ = undefined;
      var _loc9_ = undefined;
      var _loc13_ = undefined;
      var _loc12_ = length(_loc11_);
      var _loc5_ = !this.global?0:this.lastIndex;
      var _loc21_ = _loc5_;
      var _loc19_ = _loc11_;
      if(this.ignoreCase)
      {
         _loc11_ = _loc11_.toLowerCase();
      }
      var _loc16_ = new Object();
      _loc16_.i = -1;
      var _loc3_ = -1;
      while(_loc3_ < _loc18_ - 1)
      {
         _loc3_ = _loc3_ + 1;
         if(pact.utils.RegExp.d)
         {
            trace("New section started at i=" + _loc3_);
         }
         _loc5_ = _loc21_;
         _loc14_ = _loc3_;
         _loc4_[_loc14_].c = -10;
         var _loc20_ = false;
         while(_loc3_ > _loc14_ || _loc5_ < _loc12_ + 1)
         {
            if(_loc4_[_loc3_].t == 7)
            {
               break;
            }
            if(_loc4_[_loc3_].t == 9)
            {
               _loc3_ = _loc3_ + 1;
               if(_loc3_ == _loc14_ + 1)
               {
                  var _loc17_ = true;
                  _loc14_ = _loc3_;
               }
               _loc4_[_loc14_].c = -10;
            }
            else
            {
               if(_loc16_.i >= 0 && _loc5_ >= _loc16_.i)
               {
                  break;
               }
               if(_loc4_[_loc3_].c == -10)
               {
                  if(pact.utils.RegExp.d)
                  {
                     trace("Lookup #" + _loc3_ + " at index " + _loc5_ + " for \\\\\\\\\\\\\\\\\'" + _loc4_[_loc3_].s + "\\\\\\\\\\\\\\\\\' type " + _loc4_[_loc3_].t);
                  }
                  var _loc6_ = 0;
                  _loc4_[_loc3_].i = _loc5_;
                  if(_loc4_[_loc3_].t == 0)
                  {
                     _loc7_ = !this.ignoreCase?_loc4_[_loc3_].s:_loc4_[_loc3_].s.toLowerCase();
                     while(_loc6_ < _loc4_[_loc3_].b && _loc5_ < _loc12_)
                     {
                        if(_loc11_.substr(1 + _loc5_,1) == _loc7_)
                        {
                           _loc6_ = _loc6_ + 1;
                           _loc5_ = _loc5_ + 1;
                           continue;
                        }
                        break;
                     }
                  }
                  else if(_loc4_[_loc3_].t == 1)
                  {
                     if(_loc4_[_loc3_].s == "--wb--")
                     {
                        _loc4_[_loc3_].a = 1;
                        if(_loc5_ > 0 && _loc5_ < _loc12_)
                        {
                           _loc9_ = _loc11_.substr(_loc5_,1);
                           if(_loc9_ == " " || _loc9_ == "\\\\\\\\\\\\\\\\n")
                           {
                              _loc6_ = 1;
                           }
                           if(_loc6_ == 0)
                           {
                              _loc9_ = _loc11_.substr(1 + _loc5_,1);
                              if(_loc9_ == " " || _loc9_ == "\\\\\\\\\\\\\\\\n")
                              {
                                 _loc6_ = 1;
                              }
                           }
                        }
                        else
                        {
                           _loc6_ = 1;
                        }
                     }
                     else
                     {
                        _loc7_ = !this.ignoreCase?_loc4_[_loc3_].s:_loc4_[_loc3_].s.toLowerCase();
                        _loc8_ = length(_loc7_);
                        var _loc10_ = undefined;
                        while(_loc6_ < _loc4_[_loc3_].b && _loc5_ < _loc12_)
                        {
                           _loc9_ = _loc11_.substr(1 + _loc5_,1);
                           _loc10_ = 0;
                           while(_loc10_ <= _loc8_ && _loc7_.substr(1 + _loc10_++,1) != _loc9_)
                           {
                           }
                           if(_loc10_ <= _loc8_)
                           {
                              _loc6_ = _loc6_ + 1;
                              _loc5_ = _loc5_ + 1;
                              continue;
                           }
                           break;
                        }
                     }
                  }
                  else if(_loc4_[_loc3_].t == 2)
                  {
                     _loc7_ = !this.ignoreCase?_loc4_[_loc3_].s:_loc4_[_loc3_].s.toLowerCase();
                     _loc8_ = length(_loc7_);
                     if(_loc4_[_loc3_].s == "--wb--")
                     {
                        _loc4_[_loc3_].a = 1;
                        if(_loc5_ > 0 && _loc5_ < _loc12_)
                        {
                           _loc9_ = _loc11_.substr(_loc5_,1);
                           _loc13_ = _loc11_.substr(1 + _loc5_,1);
                           if(_loc9_ != " " && _loc9_ != "\\\\\\\\\\\\\\\\n" && _loc13_ != " " && _loc13_ != "\\\\\\\\\\\\\\\\n")
                           {
                              _loc6_ = 1;
                           }
                        }
                        else
                        {
                           _loc6_ = 0;
                        }
                     }
                     else
                     {
                        while(_loc6_ < _loc4_[_loc3_].b && _loc5_ < _loc12_)
                        {
                           _loc9_ = _loc11_.substr(1 + _loc5_,1);
                           _loc10_ = 0;
                           while(_loc10_ <= _loc8_ && _loc7_.substr(1 + _loc10_++,1) != _loc9_)
                           {
                           }
                           if(_loc10_ <= _loc8_)
                           {
                              break;
                           }
                           _loc6_ = _loc6_ + 1;
                           _loc5_ = _loc5_ + 1;
                        }
                     }
                  }
                  else if(_loc4_[_loc3_].t == 10)
                  {
                     _loc13_ = _loc11_.substr(1 + _loc5_,1);
                     _loc6_ = !(this.multiline && (_loc13_ == "\\\\\\\\\\\\\\\\n" || _loc13_ == "\\\\\\\\\\\\\\\\r") || _loc5_ == _loc12_)?0:1;
                  }
                  else if(_loc4_[_loc3_].t == 3)
                  {
                     _loc15_ = _loc4_[_loc3_].s;
                     _loc4_[_loc3_].ix = [];
                     _loc4_[_loc3_].ix[_loc6_] = _loc5_;
                     _loc15_.lastIndex = _loc5_;
                     while(_loc6_ < _loc4_[_loc3_].b && _loc15_.test(_loc19_))
                     {
                        _loc8_ = length(pact.utils.RegExp._xxlm);
                        if(_loc8_ > 0)
                        {
                           _loc5_ = _loc5_ + _loc8_;
                           _loc6_ = _loc6_ + 1;
                           _loc4_[_loc3_].ix[_loc6_] = _loc5_;
                           continue;
                        }
                        _loc6_ = _loc4_[_loc3_].a;
                        _loc4_[_loc3_].ix[_loc6_ - 1] = _loc5_;
                        break;
                     }
                     if(_loc6_ == 0)
                     {
                        pact.utils.RegExp._xxlm = "";
                     }
                     if(_loc15_._xr > pact.utils.RegExp._xxlp)
                     {
                        pact.utils.RegExp._xxlp = _loc15_._xr;
                     }
                     pact.utils.RegExp._xxa[Number(_loc15_._xr)] = pact.utils.RegExp._xxlm;
                  }
                  else if(_loc4_[_loc3_].t == 4)
                  {
                     if(pact.utils.RegExp._xp >= (_loc7_ = Number(_loc4_[_loc3_].s)))
                     {
                        _loc7_ = pact.utils.RegExp._xxa[_loc7_];
                        _loc7_ = !this.ignoreCase?_loc7_:_loc7_.toLowerCase();
                        _loc8_ = length(_loc7_);
                        _loc4_[_loc3_].ix = [];
                        _loc4_[_loc3_].ix[_loc6_] = _loc5_;
                        if(_loc8_ > 0)
                        {
                           while(_loc6_ < _loc4_[_loc3_].b && _loc5_ < _loc12_)
                           {
                              if(_loc11_.substr(1 + _loc5_,_loc8_) == _loc7_)
                              {
                                 _loc6_ = _loc6_ + 1;
                                 _loc5_ = _loc5_ + _loc8_;
                                 _loc4_[_loc3_].ix[_loc6_] = _loc5_;
                                 continue;
                              }
                              break;
                           }
                        }
                        else
                        {
                           _loc6_ = 0;
                           _loc4_[_loc3_].a = 0;
                        }
                     }
                     else
                     {
                        _loc7_ = chr(_loc7_);
                        _loc4_[_loc3_].ix = [];
                        _loc4_[_loc3_].ix[_loc6_] = _loc5_;
                        while(_loc6_ < _loc4_[_loc3_].b && _loc5_ < _loc12_)
                        {
                           if(_loc11_.substr(1 + _loc5_,1) == _loc7_)
                           {
                              _loc6_ = _loc6_ + 1;
                              _loc5_ = _loc5_ + 1;
                              _loc4_[_loc3_].ix[_loc6_] = _loc5_;
                              continue;
                           }
                           break;
                        }
                     }
                  }
                  _loc4_[_loc3_].c = _loc6_;
                  if(pact.utils.RegExp.d)
                  {
                     trace("   " + _loc6_ + " matches found");
                  }
               }
               if(_loc4_[_loc3_].c < _loc4_[_loc3_].a)
               {
                  if(pact.utils.RegExp.d)
                  {
                     trace("   not enough matches");
                  }
                  if(_loc3_ > _loc14_)
                  {
                     _loc3_ = _loc3_ - 1;
                     _loc4_[_loc3_].c = _loc4_[_loc3_].c - 1;
                     if(_loc4_[_loc3_].c >= 0)
                     {
                        _loc5_ = !(_loc4_[_loc3_].t == 3 || _loc4_[_loc3_].t == 4)?_loc4_[_loc3_].i + _loc4_[_loc3_].c:_loc4_[_loc3_].ix[_loc4_[_loc3_].c];
                     }
                     if(pact.utils.RegExp.d)
                     {
                        trace("Retreat to #" + _loc3_ + " c=" + _loc4_[_loc3_].c + " index=" + _loc5_);
                     }
                  }
                  else
                  {
                     if(pact.utils.RegExp._xp > 1)
                     {
                        break;
                     }
                     if(_loc17_)
                     {
                        if(this.multiline)
                        {
                           while(_loc5_ <= _loc12_)
                           {
                              _loc5_;
                              _loc13_ = _loc11_.substr(1 + _loc5_++,1);
                              if(_loc13_ == "\\\\\\\\\\\\\\\\n" || _loc13_ == "\\\\\\\\\\\\\\\\r")
                              {
                                 break;
                              }
                           }
                           _loc4_[_loc3_].c = -10;
                        }
                        else
                        {
                           break;
                        }
                     }
                     else
                     {
                        _loc5_ = _loc5_ + 1;
                        _loc4_[_loc3_].c = -10;
                     }
                  }
               }
               else
               {
                  if(pact.utils.RegExp.d)
                  {
                     trace("   enough matches!");
                  }
                  _loc3_ = _loc3_ + 1;
                  if(_loc3_ == _loc18_ || _loc4_[_loc3_].t == 7)
                  {
                     if(pact.utils.RegExp.d)
                     {
                        trace("Saving better result: r.i = q[" + _loc14_ + "].i = " + _loc4_[_loc14_].i);
                     }
                     _loc16_.i = _loc4_[_loc14_].i;
                     _loc16_.li = _loc5_;
                     break;
                  }
                  _loc4_[_loc3_].c = -10;
               }
            }
         }
         while(_loc3_ < _loc18_ && _loc4_[_loc3_].t != 7)
         {
            _loc3_ = _loc3_ + 1;
         }
      }
      if(_loc16_.i < 0)
      {
         this.lastIndex = 0;
         pact.utils.RegExp._xp = pact.utils.RegExp._xp - 1;
         if(pact.utils.RegExp._xp == 1)
         {
            pact.utils.RegExp._xxa = [];
            pact.utils.RegExp._xxlp = 0;
         }
         return false;
      }
      _loc5_ = _loc16_.li;
      this._xi = _loc16_.i;
      pact.utils.RegExp._xxlm = _loc19_.substr(_loc16_.i + 1,_loc5_ - _loc16_.i);
      pact.utils.RegExp._xxlc = _loc19_.substr(1,_loc16_.i);
      pact.utils.RegExp._xxrc = _loc19_.substr(_loc5_ + 1,_loc12_ - _loc5_);
      if(_loc5_ == _loc16_.i)
      {
         _loc5_ = _loc5_ + 1;
      }
      this.lastIndex = _loc5_;
      pact.utils.RegExp._xp = pact.utils.RegExp._xp - 1;
      if(pact.utils.RegExp._xp == 1)
      {
         pact.utils.RegExp.lastMatch = pact.utils.RegExp._xxlm;
         pact.utils.RegExp.leftContext = pact.utils.RegExp._xxlc;
         pact.utils.RegExp.rightContext = pact.utils.RegExp._xxrc;
         pact.utils.RegExp._xaStatic = pact.utils.RegExp._xxa;
         pact.utils.RegExp.lastParen = pact.utils.RegExp._xxa[Number(pact.utils.RegExp._xxlp)];
         _loc3_ = 1;
         while(_loc3_ < 10)
         {
            pact.utils.RegExp["$" + _loc3_] = pact.utils.RegExp._xaStatic[Number(_loc3_)];
            _loc3_ = _loc3_ + 1;
         }
      }
      return true;
   }
   function exec()
   {
      var _loc5_ = arguments[0] + "";
      if(_loc5_ == "")
      {
         return false;
      }
      var _loc6_ = this.test(_loc5_);
      if(_loc6_)
      {
         var _loc7_ = new Array();
         _loc7_.index = this._xi;
         _loc7_.input = _loc5_;
         _loc7_[0] = pact.utils.RegExp.lastMatch;
         var _loc4_ = pact.utils.RegExp._xaStatic.length;
         var _loc3_ = 1;
         while(_loc3_ < _loc4_)
         {
            _loc7_[_loc3_] = pact.utils.RegExp._xaStatic[Number(_loc3_)];
            _loc3_ = _loc3_ + 1;
         }
      }
      else
      {
         _loc7_ = null;
      }
      return _loc7_;
   }
   static function setStringMethods()
   {
      if(String.prototype.match != undefined)
      {
         return undefined;
      }
      String.prototype.match = function()
      {
         if(typeof arguments[0] != "object")
         {
            return null;
         }
         if(arguments[0].const != "RegExp")
         {
            return null;
         }
         var _loc3_ = arguments[0];
         var _loc5_ = this.valueOf();
         var _loc6_ = 0;
         var _loc4_ = 0;
         if(_loc3_.global)
         {
            _loc3_.lastIndex = 0;
            while(_loc3_.test(_loc5_))
            {
               if(_loc4_ == 0)
               {
                  var _loc7_ = new Array();
               }
               _loc4_;
               _loc7_[_loc4_++] = pact.utils.RegExp.lastMatch;
               _loc6_ = _loc3_.lastIndex;
            }
            _loc3_.lastIndex = _loc6_;
         }
         else
         {
            _loc7_ = _loc3_.exec(_loc5_);
            _loc4_ = _loc4_ + 1;
         }
         return _loc4_ != 0?_loc7_:null;
      };
      String.prototype.replace = function()
      {
         if(typeof arguments[0] != "object")
         {
            return null;
         }
         if(arguments[0].const != "RegExp")
         {
            return null;
         }
         var _loc8_ = arguments[0];
         var _loc7_ = arguments[1] + "";
         var _loc11_ = this;
         var _loc12_ = "";
         _loc8_.lastIndex = 0;
         if(_loc8_.global)
         {
            var _loc13_ = 0;
            var _loc10_ = 0;
            while(_loc8_.test(_loc11_))
            {
               var _loc5_ = 0;
               var _loc9_ = length(_loc7_);
               var _loc3_ = "";
               var _loc6_ = "";
               var _loc4_ = "";
               while(_loc5_ < _loc9_)
               {
                  _loc5_;
                  _loc3_ = _loc7_.substr(1 + _loc5_++,1);
                  if(_loc3_ == "$" && _loc6_ != "\\")
                  {
                     _loc5_;
                     _loc3_ = _loc7_.substr(1 + _loc5_++,1);
                     if(isNaN(Number(_loc3_)) || Number(_loc3_) > 9)
                     {
                        _loc4_ = _loc4_ + ("$" + _loc3_);
                     }
                     else
                     {
                        _loc4_ = _loc4_ + pact.utils.RegExp._xaStatic[Number(_loc3_)];
                     }
                  }
                  else
                  {
                     _loc4_ = _loc4_ + _loc3_;
                  }
                  _loc6_ = _loc3_;
               }
               _loc12_ = _loc12_ + (_loc11_.substr(_loc10_ + 1,_loc8_._xi - _loc10_) + _loc4_);
               _loc10_ = _loc8_._xi + length(pact.utils.RegExp.lastMatch);
               _loc13_ = _loc8_.lastIndex;
            }
            _loc8_.lastIndex = _loc13_;
         }
         else if(_loc8_.test(_loc11_))
         {
            _loc12_ = _loc12_ + (pact.utils.RegExp.leftContext + _loc7_);
         }
         _loc12_ = _loc12_ + (_loc8_.lastIndex != 0?pact.utils.RegExp.rightContext:_loc11_);
         return _loc12_;
      };
      String.prototype.search = function()
      {
         if(typeof arguments[0] != "object")
         {
            return null;
         }
         if(arguments[0].const != "RegExp")
         {
            return null;
         }
         var _loc3_ = arguments[0];
         var _loc5_ = this;
         _loc3_.lastIndex = 0;
         var _loc4_ = _loc3_.test(_loc5_);
         return !_loc4_?-1:_loc3_._xi;
      };
      String.prototype.old_split = String.prototype.split;
      String.prototype.split = function()
      {
         if(typeof arguments[0] == "object" && arguments[0].const == "RegExp")
         {
            var _loc3_ = arguments[0];
            var _loc8_ = arguments[1] != null?Number(arguments[1]):9999;
            if(isNaN(_loc8_))
            {
               _loc8_ = 9999;
            }
            var _loc6_ = this;
            var _loc9_ = new Array();
            var _loc5_ = 0;
            var _loc11_ = _loc3_.global;
            _loc3_.global = true;
            _loc3_.lastIndex = 0;
            var _loc7_ = 0;
            var _loc10_ = 0;
            var _loc4_ = 0;
            while(_loc5_ < _loc8_ && _loc3_.test(_loc6_))
            {
               trace(_loc3_._xi + " " + _loc4_ + " " + pact.utils.RegExp.lastMatch);
               if(_loc3_._xi != _loc4_)
               {
                  _loc5_;
                  _loc9_[_loc5_++] = _loc6_.substr(_loc4_ + 1,_loc3_._xi - _loc4_);
               }
               _loc4_ = _loc3_._xi + length(pact.utils.RegExp.lastMatch);
               _loc10_ = _loc7_;
               _loc7_ = _loc3_.lastIndex;
            }
            if(_loc5_ == _loc8_)
            {
               _loc3_.lastIndex = _loc10_;
            }
            else
            {
               _loc3_.lastIndex = _loc7_;
            }
            if(_loc5_ == 0)
            {
               _loc9_[_loc5_] = _loc6_;
            }
            else if(_loc5_ < _loc8_ && length(pact.utils.RegExp.rightContext) > 0)
            {
               _loc5_;
               _loc9_[_loc5_++] = pact.utils.RegExp.rightContext;
            }
            _loc3_.global = _loc11_;
            return _loc9_;
         }
         return this.old_split(arguments[0],arguments[1]);
      };
      return true;
   }
}
