pipeline {
    agent any
    
    parameters {
        string(defaultValue: "", description: "Tag Version", name: "TagVersion")
    }
    
    environment {
        TAG_NAME = "v1.0.${env.BUILD_NUMBER}"
    }

    stages {
        stage('Init') {
            steps {
                echo "param: ${params.deployEnv}"
            }
        }
        stage('Clean Up') {
            steps {
                sshagent(['server-1']) {
                    script {
                        def dirExists = sh(script: 'ssh [USERNAME]@[SERVER IP] "[ -d /home/[USERNAME]/jenkins ] && echo exists || echo not-exists"', returnStdout: true).trim()
                        if (dirExists == 'exists') {
                            sh 'ssh [USERNAME]@[SERVER IP] "rm -r /home/[USERNAME]/jenkins"'
                        } else {
                            echo 'Directory does not exist, skipping deletion.'
                        }
                    }
                }
            }
        }
        stage('Clone Source') {
            steps {
                sshagent(['server-1']) {
                    sh 'ssh [USERNAME]@[SERVER IP] "git clone [GIT URL] /home/[USERNAME]/jenkins/[PROJECTNAME]"'
                }
            }
        }
        stage('Build') {
            steps {
                sshagent(['server-1']) {
                    sh 'ssh [USERNAME]@[SERVER IP] "cd /home/[USERNAME]/jenkins/[PROJECTNAME] && mvn clean install"'
                }
            }
        }
        stage('Scan SonarQube') {
            steps {
                sshagent(['server-1']) {
                    sh 'ssh [USERNAME]@[SERVER IP] "cd /home/[USERNAME]/jenkins/[PROJECTNAME] && mvn clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:4.0.0.4121:sonar -Dsonar.projectKey=springboot-security -Dsonar.projectName=\"springboot-security\" -Dsonar.host.url=http://localhost:9001 -Dsonar.token=sqp_61c409afa83aaa197d2f88a9fa5963f694febd98"'
                }
            }
        }
        stage('Unit test') {
            steps {
                sshagent(['server-1']) {
                    sh 'ssh [USERNAME]@[SERVER IP] "cd /home/[USERNAME]/jenkins/[PROJECTNAME] && mvn test"'
                }
            }
        }
    }
    
    post {
        success {
            script {
                currentBuild.description = "Tag: ${TAG_NAME}"
            }
        }
    }
}