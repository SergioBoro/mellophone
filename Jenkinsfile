node {
    def server = Artifactory.server 'ART'
    def rtMaven = Artifactory.newMavenBuild()
    def buildInfo
    def registry = "sergioboroid/docker-test"
    def registryCredential = "dockerhub"
    def pcImg
    
    stage ('Clone') {
        checkout scm
    }

    stage ('Artifactory configuration') {
        rtMaven.tool = 'M3' 
        rtMaven.deployer releaseRepo: 'libs-release-local', snapshotRepo: 'libs-snapshot-local', server: server
        rtMaven.resolver releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot', server: server
        buildInfo = Artifactory.newBuildInfo()
        buildInfo.env.capture = true
    }

    try{
        stage ('Exec Maven') {
            rtMaven.run pom: 'pom.xml', goals: 'clean install', buildInfo: buildInfo
        }
    } finally {
        junit 'target/surefire-reports/**/*.xml'
    }

    //if (env.BRANCH_NAME == 'dev') {
      //  stage ('Publish build info') {
        //    server.publishBuildInfo buildInfo
        //}
    //}
    
     stage('Building image') {
         pcImg = docker.build(registry + ":mellophone-6.1-SNAPSHOT-$BUILD_NUMBER", '.')
   }
  
  stage('Deploy Image') {
          docker.withRegistry("https://registry.hub.docker.com/", registryCredential) {
             pcImg.push()
      }
    }
}
