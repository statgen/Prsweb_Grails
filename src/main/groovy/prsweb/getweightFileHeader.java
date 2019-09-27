package prsweb;



import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class getweightFileHeader {

    private static String readWtFile(String fpath)
    {




        String datadirpath ="";

            datadirpath = "/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version2/PRSweb_Update_20190801/data/";

        String filepath =datadirpath+fpath+"_WEIGHTS.txt";
        File file = new File(filepath);

        System.out.println(file.exists());
        String infof = "";

        try {

            BufferedReader br = new BufferedReader(new FileReader(filepath));
            String line;



            while ((line = br.readLine()) != null) {


                if (line.contains("##")) {
                    // println(line)
                    infof = infof + line.replace("##", "") + "\n";
                }


            }
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }




        System.out.println(infof);


        return infof;



    }
}
