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
                withCredentials([string(credentialsId: 'terraform-cloud-token', variable: 'TERRAFORM_CLOUD_TOKEN')]) {
                    script {
                        // Configure Terraform CLI to use the Terraform Cloud token
                        writeFile file: TF_CLI_CONFIG_FILE, text: "credentials \"app.terraform.io\" { token = \"${TERRAFORM_CLOUD_TOKEN}\" }"
                        // Initialize Terraform
                        sh 'terraform init'
                        // Apply Terraform configuration
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Deploy Static Files') {
            steps {
                withCredentials([awsCredentials(credentialsId: 'aws-jenkins-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    // Sync static files to S3 bucket
                    sh 'aws s3 sync website_files/ s3://your-s3-bucket-name --delete'
                }
            }
        }
    }
    post {
        always {
            // Cleanup to ensure sensitive files are not left on the agent
            cleanWs()
        }
    }
}
