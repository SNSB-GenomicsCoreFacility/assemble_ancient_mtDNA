process PYTHON3_CIRCULARIZE_MTDNA{
    tag { "${meta.id}" }
    label 'process_single'
    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/python:3.10.2' :
        'quay.io/biocontainers/pysam:0.22.0--py310h41dec4a_0' }"
    publishDir("${params.outdir}/python3/circularize_mtdna/", mode:'copy')

    input:
        tuple val(meta), path(fasta)

    output:
        tuple val(meta), path("${prefix}_circularize.fasta"), emit: fa

    when:
        task.ext.when == null || task.ext.when

    script:
    	def args  = task.ext.args ?: '' // args is used for the main arguments of the tool
    	prefix = task.ext.prefix ?: "${meta.id}"

        """

        python3 ${baseDir}/bin/circularize_mtdna.py ${fasta} ${args} ${prefix}_circularize.fasta

        """
}

