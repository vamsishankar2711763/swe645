//Jenkinsfile creates a CI/CD pipeline for building and deploying the docker image to k8 cluster using Github as source control version

pipeline{
    environment {
	    	registry = "vsimhadr/survey645"
        registryCredential = 'dockerhub'
	}
agent any
  stages{
    stage('Building war') {
            steps {
                script {
                    sh 'rm -rf *.war'
                    sh 'jar -cvf Survey.war -C src/main/webapp .'

               }
            }
        }
    stage('Pushing latest code to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        def image = docker.build('vsimhadr/survey645:latest', '.')
                        docker.withRegistry('',registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }
     stage('Deploying to single node in Rancher') {
         steps {
            script{
               sh 'kubectl set image deployment/deploy1 container-0=vsimhadr/survey645:latest'
            }
         }
      }
   
  }
 
  post {
	  always {
			sh 'docker logout'
		}
	}    
}