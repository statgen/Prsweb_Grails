package prsweb;




import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;

public class createDisplayData {

    public static void main(String[] args) throws Exception {
        createDisplayData dao = new createDisplayData();
        dao.readDataBase();
    }


    private Connection connect = null;
    private Statement statement = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

//set SQL_SAFE_UPDATES =0;
//UPDATE prsweb.display_data  SET aucci = TRIM(BOTH '"' FROM aucci);

    public void readDataBase() throws Exception {
        try {
            // This will load the MySQL driver, each DB has its own driver


            String filepath = "/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version5/PRSweb_Update_20190801/PRS_Evaluation_Overview_20190801_mod.txt";

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

                    //phecode	prefix	description	reference	source	url	n_cases	n_controls	sex	comment	outsource	prswebprefix	genomeLD	genomePRS	method	Predictor	Tuning_Parameter	SNPs
                    // P	BETA	SEBETA	OR	OR_CI	LOG10P	AUC	AUC_CI	R2 (Nagelkerke [Cragg and Uhler])	HosmerLemeshow_ChiSq	HosmerLemeshow_P	BrierScore	R2 (McFadden)	R2 (Cox and Snell [ML])
                    // Top_0.01_BETA	Top_0.01_SEBETA	Top_0.01_P	Top_0.01_OR	Top_0.01_CI1	Top_0.01_CI2	Top_0.01_LOG10P	Top_0.02_BETA	Top_0.02_SEBETA	Top_0.02_P	Top_0.02_OR	Top_0.02_CI1	Top_0.02_CI2
                    // Top_0.02_LOG10P	Top_0.05_BETA	Top_0.05_SEBETA	Top_0.05_P	Top_0.05_OR	Top_0.05_CI1	Top_0.05_CI2	Top_0.05_LOG10P	Top_0.1_BETA	Top_0.1_SEBETA	Top_0.1_P	Top_0.1_OR	Top_0.1_CI1
                    // Top_0.1_CI2	Top_0.1_LOG10P	Top_0.25_BETA	Top_0.25_SEBETA	Top_0.25_P	Top_0.25_OR	Top_0.25_CI1	Top_0.25_CI2	Top_0.25_LOG10P	MinPower80	Top_MinPower80_BETA	Top_MinPower80_SEBETA
                    // Top_MinPower80_P	Top_MinPower80_OR	Top_MinPower80_CI1	Top_MinPower80_CI2	Top_MinPower80_LOG10P	Top_Underpowered	N_Q1	N_Q2	N_Q3	N_Q4	Q1Q2_BETA	Q1Q2_SEBETA	Q1Q2_P
                    // Q1Q2_OR	Q1Q2_CI1	Q1Q2_CI2	Q1Q2_LOG10P	Q1Q3_BETA	Q1Q3_SEBETA	Q1Q3_P	Q1Q3_OR	Q1Q3_CI1	Q1Q3_CI2	Q1Q3_LOG10P	Q1Q4_BETA	Q1Q4_SEBETA	Q1Q4_P	Q1Q4_OR	Q1Q4_CI1	Q1Q4_CI2
                    // Q1Q4_LOG10P	PRS_PHEWAS	NOMINAL_SIGNIFICANT	WARNING_REVERSED_EFFECT	WARNING_PERCENTILES_UNDERPOWERED	WARNING_NO_QUARTILE_ANALYSIS	prsweb_date	method_details	Tuning_Parameters_Clean	genome_build
                    // referenceURL

                    String prefixdata=tokens[colorder.get("prefix")];
                    String phecodedata=tokens[colorder.get("phecode")];
                    String descdata=tokens[colorder.get("description")];
                    String refdata=tokens[colorder.get("reference")];
                    // String sourcedata=tokens[colorder.get("phewas_code")];
                    String urldata=tokens[colorder.get("url")];
                    String ncases=tokens[colorder.get("n_cases")];
                    String ncontrols=tokens[colorder.get("n_controls")];
                    String sexdata=tokens[colorder.get("sex")];
                    String phenomes=tokens[colorder.get("genomePRS")];
                    String outsource=tokens[colorder.get("outsource")];
                    Integer nsnp=Integer.parseInt(tokens[colorder.get("SNPs")]);
                    Double r2_nage=Double.parseDouble(tokens[colorder.get("R2 (Nagelkerke [Cragg and Uhler])")]);
                    Double brierScore=Double.parseDouble(tokens[colorder.get("BrierScore")]);
                    Double auc=Double.parseDouble(tokens[colorder.get("AUC")]);
                    String aucci=tokens[colorder.get("AUC_CI")];
                    //System.out.println(prefixdata+ " : "+tokens[colorder.get("HosmerLemeshow_ChiSq")].isEmpty());
                    Double hosm_chi=tokens[colorder.get("HosmerLemeshow_ChiSq")].isEmpty() ? 0: Double.parseDouble(tokens[colorder.get("HosmerLemeshow_ChiSq")]);
                    Double hosm_p=tokens[colorder.get("HosmerLemeshow_P")].isEmpty()? 0:Double.parseDouble(tokens[colorder.get("HosmerLemeshow_P")]);
                    int phecat=2;
                    String prsweb=tokens[colorder.get("PRS_PHEWAS")]; //indicates phenomwide significan=

                    String nomsig=tokens[colorder.get("NOMINAL_SIGNIFICANT")]; //nominal_significance
                    String warreveff=tokens[colorder.get("WARNING_REVERSED_EFFECT")];//warning_reversed_effect
                    String perunpow=tokens[colorder.get("WARNING_PERCENTILES_UNDERPOWERED")];
                    String quaanal=tokens[colorder.get("WARNING_NO_QUARTILE_ANALYSIS")];

                    String pval=tokens[colorder.get("P")];
                    String logpval=tokens[colorder.get("LOG10P")];
                    String orval=tokens[colorder.get("OR")];
                    String orcival=tokens[colorder.get("OR_CI")];

                    String prswebprefix=tokens[colorder.get("prswebprefix")];
                    String method=tokens[colorder.get("method")];

                    String genld=tokens[colorder.get("genomeLD")];
                    String source=tokens[colorder.get("source")];
                    String datecreated="2018-08-01";//tokens[colorder.get("prsweb_date")];

                    String topor=tokens[colorder.get("Top_0.01_OR")];
                    String toporci1=tokens[colorder.get("Top_0.01_CI1")];
                    String toporci2=tokens[colorder.get("Top_0.01_CI2")];

                    String topor2=tokens[colorder.get("Top_0.02_OR")];
                    String toporci12=tokens[colorder.get("Top_0.02_CI1")];
                    String toporci22=tokens[colorder.get("Top_0.02_CI2")];

                    String topor5=tokens[colorder.get("Top_0.05_OR")];
                    String toporci15=tokens[colorder.get("Top_0.05_CI1")];
                    String toporci25=tokens[colorder.get("Top_0.05_CI2")];

                    String tunparam=tokens[colorder.get("Tuning_Parameters_Clean")];
                    String genome_build=tokens[colorder.get("genome_build")];

                    //"phecode"	"prefix"	"description"	"reference"	"source"	"url"	"n_cases"	"n_controls"	"sex"	"comment"	"outsource"	"prswebprefix"
                    // "genomeLD"	"genomePRS"	"method"	"Predictor"	"Tuning_Parameter"	"SNPs"	"P"	"BETA"	"SEBETA"	"OR"	"OR_CI"	"LOG10P"	"AUC"	"AUC_CI"
                    // "R2 (Nagelkerke [Cragg and Uhler])"	"HosmerLemeshow_ChiSq"	"HosmerLemeshow_P"	"BrierScore"	"R2 (McFadden)"	"R2 (Cox and Snell [ML])"
                    // "Top_0.01_BETA"	"Top_0.01_SEBETA"	"Top_0.01_P"	"Top_0.01_OR"	"Top_0.01_CI1"	"Top_0.01_CI2"	"Top_0.01_LOG10P"
                    // "Top_0.02_BETA"	"Top_0.02_SEBETA"	"Top_0.02_P"	"Top_0.02_OR"	"Top_0.02_CI1"	"Top_0.02_CI2"	"Top_0.02_LOG10P"
                    // "Top_0.05_BETA"	"Top_0.05_SEBETA"	"Top_0.05_P"	"Top_0.05_OR"	"Top_0.05_CI1"	"Top_0.05_CI2"	"Top_0.05_LOG10P"
                    // "Top_0.1_BETA"	"Top_0.1_SEBETA"	"Top_0.1_P"	"Top_0.1_OR"	"Top_0.1_CI1"	"Top_0.1_CI2"	"Top_0.1_LOG10P"
                    // "Top_0.25_BETA"	"Top_0.25_SEBETA"	"Top_0.25_P"	"Top_0.25_OR"	"Top_0.25_CI1"	"Top_0.25_CI2"	"Top_0.25_LOG10P"
                    // "MinPower80"	"Top_MinPower80_BETA"	"Top_MinPower80_SEBETA"	"Top_MinPower80_P"	"Top_MinPower80_OR"	"Top_MinPower80_CI1"	"Top_MinPower80_CI2"
                    // "Top_MinPower80_LOG10P"	"Top_Underpowered"	"N_Q1"	"N_Q2"	"N_Q3"	"N_Q4"	"Q1Q2_BETA"	"Q1Q2_SEBETA"	"Q1Q2_P"	"Q1Q2_OR"	"Q1Q2_CI1"	"Q1Q2_CI2"
                    // "Q1Q2_LOG10P"	"Q1Q3_BETA"	"Q1Q3_SEBETA"	"Q1Q3_P"	"Q1Q3_OR"	"Q1Q3_CI1"	"Q1Q3_CI2"	"Q1Q3_LOG10P"	"Q1Q4_BETA"	"Q1Q4_SEBETA"	"Q1Q4_P"
                    // "Q1Q4_OR"	"Q1Q4_CI1"	"Q1Q4_CI2"	"Q1Q4_LOG10P"	"PHENOMEWIDE_SIGNIFICANT"	"NOMINAL_SIGNIFICANT"	"WARNING_REVERSED_EFFECT"
                    // "WARNING_PERCENTILES_UNDERPOWERED"	"WARNING_NO_QUARTILE_ANALYSIS"	"prsweb_date"	"method_details"	"Tuning_Parameters_Clean"	"genome_build"



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
                            .prepareStatement("insert into  prsweb.display_data (id, version, aucci, hosm_p, orval, descdata, auc, refdata, urldata, brier_score, pval, phecodedata, prsweb, hosm_chi, ncontrols, nomsig, quaanal, outsource, method, phecat, r2_nage, phenomes, nsnp, prefixdata, ncases, logpval, prswebprefix, perunpow, sexdata, warreveff, orcival, toporci2, source, topor, toporci1, genld, datecreated, tunparam,genomebuild,toporci22, topor2, toporci12,toporci25, topor5, toporci15) \n" +
                                    "values ( ?, ?, ?, ? , ?, ?,?, ?, ?, ? , ?, ?,?, ?, ?, ? , ?, ?,?, ?, ?, ? , ?, ?,?, ?, ?, ? , ?, ?,?, ?, ?, ? , ?, ?,?,?,?,?,?,?,?,?,?)");
                    // "myuser, webpage, datum, summary, COMMENTS from feedback.comments");
                    // Parameters start with 1
                    preparedStatement.setDouble(1,count );
                    preparedStatement.setDouble(2, 1.00);
                    preparedStatement.setString(3,aucci );
                    preparedStatement.setDouble(4,hosm_p );
                    preparedStatement.setString(5,orval );
                    preparedStatement.setString(6,descdata );
                    preparedStatement.setDouble(7,auc );
                    preparedStatement.setString(8,refdata );
                    preparedStatement.setString(9,urldata );
                    preparedStatement.setDouble(10,brierScore );
                    preparedStatement.setString(11,pval );
                    preparedStatement.setString(12,phecodedata );
                    preparedStatement.setString(13,prsweb );
                    preparedStatement.setDouble(14,hosm_chi );
                    preparedStatement.setString(15,ncontrols );
                    preparedStatement.setString(16,nomsig );
                    preparedStatement.setString(17,quaanal );
                    preparedStatement.setString(18,outsource );
                    preparedStatement.setString(19,method );
                    preparedStatement.setInt(20,phecat );
                    preparedStatement.setDouble(21,r2_nage );
                    preparedStatement.setString(22,phenomes );
                    preparedStatement.setInt(23,nsnp );
                    preparedStatement.setString(24,prefixdata );
                    preparedStatement.setString(25,ncases );
                    preparedStatement.setString(26,logpval );
                    preparedStatement.setString(27,prswebprefix );
                    preparedStatement.setString(28,perunpow );
                    preparedStatement.setString(29,sexdata );
                    preparedStatement.setString(30,warreveff );
                    preparedStatement.setString(31,orcival );

                    preparedStatement.setString(32,toporci2 );
                    preparedStatement.setString(33,source );
                    preparedStatement.setString(34,topor );
                    preparedStatement.setString(35,toporci1 );
                    preparedStatement.setString(36,genld );
                    preparedStatement.setString(37,datecreated );
                    preparedStatement.setString(38,tunparam );
                    preparedStatement.setString(39,genome_build );

                    preparedStatement.setString(40,toporci22 );
                    preparedStatement.setString(41,topor2 );
                    preparedStatement.setString(42,toporci12 );

                    preparedStatement.setString(43,toporci25 );
                    preparedStatement.setString(44,topor5 );
                    preparedStatement.setString(45,toporci15 );

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