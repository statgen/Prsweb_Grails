package prsweb;


import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.util.Date;
import java.util.HashMap;

public class createPhecode {

    public static void main(String[] args) throws Exception {
        createPhecode dao = new createPhecode();
        dao.readFile();
    }


    private Connection connect = null;
    private Statement statement = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

//set SQL_SAFE_UPDATES =0;
//UPDATE prsweb.display_data  SET aucci = TRIM(BOTH '"' FROM aucci);

    public void readFile() throws Exception {
        try {
            // This will load the MySQL driver, each DB has its own driver


            String filepath = "/Users/snehalpatil/Documents/GithubProjects/PRSwebData/shareSnehal/Phecode_Definitions_FullTable_Modified.txt";

            try {

                BufferedReader br = new BufferedReader(new FileReader(filepath));
                String line;

                String header = br.readLine();
                String[] colname = header.split("\t");
                HashMap<String, Integer> colorder = new HashMap<>();
                // as the column is not fixed , try to find the index based on the name of the column

                for (int k = 0; k < colname.length; k++) {

                    System.out.println(colname[k]);
                    colorder.put(colname[k].replaceAll("\"", ""), k);
                }

                int count = 1;
                while ((line = br.readLine()) != null) {

                    String []tokens = line.split("\t");

                    String phecodeid2=tokens[colorder.get("phecode")];
                    Double phecodeid=Double.parseDouble(tokens[colorder.get("phecode")]);
                    String desc=tokens[colorder.get("description")];



                    Class.forName("com.mysql.jdbc.Driver");
            // Setup the connection with the DB
            connect = DriverManager
                    .getConnection("jdbc:mysql://localhost/prsweb?"
                            + "user=prsweb&password=prsweb");

            // Statements allow to issue SQL queries to the database
            statement = connect.createStatement();
            // Result set get the result of the SQL query

//INSERT INTO `prsweb`.`display_data` (`id`, `version`, `aucci`, `hosm_p`, `orval`, `descdata`, `auc`, `refdata`, `urldata`, `brier_score`,
// `pval`, `phecodedata`,
//  `prsweb`, `hosm_chi`, `ncontrols`, `nomsig`, `quaanal`, `outsource`, `method`, `phecat`, `r2_nage`, `phenomes`, `nsnp`,
//  `prefixdata`, `ncases`, `logpval`, `prswebprefix`, `perunpow`, `sexdata`, `warreveff`, `orcival`, `toporci2`, `source`, `topor`, `toporci1`, `genld`,
//  `datecreated`, `tunparam`) VALUES ('232', '221', '5656', '5656', '565', '55656', '5656', '56565', '56565', '56565', '5656', '56565', '5656', '565656', '565656', '5656', '5566', '45454', '4545', '4545', '4545', '454545', '4545', '454545', '4545', '4545', '4545', '4545', '4545', '4545', '4545', '4545', '4545', '4545', '4545', '4545', '4545', '454545');
            preparedStatement = connect
                            .prepareStatement("INSERT INTO prsweb.phecode (id, version, phecodedesc, phecodeid,phecodeid2)  \n" +
                                    "values (?,?,?,?,?)");
                    // "myuser, webpage, datum, summary, COMMENTS from feedback.comments");
                    // Parameters start with 1
                    preparedStatement.setDouble(1,count );
                    preparedStatement.setDouble(2, 1.00);
                    preparedStatement.setString(3,desc );
                    preparedStatement.setDouble(4,phecodeid );
                    preparedStatement.setString(5,phecodeid2 );



                    System.out.println(preparedStatement);

                    preparedStatement.executeUpdate();
                    count++;

                    statement.close();
                    connect.close();






                }



            }
            catch (IOException e)
            {
                e.printStackTrace();
            }


            // PreparedStatements can use variables and are more efficient


        } catch (Exception e) {
            throw e;
        } finally {
            close();
        }

    }

    private void writeMetaData(ResultSet resultSet) throws SQLException {
        //  Now get some metadata from the database
        // Result set get the result of the SQL query

        System.out.println("The columns in the table are: ");

        System.out.println("Table: " + resultSet.getMetaData().getTableName(1));
        for  (int i = 1; i<= resultSet.getMetaData().getColumnCount(); i++){
            System.out.println("Column " +i  + " "+ resultSet.getMetaData().getColumnName(i));
        }
    }

    private void writeResultSet(ResultSet resultSet) throws SQLException {
        // ResultSet is initially before the first data set
        while (resultSet.next()) {
            // It is possible to get the columns via name
            // also possible to get the columns via the column number
            // which starts at 1
            // e.g. resultSet.getSTring(2);
            String user = resultSet.getString("myuser");
            String website = resultSet.getString("webpage");
            String summary = resultSet.getString("summary");
            Date date = resultSet.getDate("datum");
            String comment = resultSet.getString("comments");
            System.out.println("User: " + user);
            System.out.println("Website: " + website);
            System.out.println("summary: " + summary);
            System.out.println("Date: " + date);
            System.out.println("Comment: " + comment);
        }
    }

    // You need to close the resultSet
    private void close() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }

            if (statement != null) {
                statement.close();
            }

            if (connect != null) {
                connect.close();
            }
        } catch (Exception e) {

        }
    }

}