pipeline {
    agent any

    environment {
        DOCKER_REGISTRY_CREDENTIALS = 'DockerHubCred'
        DOCKER_IMAGE_NAME = 'bellman-shortest-path-finder'
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [],
                    submoduleCfg: [],
                    userRemoteConfigs: [[url: 'https://github.com/23subbhashit/bellman.git']]
                ])
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_NAME}", '.')
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'DockerHubCred') {
                        sh "docker tag ${DOCKER_IMAGE_NAME}:latest 23subbhashit/${DOCKER_IMAGE_NAME}:latest"
                        sh "docker push 23subbhashit/${DOCKER_IMAGE_NAME}:latest"
                    }
                }
            }
        }

//         stage('Deploy with Ansible') {
//             steps {
//                 script {
//                     ansiblePlaybook(
//                         playbook: 'deploy.yml',
//                         inventory: 'inventory',
//                         colorized: true,
//                         installation: 'ansible'
//                     )
//                 }
//             }
//         }
        stage('Run Python Script') {
                    steps {
                        script {
                            // Install necessary Python dependencies
                            sh 'pip3 install elasticsearch'

                            // Run the Python script to upload logs
                            sh 'python3 parsernew2.py'
                        }
                    }
                }
        stage('Deploy to Kubernetes') {
                    steps {
                        dir('/mnt/c/Users/User/desktop/majorfinal/bellman') {
                            sh 'kubectl apply -f kubernetes/'
                        }
                    }
                }
    }
}
