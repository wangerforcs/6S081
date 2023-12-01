for i in {1..10000}
do
    echo hello,world!f\*\*kC  | ./a.out >> testforkread.txt
done

cat testforkread.txt | sort | uniq
rm testforkread.txt