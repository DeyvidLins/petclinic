node('master'){
    try{
        stage('Compilação do maven'){
            checkout scm
            sh './mvnw package'

        }
        stage('Teste Unitário'){
             sh 'mvn clean test'
        }

        
    }catch (exec)
    {
	    currentBuild.result = 'FAILURE'
        throw new Exception(exec)
        
    }finally{

      
       
    } 
}
