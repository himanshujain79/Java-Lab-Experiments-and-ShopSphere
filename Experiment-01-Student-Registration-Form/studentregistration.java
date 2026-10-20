import javax.swing.*;
import java.awt.event.*;
import java.sql.*;
public class studentregistration extends JFrame implements ActionListener{
    JLabel Name,Roll,Gender,Branch;
    JTextField txtName,txtRoll,txtBranch;
    JRadioButton male,female;
    ButtonGroup genderGroup;
    JCheckBox Terms;
    JButton Submit,Reset;

    @Override
    public void actionPerformed(ActionEvent e){
        if(e.getSource()==Reset){
            txtName.setText("");
            txtRoll.setText("");
            txtBranch.setText("");
            genderGroup.clearSelection();
            Terms.setSelected(false);
            return ;
        }

           if (txtName.getText().trim().isEmpty()) {            
            JOptionPane.showMessageDialog(this,                    
            "Please enter Student Name");            
           return;        
        }
           
        if (txtRoll.getText().trim().isEmpty()) {   
            JOptionPane.showMessageDialog(this, 
             "Please enter Roll Number");            
             return;        
            }

              
        if (!male.isSelected() && !female.isSelected()) {         
            JOptionPane.showMessageDialog(this,                    
            "Please select Gender");            
            return;        
            }

                 
        if (txtBranch.getText().trim().isEmpty()) { 
            JOptionPane.showMessageDialog(this,                    
            "Please enter Branch");            
            return;        

            }

        if (!Terms.isSelected()) {            
            JOptionPane.showMessageDialog(this,                    
            "Please accept Terms & Conditions");            
            return;        
            }

       String gender = male.isSelected() ? "Male" : "Female";

try {

    Connection con = DBconnection.getConnection();

    String sql = "INSERT INTO student (name, roll, gender, branch) VALUES (?, ?, ?, ?)";

    PreparedStatement ps = con.prepareStatement(sql);

    ps.setString(1, txtName.getText().trim());
    ps.setString(2, txtRoll.getText().trim());
    ps.setString(3, gender);
    ps.setString(4, txtBranch.getText().trim());

    ps.executeUpdate();

    JOptionPane.showMessageDialog(
        this,
        "Registration Successful\n\n"
        + "Name : " + txtName.getText()
        + "\nRoll Number : " + txtRoll.getText()
        + "\nGender : " + gender
        + "\nBranch : " + txtBranch.getText()
    );

    ps.close();
    con.close();

} catch (Exception ex) {

    JOptionPane.showMessageDialog(
        this,
        "Database Error: " + ex.getMessage()
    );

    ex.printStackTrace();
}

    }

    public studentregistration(){
        setSize(450,450);
        setTitle("Student Registration Form");
        setLayout(null);

        Name=new JLabel("Student Name");
        Name.setBounds(30,30,120,30);
        add(Name);
        txtName=new JTextField();
        txtName.setBounds(170,30,180,30);
        add(txtName);

        Roll=new JLabel("Roll No.");
        Roll.setBounds(30,80,120,30);
        add(Roll);

        txtRoll=new JTextField();
        txtRoll.setBounds(170,80,180,30);
        add(txtRoll);

        Gender=new JLabel("Gender");
        Gender.setBounds(30,130,120,30);
        add(Gender);

        male=new JRadioButton("Male");
        male.setBounds(170,130,80,30);
        add(male);
        
        female=new JRadioButton("Female");
        female.setBounds(260,130,100,30);
        add(female);

        genderGroup=new ButtonGroup();
        genderGroup.add(male);
        genderGroup.add(female);

        Branch=new JLabel("Branch");
        Branch.setBounds(30,180,120,30);
        add(Branch);

        txtBranch=new JTextField();
        txtBranch.setBounds(170,180,180,30);
        add(txtBranch);

        Terms=new JCheckBox("I accept Terms & Conditions");
        Terms.setBounds(30,230,250,30);
        add(Terms);

        Submit=new JButton("Submit");
        Submit.setBounds(80,290,100,35);
        Submit.addActionListener(this);
        add(Submit);

        Reset=new JButton("Reset");
        Reset.setBounds(220,290,100,35);
        Reset.addActionListener(this);
        add(Reset);

        setVisible(true);

    }
    public static void main(String []args)
    {
        System.out.println("Student registration form");
        new studentregistration();
    }
}