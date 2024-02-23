## Create container on cluster:

Several libraries like "sf", "units", "ctmm", are tricky to install on the cluster because of the way their are programmed. There workarounds to install these packages, but they are tedious and mostly need assistance from the MPCDF support.

One solution is resorting to a containerized solution, by work within a docker on the cluster. In the docker it is easy to install all packages needed without needing any workarounds. On the cluster this is done with apptainer (more details [here](https://docs.mpcdf.mpg.de/doc/computing/software/containers.html)). 


### The frist time:

1. login to you account in your terminal 
- within the MPIAB network (also via VPN)
```sh
ssh username@raven.mpcdf.mpg.de
```
- or if not on MPIAB network
```sh
ssh username@gate.mpcdf.mpg.de
ssh username@raven.mpcdf.mpg.de
```
For more detailed instructions see [README.md](README.md)

2.  to get started you have to load apptainer (check if there is more current version with `module avail`):

```sh
module load apptainer/1.2.2
```


3. Then initially you need to get the image and convert it to a .sif-File (the container). Using the rocker/geospatial image already installs many R libraries used for spatial analysis:
```sh
apptainer pull docker://rocker/geospatial
```

4. run R locally and check which libraries already are available and which you need to install
```sh
module load apptainer/1.2.2
apptainer exec geospatial_latest.sif R
```

5. To install extra libraries In R it is necessay to create a writeable sandbox from the container 
```sh
module load apptainer/1.2.2
apptainer build --sandbox foo/ geospatial_latest.sif
apptainer exec --no-home --writable foo/ R
```

6. now install all the R packages as usual with 
```r
install.packages(c("libA","libX","libY"), lib="/usr/local/lib/R/site-library", dependencies=T)
```
and exit with Ctrl-D


7. Create the .sif-file 
```sh
apptainer build geospatial_latest_updated.sif foo/
```

8. Run R locally and check if installed libraries are available
```sh
module load apptainer/1.2.2
apptainer exec geospatial_latest_updated.sif R
```
9. **VERY IMPORTANT**: remove the foo/ folder as it has a huge amount of files that will fill up raven's nodes unnecessarily!!!
```sh
rm -rf foo
```


### Thereafter if you need the install extra libraries again:

1. login (see above)

2. create a writeable sandbox from the container:
```sh
module load apptainer/1.2.2
apptainer build --sandbox foo/ geospatial_latest_updated.sif
apptainer exec --no-home --writable foo/ R
```

3. now install all the R packages as usual with 
```r
install.packages(c("libA","libX","libY"), lib="/usr/local/lib/R/site-library", dependencies=T)
```
and exit with Ctrl-D


4. recreate the .sif-file again
```sh
apptainer build geospatial_latest_updated.sif foo/
```
5. run R locally  and check if installed libraries are available
```sh
module load apptainer/1.2.2
apptainer exec geospatial_latest_updated.sif R
```
6. **VERY IMPORTANT**: remove the foo/ folder as it has a huge amount of files that will fill up raven's nodes unnecessarily!!!
```sh
rm -rf foo
```


## Aditional points:
- R scripts file names cannot start with a number. It will give the error that the script is not found.

- getting data in and out of the container: Your homefolder should already be mounted at `/u/<your_username>` and there you should also have access from the container. Otherwise you can also mount other locations with the the --bind flag, e.g., in case you also need ptmp that would be
`apptainer exec --bind /ptmp/<your_username> geospatial_latest.sif ...`. This command will go in the .slrm script.

## Example scripts:
- R and .slurm script for one job
- R and .slurm script for array jobs
- R and .slurm script for one job/ array jobs with parralelization in the R script
