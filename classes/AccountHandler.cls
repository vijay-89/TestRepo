//Modified by Vijay-013th March 2019.
//Modified by Vijay-013th March Modified by Vijay.
public class AccountHandler {
public static Account insertNewAccount()
{
     Account act = New Account();
        act.Name = 's';
    try {
  
        insert act;
        }
    catch (DmlException e) {

       return null;
                           }
    return act;
}
//Modified by vijay
}
