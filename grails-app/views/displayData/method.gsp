<%--
  Created by IntelliJ IDEA.
  User: snehalpatil
  Date: 2019-10-14
  Time: 01:29
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-143045158-2"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'UA-143045158-2');
    </script>

    <meta name="layout" content="main" />
    <asset:javascript src="jquery-3.3.1.js"/>
    <asset:javascript src="jquery.tablesorter.min.js"/>
    <asset:javascript src="jquery.tablesorter.widgets.js"/>
    <asset:stylesheet src="theme.blue.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>



    <title>Method</title>
    <STYLE>
    .row {
        position: relative;
        /* max-width: 1400px; */
        margin: 0 auto;
        padding: 0 5%;
    }

    div.drilldown { display: inline-block; }
    p + p { margin-top: 10px; }
    </STYLE>


</head>

<body>
        <div id="create-displayData" class="content scaffold-create mt-5" role="main">
        <div class="container-fluid">
            <div class="row" style="background-color: white">
                <div class="col-12">



                    <H1>Table of Contents</H1><br/>
                    <h4><p><A href="#evaco">Evaluation cohorts</A><BR></p></h4><br/>
                    <div class="ml-5">
                        <h4><A href="#mgi">Michigan Genomics Initiative (MGI)</A><BR></h4><br/>

                        <h4><A href="#unbio">UK Biobank (UKB)</A><BR></h4><br/>

                    </div>
                    <h4><p><A href="#prsheaders">PRS</A><BR></p></h4><br/>
                    <div class="ml-5">
                        <h4><P><A href="#source"> Sources of GWAS summary statistics</A><BR></h4><br/>

                        <h4><P><A href="#prs">PRS Generation</A></P></h4><BR>
                        <h4><P><A href="#prseval">PRS Evaluation</A></P></h4><BR>
                        <h4><P><A href="#asso">Phenome-wide Exploration of PRS Associations</A><BR></P></h4><BR>

                    </div>

                    <h4><P><A href="#catalog">Online Visual Catalog: PRSweb</A><BR></P></h4><BR>
                    <h4><P><A href="#ref">Method References</A><BR></P></h4><BR>



                        <h1><A name="evaco">Evaluation cohorts</A></h1>
                    <br/>
                        <h4><A name="mgi">Michigan Genomics Initiative (MGI)</A></h4>
                        <p class="text-justify">
                            Adult (18+) participants were recruited through the Michigan Medicine health system while awaiting diagnostic or interventional procedures either during a preoperative visit prior to the procedure or on the day of the procedure that required anesthesia. In addition to coded biosamples and secure, protected health information, participants understood that all EHR, claims, and national data sources linkable to the participant may be incorporated into the MGI databank. Each participant donated a blood sample for genetic analysis, underwent baseline vital sign testing, and completed a comprehensive history and physical assessment (also see Ethics Statement below). We report results obtained from 38,360 unrelated, genotyped patients of inferred recent European ancestry with available integrated EHR data (~90 % of all MGI participants were inferred to be of recent European ancestry) (1). The data used in this study included diagnoses coded with the Ninth and Tenth Revision of the International Statistical Classification of Diseases (ICD9 and ICD10) with clinical modifications (ICD9-CM and ICD10-CM), sex, precomputed principal components (PCs), genotyping batch, and age. Data were collected according to the Declaration of Helsinki principles (2). MGI study participants’ consent forms and protocols were reviewed and approved by the University of Michigan Medical School Institutional Review Board (IRB ID HUM00099605 and HUM00155849). Opt-in written informed consent was obtained.
                        </p>
                    <H2><A name="genedata"><u>Genetic data</u></A></H2>
                        <p class="text-justify">DNA from 47,364 blood samples was genotyped on customized Illumina Infinium CoreExome-24 bead arrays and subjected to various quality control filters,
                        resulting in a set of 392,323 polymorphic variants. Principal components and ancestry were estimated by projecting all genotyped samples into the space of the principal
                        components of the Human Genome Diversity Project reference panel using PLINK (938 individuals) (3, 4). Pairwise kinship was assessed with the software KING (5),
                        and the software fastindep was used to reduce the data to a maximal subset that contained no pairs of individuals with 3rd-or closer degree relationship (6).
                        We removed participants without EHR data and participants not of recent European descent from the analysis, resulting in a final sample of 38,360 unrelated subjects.
                        Additional genotypes were obtained using the Haplotype Reference Consortium reference panel of the Michigan Imputation Server (7) and included over 24
                        million imputed variants with R<sup>2</sup><span>&#8805;</span>0.3 and minor allele frequency (MAF) <span>&#8805;</span>0.01%. Genotyping, quality control, and imputation are described in detail elsewhere (1).
                        </p><H2><A name="phenome"><u>Phenome</u></A></H2>
                        <p class="text-justify">The MGI phenome was based on ICD9-CM and ICD10-CM code data for 38,360 unrelated, genotyped individuals of recent European ancestry. These ICD9-CM and ICD10-CM codes were aggregated to form up to 1,857 PheWAS traits using the PheWAS R package (as described in detail elsewhere [1, 7]). For each trait, we identified case and control samples. To minimize differences in age and sex distributions or extreme case-control ratios as well as to reduce computational burden, we matched up to 10 controls to each case using the R package “MatchIt” [8]. Nearest neighbor matching was applied for age and the first four principal components (PC1-4; using Mahalanobis-metric matching; matching window caliper/width of 0.25 standard deviations) and exact matching was applied for sex and genotyping array. A total of 1,689 case-control studies with >50 cases were used for our analyses of the MGI phenome.
                        <br/><br/>
                        </p>
                        <H4><A name="unbio">UK Biobank (UKB)</A></H4>
                        <p class="text-justify">The UKB is a population-based cohort collected from multiple sites across the United Kingdom and includes over 500,000 participants aged between 40 and 69 years when recruited in 2006–2010 (10). The open-access UK Biobank data used in this study included genotypes, ICD9 and ICD10 codes, inferred sex, inferred White British ancestry, kinship estimates down to third degree, birthyear, genotype array, and precomputed principal components of the genotypes.</p>

                    <H2><A name="ukgene"><u>Genetic data</u></A></H2>

                        <p class="text-justify"> We used the UK BioBank Imputed Dataset (v3, https://www.ebi.ac.uk/ega/datasets/EGAD00010001474) and limited analyses to the documented 408,961 White British (11)
                        individuals and 47,836,001 variants with imputation information score <span>&#x2267;</span> 0.3 and MAF <span>&#x2267;</span> 0.01% of which 22,846,729 overlapped with the imputed MGI data (see above).
                        Two random subsets of 5,000 and 10,000 unrelated, White British individuals were used for LD analyses of UKB-based summary statistics.    </p>

                    <H2><A name="ukphen"><u>Phenome</u></A></H2>

                        <p class="text-justify">The UK Biobank phenome was used as a replication dataset and was based on ICD9 and ICD10 code data of 408,961 White British (11), genotyped individuals that were similarly aggregated to PheWAS traits as MGI (as described elsewhere (12)). In contrast to MGI, there were many pairwise relationships reported for UKB participants.
                        To retain a larger effective sample size for each phenotype, we first selected a maximal set of unrelated cases for each phenotype (defined as no pairwise relationship of 3rd degree or closer (6, 13)) before selecting a maximal set of unrelated controls unrelated to these cases. Similar to MGI, we matched up to 10 controls to each case using the R package “MatchIt” (9). Nearest neighbor matching was applied for birthyear and PC1-4 (Mahalanobis-metric matching; matching window caliper/width of 0.25 standard deviations), and exact matching was applied for sex and genotyping array. A total of 1,419 case-control studies with >50 cases each were used for our analyses of the UK Biobank phenome.
                        </p>
                            <br/><br/>

                    <h1><A name="prsheaders">PRS</A></h1>
                    <p class="text-justify">PRS combine information across a defined set of genetic loci, incorporating each locus’s association with the target trait. The PRS for patient j
                    takes the form
                    PRS<sub>j</sub>=∑<sub>i</sub>β<sub>i</sub> G<sub>ij</sub>

                    where i indexes the included loci for that trait, weight β<sub>i</sub> is the log odds ratios retrieved from the external GWAS summary statistics
                    for locus i, and G<sub>ij </sub>is a continuous version of the measured dosage data for the risk allele on locus i in subject j. In order to construct a PRS, one must determine which genetic loci to include in the PRS and their relative weights. Below, we obtain GWAS summary statistics from several different sources, resulting in several sets of weights for each trait of interest. For each set of weights, we consider several strategies for determining which genetic loci to include in the PRS construction.
                </p>
                    <H2><A name="source"><u>Sources of GWAS summary statistics</u></A></H2>

                        <p class="text-justify">For each of 68 cancers of interest, we collected GWAS summary statistics from up tothree different sources: (1) merged genome-wide significant association signalspublished in the NHGRI EBI GWAS Catalog (14) if available; (2) large cancer GWASmeta-analysis if available; and (3) publicly available GWAS summary statistics ofphenome x genome screening efforts of the UK Biobank data (12). If needed, weused LiftOver to convert coordinates of GWAS summary statistics to human genomeassembly GRCh37 (https://genome-store.ucsc.edu/)   </p>

                    <H2><A name="gwas"><u>GWAS Catalog</u></A></H2>

                        <p class="text-justify">
                            We downloaded previously reported GWAS variants from the NHGRI-EBI GWASCatalog (file version: r2019-05-03,  https://www.ebi.ac.uk/gwas/)  (14, 15). Singlenucleotide polymorphism (SNP) positions were converted to GRCh37 using variantIDs from dbSNP (build 151; UCSC Genome Browser, http://genome.ucsc.edu/) afterupdating outdated dbSNP IDs to their merged dbSNP IDs.Entries with missing risk alleles, risk allele frequencies, or SNP-disease oddsratios were excluded. If a reported risk allele did not match any of the reportedforward strand alleles of a non-ambiguous SNP (not A/T or C/G) in the imputed MGIgenotype data (which correspond to the alleles of the imputation reference panel), weassumed   minus-strand   designation   and   corrected   the   effect   allele   to   itscomplementary base of the forward strand. Entries with a reported risk allele that didnot match any of the alleles of an ambiguous SNP (A/T and C/G) in our data wereexcluded at this step. We only included entries with broad European ancestry (asreported by the NHGRI-EBI GWAS Catalog) to match ancestries of discovery GWASand target cohorts (MGI and UKB). As a quality control check, we compared theGWAS   Catalog   reported   risk   allele   frequencies   (RAF)   with   the   RAF   in   MGIindividuals. We then excluded entries whose RAF deviated more than 15%. Thischosen threshold is subjective and was based on clear differentiation betweencorrect and likely flipped alleles on the two diagonals, as noted frequently in GWASmeta-analyses quality control procedures (16).For SNPs with multiple entries, wekept the SNP with the most recent publication date (and smaller  p-value, ifnecessary) and excluded the others.
                        </p>
                    <H2><A name="metan"><u>Large GWAS meta-analyses</u></A></H2>
                        <p class="text-justify">
                            We downloaded full GWAS summary statistics made available by the “Breast CancerAssociation Consortium” (BCAC) (13), the “Prostate Cancer Association Group toInvestigate Cancer Associated Alterations in the Genome” (PRACTICAL) (17), andthe “Ovarian Cancer Association Consortium” (OCAC) (18). In addition, we extractedpartial GWAS summary statistics that accompanied recent publications but wereincomplete, i.e. reporting only SNPs below a certain p-value threshold  (19-22).GWAS summary statistics were harmonized and, if needed, lifted over to humangenome assembly GRCh37. In this paper, this source is referred to as “LargeGWAS”.</p>

                    <H2><A name="ukgwas"><u>UK-Biobank-based GWAS</u></A></H2>

                        <p class="text-justify">
                            We downloaded UK Biobank based GWAS summary statistics from two publicrepositories. The first set of UK Biobank GWAS summary statistics were based on theanalysis   of   up   to   408,961   White   British   European-ancestry   samples(https://www.leelabsg.org/resources). SNP-disease odds ratios were estimated usinglogistic   mixed   modeling   adjusting   for   sample   relatedness,   and   p-values   wereestimated using saddlepoint approximations (SAIGE method (23)) to calibrate thedistribution of score test statistics and, thus, control for unbalanced case-controlratios. The underlying phenotypes were auto-curated phenotypes based on thePheCodes of the PheWAS R package (1, 8, 12) similar to the phenomes used in ourstudy and in the following are referred to as “UKB PHECODE”.The second set of UK Biobank GWAS summary statistics were based on alinear regression model of up to 361,194 unrelated White British samples adjustingfor   relevant   covariates   (https://github.com/Nealelab/UK_Biobank_GWAS).   Threephenotype models were used in their analyses: (1) “PHESANT”: auto-curatedphenotypes     using     PHEnome     Scan     ANalysis     Tool(https://github.com/MRCIEU/PHESANT),   (2)   “ICD10”:   individuals   with   the   sameICD10 category code (first three characters, e.g. “C50”) were used as cases while allnon-coded   individuals   were   treated   as   controls,   and   (3)   “FINNGEN”:   curatedphenotypes   /   endpoints   based   on   definitions   of   the   Finngen   consortium(https://www.finngen.fi/en/researchers/clinical-endpoints). In  addition   to  the  “UKBPHECODE” (described above), these three latter sources are referred to as “UKBPHESANT”, “UKB ICD10” and “UKB FINNGEN”, respectively.

                        </p>

                        <br/><br/>
                            <h4><A name="prs">PRS Generation</A></h4>

                        <p class="text-justify">
                            For each set of GWAS summary statistics from the above-mentioned sources and each cancer, we develop up to seven different PRS using three different construction methods.
                            Our goal of this approach was to compare multiple PRS methods and find the method that works best for the various types of GWAS summary statistics.
                        </p>  <p class="text-justify">

                    For the first two construction strategies, we performed LD clumping/pruning of variants with p-values below 10<sup>-4</sup> by using the imputed allele dosages of 10,000 randomly selected
                            samples and a pairwise correlation cut-off at r<sup>2</sup> <span>&#x3c;</span> 0.1 within 1Mb window. Using the resulting loci, we defined up to five sub-sets of variants with p-values
                below different thresholds (<5x10<sup>-9 </sup> to <5x10<sup>-5</sup>). These were used to construct a PRS tied to each threshold, where the PRS associated with p-values less than 5x10<sup>-8</sup>
                    is sometimes denoted as “GWAS hits.” For the second PRS construction method, we construct many different PRS across a fine grid of p-value thresholds.
                    The p-value threshold with the highest cross-validated pseudo-R2 (see PRS Evaluation below) was used to define the more optimized “Pruning and Thresholding (P & T)” PRS.

                </p>  <p class="text-justify">

                            As an alternative to the p-value thresholding and “P&T” PRS construction strategies, we also used the software package “lassosum” (24) to define a third type of PRS for GWAS
                            sources with full summary statistics. Lassosum obtains PRS weights by applying elastic net penalization to GWAS summary statistics and incorporating LD information
                            from a reference panel. Here, we used 5,000 randomly selected, unrelated samples as the LD reference panel.
                            We applied a MAF filter of 1 % and, in contrast to the other two approaches, only included autosomal variants that overlap between summary
                            statistics, LD reference panel, and target panel. Each “lassosum” run resulted in up to 76 combinations of the elastic net tuning parameters s and λ, and
                            consequently, in 76 SNP sets with corresponding weights used to construct 76 PRS. We then selected the PRS with the highest cross-validated pseudo-R2 to define the “lassosum” PRS.
                </p>  <p class="text-justify">
                            For each cancer and set of GWAS summary statistics, this approach resulted in up to seven PRS, where PRS with less than 5 included variants were excluded and the available GWAS
                            summary statistics limited the available PRS construction techniques in some cases. Using the R package “Rprs” (https://github.com/statgen/Rprs), the value of each PRS was
                            then calculated for each MGI participant and, if the GWAS source was not based on UKB, also for each UKB participant. For comparability of association effect sizes
                            corresponding to the continuous PRS across cancer traits and PRS construction methods, we centered PRS values in MGI and UKB to their mean and scaled them to have a standard deviation of 1.
                        </p>



                    <br/><br/>
                            <h4><A name="prseval">PRS Evaluation</A></h4>

                    <p class="text-justify"> For the PRS evaluations, we fit the following model for each PRS and cancer phenotype without adjusting for covariates:
                    </p>  <p class="text-justify">
                    logit (P(Phenotype is present | PRS)) =β<sub>0</sub>+β<sub>PRS</sub> PRS
                </p>  <p class="text-justify">
                    We performed a 5-fold cross validation with the R package “caret” (25) to obtain fitted predictors for the actual PRS evaluations. We used Nagelkerke’s pseudo-R2 (26)
                    to select the tuning parameters within the “P&T” and lassosum construction methods (P-value for “P&T” SNP sets; s and λ for lassosum) and kept the
                    PRS with the highest pseudo-R2 for further analyses. For each PRS derived for each GWAS source/method combination, we assessed the following
                    performance measures relative to observed disease status in MGI and UKB:
                </p>  <p class="text-justify">
                    (1) overall performance with Nagelkerke’s pseudo-R<sup>2</sup>using R packages “rcompanion” (26), (2) accuracy with Brier score using R package “DescTools” (27);
                (3) ability to discriminate between cases and controls as measured by the area under the receiver operating characteristic (ROC) curve (denoted AUC) using R package “pROC”
                (28) and (4) calibration using Hosmer-Lemeshow Goodness of Fit test in the R package “ResourceSelection” (29-31).
                    </p>
                    <br/><br/>

                            <h4><A name="testing">PRS Association Testing</A></h4>
                        <p class="text-justify">
                            Next, we assessed the strength of the relationship between these PRS and the traits they were designed for. To do this we fit the following model for each PRS and cancer phenotype
                            adjusting for various covariates:
                        </p>  <p class="text-justify">
                    logit (P(Phenotype is present | PRS, Age, Sex, Array, PC)) =β<sub>0</sub>+β<sub>PRS</sub>PRS+β<sub>Age</sub> Age+ β<sub>Sex</sub>Sex+β<sub>Array</sub>Array+β PC,
                </p>  <p class="text-justify">
                            where the PCs were the first four principal components obtained from the principal component analysis of the genotyped GWAS markers, where “Age”
                            was the age at last observed diagnosis in MGI and birthyear in UKB and where “Array” represents the genotyping array. Our primary interest is β<sub>PRS</sub>, while the other factors
                (Age, Sex and PC) were included to address potential residual confounding and do not provide interpretable estimates due to the preceding application of case-control matching.
                Firth's bias reduction method was used to resolve the problem of separation in logistic regression (Logistf in R package “EHR”) (32-34).
                </p>  <p class="text-justify">
                            To study the ability of the PRS to identify high risk patients, we fit the above model but replacing the PRS with an indicator for whether the PRS value was in the top
                            1, 2, 5, 10, or 25% among the matched case control cohort.


                        </p>
                        <br/><br/>
                            <h4><A name="ref">Phenome-wide Exploration of PRS Associations</A></h4>
                    <p class="text-justify">

                        We selected PRS that were strongly associated with the cancer trait they weredesigned for phenome-wide association exploration in the phenomes of MGI andUKB for
                        (p-value <span>&#x2264;</span> (0.05 / [#phenotypes in corresponding phenome]); see below).
                    </p>  <p class="text-justify">
                    We conducted PheWAS in MGI and also UKB (if the GWAS source was notbased on UKB) to identify additional, secondary phenotypes associated with the PRS(35).
                    To evaluate PRS-phenotype associations, we conducted Firth bias-correctedlogistic regression by fitting model of equation 1 above for each PRS and eachphenotype
                    of the corresponding phenome. To adjust for multiple testing, we appliedthe conservative phenome-wide Bonferroni correction according to the total numberof analyzed PheWAS codes
                    (MGI: 1,689 phenotypes; UKB: 1,419 phenotypes). InManhattan plots, we present –log10 (p-value) corresponding to tests of H<sub>0</sub>:β<sub>PRS</sub>=0.
                Directional triangles on the PheWAS plot indicate whether a phenome-widesignificant trait was positively (pointing up) or negatively (pointing down) associatedwith the PRS.
                </p>  <p class="text-justify">
                    To investigate the possibility of the secondary trait associations with PRSbeing completely driven by the primary trait association,
                    we performed a second setof PheWAS after excluding individuals affected with the primary or related cancertraits for which the PRS was constructed,
                    referred to as “Exclusion-PRS-PheWAS” asdescribed previously (1).
                    </p>

                    <br/><br/>

                    <h4><A name="catalog">Online Visual Catalog: PRSweb</A></h4>
                    <p class="text-justify">
                        The online open access visual catalog PRSweb was implemented using Grails, aGroovy- and Java-based backend logic, to integrate interactive visualizations andMySQL databases.
                        Interactive PheWAS plots are drawn with the JavaScript library“LocusZoom.js” which is maintained by the UM Center for Statistical Genetics(https://github.com/statgen/locuszoom)
                        and offers dynamic plotting, automatic plotsizing, and label positioning. Additional data-driven visualizations (e.g. temporalrelationship plots) were implemented with the JavaScript
                        library “D3.js”.
                    </p>  <p class="text-justify">
                    Unless otherwise stated, analyses were performed using R 3.6.1 (36).

                           </p>

                    <br/><br/>

                    <h4><A name="ref">
                        Method References
                    </A></h4>

                        <p class="text-justify">

                        <ol>
                        <li>   Fritsche LG, Gruber SB, Wu Z, Schmidt EM, Zawistowski M, Moser SE, et al. Association of Polygenic Risk Scores for Multiple Cancers in a Phenome-wide Study: Results from The Michigan Genomics Initiative. Am J Hum Genet. 2018;102(6):1048-61. Epub 2018/05/22. doi: 10.1016/j.ajhg.2018.04.001. PubMed PMID: 29779563; PubMed Central PMCID: PMCPMC5992124.</li>
                        <li>    World Medical Association. World Medical Association Declaration of Helsinki: ethical principles for medical research involving human subjects. JAMA. 2013;310(20):2191-4. Epub 2013/10/22. doi: 10.1001/jama.2013.281053. PubMed PMID: 24141714.</li>
                        <li>	Wang C, Zhan X, Bragg-Gresham J, Kang HM, Stambolian D, Chew EY, et al. Ancestry estimation and control of population stratification for sequence-based association studies. Nat Genet. 2014;46(4):409-15. Epub 2014/03/19. doi: 10.1038/ng.2924. PubMed PMID: 24633160; PubMed Central PMCID: PMCPMC4084909.</li>
                        <li>	Li JZ, Absher DM, Tang H, Southwick AM, Casto AM, Ramachandran S, et al. Worldwide human relationships inferred from genome-wide patterns of variation. Science. 2008;319(5866):1100-4. Epub 2008/02/23. doi: 10.1126/science.1153717. PubMed PMID: 18292342..</li>
                        <li>	Manichaikul A, Mychaleckyj JC, Rich SS, Daly K, Sale M, Chen WM. Robust relationship inference in genome-wide association studies. Bioinformatics. 2010;26(22):2867-73. Epub 2010/10/12. doi: 10.1093/bioinformatics/btq559. PubMed PMID: 20926424; PubMed Central PMCID: PMCPMC3025716..</li>
                        <li>	Abraham KJ, Diaz C. Identifying large sets of unrelated individuals and unrelated markers. Source Code Biol Med. 2014;9(1):6. Epub 2014/03/19. doi: 10.1186/1751-0473-9-6. PubMed PMID: 24635884; PubMed Central PMCID: PMCPMC3995366..</li>
                        <li>	McCarthy S, Das S, Kretzschmar W, Delaneau O, Wood AR, Teumer A, et al. A reference panel of 64,976 haplotypes for genotype imputation. Nat Genet. 2016;48(10):1279-83. Epub 2016/08/23. doi: 10.1038/ng.3643. PubMed PMID: 27548312; PubMed Central PMCID: PMCPMC5388176.</li>
                        <li>	Carroll RJ, Bastarache L, Denny JC. R PheWAS: data analysis and plotting tools for phenome-wide association studies in the R environment. Bioinformatics. 2014;30(16):2375-6. Epub 2014/04/16. doi: 10.1093/bioinformatics/btu197. PubMed PMID: 24733291; PubMed Central PMCID: PMCPMC4133579.</li>
                        <li>	Ho DE, Imai K, King G, Stuart EA. MatchIt: Nonparametric Preprocessing for Parametric Causal Inference. J Stat Softw. 2011;42(8):1-28. PubMed PMID: WOS:000292097500001.</li>
                        <li>	Sudlow C, Gallacher J, Allen N, Beral V, Burton P, Danesh J, et al. UK biobank: an open access resource for identifying the causes of a wide range of complex diseases of middle and old age. PLoS Med. 2015;12(3):e1001779. Epub 2015/04/01. doi: 10.1371/journal.pmed.1001779. PubMed PMID: 25826379; PubMed Central PMCID: PMCPMC4380465.</li>
                        <li>	Bycroft C, Freeman C, Petkova D, Band G, Elliott LT, Sharp K, et al. Genome-wide genetic data on ~500,000 UK Biobank participants. bioRxiv. 2017. doi: 10.1101/166298.</li>
                        <li>	Zhou W, Nielsen JB, Fritsche LG, Dey R, Gabrielsen ME, Wolford BN, et al. Efficiently controlling for case-control imbalance and sample relatedness in large-scale genetic association studies. Nat Genet. 2018;50(9):1335-41. Epub 2018/08/15. doi: 10.1038/s41588-018-0184-y. PubMed PMID: 30104761; PubMed Central PMCID: PMCPMC6119127.</li>
                        <li>	Michailidou K, Lindstrom S, Dennis J, Beesley J, Hui S, Kar S, et al. Association analysis identifies 65 new breast cancer risk loci. Nature. 2017;551(7678):92-4. Epub 2017/10/24. doi: 10.1038/nature24284. PubMed PMID: 29059683; PubMed Central PMCID: PMCPMC5798588.</li>
                        <li>	MacArthur J, Bowler E, Cerezo M, Gil L, Hall P, Hastings E, et al. The new NHGRI-EBI Catalog of published genome-wide association studies (GWAS Catalog). Nucleic Acids Res. 2017;45(D1):D896-D901. Epub 2016/12/03. doi: 10.1093/nar/gkw1133. PubMed PMID: 27899670; PubMed Central PMCID: PMCPMC5210590.</li>
                        <li>.	Welter D, MacArthur J, Morales J, Burdett T, Hall P, Junkins H, et al. The NHGRI GWAS Catalog, a curated resource of SNP-trait associations. Nucleic Acids Res. 2014;42(Database issue):D1001-6. Epub 2013/12/10. doi: 10.1093/nar/gkt1229. PubMed PMID: 24316577; PubMed Central PMCID: PMCPMC3965119.</li>
                        <li>.	Schumacher FR, Al Olama AA, Berndt SI, Benlloch S, Ahmed M, Saunders EJ, et al. Association analyses of more than 140,000 men identify 63 new prostate cancer susceptibility loci. Nat Genet. 2018;50(7):928-36. Epub 2018/06/13. doi: 10.1038/s41588-018-0142-8. PubMed PMID: 29892016; PubMed Central PMCID: PMCPMC6568012.</li>
                        <li>	Phelan CM, Kuchenbaecker KB, Tyrer JP, Kar SP, Lawrenson K, Winham SJ, et al. Identification of 12 new susceptibility loci for different histotypes of epithelial ovarian cancer. Nat Genet. 2017;49(5):680-91. Epub 2017/03/28. doi: 10.1038/ng.3826. PubMed PMID: 28346442; PubMed Central PMCID: PMCPMC5612337.</li>
                        <li>	Ransohoff KJ, Wu W, Cho HG, Chahal HC, Lin Y, Dai HJ, et al. Two-stage genome-wide association study identifies a novel susceptibility locus associated with melanoma. Oncotarget. 2017;8(11):17586-92. Epub 2017/02/18. doi: 10.18632/oncotarget.15230. PubMed PMID: 28212542; PubMed Central PMCID: PMCPMC5392271.</li>
                        <li>	Huyghe JR, Bien SA, Harrison TA, Kang HM, Chen S, Schmit SL, et al. Discovery of common and rare genetic risk variants for colorectal cancer. Nat Genet. 2019;51(1):76-87. Epub 2018/12/05. doi: 10.1038/s41588-018-0286-6. PubMed PMID: 30510241; PubMed Central PMCID: PMCPMC6358437.</li>
                        <li>	Chahal HS, Wu W, Ransohoff KJ, Yang L, Hedlin H, Desai M, et al. Genome-wide association study identifies 14 novel risk alleles associated with basal cell carcinoma. Nat Commun. 2016;7:12510. Epub 2016/08/20. doi: 10.1038/ncomms12510. PubMed PMID: 27539887; PubMed Central PMCID: PMCPMC4992160.</li>
                        <li>	Chahal HS, Lin Y, Ransohoff KJ, Hinds DA, Wu W, Dai HJ, et al. Genome-wide association study identifies novel susceptibility loci for cutaneous squamous cell carcinoma. Nat Commun. 2016;7:12048. Epub 2016/07/19. doi: 10.1038/ncomms12048. PubMed PMID: 27424798; PubMed Central PMCID: PMCPMC4960294.</li>
                        <li>    Zhou W, Nielsen JB, Fritsche LG, Dey R, Gabrielsen ME, Wolford BN, LeFaive J, VandeHaar P, Gagliano SA, Gifford A, Bastarache LA, Wei WQ, Denny JC, Lin M, Hveem K, Kang HM, Abecasis GR, Willer CJ, Lee S. Efficiently controlling for case-control imbalance and sample relatedness in large-scale genetic association studies. Nat Genet. 2018;50(9):1335-41. doi: 10.1038/s41588-018-0184-y; PMCID: 30104761.</li>
                        <li>	Mak TSH, Porsch RM, Choi SW, Zhou X, Sham PC. Polygenic scores via penalized regression on summary statistics. Genet Epidemiol. 2017;41(6):469-80. Epub 2017/05/10. doi: 10.1002/gepi.22050. PubMed PMID: 28480976.</li>
                        <li>    Kuhn M, Wing J, Weston S, Williams A, Keefer C, Engelhardt A, Cooper T, Mayer Z, Kenkel B, the RCT, Benesty M, Lescarbeau R, Ziem A, Scrucca L, Tang Y, Candan C, Hunt T. caret: Classification and Regression Training. 2018.</li>
                        <li>	Mangiafico S. rcompanion: Functions to Support Extension Education Program Evaluation. 2019.
                        <li>	Signorell A. DescTools: Tools for Descriptive Statistics. 2018.
                        <li>	Robin X, Turck N, Hainard A, Tiberti N, Lisacek F, Sanchez JC, et al. pROC: an open-source package for R and S+ to analyze and compare ROC curves. BMC Bioinformatics. 2011;12:77. Epub 2011/03/19. doi: 10.1186/1471-2105-12-77. PubMed PMID: 21414208; PubMed Central PMCID: PMCPMC3068975.</li>
                        <li>	Hosmer DW, Lemeshow S. Applied Logistic Regression. New York, USA: John Wiley and Sons; 2010.</li>
                        <li>	Lele S, R., Keim JL, Solymos P. ResourceSelection: Resource Selection (Probability) Functions for Use-Availability Data. 2017.</li>
                        <li>	Steyerberg EW, Vickers AJ, Cook NR, Gerds T, Gonen M, Obuchowski N, et al. Assessing the performance of prediction models: a framework for
                        <li>	Kuhn M, Wing J, Weston S, Williams A, Keefer C, Engelhardt A, et al. caret: Classification and Regression Training. 2018.</li>
                        <li>	Heinze G. A comparative investigation of methods for logistic regression with separated or nearly separated data. Stat Med. 2006;25(24):4216-26. Epub 2006/09/07. doi: 10.1002/sim.2687. PubMed PMID: 16955543.</li>
                        <li>	Heinze G, Ploner M, Dunkler D, Southworth H. logistf: Firth's bias reduced logistic regression. 2013.</li>
                        <li>    Choi L, Beck C. EHR: Electronic Health Record (EHR) Data Processing and Analysis Tool. 2017.</li>
                        <li>    ritsche LG, Gruber SB, Wu Z, Schmidt EM, Zawistowski M, Moser SE, Blanc VM, Brummett CM, Kheterpal S, Abecasis GR, Mukherjee B. Association of Polygenic Risk Scores for Multiple Cancers in a Phenome-wide Study: Results from The Michigan Genomics Initiative. Am J Hum Genet. 2018;102(6):1048-61. doi: 10.1016/j.ajhg.2018.04.001; PMCID: 29779563.</li>
                        <li>	R Core Team. R: A Language and Environment for Statistical Computing. R Foundation for Statistical Computing, Vienna, Austria; 2016.</li>
                    </ol>


                </div>
            </div>
        </div>
        </div>

</body>
</html>