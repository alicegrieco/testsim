sampleID=$1
echo "QC the data by FastQC..."
mkdir -p out/fastqc
fastqc -o out/fastqc data/${sampleID}*.fastq.gz
echo
echo "Running cutadapt..."
mkdir -p log/cutadapt
mkdir -p out/cutadapt
cutadapt -m 20 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-o out/cutadapt/${sampleID}_1.trimmed.fastq.gz \
-p out/cutadapt/${sampleID}_2.trimmed.fastq.gz \
data/${sampleID}_1.fastq.gz data/${sampleID}_2.fastq.gz > log/cutadapt/${sampleID}.log

echo
echo "Running STAR alignment..."
mkdir -p out/star/${sampleID}
STAR --runThreadN 4 --genomeDir res/genome/star_index/ \
--readFilesIn out/cutadapt/${sampleID}_1.trimmed.fastq.gz out/cutadapt/${sampleID}_2.trimmed.fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix out/star/${sampleID}/

echo
echo "DONE"

