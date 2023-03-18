// Check input path parameters to see if they exist
def checkPathParamList = [ params.input, params.design_directory, params.rmap, params.baitmap ]
for (param in checkPathParamList) { if (param) { file(param, checkIfExists: true) } }

// Check mandatory parameters
if (params.input) { ch_input = file(params.input) } else { exit 1, 'Input samplesheet not specified!' }
if (!params.design_directory) { exit 1, 'design files directory not specified!' }
if (!params.rmap) { exit 1, 'digest map file (.rmap) not specified!' }
if (!params.baitmap) { exit 1, 'baitmap file (.baitmap) not specified!' }



include { MAKE_CHINPUTS } from './modules/make_chinputs'
include { RUN_CHICAGO   } from './modules/run_chicago'


Channel.fromPath(params.input)
    .splitCsv(header:true, sep:',')
    .map { row -> [ ["id" : row.id], file(row.bam, checkIfExists: true) ] }
    .set { ch_bam }

workflow {
    MAKE_CHINPUTS (
        ch_bam,
        params.baitmap,
        params.rmap
    )
    RUN_CHICAGO (
        MAKE_CHINPUTS.out.chinput,
        params.design_directory,
        (params.features_file) ? params.features_file : "${launchDir}/assets/dummy_file.txt" // create channel of dummy file as placeholder if feature file is not provided, dummy file will not be used

    )

}