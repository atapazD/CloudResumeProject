pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm: [
                    $class: 'GitSCM',
                    branches: [[name: '*/dev']],
                    userRemoteConfigs: [[
                        url: 'git@github.com:atapazD/CloudResumeProject.git',
                        credentialsId: 'github-credentials'
                    ]]
                ]
            }
        }
        stage('Build') {
            steps {
                echo "Build step (placeholder)"
                // Example: sh 'npm install && npm run build'
            }
        }

        stage('Test') {
            steps {
                echo "Test step (placeholder)"
                // Example: sh 'npm test'
            }
        }

        stage('Terraform Init and Apply') {
            environment {
                TF_CLI_CONFIG_FILE = "${WORKSPACE}/.terraformrc"
            }
            steps {
                withCredentials([string(credentialsId: 'terraform-cloud-token', variable: 'TERRAFORM_CLOUD_TOKEN')]) {
                    script {
                        writeFile file: TF_CLI_CONFIG_FILE, text: "credentials \"app.terraform.io\" { token = \"${TERRAFORM_CLOUD_TOKEN}\" }"
                            sh '''
                                cd terraform/environments/dev
                                terraform init
                                terraform apply --auto-approve

                            '''
                        
                    }
                }
            }
        }

        stage('Deploy Static Files') {
            steps {
                withCredentials([<object of type com.cloudbees.jenkins.plugins.awscredentials.AmazonWebServicesCredentialsBinding>]) {
                sh '''
                    sh 'aws s3 sync website_files/ s3://dev-danzresume.com --delete'
                '''
            }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
