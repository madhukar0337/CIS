#!groovy
pipeline {
	agent {
		node {
		    //label   'New-Linux'
		    label 'DEV-L64-B3||DEV-L64-B4||DEV-L64-B5'
			//label 'DEV-L64-B1||DEV-L64-B2||DEV-L64-B3||DEV-L64-B4||DEV-L64-B5||DEV-L64-B6||DEV-L64-B7'
		}
	}

	environment {
		def resource_path = "${RESOURCE_PATH}"
		def project_env = "${ENV}"
		def service = "${SERVICE}"
        def file_name = "${FILE_NAME}"
        def arf = "${ARF}"
        def email = "${EMAIL}"
        def file_splitted = ""
        def report_path = ""
        def apigee = "${APIGEE}"
        def apigee_user = "${APIGEE_USER}"
        def apigee_password = "${APIGEE_PASSWORD}"
        def htmlSummary = ""
        def build_ok = true
	}

	stages {
		stage('Checkout SCM') {
			steps {
				script {
					GIT_URL = checkout scm
					GIT_URL = GIT_URL.getAt("GIT_URL")
					echo "${GIT_URL}"
				}
			}
		}

		stage('Create Virtual Env and Install Dependency') {
			steps {
				script {
    				sh """#!/bin/bash
    				    virtualenv -p python3.6 apihub-qa-env
                        source apihub-qa-env/bin/activate
                        python -m pip install -r requirements.txt
    				"""
				}
			}
		}

		stage('Run Robot Script') {
			steps {
				script {
				    try {
                        if(apigee == "true") {
                            if(arf == "true") {
                                sh """#!/bin/bash
                                    source apihub-qa-env/bin/activate
                                    python run.py --service $service  --env $project_env -f $file_name -au $apigee_user -ap $apigee_password -re -arf
                                """
                            } else {
                                sh """#!/bin/bash
                                    source apihub-qa-env/bin/activate
                                    python run.py --service $service  --env $project_env -f $file_name -au $apigee_user -ap $apigee_password -re
                                """
                            }
                        } else {
                            if(arf == "true") {
                                sh """#!/bin/bash
                                    source apihub-qa-env/bin/activate
                                    python run.py --service $service  --env $project_env -f $file_name -re -arf
                                """
                            } else {
                                sh """#!/bin/bash
                                    source apihub-qa-env/bin/activate
                                    python run.py --service $service  --env $project_env -f $file_name -re
                                """
                            }
                        }
                    } catch (Exception e) {
				        build_ok = false
				    }
				}
			}
		}

		stage('Publish Report') {
		    steps {
				script {
                    file_splitted = file_name.tokenize('.')
                    def path = readFile("file_for_jenkins_reference.txt")
                    htmlSummary = readFile("execution_summary.html")
                    def timestamp = path.tokenize('_')[-1]
                    report_path = path + '/reports/' + file_splitted[0]
                    publishHTML([allowMissing: true, alwaysLinkToLastBuild: true, keepAll: true, reportDir: report_path, reportFiles: 'log.html', reportName: 'RF Log', reportTitles: 'Execution Report'])
                    publishHTML([allowMissing: true, alwaysLinkToLastBuild: true, keepAll: true, reportDir: report_path, reportFiles: 'report.html', reportName: 'RF Summary Report', reportTitles: 'Execution Report'])
                    publishHTML([allowMissing: true, alwaysLinkToLastBuild: true, keepAll: true, reportDir: '', reportFiles: 'execution_summary.html', reportName: 'Execution Summary Report', reportTitles: 'Execution Summary Report'])
                }
            }
		}

		stage('Create Tar File for Reports') {
		    steps {
		        script {
		            sh """#!/bin/bash
		                cp -rf $report_path reports
		                tar -czvf reports.tar.gz reports
		            """
		        }
		    }
		}

		stage('Build Status') {
		    steps {
		        script {
		            if(build_ok) {
                        currentBuild.result = "SUCCESS"
                    } else {
                        currentBuild.result = "FAILURE"
                    }
		        }
		    }
		}
	}

	post {
	    success {
            emailext compressLog: true,
            body:  """<html>
            <head>
                <style>
                    table {
                      width:100%;
                    }
                    table, th, td {
                      border: 1px solid black;
                      border-collapse: collapse;
                    }
                    th, td {
                      padding: 15px;
                      text-align: left;
                    }
                </style>
            </head>
            <body>
                <table>
                    <tr>
                        <td>Jenkins Job URL</td>
                        <td>:</td>
                        <td>${env.BUILD_URL}</td>
                    </tr>
                </table>""" + htmlSummary + """
            </body>
            </html>""" ,
            mimeType : 'text/html',
            attachLog: true,
            attachmentsPattern: '**/reports.tar.gz',
            subject: "Successful RF QA Jenkins Build for ${currentBuild.fullDisplayName}",
            to: email
        }

        unstable {
            emailext compressLog: true,
            body:  """<html>
            <head>
                <style>
                    table {
                      width:100%;
                    }
                    table, th, td {
                      border: 1px solid black;
                      border-collapse: collapse;
                    }
                    th, td {
                      padding: 15px;
                      text-align: left;
                    }
                </style>
            </head>
            <body>
                <table>
                    <tr>
                        <td>Jenkins Job URL</td>
                        <td>:</td>
                        <td>${env.BUILD_URL}</td>
                    </tr>
                </table>""" + htmlSummary + """
            </body>
            </html>""" ,
            mimeType : 'text/html',
            attachLog: true,
            attachmentsPattern: '**/reports.tar.gz',
            subject: "Unstable RF QA Pipeline: ${currentBuild.fullDisplayName}",
            to: email
        }

        failure {
            emailext compressLog: true,
            body:  """<html>
            <head>
                <style>
                table {
                  width:100%;
                }
                table, th, td {
                  border: 1px solid black;
                  border-collapse: collapse;
                }
                th, td {
                  padding: 15px;
                  text-align: left;
                }
                </style>
            </head>
            <body>
                <table>
                    <tr>
                        <td>Jenkins Job URL</td>
                        <td>:</td>
                        <td>${env.BUILD_URL}</td>
                    </tr>
                </table>""" + htmlSummary + """
            </body>
            </html>""" ,
            mimeType : 'text/html',
            attachLog: true,
            attachmentsPattern: '**/reports.tar.gz',
            subject: "Failed RF QA Pipeline: ${currentBuild.fullDisplayName}",
            to: email
        }
    }
}