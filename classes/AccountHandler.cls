//Modified by Vijay-30th July
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
