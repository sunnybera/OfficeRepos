﻿trigger: none
 
pool:
  vmImage: ubuntu-latest 
 
steps:
- task: AzureKeyVault@2
  inputs:
    azureSubscription: 'SC_Business Innovation Platform - 1000106902'
    KeyVaultName: 'akv-pega-poc1'
    SecretsFilter: '*'
    RunAsPreJob: false
 
- task: CmdLine@2
  inputs:
    script: 'cat ./DemoApp/secrets.csv'
 
- task: CopyFiles@2
  inputs:
    Contents: '**/secrets.csv'
    targetFolder: '$(System.DefaultWorkingDirectory)/DemoApp'
 
- task: PublishBuildArtifacts@1
  inputs:
    PathtoPublish: '$(System.DefaultWorkingDirectory)/DemoApp'
    ArtifactName: 'drop'
    publishLocation: 'Container'

    ###############################

    trigger: none
 
pool:
  vmImage: 'ubuntu-latest'
 
steps:
- task: AzureCLI@2
  inputs:
    azureSubscription: 'SC_Business Innovation Platform - 1000106902'
    scriptType: 'bash'
    scriptLocation: 'inlineScript'
    inlineScript: |
      az login --service-principal -u cf877cb2-d407-49fc-a0c9-c98777cef68b -p Ven8Q~1iY4au6X21sSPlGynbxtfUGanZsftyXcYu --tenant 188285f7-8f1e-4c0d-a0bc-797e3e38c5b3
      echo "Connected to Azure"
 
- task: AzureKeyVault@2
  inputs:
    azureSubscription: 'SC_Business Innovation Platform - 1000106902'
    KeyVaultName: 'akv-pega-poc1'
    SecretsFilter: '*'
    RunAsPreJob: false
 
- task: CopyFiles@2
  inputs:
    Contents: '**/secrets.csv'
    targetFolder: '$(System.DefaultWorkingDirectory)/DemoApp'
 
- task: CmdLine@2
  inputs:
    script: |
      #!/bin/bash
      IFS=',' 
      while read -r name value
      do
        echo "Setting secret $name in Azure Key Vault"
        az login --service-principal -u cf877cb2-d407-49fc-a0c9-c98777cef68b -p Ven8Q~1iY4au6X21sSPlGynbxtfUGanZsftyXcYu --tenant 188285f7-8f1e-4c0d-a0bc-797e3e38c5b3
        az keyvault secret set --vault-name "akv-pega-poc1" --name "$name" --value "$value"
      done < $(System.DefaultWorkingDirectory)/DemoApp/secrets.csv
 
- task: PublishBuildArtifacts@1
  inputs:
    PathtoPublish: '$(System.DefaultWorkingDirectory)/DemoApp'
    ArtifactName: 'drop'
    publishLocation: 'Container'

    #########################################
    trigger:
- none
 
pool:
  vmImage: 'ubuntu-latest'
 
steps:
- checkout: self
  persistCredentials: true
 
- script: |
    echo 'Replace old_word with new_word in all files in the specific_folder'
    find ./DemoApp/deployment-1.yaml -type f -name '*' -exec sed -i 's/delete/nginx/g' {} \;
    find ./DemoApp/deployment-1.yaml -type f -name '*' -exec sed -i 's/data1/data/g' {} \;
  displayName: 'Replace word'
  
- script: |
    echo 'Commit and push changes'
    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
    git commit -am "Replace nginx with new_word"
    git push origin HEAD:main
  displayName: 'Commit changes'