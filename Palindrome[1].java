/**
 * Write an efficient algorithm to check if a string is a palindrome. A string is a palindrome if the string matches
 * the reverse of string.Example: 1221 is a palindrome but not 1121.
 */

public class Palindrome {

    public static void main(String[] args) {
        String[] arrayString = {"Palindrome", "Logan", "hello", "A man, a plan, a canal. Panama",
                "My age is 0, 0 si ega ym.", "lol", "Haah", "Palindrome", "maaM", "race car"};
        for (String word : arrayString) {
            show(word, isPalindrome(word));
        }
    }

    /**
     * Check if a string is palindrome using ignore case, using Time O(n/2), Space O(N)
     *
     * @param string
     * @return
     */
    private static boolean isPalindrome(String string) {
        String wordWithoutCase = string.toLowerCase();
        String stringWithoutPattern = wordWithoutCase.replaceAll("[^a-z0-9]", "");
        int lastElement = stringWithoutPattern.length() - 1;
        for (int i = 0; i < stringWithoutPattern.length() / 2; i++) {
            if (!(stringWithoutPattern.charAt(i) == stringWithoutPattern.charAt(lastElement - i))) {
                return false;
            }
        }
        return true;
    }

    /**
     * Display result
     */
    private static void show(String string, boolean palindrome) {
        if (palindrome) {
            System.out.println(string + " " + "is palindrome");
        } else {
            System.out.println(string + " " + "is not palindrome");
        }
    }

}
