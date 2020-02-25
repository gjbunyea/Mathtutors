class edu.cmu.hcii.ctat.CTATTutorShopMessage extends edu.cmu.hcii.ctat.CTATBase
{
   function CTATTutorShopMessage(a_curriculum_service_url, a_user_guid, a_session_id, a_student_problem_id, a_school_name, a_admit_code, a_cmd, a_LVMethodForSendDone)
   {
      super();
      this.setClassType("CTATTutorShopMessage");
      this.debug("CTATTutorShopMessage ()");
      this.curriculum_service_url = a_curriculum_service_url;
      this.user_guid = a_user_guid;
      this.session_id = a_session_id;
      this.student_problem_id = a_student_problem_id;
      this.school_name = a_school_name;
      this.admit_code = a_admit_code;
      this.cmd = a_cmd;
      this.LVMethodForSendDone = a_LVMethodForSendDone;
   }
}
