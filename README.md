# ENCODING RECOGNITION

The specific fastq_class.sh program was developed and runs in a UNIX environment with Bash and performs the classification of FASTQ files,
based on the Phred encoding.
It recognizes the Phred+33 and Phred+64 encoding contained in each FASTQ file
and places each file separately in the phred33 folder or the phred64 folder that it creates in advance.

---

## Features

- Detects FASTQ quality score encoding by analyzing ASCII values.
- Supports Phred+33 and Phred+64.
- Automatically organizes files into phred33/ and phred64/ directories.
- Provides min and max ASCII values for each file.
- Handles multiple FASTQ files.

---

## Project structure

- .gitignore
- LICENSE
- -README.md
- fastq_class.sh

---

## How it works

The script loops through all .fastq files in the current directory.<br>
For each file:
- Extracts quality score lines.
- Converts characters to ASCII codes.
- Finds minimum and maximum ASCII values.</p>

Classification rules:<br>
- Phred+33: min ≥ 33 and max ≤ 74
- Phred+64: min ≥ 64 and max ≤ 104</p>

Moves the file to the correct folder

---

## Example Usage

./classify_fastq.sh

Example output:</p>

Processing sample1.fastq<br>
Min ASCII: 33<br>
Max ASCII: 73<br>
Classified as phred33</p>

Processing sample2.fastq<br>
Min ASCII: 66<br>
Max ASCII: 104<br>
Classified as phred64</p>

---

## Input Files

The script expects raw FASTQ files with extension .fastq located in the current working directory.<br>
Each FASTQ file must follow the standard 4-line FASTQ format:
- Sequence identifier (@...)
- Nucleotide sequence
- Separator line starting with +
- Quality score string (ASCII-encoded)</p>

Compressed files (.fastq.gz) must be decompressed first:<br>
gunzip file.fastq.gz

---

## Installation

Download this repository and unzip the file.<br>
Then open the terminal and go to the "encoding-recognitionion-main" file.<br>
Then make the script executable:<br>
chmod +x classify_fastq.sh

---

## Compilation

Since this is a Bash script, no compilation is required.<br>

---

## Execution

Run the script in a directory containing .fastq files:<br>
./classify_fastq.sh

After execution, you will have two folders:<br>
phred33/<br>
phred64/<br>

Each folder will contain only the phred33 or the phred64 files.

---

## Notes

- Requires Bash and standard Unix tools (od, tr, grep, sort, head, tail).
- Works with plain .fastq files (not compressed).
- Files that do not fit into Phred+33 or Phred+64 ranges will be left unclassified.
- If the quality bar is not present, the message "No quality results found" is displayed.
- If the file does not belong to one of two categories, the message "Could not classify (and the file name)" is displayed.
- Designed for batch processing of multiple FASTQ files in a single directory.

## License

This project is licensed under the ΜΙΤ License
