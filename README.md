16S-pipeline
============

usearch based 16S community profiling pipeline for analysis of ribosomal amplicon sequencing &amp; analysis



--------

You will need the following tools to use this pipeline:
----------
* usearch7 from [Rob Edgar's Drive5 site](http://www.drive5.com/usearch/download.html) as described here:  
 * Edgar, R.C. (2013) UPARSE: Highly accurate OTU sequences from microbial amplicon reads, Nature Methods Pubmed:23955772,  dx.doi.org/10.1038/nmeth.2604

* The naive Bayes RDP classifier from the RDP Project: [on github](https://github.com/rdpstaff/classifier) as described here:
 * Wang, Q, G. M. Garrity, J. M. Tiedje, and J. R. Cole. 2007. 
Naive Bayesian Classifier for Rapid Assignment of rRNA Sequences into the New Bacterial Taxonomy. Appl Environ Microbiol. 73(16):5261-7.
* A working MySQL server installation (contact me for a SQLite3 version)

Getting started:
----------
* Edit the file __globals__ with the paths to the above files and the MySQL host and database name; Leave the __TRUNCLEN__ unchanged for now.
* Look at the __0.setup__ script to make sure the paths to the data are correct and adjust as necessary to find the _.fasta_, _.qual_, and _mapping.txt_ files. 
* Use the __EXECUTE__ command to run the pipeline and review the results.  In particular, pay attention to the data in the __1.quality_filter.stats.log__ file.  Use the rules described on Rob Edgar's site, decide on the __TRUNCLEN__ and possibly the __MAXEE__ parameters.
 * The __1.quality_filter.stats.log__ file contains data on the % of reads falling into the read length bins and what % of reads are accounted for buy a bin and cummlatively.  A choice needs to be made between the accumulated % of reads and the _avgEE_ (cumulative error rate average).  
* Rerun the __EXECUTE__ command and examine the output.

