pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm: [
                    $class: 'GitSCM',
                    branches: [[name: '*/7-refactor-acm-module-to-new-directory-structure']],
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
                sh 'ls -R'
                sh 'pwd'
            }
        }

        // stage('Test') {
        //     steps {
        //         echo "Test step (placeholder)"
        //         // Example: sh 'npm test'
        //     }
        // }

        // stage('Terraform Init and Apply') {
        //     environment {
        //         TF_CLI_CONFIG_FILE = "${WORKSPACE}/.terraformrc"
        //     }
        //     steps {
        //         withCredentials([string(credentialsId: 'terraform-cloud-token', variable: 'TERRAFORM_CLOUD_TOKEN')]) {
        //             script {
        //                 writeFile file: TF_CLI_CONFIG_FILE, text: "credentials \"app.terraform.io\" { token = \"${TERRAFORM_CLOUD_TOKEN}\" }"
        //                 sh '''
        //                     cd terraform/environments/prod
        //                     terraform init
        //                     terraform apply --auto-approve
        //                 '''
        //             }
        //         }
        //     }
        // }

        // stage('Deploy Static Files') {
        //     steps {
        //         withCredentials([[
        //             $class: 'AmazonWebServicesCredentialsBinding', 
        //             credentialsId: 'aws-jenkins-credentials', 
        //             accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
        //             secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        //         ]]) {
        //             sh 'aws s3 sync website_files/ s3://prod-danzresume.com --delete'
        //         }
        //     }
        // }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}