# CIS APIHUB API Testing

### Environment Prerequisites
- Python 3.6.* [Installation Guide](https://www.howtogeek.com/197947/how-to-install-python-on-windows/)
- Pip
- Git
- Input CSV files should follow a consistent layout as defined in other api resources specially for first 5 fields.
> For more details refer to tutorial Robot [Framework Environment Setup](https://confluenceglobal.experian.local/confluence/display/CCAH/Robot+Framework+Environment+Setup)  [Documentation](https://media.readthedocs.org/pdf/python-jsonschema/v2.2.0/python-jsonschema.pdf)

> Note: Setup will work only if you are not using VPN as it needs to download dependency

### Validating Python Version
- Check python version by executing following command cmd/powershell 
```
  >python --version
  Python 3.6.*
```
> If you do not have the latest version of python you will have to install it and update the environment variable for same.

### Cloning repository
Open git bash 
- Clone repository without ssh access
```
    git clone http://C50285A@bitbucketglobal.experian.local/scm/cah/apihub-qa-automation-rf.git
```
- Clone repository if you have ssh access 
```
    git clone ssh://git@bitbucketglobal.experian.local/cah/apihub-qa-automation-rf.git
```

### Configure Program to Open Json File
1) Select a *.json file and right click
2) Click on properties
3) Click on Change and configure your program to open file. Preferred programs are notepad++ or Sublime Text 

### Install Project Dependencies
Open cmd/powershell and move to folder where you have checked out your code
- To install all dependencies in one go run following command
```
pip install -r requirements.txt
```

### Project Perquisites
`Note:` This project relies on files available on swagger-schema and csv-resources so make sure they have been correctly defined as per the information given below
- Every project resource folder must have following and follow same naming convention:
    1) \<ResourceFolder>/csv-resources/json_meta_config.json
    2) \<ResourceFolder>/csv-resources/\<CSV File To be used for output validation and input generation>
    3) \<ResourceFolder>/swagger-schema/<All Swagger Schema>  // Please follow naming convention defined in other resource folders
    4) \<ResourceFolder>/output/expected-output/arf/<arf file or folder having same name as input csv>

### CSV Input file Perquisites
- Input CSV files for test cases:
    1) The 1st 10 header names in each and every CSV files should be exactly as below

    testCase,	scenario,	expectedResult-Text,	expectedHttpCd, 	clientReferenceId,	profileVersion,	experianTransactionId,	userId,	ipAddress,	Content-Type

`Note:` Here, the 1st 4 col names are about the test data and the last 6 col names are the header names that actually are requested as headers for each request to the CISAPI Hub Services.

- Data in CSV files for various test cases are as per input request Jsons and as per Swagger:
    - Features:
        1) If field for any col name is left blank then the corresponding element/object will not be populated in the request Json for that perticular tests case.
        2) If an element needs to be populated with ""(empty) value then the corresponding field value should be entered into CSV file as NULL(case sensitive).

   
### Running with run.py
For usage guide run following command:
```bash
python run.py --help
```
##### Basic Command Format
```bash
usage: usage: python run.py [-h] -s SERVICE --env [-f FILES/Folder] [-re] [-fa] [--arf]

python run.py -s <your service> -f <optional csv file name or folder name> -re --arf --env <environment like DEV/QA/UAT/PROD, case sensitive>
```
### Command Explanation
##### Mandatory Parameters
-  -s, --service  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     Parameter required to identify api
-  --env    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   environment name for which the tool needs to be run
##### Optional Parameters:
-  -h, --help  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    Show this help message and exit
-  -re, --regenerate     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Regenerate json from csv file (default: do not
                        regenerate))
-  -f, --files   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; List of files/folders in resource
-  -fa, --failed  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Run Tests for Failed Scenarios
-    --arf      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;           Perform arf comparison and update results file based
                        on comparison

### Sample Commands
Running for specific files in csv-resources folder '-f' flag is mandatory before each file name, running for env DEV
```
python run.py --service eva --env DEV -f input1.csv  -f input2.csv
```
Running with folders having JSON. In this case we are usually not aware about expected output and also we do not have csv file
```
python run.py --service cp --env QA -f NegativeTestCase_V2_PD_json -f PositiveTestCases_1-20_V2_Json
```
Running with folders having JSON and files in csv-resources folder
```
python run.py --service cp --env UAT -f NegativeTestCase_V2_PD_json -f input.csv
```
- Running for all csv files in csv-resources we can use 'ALL' with -f 
- Another way is do not give -f but use -re to tell that csv files exist and we want to generate/regenerate json for all csv files in csv-resources
```
python run.py --service io --env QA -f ALL -re
python run.py --service io --env QA -re
```
Once we have already run and then we want to run again only for failed scenarios use '-fa' flag as given in command below
```
python run.py --service eva --env QA -f input.csv -fa
```
APIGEE requests work same way as other requests work just a minor difference we have that is apigee user name and passwords are mandatory for OAUTH authentication in case of APIGEE
```
python run.py --service a-eva --env QA -f input.csv -fa
```
Running arf comparison when we have ARF file available
```
python run.py --service cp --env QA -f arf_tests -arf
python run.py --service ps --env QA -f prequalstandard.csv -arf 
```

`Note:` If -re(regenerate) flag is passed json files will be regenerated. There are few combination with file those are:
- If we want to regenerate json for all csv files then just pass -re with out any file
- If we want to regenerate json for some specific files then with -re give **`-f <file name>`** combination for each file
- If we do not want to regenerate json then do not use -re parameter
- If we are running test cases for failed scenarios, then we will not use -re flag and even if it is passed it will be of no use

The configuration for all the services for different env are under the parent folder AUTOMATION-CONFIG, for example, for QA **`config-for-qa-env.yaml`** as per requirement

### Configuration Variables
> All variables are setup in config files available in **"AUTOMATION-CONFIG folders"** according to service we are using

Headers for each payload for a given csv file for test cases could be entered in the input csv files.

##### Project Acronyms Used as "--service/-s" Parameter
- Credit Profile = cp
- Extended View Score = evs
- Extended View Attribute = eva
- Extended View Score and Attribute = evas
- Inquiry Only = io
- Prequal Standard = ps
- Prequal Score Only = pso
- Standard Instant Prescreen = sip
- MLA Standalone = mlas
- Premier Attributes = pa
- Trended Attributes = ta
- Pinning = pin
- Social Search = ss
- Address Search = as
- Address Update = au
- Healthcare Credit Profile = hcp
- Premier Trend3D Attributes = pt3da
- Employment Insight = ei  
- TEC Credit Report = tec 
- Decision Service = ds
- Connect Check = cc
- Automotive Credit Profile = acp
- Lite Report = lr

- APIGEE Credit Profile = a-cp
- APIGEE Extended View Score = a-evs
- APIGEE Extended View Attribute = a-eva
- APIGEE Extended View Score and Attribute = a-evas
- Inquiry Only = a-io
- Prequal Standard = a-ps
- Prequal Score Only = a-pso
- Standard Instant Prescreen = a-sip
- MLA Standalone = a-mlas
- Premier Attributes = a-pa
- Trended Attributes = a-ta
- Pinning = a-pin
- Social Search = a-ss
- Address Search = a-as
- Address Update = a-au
- Healthcare Credit Profile = a-hcp
- Premier Trend3D Attributes = a-pt3da
- Employment Insight = a-ei  
- TEC Credit Report = a-tec 
- Decision Service = a-ds
- Connect Check = a-cc
- Automotive Credit Profile = a-acp
- Lite Report = a-lr
### Execution Using Robot Scripts

##### Running Robot Script
once environment is setup run following command
```
  robot -d <Reports Path> -n noncritical -v <Colon separated variable> <Test Suit Path>
  e.g. robot -d reports -n noncritical testsuit
  e.g. robot -d reports -n noncritical apigee-test-suit
```

###### Quick Explanation of Switches Used
- -T - Short for --timestampoutputs. Creates reports, logs, etc. with the current timestamp so we don't overwrite existing ones upon execution.
- -d - Short for --outputdir. Tells the framework where to create the report files.
- -n - Short for --noncritical. This tells Robot Framework what tag indicates a non-critical test (I've standardized on noncritical to reduce ambiguity).

###### Test Only a Given Suite
To execute only a particular test suite (file) run following command:
```
 robot -T -d reports -n noncritical test_case/path/to/case.robot
```
where /path/to/case.robot is of course the path to the suite (file) you want to execute.

###### Test Only a Particular Test Case
To execute only a particular test case from file:
```
 robot -T -d reports -n noncritical -t "Name of Test Case Here" test_case/path/to/case.robot
 e.g. robot -T -d reports -n noncritical -t "Test With Input Json" apigee-test-suit/apigee_test_automation.robot
```

where "Name of Test Case Here" is the name of the test case within the file pointed to via /path/to/case.robot.
```
 e.g. robot -d reports -n noncritical test-suit/extended_view_score_api_tests.robot
```

###### Dev Notes
- Vagrant
```
vagrant up
vagrant global-status
vagrant halt <id>
ssh -i .vagrant/machines/default/virtualbox/private_key -p 2201 vagrant@127.0.0.1
```

### APIGEE Knowledge Base
- https://confluenceglobal.experian.local/confluence/pages/viewpage.action?spaceKey=CCAH&title=OAuth2+Access+and+Token+Generation
- https://confluenceglobal.experian.local/confluence/display/CCAH/Useful+Links

### References
- https://github.com/robotframework/HowToWriteGoodTestCases/blob/master/HowToWriteGoodTestCases.rst#workflow-tests
- http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html
- https://bitbucketglobal.experian.local/projects/APS/repos/roboz/browse
- https://confluenceglobal.experian.local/confluence/display/PCOD/Robot+Framework+-+Knowledge+Base
- https://baishanlu.gitbooks.io/robot-framework-cn-en-user-manual/content/1getting_started/