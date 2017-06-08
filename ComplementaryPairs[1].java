import java.util.ArrayList;
import java.util.List;

/**
 * Write an efficient algorithm to find K-complementary pairs in a given array of integers. Given Array A, pair (i, j)
 * is K- complementary if K = A[i] + A[j];
 */
public class ComplementaryPairs {

    public static void main(String[] args) {
        int[] array = {1, 4, 2, 0, 5, 8, 2, 3, 4};
        int k = 5;
        List<Pair> complimentaryPairs = searchComplimentary(k, array);
        show(k, complimentaryPairs);
    }

    /**
     * search K-complementary pairs , using Time O(N*N), Space O(N)
     *
     * @param k
     * @param array
     * @return
     */

    private static List<Pair> searchComplimentary(int k, int[] array) {
        List<Pair> pairList = new ArrayList<>();

        for (int i = 0; i < array.length - 1; i++) {
            for (int j = i + 1; j < array.length; j++) {
                if (array[i] + array[j] == k) {
                    pairList.add(new Pair(array[i], array[j]));
                }
            }
        }
        return pairList;
    }

    /**
     * Display result
     *
     * @param k
     * @param listPair
     */

    private static void show(int k, List<Pair> listPair) {
        System.out.println("There are the following Complementary pairs for the: " + k);
        for (Pair pair : listPair) {
            System.out.println(pair.i + " " + pair.j);
        }
    }


    /**
     * Class for pairs content
     */

    private static class Pair {
        private int i;
        private int j;

        Pair(int i, int j) {
            this.i = i;
            this.j = j;
        }
    }

}
