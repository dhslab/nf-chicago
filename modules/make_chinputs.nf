process MAKE_CHINPUTS {
    tag "$meta.id"
    container "ghcr.io/dhslab/docker-chicago_preprocessing"
    
    publishDir "$params.outdir/${meta.id}/preprocessing", mode:'copy', pattern: "${meta.id}/*.bedpe", saveAs: { "${file(it).getName()}"}
    publishDir "$params.outdir/${meta.id}/preprocessing", mode:'copy', pattern: "${meta.id}/*.chinput", saveAs: { "${file(it).getName()}"}
    cpus 8
    memory '32 GB'

    input:
    tuple val(meta), path(bam)
    path(baitmap)
    path(rmap)
   
    output:
    tuple val(meta), path("${meta.id}/*.chinput")  , emit: chinput
    tuple val(meta), path("${meta.id}/*.bedpe")    , emit: bedpe
    script:
        """
        bam2chicago.sh \\
        ${bam} \\
        ${baitmap} \\
        ${rmap} \\
        ${meta.id}
        """
    stub:
    """
    STUB_DATA_DIR=/scratch1/fs1/dspencer/mohamed/chicago_dev/results
    mkdir ${meta.id}
    cp \$STUB_DATA_DIR/${meta.id}/preprocessing/${meta.id}.chinput ${meta.id}/${meta.id}.chinput
    cp \$STUB_DATA_DIR/${meta.id}/preprocessing/${meta.id}_bait2bait.bedpe ${meta.id}/${meta.id}_bait2bait.bedpe
    """
}