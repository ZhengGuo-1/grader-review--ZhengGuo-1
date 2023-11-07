set -e
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
FILE="student-submission/ListExamples.java"
if [[ -e "$FILE" ]]; 
then
    if [[ "$FILE" == *.java ]]; 
    then
        echo "The file is a Java file."
    else
        echo "The file is not a Java file."
    fi
else
    echo "The file does not exist"
fi

cp $FILE grading-area
cp "TestListExamples.java" grading-area
cp -r "lib" grading-area
cd grading-area
FILE1="ListExamples.java"

javac "$FILE1" > compile_output.log 2>&1
if [ $? -eq 0 ]; then
    echo "Compilation successful."
else
    echo "Compilation failed. Check compile_output.log for details."
    cat $compile_output 
fi

javac -cp "$CPATH" "TestListExamples.java" "$FILE1"
java -cp "$CPATH" "org.junit.runner.JUnitCore" "TestListExamples"> test_output.txt 2>&1

# tests_run=$(grep -oP 'Tests run: \K\d+' "test_output.txt")
# failures=$(grep -oP 'Failures: \K\d+' "test_output.txt")
# echo $tests_run