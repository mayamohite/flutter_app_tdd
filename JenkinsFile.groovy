pipeline {
    agent any

    stages {
        stage('PR Status'){
            steps {
                script {
                    String s = "Not Merged"
                    if (params.merged) {
                        s = "Merged"
                    }
                    echo ">>>> PR CURRENT STATUS: ${params.current_status}"
                    echo ">>>> PR MERGED STATUS: $s"
                    echo ">>>> PR CURRENT BRANCH NAME: ${params.current_branch}"
                    echo ">>>> PR BASE BRANCH NAME: ${params.base_branch}"
                }
            }
        }
        stage('Pull Current Branch') {
            steps {
                echo ">>>> PULL : ${params.current_branch}"
                git branch: "${params.current_branch}", url: 'https://github.com/mayamohite/flutter_app_tdd.git'
            }
        }
        stage('Build Current Branch') {
            steps {
                echo ">>>> BULID: ${params.current_branch}"
                sh '''
            #!/bin/sh
            flutter build apk --debug
            '''
            }
        }
        stage('Test Current Branch') {
            steps {
                echo ">>>> TEST: ${params.current_branch}"
                sh 'flutter test'
            }
        }
        stage('Pull Base Branch') {
            when {
                expression { return params.current_status == "closed" && params.merged == true }
            }
            steps {
                echo ">>>> PULL: ${params.current_branch}"
                git branch: "${params.base_branch}", url: 'https://github.com/mayamohite/flutter_app_tdd.git'
            }
        }
        stage('Test Base Branch') {
            when {
                expression { return params.current_status == "closed" && params.merged == true }
            }
            steps {
                echo ">>>> TEST: ${params.base_branch}"
                sh 'flutter test'
            }
        }
        stage('Build Base Branch') {
            when {
                expression { return params.current_status == "closed" && params.merged == true }
            }
            steps {
                echo ">>>> BULID: ${params.base_branch}"
                sh '''
            #!/bin/sh
            flutter build apk --debug
            '''
            }
        }
        stage('Distribute') {
            when {
                expression { return params.current_status == "closed" && params.merged == true }
            }
            steps {
                echo ">>>> UPLOAD TO APPCENTER: ${params.base_branch}"
                appCenter apiToken: 'f51cf29ba6b2234a84c999bc37348db84624c615',
                        ownerName: 'ranaranvijaysingh9-gmail.com',
                        appName: 'Flutter-Starter',
                        pathToApp: 'build/app/outputs/apk/debug/app-debug.apk',
                        distributionGroups: 'AlphaTester'
            }
        }
    }
}
