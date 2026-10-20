import javax.swing.*;
public class cViews extends JFrame {
    JLabel a,b,result;
    JTextField txta,txtb,txtresult;
    JButton add,sub,mul,div;

    cViews(){
        setSize(500,500);
        setLayout(null);
        setTitle("Calculator");

        a=new JLabel("Enter A");
        a.setBounds(30,30,100,30);
        add(a);
        txta=new JTextField();
        txta.setBounds(100,30,100,30);
        add(txta);

        b= new JLabel("Enter B");
        b.setBounds(30,60,100,30);
        add(b);

         txtb=new JTextField();
        txtb.setBounds(100,60,100,30);
        add(txtb);

        add= new JButton("+");
        add.setBounds(30,90,60,30);
        add(add);

        sub= new JButton("-");
        sub.setBounds(70,90,60,30);
        add(sub);

        mul= new JButton("+");
        mul.setBounds(110,90,60,30);
        add(mul);

        div= new JButton("+");
        div.setBounds(150,90,60,30);
        add(div);

        result=new JLabel("Result");
        result.setBounds(30,120,100,30);
        add(result);

        txtresult=new JTextField();
        txtresult.setBounds(100,120,100,30);
        txtresult.setEditable(false);
        add(txtresult);
        setVisible(true);


    }
}
