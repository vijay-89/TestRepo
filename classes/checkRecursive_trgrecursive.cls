public Class checkRecursive_trgrecursive{
    private static boolean run = true;
    private static boolean beforerun = true;
    private static boolean afterrun = true;
    public static boolean runOnce(){
    if(run){
     run=false;
     return true;
    }else{
        return run;
    }
    }
    public static boolean beforerunOnce(){
    if(beforerun){
     beforerun=false;
     return true;
    }else{
        return beforerun;
    }
    }
    public static boolean afterrunOnce(){
    if(afterrun){
     afterrun=false;
     return true;
    }else{
         return afterrun;   
        }
    }
}