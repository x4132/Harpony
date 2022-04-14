import java.util.Scanner;
import java.nio.file.Paths;
import java.util.regex.Pattern;
import java.util.ArrayList;

class OsuFile {
    Scanner scanner;
    String pwd;

    String audioFile;
    String title;
    String artist;

    int bpm;
    int meter;

    int total = 0;

    ArrayList<ArrayList<Note>> cols = new ArrayList<ArrayList<Note>>();

    OsuFile(String filename, String pwd) {
        cols.add(new ArrayList<Note>());
        cols.add(new ArrayList<Note>());
        cols.add(new ArrayList<Note>());
        cols.add(new ArrayList<Note>());

        try {
            long start = System.currentTimeMillis();
            this.pwd = pwd;
            System.out.println(Paths.get(pwd, filename).toString());
            scanner = new Scanner(Paths.get(pwd, filename));
            Pattern sections = Pattern.compile("\\[.*]");
            scanner.useDelimiter(sections);

            scanner.next(); scanner.nextLine(); // seek to [General]

            audioFile = scanner.nextLine().split(":")[1].trim();

            scanner.next(); scanner.next(); scanner.nextLine(); // seek to [Metadata]
            println("Loading Metadata");

            title = scanner.nextLine().split(":")[1].trim(); scanner.nextLine();
            artist = scanner.nextLine().split(":")[1].trim();

            scanner.next(); scanner.next(); scanner.next(); scanner.nextLine(); // seek to [TimingPoints]
            println("Loading Timings");

            // TIMING POINT (SINGULAR)
            scanner.useDelimiter(",");
            scanner.next();
            bpm = (int) Math.floor(60000 / scanner.nextDouble());
            meter = scanner.nextInt();
            scanner.useDelimiter(sections);
            
            scanner.next();scanner.nextLine();// seek to [HitObjects]
            println("Loading Hit Objects");
            scanner.useDelimiter(",");

            // HIT OBJECTS
            while (scanner.hasNextLine()) {
                total++;
                int col = (int) Math.floor(scanner.nextInt() * 4 / 512); scanner.next();
                int time = scanner.nextInt();
                int type = scanner.nextInt();
                int end = -1;
                scanner.nextInt();

                switch(type) {
                    case 1:
                        cols.get(col).add(new Note(time));
                        break;
                    case 128:
                        scanner.skip(",");
                        end = Integer.parseInt(scanner.nextLine().split(":")[0].trim());
                        cols.get(col).add(new Hold(time, end));
                        total++;
                        continue;
                    default:
                        break;
                }

                scanner.nextLine();
            }

            println(artist + " - " + title);
            println("Audio Source audio/" + audioFile);
            println(bpm + " bpm in " + meter + "/4 meter");
            println("Loaded " + total + " notes in " + (System.currentTimeMillis() - start) + " milliseconds");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    void destructor() {

    }
}