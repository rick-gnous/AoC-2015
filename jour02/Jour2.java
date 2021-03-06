import java.util.Scanner;
import java.io.FileInputStream;
import java.io.RandomAccessFile;
import java.util.ArrayList;

public class Jour2 {
        private String filename;
        private FileInputStream fis;
        private Scanner sc;
        private ArrayList<Box> listBox;
        
        public Jour2(String filename) {
                this.filename = filename;
                this.listBox = new ArrayList<Box>();
        }

        public void premPartie() {
                int result = 0, x, y, z;
                this.loadFile();
                try {
                        String line;
                        while (sc.hasNextLine()) {
                                line = sc.nextLine();
                                String[] tokens = line.split("x");
                                x = Integer.parseInt(tokens[0]);
                                y = Integer.parseInt(tokens[1]);
                                z = Integer.parseInt(tokens[2]);
                                this.listBox.add(new Box(x, y, z));
                        }

                        for (int i = 0; i < this.listBox.size(); i++) {
                                result += this.listBox.get(i).getSurface();
                                result += this.listBox.get(i).areaSmallSurface();
                        }
                } catch (Exception e) {
                        System.err.println("Erreur !!");
                        e.printStackTrace();
                }

                this.unloadFile();
                System.out.println("Il faut " + result + " pieds de papiers cadeaux.");
        }

        public void deuxPartie() {
                this.loadFile();
                try {
                        //while (sc.hasNextLine()) {
                        //        
                        //}

                } catch (Exception e) {
                        System.err.println("Erreur !!");
                        e.printStackTrace();
                }
                this.unloadFile();
        }

        private void loadFile() {
                try {
                        this.fis = new FileInputStream(filename);
                        this.sc = new Scanner(fis);
                } catch (Exception e) {
                        System.err.println("Erreur rencontrée lors de"
                                        + "l’ouverture du fichier.");
                        e.printStackTrace();
                }
        }

        private void unloadFile() {
                try {
                        this.sc.close();
                        this.fis.close();
                } catch (Exception e) {
                        System.err.println("Erreur rencontrée lors de la "
                                        + "fermeture du fichier.");
                        e.printStackTrace();
                }
        }
}
