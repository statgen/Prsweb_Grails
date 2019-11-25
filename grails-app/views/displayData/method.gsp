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
    div.drilldown { display: inline-block; }
    p + p { margin-top: 10px; }
    </STYLE>


</head>

<body>
        <div id="create-displayData" class="content scaffold-create mt-5" role="main">
        <div class="container-fluid">
            <div class="row" style="background-color: white">
                <div class="col-10">



                    <H1>Table of Contents</H1><br/>
                    <h4><p><A href="#evaco">Evaluation cohorts</A><BR></p></h4><br/>
                    <h4><A href="#mgi">Michigan Genomics Initiative (MGI)</A><BR></h4><br/>

                    <h4><A href="#unbio">UK Biobank (UKB)</A><BR></h4><br/>

                    <h4><P><A href="#source"> Sources of GWAS summary statistics</A><BR></h4><br/>

                        <h4><P><A href="#prs">PRS Generation</A></P></h4><BR>
                        <h4><P><A href="#prseval">PRS Evaluation</A></P></h4><BR>
                        <h4><P><A href="#asso">Phenome-wide Exploration of PRS Associations</A><BR></P></h4><BR>
                        <h4><P><A href="#ref">Method References</A><BR></P></h4><BR>



                        <h1><A name="evaco">Evaluation cohorts</A></h1>
                    <br/>
                        <h4><A name="mgi">Michigan Genomics Initiative (MGI)</A></h4>
                        <p class="text-justify">Participants were recruited through the Michigan Medicine health system while awaiting diagnostic or interventional procedures either during a preoperative visit prior to the procedure or on the day of the procedure that required anaesthesia. In addition to coded biosamples and secure protected health information, participants understood that all EHR, claims, and national data sources – linkable to the participant – may be incorporated into the MGI databank. Each participant donated a blood sample for genetic analysis, underwent baseline vital signs and a comprehensive history and physical assessment (also see Ethics Statement below). In the current study, we report results obtained from 38,360 unrelated, genotyped samples of recent European ancestry with available integrated EHR data (~90 % of all MGI participants were inferred to be of recent European ancestry) [1]. Data were collected according to Declaration of Helsinki principles. MGI study participants’ consent forms and protocols were reviewed and approved by the University of Michigan Medical School Institutional Review Board (IRB ID HUM00099605 and HUM00155849). Opt-in written informed consent was obtained.

                        </p><H2><A name="genedata"><u>Genetic data</u></A></H2>
                        <p class="text-justify">DNA from 47,364 blood samples was genotyped on customized Illumina Infinium CoreExome-24 bead arrays and subjected to various quality control filters that resulted in a set of 392,323 polymorphic variants. Principal components and ancestry were estimated by projecting all genotyped samples into the space of the principal components of the Human Genome Diversity Project reference panel using PLINK (938 unrelated individuals) [2, 3]. Pairwise kinship was assessed with the software KING [4], and the software fastindep was used to reduce the data to a maximal subset that contained no pairs of individuals with 3rd-or closer degree relationship [5]. We also removed participants without EHR data and not of recent European descent from the analysis, resulting in a final sample of 38,360 unrelated subjects. Additional genotypes were obtained using the Haplotype Reference Consortium using the Michigan Imputation Server [6] and included over 24 million imputed variants with R2 ≥0.3 and minor allele frequency (MAF) ≥0.01%. Genotyping, quality control and imputation are described in detail elsewhere [1]. Two random subsets of 5,000 and 10,000 unrelated individuals were used for linkage disequilibrium (LD) analyses of non-UKB-based summary statistics

                        </p><H2><A name="phenome"><u>Phenome</u></A></H2>
                        <p class="text-justify">The MGI phenome was based on ICD9-CM and ICD10-CM code data for 38,360 unrelated, genotyped individuals of recent European ancestry. These ICD9-CM and ICD10-CM codes were aggregated to form up to 1,857 PheWAS traits using the PheWAS R package (as described in detail elsewhere [1, 7]). For each trait, we identified case and control samples. To minimize differences in age and sex distributions or extreme case-control ratios as well as to reduce computational burden, we matched up to 10 controls to each case using the R package “MatchIt” [8]. Nearest neighbor matching was applied for age and the first four principal components (PC1-4; using Mahalanobis-metric matching; matching window caliper/width of 0.25 standard deviations) and exact matching was applied for sex and genotyping array. A total of 1,689 case-control studies with >50 cases were used for our analyses of the MGI phenome.
                        <br/><br/>
                        </p>
                        <H4><A name="unbio">UK Biobank (UKB)</A></H4>
                        <p class="text-justify">The UK Biobank is a population-based cohort collected from multiple sites across the United Kingdom and includes over 500,000 participants aged between 40 and 69 years when recruited in 2006–2010 [9]. The open access UK Biobank data used in this study included genotypes, the Ninth and Tenth Revision of the International Statistical Classification of Diseases (ICD9 and ICD10) codes, inferred sex, inferred White British ancestry, kinship estimates down to third degree, birthyear, genotype array, and precomputed principal components of the genotypes. Part of this research has been conducted using the UK Biobank Resource under application number 24460.
                        </p>

                    <H2><A name="ukgene"><u>Genetic data</u></A></H2>

                        <p class="text-justify"> We used the UK BioBank Imputed Dataset (n= 487,409, https://www.ebi.ac.uk/ega/datasets/EGAD00010001474) and limited analyses to 408,961 White British [10] individuals and 47,836,001 variants with info >= 0.3 and MAF >= 0.01% of which 22,846,729 overlapped with the imputed MGI data (see above). Two random subsets of 5,000 and 10,000 unrelated, White British individuals were used for LD analyses of UKB-based summary statistics.
                        </p>

                    <H2><A name="ukphen"><u>Phenome</u></A></H2>

                        <p class="text-justify">The UKB phenome was based on ICD9 and ICD10 code data of 408,961 White British [10], genotyped individuals that were aggregated to PheWAS traits in a similar fashion (as described elsewhere [11]). To remove related individuals and to retain larger sample sizes, we first selected a maximal set of unrelated cases for each phenotype (defined as no pairwise relationship of 3rd degree or closer [5, 12]) before selecting a maximal set of unrelated controls unrelated to these cases. Similar to MGI, we matched up to 10 controls to each case using the R package “MatchIt” [8]. Nearest neighbor matching was applied for birthyear and PC1-4 (using Mahalanobis-metric matching; matching window caliper/width of 0.25 standard deviations) and exact matching was applied for sex and genotyping array. A total of 1,419 case-control studies with >50 cases each were used for our analyses of the UK Biobank phenome.
                        </p>
                            <br/><br/>
                            <h4><A name="source">Sources of GWAS summary statistics</A></h4>

                        <p class="text-justify">For each cancer phecode, we collected GWAS summary statistics from up to three different sources: (1) merged genome-wide significant association signals published in the NHGRI EBI GWAS catalog [13] if available; (2) large cancer GWAS meta-analysis if available; and (3) publicly available GWAS summary statistics of phenome x genome screening efforts of the UK Biobank data [11].
                        </p>

                    <H2><A name="gwas"><u>GWAS Catalog</u></A></H2>

                        <p class="text-justify">We downloaded previously reported GWAS variants from the NHGRI-EBI GWAS catalog (current file version: r2019-05-03, https://www.ebi.ac.uk/gwas/) [13, 14]. Single nucleotide polymorphism (SNP) positions were converted to GRCh37 using variant IDs from dbSNP (build 151; UCSC Genome Browser, http://genome.ucsc.edu/) after updating outdated dbSNP IDs to their merged dbSNP IDs.
                    Entries with missing risk alleles, risk allele frequencies, or odds ratios were excluded. If a reported risk allele did not match any of the reported forward strand alleles of a non-ambiguous SNP (not A/T or C/G) in the imputed MGI genotype data (which correspond to the alleles of the imputation reference panel), we assumed minus strand designation and corrected the effect allele to its complementary base of the forward strand. Entries with a reported risk allele that did not match any of the alleles of an ambiguous SNP (A/T and C/G) in our data were excluded at this step. We only included entries with broad European ancestry (as reported by the NHGRI-EBI GWAS catalog) to match ancesties of source and target cohorts (UKB and MGI). As a quality control check, we compared the reported risk allele frequencies (RAF) in 38,360 unrelated, European-ancestry MGI individuals. We then excluded entries whose RAF deviated more than 15%. For SNPs with multiple entries, we kept the SNP with the most recent publication date (and smaller P value, if necessary) and excluded the other.
                        </p>
                    <H2><A name="metan"><u>Large GWAS meta-analyses</u></A></H2>
                        <p class="text-justify">We downloaded full GWAS summary statistics that were made available by the “Breast Cancer Association Consortium” (BCAC) [12], the “Prostate Cancer Association Group to Investigate Cancer Associated Alterations in the Genome” (PRACTICAL) [15], or the “Ovarian Cancer Association Consortium” (OCAC) [16]. In addition, we extracted partial GWAS summary statistics that accompanied recent publications but were incomplete, i.e. only included SNPs below a certain p-value threshold [17-20]. GWAS summary statistics were harmonized and if needed, lifted over to human genome assembly GRCh37.
                        </p>

                    <H2><A name="ukgwas"><u>UK-Biobank-based GWAS</u></A></H2>

                        <p class="text-justify">We downloaded UK Biobank based GWAS summary statistics from two public downloads (ftp://share.sph.umich.edu/UKBB_SAIGE_HRC/ and https://github.com/Nealelab/UK_Biobank_GWAS).
                    The first set of UK Biobank GWAS summary statistics of the Lee Lab were based on the analysis of up to 408,961 White British European-ancestry samples with generalized mixed model association tests that used the saddlepoint approximation to calibrate the distribution of score test statistics as implemented in SAIGE and thus could control for unbalanced case-control ratios and sample relatedness. The underlying phenotypes were auto-curated phenotypes based on the PheCodes of the PheWAS R package [1, 7, 11] and in the following are referred to as “UKB PHECODE”. The UK Biobank GWAS summary statistics of the Neale Lab were based on a linear regression model of up to 361,194 unrelated samples. Three phenotype models were used in their analyses: (1) “PHESANT”: auto-curated phenotypes using PHEnome Scan ANalysis Tool (https://github.com/MRCIEU/PHESANT), (2) “ICD10”: individuals with the same ICD10 category code (first three characters) were used as cases while all non-coded individuals were treated as controls, and (3) “FINNGEN”: curated phenotypes / endpoints based on definitions of the Finngen consortium (https://www.finngen.fi/en/researchers/clinical-endpoints). These three latter sources are referred to as “UKB PHESANT”, “UKB ICD10” and “UKB FINNGEN”, respectively.
                        </p>

                        <br/><br/>
                            <h4><A name="prs">PRS Generation</A></h4>

                        <p class="text-justify">For each set of GWAS summary statistics from the above-mentioned sources, we performed LD clumping/pruning of variants with P-value below 10-4 by using the imputed allele dosages of 10,000 randomly selected samples and a pairwise correlation cut-off at r2 < 0.1 within 1Mb window. Next, we created incremental sub-sets of variants by stepwise increasing P-value thresholds by -log10(0.1). For each of these sub-sets we generated PRS and evaluated their performance to determine the “Pruning and Thresholding (P & T)” set whose p-value threshold obtained the highest cross-validated pseudo R2 (see PRS Evaluation).
                    In addition (and if present), we selected the subset of uncorrelated variants that passed the common threshold for genome-wide significance (p-value <= 5x10-8) to define the “GWAS hits” SNP set per source.
                    As an alternative to the “P&T” and the “GWAS hits” approach, we used the software package “lassosum” [21] on GWAS sources with complete summary statistics. Lassosum reweights effect size of variants by using elastic net / penalized regression and LD information from a reference panel. Here, we used 5,000 randomly selected, unrelated samples as the LD reference panel. We applied a MAF filter of 1 % and in contrast to the other two approaches only included autosomal variants that overlap between summary statistics, LD reference panel and target panel. Each “lassosum” run resulted in up to 76 combinations of the elastic net tuning parameters s and λ, and consequently in 76 SNP sets with different SNP numbers and reweighted effect sizes.
                        </p>

                        <p class="text-justify">For each of the generated SNP sets with at least five variants, we generated PRS as the sum of the allele dosages of risk increasing alleles of the SNPs weighted by their reported log odds ratios. Restated, the PRS for subject j was of the form PRSj=iiGij where i indexes the included loci for that trait, i is the log odds ratios retrieved from the external GWAS summary statistics for locus i, and Gij is a continuous version of the measured dosage data for the risk allele on locus i in subject j. We created the PRS variable for each MGI participant and if the GWAS source was not based on UKB also for each UKB participant. For comparability of association effect sizes corresponding to the continuous PRS across cancer traits and PRS construction methods, we transformed each PRS of the corresponding analytical data set to the standard Normal distribution using the R function “scale”.
                        </p><br/><br/>
                            <h4><A name="prseval">PRS Evaluation</A></h4>
                        <p class="text-justify">We used Nagelkerke’s pseudo-R2 [22] to select the tuning parameters within the “P&T” and lassosum construction methods (P-value for “P&T” SNP sets; s and λ for lassosum) and kept the PRS with the highest pseudo-R2 for further analyses.
                    For each PRS, we assessed various performance measures:
                    (1) overall performance with Nagelkerke’s pseudo-R2 and Brier Score in the R packages “rcompanion” [22] and “DescTools” [23];
                    (2) ability to discriminate between cases and controls by determining the area under the receiver-operator characteristics (ROC) curve (AUC) using R package “pROC” [24] and (3) calibration using Hosmer-Lemeshow Goodness of Fit test in the R package “ResourceSelection” [25-27]. These evaluations were based on the matched case control studies (see above) and did not adjust for additional covariates. All metrics were estimated using fitted predictors from a 5-fold cross validation with the R package “caret” [28].
                        </p><br/><br/>

                            <h4><A name="testing">PRS Association Testing</A></h4>
                        <p class="text-justify">We assessed the association between these PRS and the traits they were designed for. To do this we fit the following model for each PRS and cancer phenotype:
                    logit (P(Phenotype is present | PRS, Age, Sex, Array, PC)) =0+PRSPRS+AgeAge+ SexSex+ArrayArray+β PC, where the PCs were the first four principal components obtained from the principal component analysis of the genotyped GWAS markers, where “Age” was the age at last observed diagnosis in MGI and birthyear in UKB and where “Array” represents the genotyping array. Our primary interest is PRS, while the other factors (Age, Sex and PC) were included to address potential residual confounding and do not provide interpretable estimates due to the preceding application of case-control matching. Firth's bias reduction method was used to resolve the problem of separation in logistic regression (Logistf in R package “EHR”) [29-31], a common problem for binary or categorical outcome models when a certain part of the covariate space has only one observed value of the outcome, which often leads to very large parameter estimates and standard errors.
                    In a similar fashion, we evaluated the extremes of the PRS distribution (top 1, 2, 5, 10, and 25%) by recoding the predictor PRS of individuals within the top quantile of the PRS distribution as 1 and the remainder as 0 and fitted a similar model as above.
<br/>
                            Phenome-wide Exploration of PRS Associations
                    PRS that were strongly associated with the cancer trait they were designed for (p-value  ≤ 2.98 x 10-5; corresponds to Bonferroni-corrected phenome-wide significance level see below) were selected for phenome-wide association exploration in the phenomes of MGI and UKB.
                    We conducted PheWAS in MGI and also UKB (if the GWAS source was independent of UKB) to identify additional, secondary phenotypes associated with the PRS. To evaluate PRS-phenotype associations, we conducted Firth bias-corrected logistic regression by fitting a model of the above form (see PRS Association Testing) for each PRS and each phenotype of the corresponding phenome. To adjust for multiple testing, we applied the conservative phenome-wide Bonferroni correction according to the total number of analyzed PheWAS codes (n = 1,689). In Manhattan plots, we present –log10 (p-value) corresponding to tests of H0: PRS=0.  Directional triangles on the PheWAS plot indicate whether a phenome-wide significant trait was positively (pointing up) or negatively (pointing down) associated with the PRS.
                    To investigate the possibility of the secondary trait associations with PRS being completely driven by the primary trait association, we performed a second set of PheWAS after excluding individuals affected with the primary or related cancer traits for which the PRS was constructed, referred to as “Exclusion PRS PheWAS” as described previously [1].
                        <br/>
                            Unless otherwise stated, analyses were performed using R 3.6.1 [32].</p>
                    </p>
                        <br/><br/>
                            <h4><A name="ref">Method References</A></h4>
                        <p class="text-justify">

                        <ol>
                        <li>Fritsche LG, Gruber SB, Wu Z, Schmidt EM, Zawistowski M, Moser SE, et al. Association of Polygenic Risk Scores for Multiple Cancers in a Phenome-wide Study: Results from The Michigan Genomics Initiative. Am J Hum Genet. 2018;102(6):1048-61. Epub 2018/05/22. doi: 10.1016/j.ajhg.2018.04.001. PubMed PMID: 29779563; PubMed Central PMCID: PMCPMC5992124.</li>
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
                        <li>	Mak TSH, Porsch RM, Choi SW, Zhou X, Sham PC. Polygenic scores via penalized regression on summary statistics. Genet Epidemiol. 2017;41(6):469-80. Epub 2017/05/10. doi: 10.1002/gepi.22050. PubMed PMID: 28480976.</li>
                        <li>	Mangiafico S. rcompanion: Functions to Support Extension Education Program Evaluation. 2019.
                        <li>	Signorell A. DescTools: Tools for Descriptive Statistics. 2018.
                        <li>	Robin X, Turck N, Hainard A, Tiberti N, Lisacek F, Sanchez JC, et al. pROC: an open-source package for R and S+ to analyze and compare ROC curves. BMC Bioinformatics. 2011;12:77. Epub 2011/03/19. doi: 10.1186/1471-2105-12-77. PubMed PMID: 21414208; PubMed Central PMCID: PMCPMC3068975.</li>
                        <li>	Hosmer DW, Lemeshow S. Applied Logistic Regression. New York, USA: John Wiley and Sons; 2010.</li>
                        <li>	Lele S, R., Keim JL, Solymos P. ResourceSelection: Resource Selection (Probability) Functions for Use-Availability Data. 2017.</li>
                        <li>	Steyerberg EW, Vickers AJ, Cook NR, Gerds T, Gonen M, Obuchowski N, et al. Assessing the performance of prediction models: a framework for traditional and novel measures. Epidemiology. 2010;21(1):128-38. Epub 2009/12/17. doi: 10.1097/EDE.0b013e3181c30fb2. PubMed PMID: 20010215; PubMed Central PMCID: PMCPMC3575184.</li>
                        <li>	Kuhn M, Wing J, Weston S, Williams A, Keefer C, Engelhardt A, et al. caret: Classification and Regression Training. 2018.</li>
                        <li>	Heinze G. A comparative investigation of methods for logistic regression with separated or nearly separated data. Stat Med. 2006;25(24):4216-26. Epub 2006/09/07. doi: 10.1002/sim.2687. PubMed PMID: 16955543.</li>
                        <li>	Heinze G, Ploner M, Dunkler D, Southworth H. logistf: Firth's bias reduced logistic regression. 2013.</li>
                        <li> Choi L, Beck C. EHR: Electronic Health Record (EHR) Data Processing and Analysis Tool. 2017.</li>
                        <li>	R Core Team. R: A Language and Environment for Statistical Computing. R Foundation for Statistical Computing, Vienna, Austria; 2016.</li>
                    </ol>


                </div>
            </div>
        </div>
        </div>

</body>
</html>