/**
 * Created by Kristo on 24.10.2016.
 */

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Random;

public class Runner {

    public static void main(String[] args) {
        /*
        String fileName = "C:/Users/Kristo/Documents/Andmebaasid II/hex-codes-500.txt";
        String tableName = "Toote_varv";
        String idAttr = "toote_varv";
        String nameAttr = "nimetus";
        String descAttr = "kirjeldus";

        // INSERT INTO Isiku_seisundi_liik(isiku_seisundi_liik_kood, nimetus, kirjeldus) VALUES (1,'Elus','Inimene on elus');
        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {

            String line;
            while ((line = br.readLine()) != null) {

                String[] details = line.split("\t\t");

                String code = details[1].trim();
                String name = (details[0].substring(0,1).toUpperCase() + details[0].substring(1)).trim();
                String first = generateDroppingItems3();
                String desc = makeFirstUpper(first) + makeFirstUpper(first, generateDroppingItems1()) + " ja" + generateDroppingItems4() + generateDroppingItems2();

                System.out.println("INSERT INTO " + tableName + "(" + idAttr + ", " + nameAttr + ", " + descAttr + ") VALUES ('" + code + "', '" + name + "', '" + desc + "');");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }*/
        String fileName = "C:/Users/Kristo/Documents/Andmebaasid II/brands.txt";
        String tableName = "Toote_brand";
        String idAttr = "toote_brand_kood";
        String nameAttr = "nimetus";
        String descAttr = "kirjeldus";

        // INSERT INTO Isiku_seisundi_liik(isiku_seisundi_liik_kood, nimetus, kirjeldus) VALUES (1,'Elus','Inimene on elus');
        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {

            String line;
            while ((line = br.readLine()) != null) {

                String[] details = line.split("\t");

                String code = details[0].trim();
                String name = (details[1].substring(0,1).toUpperCase() + details[1].substring(1)).trim();
                String first = generateDroppingItems3();
                String desc = details[2];

                System.out.println("INSERT INTO " + tableName + "(" + idAttr + ", " + nameAttr + ", " + descAttr + ") VALUES ('" + code + "', '" + name + "', '" + desc + "');");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String makeFirstUpper(String s) {
        if (!s.equals(" ")) {
            return s.substring(0,1).toUpperCase() + s.substring(1);
        } else {
            return "";
        }
    }

    private static String makeFirstUpper(String first, String second) {
        if (first.equals(" ")) {
            return second.substring(0,1).toUpperCase() + second.substring(1);
        } else {
            return second;
        }
    }

    private static String generateDroppingItems1() {
        double d = new Random().nextDouble();
        if (d <= 0.10) {
            return "ilus";
        } else if (d > 0.10 && d <= 0.20) {
            return "rahustav";
        } else if (d > 0.20 && d <= 0.30) {
            return "elegantne";
        } else if (d > 0.30 && d <= 0.40) {
            return "lummav";
        } else if (d > 0.40 && d <= 0.50) {
            return "kaunis";
        } else if (d > 0.50 && d <= 0.60) {
            return "suurejooneline";
        } else if (d > 0.60 && d <= 0.70) {
            return "nooruslik";
        } else if (d > 0.70 && d <= 0.80) {
            return "modernne";
        } else if (d > 0.80 && d <= 0.90) {
            return "klassikaline";
        } else {
            return "kordumatu";
        }
    }

    private static String generateDroppingItems2() {
        double d = new Random().nextDouble();
        if (d <= 0.10) {
            return "aukartustäratav";
        } else if (d > 0.10 && d <= 0.20) {
            return "tagasihoidlik";
        } else if (d > 0.20 && d <= 0.30) {
            return "malbe";
        } else if (d > 0.30 && d <= 0.40) {
            return "julge";
        } else if (d > 0.40 && d <= 0.50) {
            return "lihtne";
        } else if (d > 0.50 && d <= 0.60) {
            return "salapärane";
        } else if (d > 0.60 && d <= 0.70) {
            return "kutsuv";
        } else if (d > 0.70 && d <= 0.80) {
            return "kirgas";
        } else if (d > 0.80 && d <= 0.90) {
            return "traditsiooniline";
        } else {
            return "nooruslik";
        }
    }

    private static String generateDroppingItems3() {
        double d = new Random().nextDouble();
        if (d <= 0.15) {
            return "üpris ";
        } else if (d > 0.15 && d <= 0.30) {
            return "väga ";
        } else if (d > 0.30 && d <= 0.45) {
            return "natuke ";
        } else if (d > 0.45 && d <= 0.60) {
            return "pisut ";
        } else if (d > 0.60 && d <= 0.80) {
            return "õige pisut ";
        } else {
            return "ülimalt ";
        }
    }

    private static String generateDroppingItems4() {
        double d = new Random().nextDouble();
        if (d <= 0.15) {
            return " veidi ";
        } else if (d > 0.15 && d <= 0.30) {
            return " kergelt ";
        } else if (d > 0.30 && d <= 0.45) {
            return " üüratult ";
        } else if (d > 0.45 && d <= 0.60) {
            return " äärmiselt ";
        } else if (d > 0.60 && d <= 0.80) {
            return " ääretult ";
        } else {
            return " ";
        }
    }

}
