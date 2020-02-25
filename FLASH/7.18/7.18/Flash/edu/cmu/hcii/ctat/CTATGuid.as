class edu.cmu.hcii.ctat.CTATGuid extends edu.cmu.hcii.ctat.CTATBase
{
   static var counter = 0;
   function CTATGuid()
   {
      super();
      this.setClassType("CTATGuid");
      this.debug("CTATGuid ()");
   }
   static function create(len)
   {
      len <= 40?true:len = 40;
      var _loc3_ = new Date();
      var _loc6_ = _loc3_.getTime();
      var _loc5_ = Math.random() * 1.7976931348623157e308;
      var _loc4_ = System.capabilities.serverString;
      edu.cmu.hcii.ctat.CTATGuid.counter = edu.cmu.hcii.ctat.CTATGuid.counter + 1;
      var _loc2_ = edu.cmu.hcii.ctat.CTATGuid.calculate(_loc6_ + _loc4_ + _loc5_ + edu.cmu.hcii.ctat.CTATGuid.counter).toUpperCase();
      return _loc2_.substr(1,len);
   }
   static function calculate(src)
   {
      return edu.cmu.hcii.ctat.CTATGuid.hex_sha1(src);
   }
   static function hex_sha1(src)
   {
      return edu.cmu.hcii.ctat.CTATGuid.binb2hex(edu.cmu.hcii.ctat.CTATGuid.core_sha1(edu.cmu.hcii.ctat.CTATGuid.str2binb(src),src.length * 8));
   }
   static function core_sha1(x, len)
   {
      x[len >> 5] = x[len >> 5] | 128 << 24 - len % 32;
      x[(len + 64 >> 9 << 4) + 15] = len;
      var _loc2_ = new Array(80);
      var _loc6_ = 1732584193;
      var _loc5_ = -271733879;
      var _loc4_ = -1732584194;
      var _loc3_ = 271733878;
      var _loc7_ = -1009589776;
      var _loc9_ = 0;
      while(_loc9_ < x.length)
      {
         var _loc15_ = _loc6_;
         var _loc14_ = _loc5_;
         var _loc13_ = _loc4_;
         var _loc12_ = _loc3_;
         var _loc11_ = _loc7_;
         var _loc1_ = 0;
         while(_loc1_ < 80)
         {
            if(_loc1_ < 16)
            {
               _loc2_[_loc1_] = x[_loc9_ + _loc1_];
            }
            else
            {
               _loc2_[_loc1_] = edu.cmu.hcii.ctat.CTATGuid.rol(_loc2_[_loc1_ - 3] ^ _loc2_[_loc1_ - 8] ^ _loc2_[_loc1_ - 14] ^ _loc2_[_loc1_ - 16],1);
            }
            var _loc8_ = edu.cmu.hcii.ctat.CTATGuid.safe_add(edu.cmu.hcii.ctat.CTATGuid.safe_add(edu.cmu.hcii.ctat.CTATGuid.rol(_loc6_,5),edu.cmu.hcii.ctat.CTATGuid.sha1_ft(_loc1_,_loc5_,_loc4_,_loc3_)),edu.cmu.hcii.ctat.CTATGuid.safe_add(edu.cmu.hcii.ctat.CTATGuid.safe_add(_loc7_,_loc2_[_loc1_]),edu.cmu.hcii.ctat.CTATGuid.sha1_kt(_loc1_)));
            _loc7_ = _loc3_;
            _loc3_ = _loc4_;
            _loc4_ = edu.cmu.hcii.ctat.CTATGuid.rol(_loc5_,30);
            _loc5_ = _loc6_;
            _loc6_ = _loc8_;
            _loc1_ = _loc1_ + 1;
         }
         _loc6_ = edu.cmu.hcii.ctat.CTATGuid.safe_add(_loc6_,_loc15_);
         _loc5_ = edu.cmu.hcii.ctat.CTATGuid.safe_add(_loc5_,_loc14_);
         _loc4_ = edu.cmu.hcii.ctat.CTATGuid.safe_add(_loc4_,_loc13_);
         _loc3_ = edu.cmu.hcii.ctat.CTATGuid.safe_add(_loc3_,_loc12_);
         _loc7_ = edu.cmu.hcii.ctat.CTATGuid.safe_add(_loc7_,_loc11_);
         _loc9_ = _loc9_ + 16;
      }
      return new Array(_loc6_,_loc5_,_loc4_,_loc3_,_loc7_);
   }
   static function sha1_ft(t, b, c, d)
   {
      if(t < 20)
      {
         return b & c | (~b) & d;
      }
      if(t < 40)
      {
         return b ^ c ^ d;
      }
      if(t < 60)
      {
         return b & c | b & d | c & d;
      }
      return b ^ c ^ d;
   }
   static function sha1_kt(t)
   {
      return t >= 20?t >= 40?t >= 60?-899497514:-1894007588:1859775393:1518500249;
   }
   static function safe_add(x, y)
   {
      var _loc1_ = (x & 65535) + (y & 65535);
      var _loc2_ = (x >> 16) + (y >> 16) + (_loc1_ >> 16);
      return _loc2_ << 16 | _loc1_ & 65535;
   }
   static function rol(num, cnt)
   {
      return num << cnt | num >>> 32 - cnt;
   }
   static function str2binb(str)
   {
      var _loc3_ = new Array();
      var _loc4_ = 255;
      var _loc1_ = 0;
      while(_loc1_ < str.length * 8)
      {
         _loc3_[_loc1_ >> 5] = _loc3_[_loc1_ >> 5] | (str.charCodeAt(_loc1_ / 8) & _loc4_) << 24 - _loc1_ % 32;
         _loc1_ = _loc1_ + 8;
      }
      return _loc3_;
   }
   static function binb2hex(binarray)
   {
      var _loc4_ = new String("");
      var _loc3_ = new String("0123456789abcdef");
      var _loc1_ = 0;
      while(_loc1_ < binarray.length * 4)
      {
         _loc4_ = _loc4_ + (_loc3_.charAt(binarray[_loc1_ >> 2] >> (3 - _loc1_ % 4) * 8 + 4 & 15) + _loc3_.charAt(binarray[_loc1_ >> 2] >> (3 - _loc1_ % 4) * 8 & 15));
         _loc1_ = _loc1_ + 1;
      }
      return _loc4_;
   }
}
