#Save this as awakealways.ps1
add-type -AssemblyName microsoft.VisualBasic
add-type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Write-Warning "Welcome to PowerShell stable release v7.3.8
   Upgrade now, or check out the release page at:
     https://aka.ms/PowerShell-Release?tag=v7.4.1"
$form = New-Object System.Windows.Forms.Form
$form.Text = 'AwakeScreen'
$form.Size = New-Object System.Drawing.Size(200,100)
$form.StartPosition = 'Manual'
$form.Location = New-Object System.Drawing.Point(1500,670)
$textBox = New-Object System.Windows.Forms.TextBox
#$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(200,100)
$textBox.Multiline = $true 
$form.Controls.Add($textBox)
$form.Topmost = $true
$form.Add_Shown({$textBox.Select()})
$form.Show()
 start-sleep -Milliseconds 1000
 try{

  Do {  
            $form.Activate()
            #[Microsoft.VisualBasic.Interaction]::AppActivate($form.fo)
             [System.Windows.Forms.SendKeys]::SendWait("{BS}")
    [System.Windows.Forms.SendKeys]::SendWait(".")
    start-sleep -Milliseconds 180000
  } While ($true)
 }

 finally
 {
  Write-Warning "Terminating Powershell Script"
  #Stop-Process  $form
        $form.Close()
 }