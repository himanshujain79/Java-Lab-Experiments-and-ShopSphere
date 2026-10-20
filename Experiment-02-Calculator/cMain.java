
public class cMain {
    public static void main(String[]args){
       cViews cv=new cViews();
       cModels cm=new cModels();
       new cController(cv,cm);

    }
}