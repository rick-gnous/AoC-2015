import java.util.Scanner;
import java.io.FileInputStream;
import java.util.ArrayList;

public class Jour2 {
        private String filename;
        private ArrayList<Box> listBox;
        
        public Jour2(String filename) {
                this.filename = filename;
                this.listBox = new ArrayList<Box>();
        }

        /**
         * Charge dans l’attribut listBox les boites contenues dans le fichier.
         */
        private void loadFileArrayList() {
                int x, y, z;
                try {
                        FileInputStream fis = new FileInputStream(filename);
                        Scanner sc = new Scanner(fis);
                        String line;
                        while (sc.hasNextLine()) {
                                line = sc.nextLine();
                                String[] tokens = line.split("x");
                                x = Integer.parseInt(tokens[0]);
                                y = Integer.parseInt(tokens[1]);
                                z = Integer.parseInt(tokens[2]);
                                this.listBox.add(new Box(x, y, z));
                        }
                        sc.close();
                        fis.close();
                } catch (Exception e) {
                        System.err.println("Erreur !!");
                        e.printStackTrace();
                }
        }

        public void premPartie() {
                if (this.listBox.isEmpty())
                        this.loadFileArrayList();
                int result = 0;
                for (int i = 0; i < this.listBox.size(); i++) {
                        result += this.listBox.get(i).getSurface();
                        result += this.listBox.get(i).areaSmallSurface();
                }
                System.out.println("Il faut " + result + " pieds de papiers cadeaux.");
        }

        public void deuxPartie() {
                if (this.listBox.isEmpty())
                        this.loadFileArrayList();
                int result = 0;
                for (int i = 0; i < this.listBox.size(); i++)
                        result += this.listBox.get(i).calculateRibbon();
                System.out.println("Il faut " + result + " pieds de rubans.");
        }
}
