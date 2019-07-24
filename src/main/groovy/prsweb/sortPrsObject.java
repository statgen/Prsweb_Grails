package prsweb;



/**
 * Created by snehalpatil on 6/7/19.
 */

import java.lang.Math;


public class sortPrsObject{

public static void main(String[]args){
    sortPrsObject dmd=new sortPrsObject();



        }

        //log10 of negative value returns NaN, so avoaid that convert that into the  positive and then take
private static Double str2neglog10(Double x)
        {
            double pout;

            if ( x> 0 )
            {
               pout =  -Math.log10(x);

            }
            else
            {

                x= x*-1;

                pout= Math.log10(x);

            }



            return pout;


        }

        }





