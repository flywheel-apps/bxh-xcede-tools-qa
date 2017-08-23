[![Docker Pulls](https://img.shields.io/docker/pulls/flywheel/bxh-xcede-tools-qa.svg)](https://hub.docker.com/r/flywheel/bxh-xcede-tools-qa/)
[![Docker Stars](https://img.shields.io/docker/stars/flywheel/bxh-xcede-tools-qa.svg)](https://hub.docker.com/r/flywheel/bxh-xcede-tools-qa/)

## flywheel/bxh-xcede-tools-qa
Build context for a [Flywheel Gear](https://github.com/flywheel-io/gears/tree/master/spec) to execute bxh-xcede-tools QA using `fmriqa_generate.pl` and `fmriqa_phantomqa.pl`.

### Description
These tools perform QA (quality assurance) calculations and produce images, graphs, and/or XML data as output. fmriqa_phantomqa.pl and fmriqa_generate.pl produce an HTML report with various QA measures. fmriqa_phantomqa.pl was designed for fMRI images of the BIRN stability phantom, and fmriqa_generate.pl has been used for human fMRI data.

### Build the Image
To build the image, either download the files from this repo or clone the repo:
```
docker build --no-cache -t flywheel/bxh-xcede-tools-qa
```

### Inputs
The input to this gear can be either a zip, a tgz, or a directory containing DICOMs.

### Outputs
A summary HTML file is the sole output of this gear - prefixed with the name of the input DICOM archive, like so:
```
output_html_file="${OUTPUT_DIR}"/`basename "$dicom_input"`_fmriqa.qa.html
```

### Options
Default options are set in `manifest.json` and copied to the container on build. Defaults are then loaded by the `run` script when the algorithm is executed.

### Example Docker Usage
While this Gear is meant for execution within a Flywheel instance, you can run it locally with the following command.

```
# Be sure the input file (DICOM archive or files) resides in ./input/fmri_dicom_input/:
docker run -ti --rm \
      -v `pwd`/input:/flywheel/v0/input \
      -v `pwd`/output:/flywheel/v0/output \
      flywheel/bxh-xcede-tools-qa
```
