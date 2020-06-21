*** Settings ***
Library           String

Documentation     Run Online part for Credit Reporting Regression
...               Validates Status 

Suite Setup       Connect to Mainframe
Suite Teardown    Disconnect from Mainframe

Resource          ${RESOURCES_PATH}


*** Variables ***
${TemplatesFolder}           ${CURDIR}//Templates//Online//
${JCLsFolder}                ${CURDIR}//JCLs//Online//
${JCLOutputFilePath}   		  ${CURDIR}//jobsOutput//Online//
${reportsOutputFilePath}   	 ${CURDIR}//reports//Online//

${jobCard}                   ${JOB_CARD}
${hlq1}                      ${HLQ1}
${hlq2_test}				 ${HLQ2_TEST}
${hlq2_prod}				 ${HLQ2_PROD}
${userID}                    ${MAINFRAME_USERNAME}
${currentFolder}             CXTT 
${sqlModels}				 ${SQL_MODELS}
${cardina}                   ${CARDINA}
${load1}			     ${LOAD1}
${load2}	             ${LOAD2}
@{INQUIRIES}    	ADDRARF    ADDRTTY    ADRIQARF    ADRIQTTY    ARF    COLLARF    COLLTTY    DISCLOS    NMSOCARF    NMSOCTTY     NUMARF    NUMTTY    OFACARF    OFACTTY    PRODARF     PRODTTY    SB168A    SB168T    SSFARF    SSFTTY    SSNARF    SSNTTY    TTY    ADMINARF     ADMINTTY    BUEYEARF     BUEYETTY     CODE          DATASMRA     DATASMRT     EFUNDARF     EFUNDTTY     EPINARF     EPINTTY        MODELARF     MODELTTY      OFACADM      OPTOUTA     OPTOUTT     PARPROF      PININQ     PRTSSNA     PRTSSNT     PUERADMA     PUERICOA     PUERICOT     PURGEARF     PURGETTY     
${regionTestSpoolDSN}        MDET.BATCHPR.TEST.CRREG.${hlq1}.RGN.ONL.T
${regionProdSpoolDSN}        MDET.BATCHPR.TEST.CRREG.${hlq1}.RGN.ONL.P
${Region}
${RegionId}
${batchWrittenTimeot}       60s
${regionTimeout}            120s
${JOBId}
${regionJobId}   
${queueName}   
${inquiryName}
${fullJobName}  
${regionSpoolDSN}
${reportName} 
@{regionsCSTI}		CYTI	CSTI
@{regionsCSTIDown}	CSTI	CYTI
${signToDownCSTI}
${signToDownCYTI}

${Duration}                  1 min
${Interval}                  1 min
${ShortInterval}             30 secs
${SignReg}
${sign}
${signToDown}


*** Test Cases ***
#=================================================================================================================================================================#
# PREPARE JCLs
#=================================================================================================================================================================#
Prepare all JCLs

         Log to Console     "Hola Mundo"