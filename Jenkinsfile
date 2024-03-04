pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Using the 'dev' branch and SSH URL for GitHub repository
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
                // Placeholder for build commands
                echo "Build step (placeholder)"
                // Example: sh 'npm install && npm run build'
            }
        }

        stage('Test') {
            steps {
                // Placeholder for test commands
                echo "Test step (placeholder)"
                // Example: sh 'npm test'
            }
        }

        stage('Terraform Init and Apply') {
            environment {
                TF_CLI_CONFIG_FILE = "${WORKSPACE}/.terraformrc"
            }
            steps {
                sh 'pwd'
                // withCredentials([string(credentialsId: 'terraform-cloud-token', variable: 'TERRAFORM_CLOUD_TOKEN')]) {
                //     script {
                //         writeFile file: TF_CLI_CONFIG_FILE, text: "credentials \"app.terraform.io\" { token = \"${TERRAFORM_CLOUD_TOKEN}\" }"
                //         // Change directory to where Terraform configurations are located
                //         //dir('terraform/environments/dev') {
                //             sh 'pwd'
                        
                //             sh 'terraform init'
                //             sh 'terraform apply -auto-approve'
                //         }
                //     }
                // }
            }
        }


    //     stage('Deploy Static Files') {
    //         steps {
    //             withCredentials([awsCredentials(credentialsId: 'aws-jenkins-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
    //                 // Sync static files to S3 bucket
    //                 sh 'aws s3 sync website_files/ s3://dev-danzresume.com --delete'
    //             }
    //         }
    //     }
    // }
    post {
        always {
            // Cleanup to ensure sensitive files are not left on the agent
            cleanWs()
        }
    }
}
}
