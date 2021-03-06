workflow TRUST4_workflow {
  File fastq1
  File fastq2
  String samplename
  Int thread
  Int stage

  call TRUST4_pe_hg38
  {input:
    fastq1=fastq1,
    fastq2=fastq2,
    samplename=samplename,
    thread=thread,
    stage=stage
  }

}

task TRUST4_pe_hg38{
  File fastq1
  File fastq2
  String samplename
  Int thread
  Int stage

  command {
    /home/TRUST4/run-trust4 -1 ${fastq1} -2 ${fastq2} \
      -f /home/TRUST4/hg38_bcrtcr.fa --ref /home/TRUST4/human_IMGT+C.fa \
      -o ${samplename} \
      -t ${thread} \
      --stage ${stage}
  }

  runtime {
    docker:"jemimalwh/trust4:0.2.0"
    memory:"4 GB"
    disks: "local‐disk 5 SSD"
  }

  output {
    File CDR3="${samplename}_cdr3.out"
    File TRUST4final="${samplename}_final.out"
    File TRUST4report="${samplename}_report.tsv"
    File toassemble_fq1="${samplename}_toassemble_1.fq"
    File toassemble_fq2="${samplename}_toassemble_2.fq"
  }
}