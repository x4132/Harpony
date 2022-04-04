import java.util.Scanner;
import java.nio.file.Paths;
import java.util.regex.Pattern;

public class OsuFile {
    Scanner scanner;
    String pwd;

    String audioFile;
    String title;

    OsuFile(String filename, String pwd) {
        try {
            this.pwd = pwd;
            System.out.println(Paths.get(pwd, filename).toString());
            scanner = new Scanner(Paths.get(pwd, filename));
            Pattern sections = Pattern.compile("\\[.*]");
            scanner.useDelimiter(sections);
            scanner.next(); scanner.nextLine(); // seek to [General]
            audioFile = scanner.nextLine().split(":")[1].trim();
            scanner.next(); scanner.next(); scanner.nextLine(); // seek to [Metadata]
            title = scanner.nextLine().split(":")[1].trim();
            

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    static void println(String s) {
        System.out.println(s);
    }

    void destructor() {

    }
}
