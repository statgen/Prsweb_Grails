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

        function gtag() {
            dataLayer.push(arguments);
        }

        gtag('js', new Date());

        gtag('config', 'UA-143045158-2');
    </script>

    <meta name="layout" content="main"/>
    <asset:javascript src="jquery-3.3.1.js"/>
    <asset:javascript src="jquery.tablesorter.min.js"/>
    <asset:javascript src="jquery.tablesorter.widgets.js"/>
    <asset:stylesheet src="theme.blue.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
            integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
            crossorigin="anonymous"></script>



    <title>Method</title>
    <STYLE>
    .row {
        position: relative;
        /* max-width: 1400px; */
        margin: 0 auto;
        padding: 0 5%;
    }

    div.drilldown {
        display: inline-block;
    }

    p + p {
        margin-top: 10px;
    }
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
                    <h4><P><A href="#prsstruct">PRS Structure</A><BR></h4><br/>

                    <h4><P><A href="#source">Sources of GWAS summary statistics</A><BR></h4><br/>


                    <h4><P><A href="#prs">PRS Construction</A></P></h4><BR>
                    <h4><P><A href="#prseval">PRS Evaluation</A></P></h4><BR>
                    <h4><P><A href="#asso">Phenome-wide Exploration of PRS Associations</A><BR></P></h4><BR>

                </div>

                <h4><P><A href="#catalog">Online Visual Catalog: PRSweb</A><BR></P></h4><BR>
                <h4><P><A href="#ref">Method References</A><BR></P></h4><BR>
                <h1><A name="evaco">Evaluation cohorts</A></h1>
                <br/>
                <h4><A name="mgi">Michigan Genomics Initiative (MGI)</A></h4>

                <p class="text-justify">
                    Adult participants aged between 18 and 101 years at enrollment were recruited through the Michigan Medicine health system between 2012 and 2018 while
                    awaiting diagnostic or interventional procedures either during a preoperative visit prior to the procedure or on the day of
                    the procedure that required anesthesia. In addition to coded biosamples and secure, protected health information, participants understood
                    that all EHR, claims, and national data sources linkable to the participant may be incorporated into the MGI databank.
                    Each participant donated a blood sample for genetic analysis, underwent baseline vital sign testing, and completed a comprehensive history and physical assessment
                    (also see Ethics Statement below). We report results obtained from 38,360 unrelated, genotyped patients of inferred recent European ancestry
                    with available integrated EHR data (~90 % of all MGI participants were inferred to be of recent European ancestry) 1.
                    The data used in this study included diagnoses coded with the Ninth and Tenth Revision of the International Statistical Classification of Diseases (ICD9 and ICD10)
                    with clinical modifications (ICD9-CM and ICD10-CM), sex, precomputed principal components (PCs), genotyping batch, and age.
                    Data were collected according to the Declaration of Helsinki principles 2. MGI study participants’ consent forms and protocols were reviewed and approved by
                    the University of Michigan Medical School Institutional Review Board (IRB ID HUM00099605 and HUM00155849). Opt-in written informed consent was obtained.
                    Additional details about MGI can be found online (<a href="https://precisionhealth.umich.edu/our-research/michigangenomics/">https://precisionhealth.umich.edu/our-research/michigangenomics/</a>).
                </p>

                <H2><A name="genedata"><u>Genetic data</u></A></H2>

                <p class="text-justify">
                    DNA from 47,364 blood samples was genotyped on customized Illumina Infinium CoreExome-24 bead arrays and subjected to various quality control filters, resulting in a set of 392,323 polymorphic variants. Principal components and ancestry were estimated by projecting all genotyped samples into the space of the principal components of the Human Genome Diversity Project reference panel using PLINK (938 individuals)<sup>3; 4</sup> .
                Pairwise kinship was assessed with the software KING<sup>5</sup>, and the software FastIndep was used to reduce the data to a maximal subset that contained no pairs of individuals with 3rd-or closer degree relationship <sup>6</sup>. We removed participants without EHR data and participants not of recent European descent from the analysis, resulting in a final sample of 38,360 unrelated subjects.
                Additional genotypes were obtained using the Haplotype Reference Consortium reference panel of the Michigan Imputation Server <sup>7</sup> and included over 24 million imputed variants with R<sup>2</sup><span>&#8805;</span>0.3 and minor allele frequency (MAF) <span>&#8805;</span>0.01%. Genotyping, quality control, and imputation are described in detail elsewhere <sup>1</sup>.

                </p>

                <H2><A name="phenome"><u>Phenome</u></A></H2>

                <p class="text-justify">

                    The MGI phenome was used as the discovery dataset and was based on ICD9-CM and ICD10-CM code data for 38,360 unrelated, genotyped individuals of recent European ancestry.
                    Longitudinal time-stamped diagnoses were recoded to indicators for whether a patient ever had given a diagnosis code recorded by Michigan Medicine.
                    These ICD9-CM and ICD10-CM codes were aggregated to form up to 1,857 PheWAS traits using the PheWAS R package
                    (as described in detail elsewhere <sup>1; 8</sup>). For each trait, we identified case and control samples.
                To minimize differences in age and sex distributions, avoid extreme case-control ratios,
                and reduce the computational burden, we matched up to 10 controls to each case using the R package “MatchIt” <sup>9</sup>.
                Nearest neighbor matching was applied for age and the first four principal components of the genotype data (PC1-4) using Mahalanobis distance with a caliper/width of 0.25 standard deviations.
                Exact matching was applied for sex and genotyping array. A total of 1,689 case-control studies with >50 cases were used for our analyses of the MGI phenome.






                    <br/><br/>
                </p>
                <H4><A name="unbio">UK Biobank (UKB)</A></H4>

                <p class="text-justify">
                    UKB is a population-based cohort collected from multiple sites across the United Kingdom and includes over 500,000 participants aged between 40 and 69 years when recruited in 2006–2010 <sup>10</sup>.
                The open-access UK Biobank data used in this study included genotypes, ICD9 and ICD10 codes, inferred sex, inferred White British ancestry, kinship estimates down to third degree, birthyear, genotype array,
                and precomputed principal components of the genotypes.
                </p>

                <H2><A name="ukgene"><u>Genetic data</u></A></H2>


                <p class="text-justify">We used the UK BioBank Imputed Dataset (v3) and limited analyses to the documented 408,961 White British 11 individuals and 47,836,001
                variants with imputation information score <span>&#x2267;</span> 0.3 and MAF <span>&#x2267;</span> 0.01%  of which 22,846,729 overlapped with the imputed MGI data (see above).
                Two random subsets of 5,000 and 10,000 unrelated, White British individuals were used for LD analyses of UKB-based summary statistics.
                </p>

                <H2><A name="ukphen"><u>Phenome</u></A></H2>

                <p class="text-justify">

                    The UK Biobank phenome was used as a replication dataset and was based on ICD9 and ICD10 code data of 408,961 White British <sup>11</sup>,
                genotyped individuals that were similarly aggregated to PheWAS traits as MGI (as described elsewhere <sup>12</sup>).
                In contrast to MGI, there were many pairwise relationships reported for UKB participants.
                To retain a larger effective sample size for each phenotype, we first selected a maximal set of unrelated cases for each phenotype
                (defined as no pairwise relationship of 3rd degree or closer <sup>6; 13</sup>) before selecting a maximal set of unrelated controls unrelated to these cases.
                Similar to MGI, we matched up to 10 controls to each case using the R package “MatchIt” <sup>9</sup>. Nearest neighbor matching was applied for birthyear (as proxy for age, because age at diagnosis was not available to us) and PC1-4 (Mahalanobis-metric matching; matching window caliper/width of 0.25 standard deviations), and exact matching was applied for sex and genotyping array. A total of 1,419 case-control studies with >50 cases each were used for our analyses of the UK Biobank phenome.
                On average, we were able to match 9 controls per case in the MGI phenome and 9.9 controls per case in the UKB phenome. Additional phenotype information for MGI and UK Biobank is included in.

                </p>
                <br/><br/>

                <h1><A name="prsheaders">PRS</A></h1>

                <H2><A name="prsstruct"><u>PRS Structure</u></A></H2>

                <p class="text-justify">
                    PRS combine information across a defined set of genetic loci, incorporating each locus’s association with the target trait.
                    The PRS for patient j takes the form  PRS<sub>j</sub>=∑<sub>i</sub>β<sub>i</sub> G<sub>ij</sub> where i indexes the included loci for that trait, weight β<sub>i</sub> is the log odds ratios retrieved from the external GWAS summary statistics for locus i, and G<sub>i</sub>
                    is a continuous version of the measured dosage data for the risk allele on locus i in subject j. In order to construct a PRS, one must determine which genetic loci
                    to include in the PRS and their relative weights. Below, we obtain GWAS summary statistics from several different sources,
                    resulting in several sets of weights for each trait of interest. For each set of weights,
                    we consider several strategies for determining which genetic loci to include in the PRS construction.
                </p>


                <H2><A name="source"><u>Sources of GWAS summary statistics</u></A></H2>

                <p class="text-justify">
                    For each of 68 cancers of interest, we collected GWAS summary statistics from up to three different sources:
                    (1) merged genome-wide significant association signals published in the NHGRI EBI GWAS Catalog <sup>14</sup>
                    if available; (2) large cancer GWAS meta-analysis if available; and (3) publicly available GWAS summary statistics of phenome x
                    genome screening efforts of the UK Biobank data<sup>12</sup>(see<b>Web Resources; </b>). If needed,
                we used LiftOver to convert coordinates of GWAS summary statistics to human genome assembly GRCh37 (UCSC Genome Browser Store, see Web Resources).
                </p>


                <H2><A name="gwas"><u>GWAS Catalog</u></A></H2>

                <p class="text-justify">
                    We downloaded previously reported GWAS variants from the NHGRI-EBI GWAS Catalog (file version: r2019-05-03) <sup>14; 15</sup>. Single nucleotide
                polymorphism (SNP) positions were converted to GRCh37 using variant IDs from dbSNP (build 151; UCSC Genome Browser) after updating outdated dbSNP IDs to their merged dbSNP IDs.
                </p>

                <p class="text-justify">
                    Entries with missing risk alleles, risk allele frequencies, or SNP-disease odds ratios were excluded. If a reported risk allele did not match any of the
                    reported forward strand alleles of a non-ambiguous SNP (not A/T or C/G) in the imputed MGI genotype data (which correspond to the alleles of the
                    imputation reference panel), we assumed minus-strand designation and corrected the effect allele to its complementary base of the forward strand.
                    Entries with a reported risk allele that did not match any of the alleles of an ambiguous SNP (A/T and C/G) in our data were excluded at this step.
                    We only included entries with broad European ancestry (as reported by the NHGRI-EBI GWAS Catalog) to match ancestries of discovery GWAS and target
                    cohorts (MGI and UKB). As a quality control check, we compared the GWAS Catalog reported risk allele frequencies (RAF) with the RAF in MGI individuals.
                    We then excluded entries whose RAF deviated more than 15%. This chosen threshold is subjective and was based on clear differentiation between correct
                    and likely flipped alleles on the two diagonals (Figure S1), as noted frequently in GWAS meta-analyses quality control procedures <sup>16</sup>.
                For SNPs with multiple entries, we kept the SNP with the most recent publication date (and smaller p-value, if necessary) and excluded the others.

                </p>

                <H2><A name="metan"><u>Large GWAS meta-analyses</u></A></H2>

                <p class="text-justify">
                    We downloaded full GWAS summary statistics made available by the “Breast Cancer Association Consortium” (BCAC)<sup>13</sup>
                    , the “Prostate Cancer Association Group to Investigate Cancer Associated Alterations in the Genome” (PRACTICAL) <sup>17</sup>,
                and the “Ovarian Cancer Association Consortium” (OCAC) 18; 19. In addition, we extracted partial GWAS summary statistics that accompanied
                recent publications but were incomplete, i.e. reporting only SNPs below a certain p-value threshold <sup>20-23</sup>.
                GWAS summary statistics were harmonized and, if needed, lifted over to human genome assembly GRCh37.
                In this paper, this source is referred to as “Large GWAS”.
                </p>

                <H2><A name="ukgwas"><u>UK-Biobank-based GWAS</u></A></H2>

                <p class="text-justify">
                    We downloaded UK Biobank based GWAS summary statistics from two public repositories.
                </p>

                <p class="text-justify">

                    The first set of UK Biobank GWAS summary statistics were based on the analysis of up to 408,961 White British European-ancestry samples (UKB GWAS Lee Lab, see Web Resources).
                    SNP-disease odds ratios were estimated using logistic mixed modeling adjusting for sample relatedness, and p-values were estimated using saddlepoint approximations (SAIGE method)<sup>24</sup>
                    to calibrate the distribution of score test statistics and, thus, control for unbalanced case-control ratios. The underlying phenotypes were auto-curated phenotypes based on the PheCodes of the PheWAS R package <sup>1; 8; 12</sup>
                    similar to the phenomes used in our study and in the following are referred to as “UKB PHECODE”.
                </p>

                <p class="text-justify">
                    The second set of UK Biobank GWAS summary statistics were based on a linear regression model of up to 361,194 unrelated White British samples adjusting for
                    relevant covariates (UKB GWAS Neale Lab, see Web Resources). Three phenotype models were used in their analyses:
                    (1) “PHESANT”: auto-curated phenotypes using PHEnome Scan ANalysis Tool, (2) “ICD10”: individuals with the same ICD10
                    category code (first three characters, e.g. “C50”) were used as cases while all non-coded individuals were treated as controls, and
                    (3) “FINNGEN”: curated phenotypes / endpoints based on definitions of the Finngen consortium. In addition to the “UKB PHECODE”
                    (described above), these three latter sources are referred to as “UKB PHESANT”, “UKB ICD10” and “UKB FINNGEN”, respectively ( see Web Resources).
                </p>

                <br/><br/>

                <h4><A name="prs">PRS Construction</A></h4>

                <p class="text-justify">
                    For each set of GWAS summary statistics from the above-mentioned sources and each cancer, we develop up to seven different PRS using three different construction methods.
                    Our goal of this approach was to compare multiple PRS methods and find the method that works best for the various types of GWAS summary statistics.
                </p>

                <p class="text-justify">

                    For the first two construction strategies, we performed LD clumping/pruning of variants with p-values below 10<sup>-4</sup> by using the imputed allele dosages of 10,000 randomly selected
                samples and a pairwise correlation cut-off at r<sup>2</sup> <span>&#x3c;</span> 0.1 within 1Mb window. Using the resulting loci, we defined up to five sub-sets of variants with p-values
                below different thresholds (<5x10<sup>-9</sup> to <5x10<sup>-5</sup>). These were used to construct a PRS tied to each threshold, where the PRS associated with p-values less than 5x10<sup>-8</sup>
                    is sometimes denoted as “GWAS hits.” For the second PRS construction method, we construct many different PRS across a fine grid of p-value thresholds.
                    The p-value threshold with the highest pseudo-R2 (see PRS Evaluation below) was used to define the more optimized “Pruning and Thresholding (P & T)” PRS.

                </p>

                <p class="text-justify">

                    As an alternative to the p-value thresholding and “P&T” PRS construction strategies, we also used the software package “lassosum” <sup>25</sup>
                    to define a third type of PRS for GWAS sources with full summary statistics. Lassosum obtains PRS weights by applying elastic net penalization to GWAS summary
                    statistics and incorporating LD information from a reference panel. Here, we used 5,000 randomly selected, unrelated samples as the LD reference panel.
                    We applied a MAF filter of 1 % and, in contrast to the other two approaches, only included autosomal variants that overlap between summary statistics,
                    LD reference panel, and target panel. Each “lassosum” run resulted in up to 76 combinations of the elastic net tuning parameters s and λ, and consequently, in
                    76 SNP sets with corresponding weights used to construct 76 PRS. We then selected the PRS with the highest pseudo-R2 to define the “lassosum” PRS (see PRS Evaluation below).

                </p>

                <p class="text-justify">
                    For each cancer and set of GWAS summary statistics, this approach resulted in up to seven PRS,
                    where PRS with less than 5 included variants were excluded and the available GWAS summary statistics
                    limited the available PRS construction techniques in some cases. Using the R package “Rprs” (see Web Resources),
                    the value of each PRS was then calculated for each MGI participant and, if the GWAS source was not based on UKB,
                    also for each UKB participant. For comparability of association effect sizes corresponding to the continuous PRS
                    across cancer traits and PRS construction methods, we centered PRS values in MGI and UKB to their mean and scaled
                    them to have a standard deviation of 1.

                </p>



                <br/><br/>
                <h4><A name="prseval">PRS Evaluation</A></h4>

                <p class="text-justify">For the PRS evaluations, we fit the following model for each PRS and cancer phenotype without adjusting for covariates::
                </p>

                <p class="text-justify">
                    logit (P(Phenotype is present | PRS,Age, Sex, Array, PC)) =β<sub>0</sub>+β<sub>PRS</sub> PRS+β<sub>Age</sub>Age+ β<sub>Sex</sub>Sex+β<<sub>Array</sub>Array+β PC
                </p>

                <p class="text-justify">
                    We used Nagelkerke’s pseudo-R2 (26)
                    to select the tuning parameters within the “P&T” and lassosum construction methods (P-value for “P&T” SNP sets; s and λ for lassosum) and kept the
                    PRS with the highest pseudo-R2 for further analyses. For each PRS derived for each GWAS source/method combination, we assessed the following
                    performance measures relative to observed disease status in MGI and UKB:
                    (1) overall performance with Nagelkerke’s pseudo-R<sup>2</sup>using R packages “rcompanion” (26), (2) accuracy with Brier score using R package “DescTools” (27);
                (3) ability to discriminate between cases and controls as measured by the area under the receiver operating characteristic (ROC) curve (denoted AUC) using R package “pROC”
                (28) and (4) calibration using Hosmer-Lemeshow Goodness of Fit test in the R package “ResourceSelection” (29-31).
                </p>

                <p class="text-justify">

                    For cross-validation purposes, we split the corresponding data for each trait in
                    a phenome into training and test set. To retain case control matching (see “Phenome generation” above),
                    we randomly and equally distributed unique strata from matching and thus obtained a 50/50% split of
                    cases where their matched controls were assigned to the same subset. We used the training set to determine the
                    PRS tuning parameter(s) with the highest pseudo-R<sup>2</sup> and used the testing set to obtain performance metrics for that PRS.
                Firth's bias reduction method was used to resolve the problem of separation in logistic regression (R package “brglm2”)<sup>33; 34</sup>.

                </p>
                <br/><br/>

                <h4><A name="testing">PRS Association Testing</A></h4>

                <p class="text-justify">
                    Next, we assessed the strength of the relationship between these PRS and the traits they were designed for. To do this we fit the following model for each PRS and cancer phenotype
                    adjusting for various covariates:
                </p>

                <p class="text-justify">
                    logit (P(Phenotype is present | PRS, Age, Sex, Array, PC)) =β<sub>0</sub>+β<sub>PRS</sub>PRS+β<sub>Age</sub> Age+ β<sub>Sex</sub>Sex+β<sub>Array</sub>Array+β PC,
                </p>

                <p class="text-justify">
                    where the PCs were the first four principal components obtained from the principal component analysis of the genotyped GWAS markers,
                    where “Age” was the age at last observed diagnosis in MGI and birthyear in UKB and where “Array” represents the genotyping array.
                    Our primary interest is β<sub>PRS</sub>, while the other factors (Age, Sex and PC) were included to address potential residual confounding and
                do not provide interpretable estimates due to the preceding application of case-control matching.
                Firth's bias reduction method was used to resolve the problem of separation in logistic regression (Logistf in R package “EHR”) <sup>35-37</sup>

                </p>

                <p class="text-justify">
                    To study the ability of the PRS to identify high risk patients, we fit the above model but replacing the PRS with an indicator for whether the PRS value
                    was in the top 1, 2, 5, 10, or 25% among the matched case control cohort.

                </p>
                <br/><br/>




                <h4><A name="ref">Phenome-wide Exploration of PRS Associations</A></h4>

                <p class="text-justify">

                    We selected PRS that were strongly associated with the cancer trait they weredesigned for phenome-wide association exploration in the phenomes of MGI andUKB for
                    (p-value <span>&#x2264;</span> (0.05 / [#phenotypes in corresponding phenome]); see below).
                </p>

                <p class="text-justify">
                    We conducted PheWAS in MGI and also UKB (if the GWAS source was not based on UKB) to identify additional,
                    secondary phenotypes associated with the PRS <sup>38</sup>. To evaluate PRS-phenotype associations, we conducted
                Firth bias-corrected logistic regression by fitting model of equation 1 above for each PRS and each phenotype of the corresponding phenome.
                To adjust for multiple testing, we applied the conservative phenome-wide Bonferroni correction according to the total number of analyzed PheWAS codes
                (MGI: 1,689 phenotypes; UKB: 1,419 phenotypes;). In Manhattan plots, we present –log10(p-value) corresponding to tests of H<sub>0</sub>: β<sub>PRS</sub>=0.  Directional triangles on the PheWAS plot indicate whether a phenome-wide significant trait was positively (pointing up) or negatively (pointing down) associated with the PRS
                </p>

                <p class="text-justify">
                    To investigate the possibility of the secondary trait associations with PRS being completely driven by the primary trait association, we performed a second set of PheWAS after excluding individuals affected with the primary or related cancer traits for which the PRS was constructed, referred to as “Exclusion-PRS-PheWAS” as described previously<sup>1</sup>.
                </p>

                <br/><br/>

                <h4><A name="catalog">Online Visual Catalog: PRSweb</A></h4>

                <p class="text-justify">
                    The online open access visual catalog PRSweb was implemented using Grails, a Groovy- and Java-based backend logic, to integrate interactive visualizations and MySQL databases. Interactive PheWAS plots are drawn with the JavaScript library “LocusZoom.js” which is maintained by the
                    UM Center for Statistical Genetics (Locuszoom, see Web Resources) and offers dynamic plotting, automatic plot sizing, and label positioning. Additional data-driven visualizations (e.g. temporal relationship plots) were implemented with the JavaScript library “D3.js”.

                </p>

                <p class="text-justify">
                    Unless otherwise stated, analyses were performed using R 3.6.1 <sup>39</sup>

                </p>

                <br/><br/>

                <h4><A name="ref">
                    Method References
                </A></h4>

                <p class="text-justify">

                <ol>
                <li>Fritsche, L.G., Gruber, S.B., Wu, Z., Schmidt, E.M., Zawistowski, M., Moser, S.E., Blanc, V.M., Brummett, C.M., Kheterpal, S., Abecasis, G.R., et al. (2018). Association of Polygenic Risk Scores for Multiple Cancers in a Phenome-wide Study: Results from The Michigan Genomics Initiative. Am J Hum Genet 102, 1048-1061</li>
                <li> World Medical Association. (2013). World Medical Association Declaration of Helsinki: ethical principles for medical research involving human subjects. JAMA 310, 2191-2194.</li>
                <li> Wang, C., Zhan, X., Bragg-Gresham, J., Kang, H.M., Stambolian, D., Chew, E.Y., Branham, K.E., Heckenlively, J., Study, F., Fulton, R., et al. (2014). Ancestry estimation and control of population stratification for sequence-based association studies. Nat Genet 46, 409-415.</li>
                <li> Li, J.Z., Absher, D.M., Tang, H., Southwick, A.M., Casto, A.M., Ramachandran, S., Cann, H.M., Barsh, G.S., Feldman, M., Cavalli-Sforza, L.L., et al. (2008). Worldwide human relationships inferred from genome-wide patterns of variation. Science 319, 1100-1104.</li>
                <li>Manichaikul, A., Mychaleckyj, J.C., Rich, S.S., Daly, K., Sale, M., and Chen, W.M. (2010). Robust relationship inference in genome-wide association studies. Bioinformatics 26, 2867-2873.</li>
                <li> Abraham, K.J., and Diaz, C. (2014). Identifying large sets of unrelated individuals and unrelated markers. Source Code Biol Med 9, 6.</li>
                <li> McCarthy, S., Das, S., Kretzschmar, W., Delaneau, O., Wood, A.R., Teumer, A., Kang, H.M., Fuchsberger, C., Danecek, P., Sharp, K., et al. (2016). A reference panel of 64,976 haplotypes for genotype imputation. Nat Genet 48, 1279-1283.</li>
                <li>Carroll, R.J., Bastarache, L., and Denny, J.C. (2014). R PheWAS: data analysis and plotting tools for phenome-wide association studies in the R environment. Bioinformatics 30, 2375-2376.</li>
                <li>Ho, D.E., Imai, K., King, G., and Stuart, E.A. (2011). MatchIt: Nonparametric Preprocessing for Parametric Causal Inference. J Stat Softw 42, 1-28.</li>
                <li>Sudlow, C., Gallacher, J., Allen, N., Beral, V., Burton, P., Danesh, J., Downey, P., Elliott, P., Green, J., Landray, M., et al. (2015). UK biobank: an open access resource for identifying the causes of a wide range of complex diseases of middle and old age. PLoS Med 12, e1001779.</li>
                <li> Bycroft, C., Freeman, C., Petkova, D., Band, G., Elliott, L.T., Sharp, K., Motyer, A., Vukcevic, D., Delaneau, O., O'Connell, J., et al. (2017). Genome-wide genetic data on ~500,000 UK Biobank participants. bioRxiv.</li>
                <li> Zhou, W., Nielsen, J.B., Fritsche, L.G., Dey, R., Gabrielsen, M.E., Wolford, B.N., LeFaive, J., VandeHaar, P., Gagliano, S.A., Gifford, A., et al. (2018). Efficiently controlling for case-control imbalance and sample relatedness in large-scale genetic association studies. Nat Genet 50, 1335-1341.</li>
                <li> Michailidou, K., Lindstrom, S., Dennis, J., Beesley, J., Hui, S., Kar, S., Lemacon, A., Soucy, P., Glubb, D., Rostamianfar, A., et al. (2017). Association analysis identifies 65 new breast cancer risk loci. Nature 551, 92-94.</li>
                <li>MacArthur, J., Bowler, E., Cerezo, M., Gil, L., Hall, P., Hastings, E., Junkins, H., McMahon, A., Milano, A., Morales, J., et al. (2017). The new NHGRI-EBI Catalog of published genome-wide association studies (GWAS Catalog). Nucleic Acids Res 45, D896-D901.</li>
                <li>Welter, D., MacArthur, J., Morales, J., Burdett, T., Hall, P., Junkins, H., Klemm, A., Flicek, P., Manolio, T., Hindorff, L., et al. (2014). The NHGRI GWAS Catalog, a curated resource of SNP-trait associations. Nucleic Acids Res 42, D1001-1006.</li>
                <li> Winkler, T.W., Day, F.R., Croteau-Chonka, D.C., Wood, A.R., Locke, A.E., Magi, R., Ferreira, T., Fall, T., Graff, M., Justice, A.E., et al. (2014). Quality control and conduct of genome-wide association meta-analyses. Nat Protoc 9, 1192-1212.</li>
                <li> Schumacher, F.R., Al Olama, A.A., Berndt, S.I., Benlloch, S., Ahmed, M., Saunders, E.J., Dadaev, T., Leongamornlert, D., Anokian, E., Cieza-Borrella, C., et al. (2018). Association analyses of more than 140,000 men identify 63 new prostate cancer susceptibility loci. Nat Genet 50, 928-936.</li>
                <li>Phelan, C.M., Kuchenbaecker, K.B., Tyrer, J.P., Kar, S.P., Lawrenson, K., Winham, S.J., Dennis, J., Pirie, A., Riggan, M.J., Chornokur, G., et al. (2017). Identification of 12 new susceptibility loci for different histotypes of epithelial ovarian cancer. Nat Genet 49, 680-691.</li>
                <li> Buniello, A., MacArthur, J.A.L., Cerezo, M., Harris, L.W., Hayhurst, J., Malangone, C., McMahon, A., Morales, J., Mountjoy, E., Sollis, E., et al. (2019). The NHGRI-EBI GWAS Catalog of published genome-wide association studies, targeted arrays and summary statistics 2019. Nucleic Acids Res 47, D1005-D1012.</li>
                <li>Ransohoff, K.J., Wu, W., Cho, H.G., Chahal, H.C., Lin, Y., Dai, H.J., Amos, C.I., Lee, J.E., Tang, J.Y., Hinds, D.A., et al. (2017). Two-stage genome-wide association study identifies a novel susceptibility locus associated with melanoma. Oncotarget 8, 17586-17592.</li>
                <li>Huyghe, J.R., Bien, S.A., Harrison, T.A., Kang, H.M., Chen, S., Schmit, S.L., Conti, D.V., Qu, C., Jeon, J., Edlund, C.K., et al. (2019). Discovery of common and rare genetic risk variants for colorectal cancer. Nat Genet 51, 76-87.</li>
                <li>Chahal, H.S., Wu, W., Ransohoff, K.J., Yang, L., Hedlin, H., Desai, M., Lin, Y., Dai, H.J., Qureshi, A.A., Li, W.Q., et al. (2016). Genome-wide association study identifies 14 novel risk alleles associated with basal cell carcinoma. Nat Commun 7, 12510.</li>
                <li> Chahal, H.S., Lin, Y., Ransohoff, K.J., Hinds, D.A., Wu, W., Dai, H.J., Qureshi, A.A., Li, W.Q., Kraft, P., Tang, J.Y., et al. (2016). Genome-wide association study identifies novel susceptibility loci for cutaneous squamous cell carcinoma. Nat Commun 7, 12048.</li>
                <li> Zhou, W., Nielsen, J.B., Fritsche, L.G., Dey, R., Gabrielsen, M.E., Wolford, B.N., LeFaive, J., VandeHaar, P., Gagliano, S.A., Gifford, A., et al. (2018). Efficiently controlling for case-control imbalance and sample relatedness in large-scale genetic association studies. Nat Genet 50, 1335-1341.</li>
                <li> Mak, T.S.H., Porsch, R.M., Choi, S.W., Zhou, X., and Sham, P.C. (2017). Polygenic scores via penalized regression on summary statistics. Genet Epidemiol 41, 469-480.</li>
                <li> Mangiafico, S. (2019). rcompanion: Functions to Support Extension Education Program Evaluation. https://CRAN.R-project.org/package=rcompanion.</li>
                <li> Signorell, A. (2018). DescTools: Tools for Descriptive Statistics. https://cran.r-project.org/package=DescTools.</li>
                <li>Janes, H., and Pepe, M.S. (2009). Adjusting for covariate effects on classification accuracy using the covariate-adjusted receiver operating characteristic curve. Biometrika 96, 371-382.</li>
                <li> Rodriguez-Alvarez, M.X., and Inacio, V. (2020). ROCnReg: ROC Curve Inference with and without Covariates. https://CRAN.R-project.org/package=ROCnReg.</li>
                <li>Hosmer, D.W., and Lemeshow, S. (2010). Applied Logistic Regression.(New York, USA: John Wiley and Sons).</li>
                <li> Lele, S., R., Keim, J.L., and Solymos, P. (2017). ResourceSelection: Resource Selection (Probability) Functions for Use-Availability Data. https://CRAN.R-project.org/package=ResourceSelection.</li>
                <li> Steyerberg, E.W., Vickers, A.J., Cook, N.R., Gerds, T., Gonen, M., Obuchowski, N., Pencina, M.J., and Kattan, M.W. (2010). Assessing the performance of prediction models: a framework for traditional and novel measures. Epidemiology 21, 128-138.</li>
                <li> Kosmidis, I., Clovis Kenne Pagui, E., and Sartori, N. (2018). Mean and median bias reduction in generalized linear models. https://ui.adsabs.harvard.edu/abs/2018arXiv180404085K.</li>
                <li> Kosmidis, I. (2019). brglm2: Bias Reduction in Generalized Linear Models. https://CRAN.R-project.org/package=brglm2.</li>
                <li>Heinze, G. (2006). A comparative investigation of methods for logistic regression with separated or nearly separated data. Stat Med 25, 4216-4226.</li>
                <li> Heinze, G., Ploner, M., Dunkler, D., and Southworth, H. (2013). logistf: Firth's bias reduced logistic regression. https://CRAN.R-project.org/package=logistf.</li>
                <li> Choi, L., and Beck, C. (2017). EHR: Electronic Health Record (EHR) Data Processing and Analysis Tool. https://CRAN.R-project.org/package=EHR.</li>
                <li> Fritsche, L.G., Gruber, S.B., Wu, Z., Schmidt, E.M., Zawistowski, M., Moser, S.E., Blanc, V.M., Brummett, C.M., Kheterpal, S., Abecasis, G.R., et al. (2018). Association of Polygenic Risk Scores for Multiple Cancers in a Phenome-wide Study: Results from The Michigan Genomics Initiative. Am J Hum Genet 102, 1048-1061.</li>
                <li> R Core Team. (2016). R: A Language and Environment for Statistical Computing. (R Foundation for Statistical Computing, Vienna, Austria), https://www.R-project.org/.</li>



            </ol>

            </div>
        </div>
    </div>
</div>

</body>
</html>