# TP4
*TP4 of the software evolution course*

## Questions 1.2.4
**1**) The probability that two different strings produce an identical cryptographical hash with SHA-256 are really low. But it is not impossible. It is writed in the PDF : "The resilience of SHA-256 is best understood through the birthday paradox. Because the algorithm is designed so well that no mathematical shortcuts exist, an attacker is forced to use the most exhaustive method: trying random inputs until two match. Finding such a collision requires approximately 2^128 operations (roughly 3.4 × 10^38 attempts). To put this in perspective, even if the entire Bitcoin network (the most powerful collective SHA-256 computing infrastructure on Earth today, performing 600 × 10^18 hashes per second) were repurposed solely to find a single collision, it would take roughly 18 billion years to reach a 50% chance of success. Given that the age of the universe is estimated at 13.8 billion years, the likelihood of a collision occurring is effectively zero."

**2**) If we take ab and ca we have the same checksum.

**3**) The resulting file is an archive which contains metadata (for instance the date) so if we do a checksum on the same file compressed at different times we will get different results.


## 2.2.1 Questions
**1**) file hello-world
hello-world: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=060cc0c79d5694d1e98137a60aa43cacc730c57f, for GNU/Linux 3.2.0, not stripped
ls -l hello-world
-rwxrwxr-x 1 gaxs gaxs 15968 Mar 10 14:33

**2**) Our outputs differs, because the date and time of compilation are different.

**3**) If we compile multiple times, we will get different outputs because of the date and time of compilation.

**4**) If we run the program multiple times, we will get the same output because the date and time of compilation are the same.

**5**) If another student runs the program, they will get the same output if they are on a similar system, but if they are on a different system, they might have an error.

**6**) It is better to share the source code because it is more portable and it can be compiled on different systems, while the executable file might not run on different systems.

## 2.3.1 Questions
**1**) We have the same number. I am on Mint and another student is on Arch and we have the same output.It is because of the seed of the random number generator is the same. 

**2**) If we run the program multiple times, we will the same output because it is always the same the seed. It is a little "reproducible" but on the other hand, on some systems, the seed is different.


## 2.4.1 Questions
**1**) As there is not MACRO we have the same build (the checksum is the same). It'is build-time reproducible.

**2**) If we run the program multiple times, we will get differnent outputs because now the seed is is different (it is based on the time). It is not run-time reproducible.

**3**) This version of the application behave differently because the seed is different at runtime. It is not run-time reproducible.

## 2.6.1 Questions
**1**) 
```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// To compile: gcc montecarlo-pi.c -o montecarlo-pi
// Usage: ./montecarlo-pi
int main(int argc, char* argv[]) {
    double x, y, z;
    int count = 0;
    time_t started = time(NULL);
    srand(started);
    int n = (int) rand() % 10000 + 1; // Number of iterations

    printf("Compiled on %s at %s\n",__DATE__,__TIME__);
    printf("Execution started on %s",ctime(&started));

    for (int i = 0; i < n; i++) {
        x = (double) rand() / RAND_MAX;
        y = (double) rand() / RAND_MAX;
        z = x * x + y * y;
        if (z <= 1) count++;
    }

    printf("The approximation of Pi using %d iterations is %f \n", n, (count / (double) n) * 4);

    time_t stopped = time(0);
    printf("Execution stopped on %s",ctime(&stopped));
    return(0);
}
```
**2**) When we increase the number n of iterations, the result is closer to the real value of pi. Moreover, the execution takes longer (a few milliseconds). This behavior is consistent with my expections because the more iterations we have, the more accurate the approximation of pi is, but it takes more time to execute.

**3**) The code is not build-time reproducible because of there are the macros __DATE__ and __TIME__.  We need remove the line which uses these macros.

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// To compile: gcc montecarlo-pi.c -o montecarlo-pi
// Usage: ./montecarlo-pi
int main(int argc, char* argv[]) {
    double x, y, z;
    int count = 0;
    time_t started = time(NULL);
    srand(started);
    int n = (int) rand() % 100000000 + 1; // Number of iterations

    //printf("Compiled on %s at %s\n",__DATE__,__TIME__);
    printf("Execution started on %s",ctime(&started));

    for (int i = 0; i < n; i++) {
        x = (double) rand() / RAND_MAX;
        y = (double) rand() / RAND_MAX;
        z = x * x + y * y;
        if (z <= 1) count++;
    }

    printf("The approximation of Pi using %d iterations is %f \n", n, (count / (double) n) * 4);

    time_t stopped = time(0);
    printf("Execution stopped on %s",ctime(&stopped));
    return(0);
}
```

**4**) The code is not run-time reproducible because of the seed of the random number generator is based on the time. We need to set a fixed seed to have a run-time reproducible code ! And we must remove all the lines which use the time.

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// To compile: gcc montecarlo-pi.c -o montecarlo-pi
// Usage: ./montecarlo-pi
int main(int argc, char* argv[]) {
    double x, y, z;
    int count = 0;
    //time_t started = time(NULL);
    srand(54);
    int n = (int) rand() % 100000000 + 1; // Number of iterations

    //printf("Compiled on %s at %s\n",__DATE__,__TIME__);
    //printf("Execution started on %s",ctime(&started));

    for (int i = 0; i < n; i++) {
        x = (double) rand() / RAND_MAX;
        y = (double) rand() / RAND_MAX;
        z = x * x + y * y;
        if (z <= 1) count++;
    }

    printf("The approximation of Pi using %d iterations is %f \n", n, (count / (double) n) * 4);

    //time_t stopped = time(0);
    //printf("Execution stopped on %s",ctime(&stopped));
    return(0);
}

```

**5**) We have juste remove the time and the macros __DATE__ and __TIME__. Now the code is build-time and run-time reproducible. We will get the same result if we run the program multiple times. We can also require an argument to take the number of iterations :

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// To compile: gcc montecarlo-pi.c -o montecarlo-pi
// Usage: ./montecarlo-pi
int main(int argc, char* argv[]) {
    double x, y, z;
    int count = 0;
    int n = atoi(argv[1]);
    if (n < 1) {
        return 1;
    }

    for (int i = 0; i < n; i++) {
        x = (double) rand() / RAND_MAX;
        y = (double) rand() / RAND_MAX;
        z = x * x + y * y;
        if (z <= 1) count++;
    }

    printf("The approximation of Pi using %d iterations is %f \n", n, (count / (double) n) * 4);

    return(0);
}
```

## 3.3.1 Questions

**1**) We need 2 arguments : the seed and the number of iterations. 

**2**) With podman image ls we can notice that the image random have a big size (291 MB). It is because the build image contains all the tools to compile the code, while the random image only contains the executable file.

**3**) With podman image ls we can notice that the image random have a size of 8.75 MB. It is less than the size of the build image (291 MB). It is because the build image contains all the tools to compile the code, while the random image only contains the executable file.

**4**) The line 8 serve to copy the executable file from the build image to the random image. We need this line because the random image only contains the executable file and not the source code. It is a good idea.

**6**) [IA] Whether you get the same output depends entirely on how your random seed is initialized. If your code uses a dynamic seed (like the current time), the results will differ; however, if you use a fixed seed, you will get identical outputs because the container ensures everyone is using the exact same libraries and execution environment.

**7**) [IA] Using podman save and podman load transfers the complete container image as a .tar archive, which includes all filesystem layers, dependencies, and the compiled executable. This guarantees that other students can reproduce your exact environment, eliminating any inconsistencies caused by differences in their host operating systems.