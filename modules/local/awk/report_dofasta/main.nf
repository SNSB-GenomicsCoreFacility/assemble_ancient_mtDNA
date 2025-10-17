process AWK_REPORT_DOFASTA{
    tag { "angsd_dofasta_report" }
    label 'process_single'
    //conda "${moduleDir}/environment.yml"
    //container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    //    'https://depot.galaxyproject.org/singularity/python:3.10.2' :
    //    'quay.io/biocontainers/pysam:0.22.0--py310h41dec4a_0' }"
    //publishDir("${params.outdir}/python3/circularize_mtdna/", mode:'copy')

    input:
        path(log)

    output:
        path("*report.txt"), emit: txt

    when:
        task.ext.when == null || task.ext.when

    script:
    	def args  = task.ext.args ?: '' // args is used for the main arguments of the tool
    	//prefix = task.ext.prefix ?: "${meta.id}"

        """
       echo "sample,num_sites_analzed,num_sites_retained_post_filtering" > angsd_report.txt;for z in \$(ls *.log);do fname=\$(basename \$z .log); awk -v fname=\$fname '\$0~/analyzed/ || \$0~/filtering/{a[NR]=\$NF}END{printf "%s",fname;for(i in a){printf ",%s",a[i]}printf "\\n"}' \${z};done >> angsd_report.txt
    
        """
}

