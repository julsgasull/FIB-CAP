import java.lang.*;
import java.io.*;
import java.util.*;
import org.apache.commons.lang3.*;

public class Memoizer {

    private static double[] Arguments = { };
    private static double[] Resultats = { };

   private static String part1 = StringEscapeUtils.escapeJava("import java.lang.*;\nimport java.io.*;\nimport java.util.*;\nimport org.apache.commons.lang3.*;\n\npublic class Memoizer {\n\n   private static double[] Arguments = { ");
   private static String part2 = StringEscapeUtils.escapeJava(" }; \n   private static double[] Resultats = { ");
   private static String part3 = StringEscapeUtils.escapeJava("}; \n\n");
   private static String part4 = StringEscapeUtils.escapeJava("   static public double memoizedf (double x) throws IOException, InterruptedException { \n        int mida = Arguments.length; \n\n        int i; \n        for (i=0; (i < mida) && (x != Arguments[i]); ++i); \n        if (i < mida) return Resultats[i]; \n\t      else { \n\n\t        double res = f(x); \n\n\t        double[] nousArguments = new double[mida + 1]; \n\t        double[] nousResultats = new double[mida + 1]; \n\n\t        System.arraycopy(Arguments,0,nousArguments,0,mida); \n\t        System.arraycopy(Resultats,0,nousResultats,0,mida); \n\t        nousArguments[mida] = x; \n\t        nousResultats[mida] = res; \n\n\t        Arguments = nousArguments; \n\t        Resultats = nousResultats; \n\n\t        String sourceClass = StringEscapeUtils.unescapeJava(part1); \n\t        for (int j=0; j < mida; ++j) sourceClass += Arguments[j]+\",\";  \n\t        sourceClass += Arguments[mida]; \n\t        sourceClass += StringEscapeUtils.unescapeJava(part2); \n          for (int j=0; j < mida; ++j) sourceClass += Resultats[j]+\",\";  \n\t        sourceClass += Resultats[mida]; \n\t        sourceClass += StringEscapeUtils.unescapeJava(part3); \n\n\t        sourceClass += \"   private static String part1 = StringEscapeUtils.escapeJava(\\\"\" + part1 + \"\\\");\\n\";\n\t        sourceClass += \"   private static String part2 = StringEscapeUtils.escapeJava(\\\"\" + part2 + \"\\\");\\n\";\n\t        sourceClass += \"   private static String part3 = StringEscapeUtils.escapeJava(\\\"\" + part3 + \"\\\");\\n\";\n\t        sourceClass += \"   private static String part4 = StringEscapeUtils.escapeJava(\\\"\" + part4 + \"\\\");\\n\\n\";\n\t        sourceClass += StringEscapeUtils.unescapeJava(part4);\n\n\t        String outputClassName = \"Memoizer.java\"; \n\t        FileWriter outputFile = new FileWriter( outputClassName );  \n\t        outputFile.write( sourceClass); \n\t        outputFile.close(); \n\n\t        ProcessBuilder pb = new ProcessBuilder(\"javac\",outputClassName); \n\t        Map<String, String> env = pb.environment(); \n\t        env.put(\"CLASSPATH\", \".:./commons-lang3-3.1.jar\"); \n\t        Process p = pb.start(); \n\t        p.waitFor(); \n\t        //System.out.println( outputClassName + \" compiled\"); \n\n\t        // pb = new ProcessBuilder(\"rm\",outputClassName); \n\t        // p = pb.start(); \n\t        // p.waitFor(); \n\n\t        return res; \n\t      } \n   } \n\n   static private double f(double x) { for(long i=0; i < 100000000; ++i); return 2*x; }    \n\n}");

   static public double memoizedf (double x) throws IOException, InterruptedException { 
        int mida = Arguments.length; 

        int i; 
        for (i=0; (i < mida) && (x != Arguments[i]); ++i); 
        if (i < mida) return Resultats[i]; 
	      else { 

	        double res = f(x); 

	        double[] nousArguments = new double[mida + 1]; 
	        double[] nousResultats = new double[mida + 1]; 

	        System.arraycopy(Arguments,0,nousArguments,0,mida); 
	        System.arraycopy(Resultats,0,nousResultats,0,mida); 
	        nousArguments[mida] = x; 
	        nousResultats[mida] = res; 

	        Arguments = nousArguments; 
	        Resultats = nousResultats; 

	        String sourceClass = StringEscapeUtils.unescapeJava(part1); 
	        for (int j=0; j < mida; ++j) sourceClass += Arguments[j]+",";  
	        sourceClass += Arguments[mida]; 
	        sourceClass += StringEscapeUtils.unescapeJava(part2); 
          for (int j=0; j < mida; ++j) sourceClass += Resultats[j]+",";  
	        sourceClass += Resultats[mida]; 
	        sourceClass += StringEscapeUtils.unescapeJava(part3); 

	        sourceClass += "   private static String part1 = StringEscapeUtils.escapeJava(\"" + part1 + "\");\n";
	        sourceClass += "   private static String part2 = StringEscapeUtils.escapeJava(\"" + part2 + "\");\n";
	        sourceClass += "   private static String part3 = StringEscapeUtils.escapeJava(\"" + part3 + "\");\n";
	        sourceClass += "   private static String part4 = StringEscapeUtils.escapeJava(\"" + part4 + "\");\n\n";
	        sourceClass += StringEscapeUtils.unescapeJava(part4);

	        String outputClassName = "Memoizer.java"; 
	        FileWriter outputFile = new FileWriter( outputClassName );  
	        outputFile.write( sourceClass); 
	        outputFile.close(); 

	        ProcessBuilder pb = new ProcessBuilder("javac",outputClassName); 
	        Map<String, String> env = pb.environment(); 
	        env.put("CLASSPATH", ".:./commons-lang3-3.1.jar"); 
	        Process p = pb.start(); 
	        p.waitFor(); 
	        //System.out.println( outputClassName + " compiled"); 

	        // pb = new ProcessBuilder("rm",outputClassName); 
	        // p = pb.start(); 
	        // p.waitFor(); 

	        return res; 
	      } 
   } 

   static private double f(double x) { for(long i=0; i < 100000000; ++i); return 2*x; }    

}
