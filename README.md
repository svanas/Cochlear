# Cochlear Programming Assignment

## Step 1

Write a Delphi VCL application that contain 5 threads that can be started or stopped independently of each other and that write the progress of the thread to the user interface in a thread-safe way.

### Step 2

Create a Delphi VCL application with a simple user interface that provides the user with two choices: to read text from a file or to randomly generate the text. After selecting the method, the user can choose to proceed, and the following should occur:

Process the text and find all occurrences of two or more consecutive digits (e.g. `456`). The digits should be in ascending order and the sequence should not contain "gaps" (e.g. `135` would not be a matching sequence, since `2` and `4` are missing).

Output the text itself as well as a list of found substrings and the number of their occurrences.

Additional clarifications:
* The longest sequence of digits should always be chosen, and sequences cannot overlap (e.g. in a string such as `asd123qwe56` only `123` and `56` should be found – and not combinations such as `12` or `23`)
* The resulting list should be sorted by the number of occurrences (most frequent come first). In case several strings have the same number of occurrences, the one that represents a larger number should come first
* Characters separated with a line break should not be considered consecutive, and shall be processed as two separate sequences

Sample input:
```
asd123qwe457rty89234
567zx01245cvbnm
```

Corresponding output:
```
45  2
567 1
234 1
123 1
89  1
012 1
```
