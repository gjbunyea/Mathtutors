# to run 
#   awk -f rmID.awk original.brd >new.brd 2>/dev/null
#
!iss                             {print}      # if not in start state, just print
$1=="</startNodeMessages>"       {iss=0; print;                     printf("%4d: iss=%d\n      %s\n", NR, iss, $0)>>"/dev/stderr"}  # exiting start state
$1=="<startNodeMessages>"        {iss=1;                            printf("%4d: iss=%d\n      %s\n", NR, iss, $0)>>"/dev/stderr"}  # entering start state
iss && $1=="</message>"          {im=0;                             printf("%4d: im=%d\n      %s\n", NR, im, $0)>>"/dev/stderr";    # exiting a message
                                  if(mt!="InterfaceDescription")
                                    printf("%s\n%s\n",m,$0);
                                  m=""; mt=""}
iss && $1=="<message>"           {im=1; mt="";                      printf("%4d: im=%d,mt=%s\n      %s\n", NR, im, mt, $0)>>"/dev/stderr"}  # entering a message
iss && im                        {m=(m?sprintf("%s\n%s",m,$0):$0);  printf("%4d: im=%d,mt=%s\n      %s\n", NR, im, mt, $0)>>"/dev/stderr"}  # any line of a message
iss && im && $1~/^<MessageType>/ {if(3>=split($0,A,"</?MessageType>"))                                                                      # the MessageType line
                                    mt=A[2];                        printf("%4d: im=%d,mt=%s\n      %s\n", NR,im,mt,$0)>>"/dev/stderr"}


# Could have this script automate the flagging of ComboBoxes - they are sometimes set from the BRD, not massProductionTable
# could swap out for Interface Actions - the wiki site will have details in the ACtion INput section to see what kind of interface action will make sense for our HTML components
