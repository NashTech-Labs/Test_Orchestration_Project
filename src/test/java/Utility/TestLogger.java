package Utility;

    import java.io.FileWriter;
import java.io.IOException;

    public class TestLogger {
        private static final String LOG_FILE = "test_results.log";

        public static void log(String message) {
            try (FileWriter writer = new FileWriter(LOG_FILE, true)) {
                writer.write(message + "\n");
            } catch (IOException e) {
                System.err.println("Error writing to log file: " + e.getMessage());
            }
        }
    }


