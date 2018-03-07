# Gilded Rose Refactoring Kata in Python

This will contain any helpful Python-specific information about working on the Gilded Rose kata.

## Text-Based Approval Testing, Python version

Instead of using TextTest, you can use the test code in `test_acceptance.py`. If the Golden Master file exists, it will run 31 days of results and compare with that file using `assertEquals`.

The Golden Master file is defined in code as `gilded_rose_golden_master.txt`. If the file doesn't exist when `test_acceptance.py` runs, the test code will run 31 days and save the results to the Golden Master file.

The file `FINAL-gilded_rose_golden_master.txt` contains the results produced after support for "Conjured" items had been implemented.

  