//Jenkins File
pipeline{
    environment {
	    	registry = "vsimhadr/studentsurvey645"
        registryCredential = 'dockerhub'
	     def dateTag = new Date().format("yyyyMMdd-HHmmss")
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
                        def image = docker.build('vsimhadr/studentsurvey645:'+ dateTag)
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
               sh 'kubectl set image deployment/depolyment1 container-0=vsimhadr/studentsurvey645:'+dateTag
	       sh 'kubectl set image deployment/deployment2 container-0=vsimhadr/studentsurvey645:'+dateTag	    
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
