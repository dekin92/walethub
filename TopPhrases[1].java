import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Given a large file that does not fit in memory (say 10GB), find the top 100000 most frequent phrases. * The file has
 * 50 phrases per line separated by a pipe (|). Assume that the phrases do not contain pipe. * Example line may look
 * like: Foobar Candy | Olympics 2012 | PGA | CNET | Microsoft Bing …. * The above line has 5 * phrases in
 * visible region.
 */
public class TopPhrases {

    private static final String PATH = "D:\\phrases.txt";
    private static final int LIMIT = 100000;

    public static void main(String[] args) {
        Map<String, Integer> topPhrases = searchTopPhrases();
        show(topPhrases);
    }

    /**
     * Read the file line by line and divide words by "|", after check if there is a word in the map, if there is,
     * then improve the counter and put in map, if not - put in map. Using Time O(N), Space O(N)
     *
     * @return
     */
    private static Map<String, Integer> searchTopPhrases() {
        Map<String, Integer> topPhrases = new HashMap<>();
        String arrayLine;
        try (BufferedReader br = new BufferedReader(new FileReader(PATH))) {
            while ((arrayLine = br.readLine()) != null) {
                String[] splitLine = arrayLine.split("\\|");
                for (String phrase : splitLine) {
                    String phraseWithoutSpace = phrase.trim();
                    if (topPhrases.containsKey(phraseWithoutSpace)) {
                        topPhrases.put(phraseWithoutSpace, topPhrases.get(phraseWithoutSpace) + 1);
                    } else {
                        topPhrases.put(phraseWithoutSpace, 1);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map<String, Integer> sortedTopPhrases = topPhrases.entrySet().stream()
                .sorted(Map.Entry.comparingByValue(Collections.reverseOrder()))
                .limit(LIMIT)
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        Map.Entry::getValue,
                        (e1, e2) -> e1,
                        LinkedHashMap::new
                ));

        return sortedTopPhrases;
    }

    /**
     * Display result
     *
     * @param topPhrases
     */
    private static void show(Map<String, Integer> topPhrases) {
        for (Map.Entry<String, Integer> entry : topPhrases.entrySet()) {
            System.out.println(entry.getKey() + " " + entry.getValue());
        }
    }
}
