#C:\temp\ForVmCreation3.csv
param(
 [Parameter(Mandatory=$True)]
 [string]
 $FilePathIncludingName
 )
#create COM object named Outlook 
$Outlook = New-Object -ComObject Outlook.Application 

#Get the users list from CSV file to send email
$usersList = Import-Csv $FilePathIncludingName
#$currentLocation = Get-Location
$imagePath = "C:\temp\VmMailer4_files/image001.png"

#Generate HTML email body with specific IP for the team.
Function getEmailBody($vmip){

    return "<html xmlns:v=""urn:schemas-microsoft-com:vml""
xmlns:o=""urn:schemas-microsoft-com:office:office""
xmlns:w=""urn:schemas-microsoft-com:office:word""
xmlns:m=""http://schemas.microsoft.com/office/2004/12/omml""
xmlns=""http://www.w3.org/TR/REC-html40"">

<head>
<meta http-equiv=Content-Type content=""text/html; charset=windows-1252"">
<meta name=ProgId content=Word.Document>
<meta name=Generator content=""Microsoft Word 15"">
<meta name=Originator content=""Microsoft Word 15"">
<link rel=File-List href=""VmMailer4_files/filelist.xml"">
<link rel=Edit-Time-Data href=""VmMailer4_files/editdata.mso"">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Kadur Renuka, Sumanth (Cognizant)</o:Author>
  <o:Template>Normal</o:Template>
  <o:LastAuthor>Kadur Renuka, Sumanth (Cognizant)</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>47</o:TotalTime>
  <o:Created>2019-05-31T09:23:00Z</o:Created>
  <o:LastSaved>2019-05-31T09:23:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>408</o:Words>
  <o:Characters>2331</o:Characters>
  <o:Company>Cognizant</o:Company>
  <o:Lines>19</o:Lines>
  <o:Paragraphs>5</o:Paragraphs>
  <o:CharactersWithSpaces>2734</o:CharactersWithSpaces>
  <o:Version>16.00</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
<link rel=themeData href=""VmMailer4_files/themedata.thmx"">
<link rel=colorSchemeMapping href=""VmMailer4_files/colorschememapping.xml"">
<!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:DontDisplayPageBoundaries/>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <m:mathPr>
   <m:mathFont m:val=""Cambria Math""/>
   <m:brkBin m:val=""before""/>
   <m:brkBinSub m:val=""&#45;-""/>
   <m:smallFrac m:val=""off""/>
   <m:dispDef/>
   <m:lMargin m:val=""0""/>
   <m:rMargin m:val=""0""/>
   <m:defJc m:val=""centerGroup""/>
   <m:wrapIndent m:val=""1440""/>
   <m:intLim m:val=""subSup""/>
   <m:naryLim m:val=""undOvr""/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=""false"" DefUnhideWhenUsed=""false""
  DefSemiHidden=""false"" DefQFormat=""false"" DefPriority=""99""
  LatentStyleCount=""371"">
  <w:LsdException Locked=""false"" Priority=""0"" QFormat=""true"" Name=""Normal""/>
  <w:LsdException Locked=""false"" Priority=""9"" QFormat=""true"" Name=""heading 1""/>
  <w:LsdException Locked=""false"" Priority=""9"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""heading 2""/>
  <w:LsdException Locked=""false"" Priority=""9"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""heading 3""/>
  <w:LsdException Locked=""false"" Priority=""9"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""heading 4""/>
  <w:LsdException Locked=""false"" Priority=""9"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""heading 5""/>
  <w:LsdException Locked=""false"" Priority=""9"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""heading 6""/>
  <w:LsdException Locked=""false"" Priority=""9"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""heading 7""/>
  <w:LsdException Locked=""false"" Priority=""9"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""heading 8""/>
  <w:LsdException Locked=""false"" Priority=""9"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""heading 9""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index 4""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index 5""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index 6""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index 7""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index 8""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index 9""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""toc 1""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""toc 2""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""toc 3""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""toc 4""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""toc 5""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""toc 6""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""toc 7""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""toc 8""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""toc 9""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Normal Indent""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""footnote text""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""annotation text""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""header""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""footer""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""index heading""/>
  <w:LsdException Locked=""false"" Priority=""35"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""caption""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""table of figures""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""envelope address""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""envelope return""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""footnote reference""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""annotation reference""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""line number""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""page number""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""endnote reference""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""endnote text""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""table of authorities""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""macro""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""toa heading""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Bullet""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Number""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List 4""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List 5""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Bullet 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Bullet 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Bullet 4""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Bullet 5""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Number 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Number 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Number 4""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Number 5""/>
  <w:LsdException Locked=""false"" Priority=""10"" QFormat=""true"" Name=""Title""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Closing""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Signature""/>
  <w:LsdException Locked=""false"" Priority=""1"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""Default Paragraph Font""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Body Text""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Body Text Indent""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Continue""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Continue 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Continue 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Continue 4""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""List Continue 5""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Message Header""/>
  <w:LsdException Locked=""false"" Priority=""11"" QFormat=""true"" Name=""Subtitle""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Salutation""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Date""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Body Text First Indent""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Body Text First Indent 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Note Heading""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Body Text 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Body Text 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Body Text Indent 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Body Text Indent 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Block Text""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Hyperlink""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""FollowedHyperlink""/>
  <w:LsdException Locked=""false"" Priority=""22"" QFormat=""true"" Name=""Strong""/>
  <w:LsdException Locked=""false"" Priority=""20"" QFormat=""true"" Name=""Emphasis""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Document Map""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Plain Text""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""E-mail Signature""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Top of Form""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Bottom of Form""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Normal (Web)""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Acronym""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Address""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Cite""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Code""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Definition""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Keyboard""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Preformatted""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Sample""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Typewriter""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""HTML Variable""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Normal Table""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""annotation subject""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""No List""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Outline List 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Outline List 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Outline List 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Simple 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Simple 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Simple 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Classic 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Classic 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Classic 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Classic 4""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Colorful 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Colorful 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Colorful 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Columns 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Columns 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Columns 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Columns 4""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Columns 5""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Grid 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Grid 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Grid 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Grid 4""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Grid 5""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Grid 6""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Grid 7""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Grid 8""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table List 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table List 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table List 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table List 4""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table List 5""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table List 6""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table List 7""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table List 8""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table 3D effects 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table 3D effects 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table 3D effects 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Contemporary""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Elegant""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Professional""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Subtle 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Subtle 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Web 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Web 2""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Web 3""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Balloon Text""/>
  <w:LsdException Locked=""false"" Priority=""39"" Name=""Table Grid""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" UnhideWhenUsed=""true""
   Name=""Table Theme""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" Name=""Placeholder Text""/>
  <w:LsdException Locked=""false"" Priority=""1"" QFormat=""true"" Name=""No Spacing""/>
  <w:LsdException Locked=""false"" Priority=""60"" Name=""Light Shading""/>
  <w:LsdException Locked=""false"" Priority=""61"" Name=""Light List""/>
  <w:LsdException Locked=""false"" Priority=""62"" Name=""Light Grid""/>
  <w:LsdException Locked=""false"" Priority=""63"" Name=""Medium Shading 1""/>
  <w:LsdException Locked=""false"" Priority=""64"" Name=""Medium Shading 2""/>
  <w:LsdException Locked=""false"" Priority=""65"" Name=""Medium List 1""/>
  <w:LsdException Locked=""false"" Priority=""66"" Name=""Medium List 2""/>
  <w:LsdException Locked=""false"" Priority=""67"" Name=""Medium Grid 1""/>
  <w:LsdException Locked=""false"" Priority=""68"" Name=""Medium Grid 2""/>
  <w:LsdException Locked=""false"" Priority=""69"" Name=""Medium Grid 3""/>
  <w:LsdException Locked=""false"" Priority=""70"" Name=""Dark List""/>
  <w:LsdException Locked=""false"" Priority=""71"" Name=""Colorful Shading""/>
  <w:LsdException Locked=""false"" Priority=""72"" Name=""Colorful List""/>
  <w:LsdException Locked=""false"" Priority=""73"" Name=""Colorful Grid""/>
  <w:LsdException Locked=""false"" Priority=""60"" Name=""Light Shading Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""61"" Name=""Light List Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""62"" Name=""Light Grid Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""63"" Name=""Medium Shading 1 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""64"" Name=""Medium Shading 2 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""65"" Name=""Medium List 1 Accent 1""/>
  <w:LsdException Locked=""false"" SemiHidden=""true"" Name=""Revision""/>
  <w:LsdException Locked=""false"" Priority=""34"" QFormat=""true""
   Name=""List Paragraph""/>
  <w:LsdException Locked=""false"" Priority=""29"" QFormat=""true"" Name=""Quote""/>
  <w:LsdException Locked=""false"" Priority=""30"" QFormat=""true""
   Name=""Intense Quote""/>
  <w:LsdException Locked=""false"" Priority=""66"" Name=""Medium List 2 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""67"" Name=""Medium Grid 1 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""68"" Name=""Medium Grid 2 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""69"" Name=""Medium Grid 3 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""70"" Name=""Dark List Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""71"" Name=""Colorful Shading Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""72"" Name=""Colorful List Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""73"" Name=""Colorful Grid Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""60"" Name=""Light Shading Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""61"" Name=""Light List Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""62"" Name=""Light Grid Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""63"" Name=""Medium Shading 1 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""64"" Name=""Medium Shading 2 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""65"" Name=""Medium List 1 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""66"" Name=""Medium List 2 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""67"" Name=""Medium Grid 1 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""68"" Name=""Medium Grid 2 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""69"" Name=""Medium Grid 3 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""70"" Name=""Dark List Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""71"" Name=""Colorful Shading Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""72"" Name=""Colorful List Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""73"" Name=""Colorful Grid Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""60"" Name=""Light Shading Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""61"" Name=""Light List Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""62"" Name=""Light Grid Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""63"" Name=""Medium Shading 1 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""64"" Name=""Medium Shading 2 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""65"" Name=""Medium List 1 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""66"" Name=""Medium List 2 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""67"" Name=""Medium Grid 1 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""68"" Name=""Medium Grid 2 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""69"" Name=""Medium Grid 3 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""70"" Name=""Dark List Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""71"" Name=""Colorful Shading Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""72"" Name=""Colorful List Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""73"" Name=""Colorful Grid Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""60"" Name=""Light Shading Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""61"" Name=""Light List Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""62"" Name=""Light Grid Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""63"" Name=""Medium Shading 1 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""64"" Name=""Medium Shading 2 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""65"" Name=""Medium List 1 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""66"" Name=""Medium List 2 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""67"" Name=""Medium Grid 1 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""68"" Name=""Medium Grid 2 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""69"" Name=""Medium Grid 3 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""70"" Name=""Dark List Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""71"" Name=""Colorful Shading Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""72"" Name=""Colorful List Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""73"" Name=""Colorful Grid Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""60"" Name=""Light Shading Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""61"" Name=""Light List Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""62"" Name=""Light Grid Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""63"" Name=""Medium Shading 1 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""64"" Name=""Medium Shading 2 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""65"" Name=""Medium List 1 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""66"" Name=""Medium List 2 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""67"" Name=""Medium Grid 1 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""68"" Name=""Medium Grid 2 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""69"" Name=""Medium Grid 3 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""70"" Name=""Dark List Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""71"" Name=""Colorful Shading Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""72"" Name=""Colorful List Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""73"" Name=""Colorful Grid Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""60"" Name=""Light Shading Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""61"" Name=""Light List Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""62"" Name=""Light Grid Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""63"" Name=""Medium Shading 1 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""64"" Name=""Medium Shading 2 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""65"" Name=""Medium List 1 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""66"" Name=""Medium List 2 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""67"" Name=""Medium Grid 1 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""68"" Name=""Medium Grid 2 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""69"" Name=""Medium Grid 3 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""70"" Name=""Dark List Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""71"" Name=""Colorful Shading Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""72"" Name=""Colorful List Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""73"" Name=""Colorful Grid Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""19"" QFormat=""true""
   Name=""Subtle Emphasis""/>
  <w:LsdException Locked=""false"" Priority=""21"" QFormat=""true""
   Name=""Intense Emphasis""/>
  <w:LsdException Locked=""false"" Priority=""31"" QFormat=""true""
   Name=""Subtle Reference""/>
  <w:LsdException Locked=""false"" Priority=""32"" QFormat=""true""
   Name=""Intense Reference""/>
  <w:LsdException Locked=""false"" Priority=""33"" QFormat=""true"" Name=""Book Title""/>
  <w:LsdException Locked=""false"" Priority=""37"" SemiHidden=""true""
   UnhideWhenUsed=""true"" Name=""Bibliography""/>
  <w:LsdException Locked=""false"" Priority=""39"" SemiHidden=""true""
   UnhideWhenUsed=""true"" QFormat=""true"" Name=""TOC Heading""/>
  <w:LsdException Locked=""false"" Priority=""41"" Name=""Plain Table 1""/>
  <w:LsdException Locked=""false"" Priority=""42"" Name=""Plain Table 2""/>
  <w:LsdException Locked=""false"" Priority=""43"" Name=""Plain Table 3""/>
  <w:LsdException Locked=""false"" Priority=""44"" Name=""Plain Table 4""/>
  <w:LsdException Locked=""false"" Priority=""45"" Name=""Plain Table 5""/>
  <w:LsdException Locked=""false"" Priority=""40"" Name=""Grid Table Light""/>
  <w:LsdException Locked=""false"" Priority=""46"" Name=""Grid Table 1 Light""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""Grid Table 2""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""Grid Table 3""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""Grid Table 4""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""Grid Table 5 Dark""/>
  <w:LsdException Locked=""false"" Priority=""51"" Name=""Grid Table 6 Colorful""/>
  <w:LsdException Locked=""false"" Priority=""52"" Name=""Grid Table 7 Colorful""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""Grid Table 1 Light Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""Grid Table 2 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""Grid Table 3 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""Grid Table 4 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""Grid Table 5 Dark Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""Grid Table 6 Colorful Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""Grid Table 7 Colorful Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""Grid Table 1 Light Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""Grid Table 2 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""Grid Table 3 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""Grid Table 4 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""Grid Table 5 Dark Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""Grid Table 6 Colorful Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""Grid Table 7 Colorful Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""Grid Table 1 Light Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""Grid Table 2 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""Grid Table 3 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""Grid Table 4 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""Grid Table 5 Dark Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""Grid Table 6 Colorful Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""Grid Table 7 Colorful Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""Grid Table 1 Light Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""Grid Table 2 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""Grid Table 3 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""Grid Table 4 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""Grid Table 5 Dark Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""Grid Table 6 Colorful Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""Grid Table 7 Colorful Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""Grid Table 1 Light Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""Grid Table 2 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""Grid Table 3 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""Grid Table 4 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""Grid Table 5 Dark Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""Grid Table 6 Colorful Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""Grid Table 7 Colorful Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""Grid Table 1 Light Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""Grid Table 2 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""Grid Table 3 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""Grid Table 4 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""Grid Table 5 Dark Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""Grid Table 6 Colorful Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""Grid Table 7 Colorful Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""46"" Name=""List Table 1 Light""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""List Table 2""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""List Table 3""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""List Table 4""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""List Table 5 Dark""/>
  <w:LsdException Locked=""false"" Priority=""51"" Name=""List Table 6 Colorful""/>
  <w:LsdException Locked=""false"" Priority=""52"" Name=""List Table 7 Colorful""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""List Table 1 Light Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""List Table 2 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""List Table 3 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""List Table 4 Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""List Table 5 Dark Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""List Table 6 Colorful Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""List Table 7 Colorful Accent 1""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""List Table 1 Light Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""List Table 2 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""List Table 3 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""List Table 4 Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""List Table 5 Dark Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""List Table 6 Colorful Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""List Table 7 Colorful Accent 2""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""List Table 1 Light Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""List Table 2 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""List Table 3 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""List Table 4 Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""List Table 5 Dark Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""List Table 6 Colorful Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""List Table 7 Colorful Accent 3""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""List Table 1 Light Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""List Table 2 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""List Table 3 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""List Table 4 Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""List Table 5 Dark Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""List Table 6 Colorful Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""List Table 7 Colorful Accent 4""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""List Table 1 Light Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""List Table 2 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""List Table 3 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""List Table 4 Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""List Table 5 Dark Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""List Table 6 Colorful Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""List Table 7 Colorful Accent 5""/>
  <w:LsdException Locked=""false"" Priority=""46""
   Name=""List Table 1 Light Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""47"" Name=""List Table 2 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""48"" Name=""List Table 3 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""49"" Name=""List Table 4 Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""50"" Name=""List Table 5 Dark Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""51""
   Name=""List Table 6 Colorful Accent 6""/>
  <w:LsdException Locked=""false"" Priority=""52""
   Name=""List Table 7 Colorful Accent 6""/>
 </w:LatentStyles>
</xml><![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;
	mso-font-charset:2;
	mso-generic-font-family:auto;
	mso-font-pitch:variable;
	mso-font-signature:0 268435456 0 0 -2147483648 0;}
@font-face
	{font-family:""Cambria Math"";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536869121 1107305727 33554432 0 415 0;}
@font-face
	{font-family:""Calibri Light"";
	panose-1:2 15 3 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-536859905 -1073732485 9 0 511 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-536859905 -1073732485 9 0 511 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"""";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:""Calibri"",sans-serif;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;}
h1
	{mso-style-priority:9;
	mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-link:""Heading 1 Char"";
	margin-top:.25in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:1;
	background:#5B9BD5;
	font-size:15.0pt;
	font-family:""Calibri Light"",sans-serif;
	color:white;
	text-transform:uppercase;
	font-weight:normal;}
h2
	{mso-style-noshow:yes;
	mso-style-priority:9;
	mso-style-qformat:yes;
	mso-style-link:""Heading 2 Char"";
	margin-top:13.0pt;
	margin-right:0in;
	margin-bottom:3.0pt;
	margin-left:0in;
	line-height:105%;
	mso-pagination:widow-orphan;
	page-break-after:avoid;
	mso-outline-level:2;
	font-size:13.0pt;
	font-family:""Calibri"",sans-serif;
	color:#5B9BD5;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:#954F72;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	mso-style-unhide:no;
	mso-style-qformat:yes;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:""Calibri"",sans-serif;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;}
span.Heading1Char
	{mso-style-name:""Heading 1 Char"";
	mso-style-priority:9;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-link:""Heading 1"";
	mso-ansi-font-size:15.0pt;
	mso-bidi-font-size:15.0pt;
	font-family:""Calibri Light"",sans-serif;
	mso-ascii-font-family:""Calibri Light"";
	mso-hansi-font-family:""Calibri Light"";
	mso-bidi-font-family:""Calibri Light"";
	color:white;
	text-transform:uppercase;
	background:#5B9BD5;
	mso-font-kerning:18.0pt;}
span.Heading2Char
	{mso-style-name:""Heading 2 Char"";
	mso-style-noshow:yes;
	mso-style-priority:9;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-link:""Heading 2"";
	mso-ansi-font-size:13.0pt;
	mso-bidi-font-size:13.0pt;
	font-family:""Calibri"",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:Calibri;
	color:#5B9BD5;
	font-weight:bold;}
p.checkboxindent, li.checkboxindent, div.checkboxindent
	{mso-style-name:""checkbox indent"";
	mso-style-priority:99;
	mso-style-unhide:no;
	margin-top:5.0pt;
	margin-right:0in;
	margin-bottom:4.0pt;
	margin-left:17.85pt;
	text-indent:-17.85pt;
	line-height:105%;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:""Calibri"",sans-serif;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-family:""Calibri"",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:""Times New Roman"";
	mso-bidi-theme-font:minor-bidi;}
.MsoPapDefault
	{mso-style-type:export-only;
	margin-bottom:8.0pt;
	line-height:107%;}
 /* Page Definitions */
 @page
	{mso-footnote-separator:url(""VmMailer4_files/header.htm"") fs;
	mso-footnote-continuation-separator:url(""VmMailer4_files/header.htm"") fcs;
	mso-endnote-separator:url(""VmMailer4_files/header.htm"") es;
	mso-endnote-continuation-separator:url(""VmMailer4_files/header.htm"") ecs;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
 /* List Definitions */
 @list l0
	{mso-list-id:451292627;
	mso-list-type:hybrid;
	mso-list-template-ids:-234212494 -1596838310 333584366 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";
	color:#0033A0;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1
	{mso-list-id:757756394;
	mso-list-type:hybrid;
	mso-list-template-ids:-1605179832 -394878624 -662293534 553681236 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0FC;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	color:#0033A0;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";
	color:#0033A0;}
@list l1:level3
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:•;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Arial"",sans-serif;
	mso-fareast-font-family:Calibri;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2
	{mso-list-id:895896302;
	mso-list-type:hybrid;
	mso-list-template-ids:-1926617320 405729702 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:68.85pt;
	text-indent:-.25in;
	font-family:""Courier New"";
	color:#0033A0;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:104.85pt;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:140.85pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:176.85pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:212.85pt;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:248.85pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:284.85pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:320.85pt;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:356.85pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3
	{mso-list-id:1453744059;
	mso-list-type:hybrid;
	mso-list-template-ids:-1911760306 67698701 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l3:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0FC;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l3:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l3:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l3:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l3:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l3:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l4
	{mso-list-id:2033604106;
	mso-list-type:hybrid;
	mso-list-template-ids:-751647396 352235540 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l4:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0FC;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	color:#0033A0;}
@list l4:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l4:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l4:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l4:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l4:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l4:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l4:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:""Courier New"";}
@list l4:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:""Table Normal"";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"""";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin-top:0in;
	mso-para-margin-right:0in;
	mso-para-margin-bottom:8.0pt;
	mso-para-margin-left:0in;
	line-height:107%;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:""Calibri"",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:""Times New Roman"";
	mso-bidi-theme-font:minor-bidi;}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=""edit"" spidmax=""2050""/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=""edit"">
  <o:idmap v:ext=""edit"" data=""2""/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US link=""#0563C1"" vlink=""#954F72"" style='tab-interval:.5in'>

<div class=WordSection1>

<div align=center>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;mso-yfti-tbllook:1184;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=624 colspan=3 valign=top style='width:6.5in;padding:0in 0in 0in 0in'>
  <p class=MsoNormal style='line-height:105%'><span style='font-family:""Arial"",sans-serif;
  mso-no-proof:yes'><!--[if gte vml 1]><v:shapetype id=""_x0000_t75""
   coordsize=""21600,21600"" o:spt=""75"" o:preferrelative=""t"" path=""m@4@5l@4@11@9@11@9@5xe""
   filled=""f"" stroked=""f"">
   <v:stroke joinstyle=""miter""/>
   <v:formulas>
    <v:f eqn=""if lineDrawn pixelLineWidth 0""/>
    <v:f eqn=""sum @0 1 0""/>
    <v:f eqn=""sum 0 0 @1""/>
    <v:f eqn=""prod @2 1 2""/>
    <v:f eqn=""prod @3 21600 pixelWidth""/>
    <v:f eqn=""prod @3 21600 pixelHeight""/>
    <v:f eqn=""sum @0 0 1""/>
    <v:f eqn=""prod @6 1 2""/>
    <v:f eqn=""prod @7 21600 pixelWidth""/>
    <v:f eqn=""sum @8 21600 0""/>
    <v:f eqn=""prod @7 21600 pixelHeight""/>
    <v:f eqn=""sum @10 21600 0""/>
   </v:formulas>
   <v:path o:extrusionok=""f"" gradientshapeok=""t"" o:connecttype=""rect""/>
   <o:lock v:ext=""edit"" aspectratio=""t""/>
  </v:shapetype><v:shape id=""_x0000_i1079"" type=""#_x0000_t75"" style='width:468pt;
   height:138pt'>
   <v:imagedata src='cid:image001.png' o:title=""image001""/>
  </v:shape><![endif]--><![if !vml]><img width=624 height=184
  src='cid:image001.png' v:shapes=""_x0000_i1079""><![endif]></span><span
  style='font-family:""Arial"",sans-serif'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:4.0pt'>
  <td width=624 colspan=3 style='width:6.5in;background:white;padding:0in 0in 0in 0in;
  height:4.0pt'>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><span style='font-family:""Arial"",sans-serif;
  color:black'><o:p>&nbsp;</o:p></span></p>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><span style='font-family:""Arial"",sans-serif;
  color:black'>Dear Caliber 2.0 Participants, <o:p></o:p></span></p>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><span style='font-family:""Arial"",sans-serif;
  color:black'>Greetings!! Please find the credentials to connect to Azure
  Virtual Machine (VM) and the important notes and steps below to follow
  throughout the event.<o:p></o:p></span></p>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><span style='font-family:""Arial"",sans-serif;
  color:black'><o:p>&nbsp;</o:p></span></p>
  <h1 style='margin:0in;margin-bottom:.0001pt;text-align:justify;line-height:
  105%;background:#0033A0'><span style='font-size:12.0pt;line-height:105%;
  font-family:""Arial"",sans-serif;mso-fareast-font-family:""Times New Roman""'>Credentials
  to Connect <o:p></o:p></span></h1>
  <h2 style='margin:0in;margin-bottom:.0001pt;text-align:justify'><span
  style='font-size:9.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  mso-fareast-font-family:""Times New Roman""'><o:p>&nbsp;</o:p></span></h2>
  <h2 style='margin:0in;margin-bottom:.0001pt;text-align:justify'><span
  style='font-size:11.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  mso-fareast-font-family:""Times New Roman"";color:#0033A0;font-weight:normal'>IP
  ADDRESS <o:p></o:p></span></h2>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><b><span style='font-size:10.0pt;line-height:105%;
  font-family:""Arial"",sans-serif;color:black'>$vmip</span></b><b><span
  style='font-size:9.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'><o:p></o:p></span></b></p>
  <p class=checkboxindent style='margin-top:0in;margin-right:0in;margin-bottom:
  0in;margin-left:17.85pt;margin-bottom:.0001pt;text-align:justify'><span
  style='font-size:9.0pt;line-height:105%;font-family:""Arial"",sans-serif'><o:p>&nbsp;</o:p></span></p>
  <h2 style='margin:0in;margin-bottom:.0001pt;text-align:justify'><span
  style='font-size:11.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  mso-fareast-font-family:""Times New Roman"";color:#0033A0;font-weight:normal'>USERS<o:p></o:p></span></h2>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><b><span style='font-size:10.0pt;line-height:105%;
  font-family:""Arial"",sans-serif;color:black'>calibone<o:p></o:p></span></b></p>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><b><span style='font-size:10.0pt;line-height:105%;
  font-family:""Arial"",sans-serif;color:black'>calibtwo<o:p></o:p></span></b></p>
  <p class=checkboxindent style='margin-top:0in;margin-right:0in;margin-bottom:
  0in;margin-left:17.85pt;margin-bottom:.0001pt;text-align:justify'><b><span
  style='font-size:9.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'><o:p>&nbsp;</o:p></span></b></p>
  <h2 style='margin:0in;margin-bottom:.0001pt;text-align:justify'><span
  style='font-size:11.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  mso-fareast-font-family:""Times New Roman"";color:#0033A0;font-weight:normal'>PASSWORD<o:p></o:p></span></h2>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><b><span style='font-size:10.0pt;line-height:105%;
  font-family:""Arial"",sans-serif;color:black'>Welcome@caliber2<o:p></o:p></span></b></p>
  <h2 style='margin:0in;margin-bottom:.0001pt;text-align:justify'><span
  style='font-size:9.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  mso-fareast-font-family:""Times New Roman""'><o:p>&nbsp;</o:p></span></h2>
  <h2 style='margin:0in;margin-bottom:.0001pt;text-align:justify'><span
  style='font-size:11.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  mso-fareast-font-family:""Times New Roman"";color:#0033A0;font-weight:normal'>TOOLS<o:p></o:p></span></h2>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><span style='font-size:10.0pt;line-height:105%;
  font-family:""Arial"",sans-serif;color:black'>Additional tools can be found in the
  below link:</span><span style='font-size:10.0pt;line-height:105%;font-family:
  ""Arial"",sans-serif'><o:p></o:p></span></p>
  <p class=checkboxindent style='margin-top:0in;margin-right:0in;margin-bottom:
  0in;margin-left:67.5pt;margin-bottom:.0001pt;text-align:justify;text-indent:
  -.25in;mso-list:l3 level3 lfo1'><![if !supportLists]><span
  class=MsoHyperlink><span style='font-family:Wingdings;mso-fareast-font-family:
  Wingdings;mso-bidi-font-family:Wingdings;mso-bidi-font-weight:bold;
  text-decoration:none;text-underline:none'><span style='mso-list:Ignore'>§<span
  style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span></span><![endif]><a
  href=""https://azure.microsoft.com/en-us/downloads/""><span style='font-size:
  10.0pt;line-height:105%;font-family:""Arial"",sans-serif'>https://azure.microsoft.com/en-us/downloads/</span></a><span
  class=MsoHyperlink><b><o:p></o:p></b></span></p>
  <p class=checkboxindent style='margin:0in;margin-bottom:.0001pt;text-align:
  justify;text-indent:0in'><span class=MsoHyperlink><b><span style='font-size:
  9.0pt;line-height:105%;font-family:""Arial"",sans-serif'><o:p><span
   style='text-decoration:none'>&nbsp;</span></o:p></span></b></span></p>
  <p class=MsoNormal style='margin-right:16.1pt;line-height:105%'><span
  style='font-size:22.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:#0033A0'>Please Note!!!</span><span style='font-size:22.0pt;line-height:
  105%;color:#0033A0'><o:p></o:p></span></p>
  <p class=MsoListParagraph style='text-indent:-.25in;line-height:150%;
  mso-list:l1 level1 lfo2'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:150%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0'><span style='mso-list:Ignore'>ü<span
  style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif'>Every
  team is allocated to one Virtual Machine with the below configuration. Non – Compliance
  would attract negative marking. <o:p></o:p></span></p>
  <p class=MsoListParagraph style='margin-left:1.0in;text-indent:-.25in;
  line-height:150%;mso-list:l1 level2 lfo2'><![if !supportLists]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Courier New"";
  mso-fareast-font-family:""Courier New"";color:#0033A0;mso-bidi-font-weight:
  bold'><span style='mso-list:Ignore'>o<span style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp;
  </span></span></span><![endif]><b><span style='font-size:10.0pt;line-height:
  150%;font-family:""Arial"",sans-serif'>Standard VM with 2 vCPU, 7GB RAM and 128
  GB SSD hard disk with Windows Datacenter 2016 OS integrated with Visual
  Studio Community Edition.<o:p></o:p></span></b></p>
  <p class=MsoListParagraph style='text-indent:-.25in;line-height:150%;
  mso-list:l1 level1 lfo2'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:150%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0'><span style='mso-list:Ignore'>ü<span
  style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif'>Teams
  are liable to furnish appropriate justification for consuming resources
  beyond the scope of proposed solutions.<o:p></o:p></span></p>
  <p class=MsoListParagraph style='text-indent:-.25in;line-height:150%;
  mso-list:l1 level1 lfo2'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:150%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0'><span style='mso-list:Ignore'>ü<span
  style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif'>VM
  is scheduled to shut down at <b>11 PM IST every day</b>. Hence, Teams are
  advised to save the data accordingly. <o:p></o:p></span></p>
  <p class=MsoListParagraph style='text-indent:-.25in;line-height:150%;
  mso-list:l1 level1 lfo2'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:150%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0'><span style='mso-list:Ignore'>ü<span
  style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif'>Team
  POC shall be given Azure portal access to <b>start &amp; stop the VM manually
  from the Azure portal</b> as per team’s requirement. <o:p></o:p></span></p>
  <p class=MsoListParagraph style='margin-left:1.0in;text-indent:-.25in;
  line-height:150%;mso-list:l1 level2 lfo2'><![if !supportLists]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Courier New"";
  mso-fareast-font-family:""Courier New"";color:#0033A0'><span style='mso-list:
  Ignore'>o<span style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif'>Note:&nbsp;
  <o:p></o:p></span></p>
  <p class=MsoListParagraph style='margin-left:1.5in;text-indent:-.25in;
  line-height:150%;mso-list:l1 level3 lfo2'><![if !supportLists]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif;
  mso-fareast-font-family:Arial'><span style='mso-list:Ignore'>•<span
  style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif'>Teams
  are advised to share their Live / Gmail ID to get the Azure portal access.<o:p></o:p></span></p>
  <p class=MsoListParagraph style='margin-left:1.5in;text-indent:-.25in;
  line-height:150%;mso-list:l1 level3 lfo2'><![if !supportLists]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif;
  mso-fareast-font-family:Arial'><span style='mso-list:Ignore'>•<span
  style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif'>Stop
  the VM every day and Start it whenever required from Azure portal.<o:p></o:p></span></p>
  <p class=MsoListParagraph style='margin-left:1.5in;text-indent:-.25in;
  line-height:150%;mso-list:l1 level3 lfo2'><![if !supportLists]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif;
  mso-fareast-font-family:Arial'><span style='mso-list:Ignore'>•<span
  style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif'>VMs
  are assigned with static IP hence, it will not change.<o:p></o:p></span></p>
  <p class=MsoListParagraph style='text-indent:-.25in;line-height:150%;
  mso-list:l1 level1 lfo2'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:150%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0'><span style='mso-list:Ignore'>ü<span
  style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:150%;font-family:""Arial"",sans-serif'>Teams
  are advised to <b>back up all the data in their local system,</b> as there is
  no back up configuration done on the VM. <o:p></o:p></span></p>
  <p class=MsoListParagraph style='margin-left:1.0in;text-indent:-.25in;
  line-height:105%;mso-list:l1 level2 lfo2'><![if !supportLists]><span
  style='font-family:""Courier New"";mso-fareast-font-family:""Courier New"";
  color:#0033A0'><span style='mso-list:Ignore'>o<span style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;
  </span></span></span><![endif]><span style='font-size:10.0pt;line-height:
  105%;font-family:""Arial"",sans-serif'>Note: Academy will not be able to
  recover any data loss. However, a new VM could be allocated</span><span
  style='font-family:""Arial"",sans-serif'><o:p></o:p></span></p>
  <h1 style='margin:0in;margin-bottom:.0001pt;text-align:justify;line-height:
  105%;background:#0033A0'><span style='font-size:12.0pt;line-height:105%;
  font-family:""Arial"",sans-serif;mso-fareast-font-family:""Times New Roman""'>STEPS
  TO CONNECT THROUGH RDP<o:p></o:p></span></h1>
  <p class=checkboxindent style='margin-left:.5in;text-indent:-.25in;
  mso-list:l4 level1 lfo3'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:105%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0;mso-bidi-font-weight:bold'><span
  style='mso-list:Ignore'>ü<span style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><b><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Run &gt; mstsc </span></b><span style='font-size:10.0pt;
  line-height:105%;font-family:""Arial"",sans-serif;color:black'>to open<b>
  ‘Remote Desktop Connection’ </b>window<b><o:p></o:p></b></span></p>
  <p class=checkboxindent style='margin-left:.5in;text-indent:-.25in;
  mso-list:l4 level1 lfo3'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:105%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0;mso-bidi-font-weight:bold'><span
  style='mso-list:Ignore'>ü<span style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Click<b> ‘Show Options’<o:p></o:p></b></span></p>
  <p class=checkboxindent style='margin-left:.5in;text-indent:-.25in;
  mso-list:l4 level1 lfo3'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:105%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0'><span style='mso-list:Ignore'>ü<span
  style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Provide the credentials at first login:<o:p></o:p></span></p>
  <p class=checkboxindent style='margin-left:68.85pt;text-indent:-.25in;
  mso-list:l2 level1 lfo4'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:105%;font-family:""Courier New"";mso-fareast-font-family:""Courier New"";
  color:#0033A0;mso-bidi-font-weight:bold'><span style='mso-list:Ignore'>o<span
  style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><b><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Computer: &lt; IP Address &gt; </span></b><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>(Need to enter your VM IP here)<b><o:p></o:p></b></span></p>
  <p class=checkboxindent style='margin-left:68.85pt;text-indent:-.25in;
  mso-list:l2 level1 lfo4'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:105%;font-family:""Courier New"";mso-fareast-font-family:""Courier New"";
  color:#0033A0;mso-bidi-font-weight:bold'><span style='mso-list:Ignore'>o<span
  style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><b><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>User name: calibone / calibtwo </span></b><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>(Need to enter anyone of the two users here)<b><o:p></o:p></b></span></p>
  <p class=checkboxindent style='margin-left:.5in;text-indent:-.25in;
  mso-list:l4 level1 lfo3'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:105%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0;mso-bidi-font-weight:bold'><span
  style='mso-list:Ignore'>ü<span style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Hit<b> connect </b>and provide password to connect to the VM<b><o:p></o:p></b></span></p>
  <p class=checkboxindent style='margin-left:.5in;text-indent:-.25in;
  mso-list:l4 level1 lfo3'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:105%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0'><span style='mso-list:Ignore'>ü<span
  style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Allow the certificate name<b> ‘azure-hackathon’ </b>by clicking<b>
  ‘Yes’ </b>in the next window<o:p></o:p></span></p>
  <p class=checkboxindent style='margin-left:.5in;text-indent:-.25in;
  mso-list:l4 level1 lfo3'><![if !supportLists]><span style='font-size:10.0pt;
  line-height:105%;font-family:Wingdings;mso-fareast-font-family:Wingdings;
  mso-bidi-font-family:Wingdings;color:#0033A0'><span style='mso-list:Ignore'>ü<span
  style='font:7.0pt ""Times New Roman""'>&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>We recommend <b>changing the passwords</b> of both admin users
  available in the Virtual Machine. Once, you are able to successfully login to
  it, please follow the below steps to change User's Password in Remote
  Desktop:<o:p></o:p></span></p>
  <p class=checkboxindent style='margin-top:5.0pt;margin-right:0in;margin-bottom:
  0in;margin-left:1.0in;margin-bottom:.0001pt;text-indent:-.25in;mso-list:l0 level2 lfo5'><![if !supportLists]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Courier New"";
  mso-fareast-font-family:""Courier New"";color:#0033A0'><span style='mso-list:
  Ignore'>o<span style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Click Start in Remote Server<o:p></o:p></span></p>
  <p class=checkboxindent style='margin-top:5.0pt;margin-right:0in;margin-bottom:
  0in;margin-left:1.0in;margin-bottom:.0001pt;text-indent:-.25in;mso-list:l0 level2 lfo5'><![if !supportLists]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Courier New"";
  mso-fareast-font-family:""Courier New"";color:#0033A0'><span style='mso-list:
  Ignore'>o<span style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Type ‘osk’ in search window to bring up the on-screen keyboard<o:p></o:p></span></p>
  <p class=checkboxindent style='margin-top:5.0pt;margin-right:0in;margin-bottom:
  0in;margin-left:1.0in;margin-bottom:.0001pt;text-indent:-.25in;mso-list:l0 level2 lfo5'><![if !supportLists]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Courier New"";
  mso-fareast-font-family:""Courier New"";color:#0033A0'><span style='mso-list:
  Ignore'>o<span style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Once the on screen keyboard is open, hold ‘ctrl+Alt’ on your
  physical keyboard, then click on the ‘Del’ key in the on-screen keyboard<o:p></o:p></span></p>
  <p class=checkboxindent style='margin-top:5.0pt;margin-right:0in;margin-bottom:
  0in;margin-left:1.0in;margin-bottom:.0001pt;text-indent:-.25in;mso-list:l0 level2 lfo5'><![if !supportLists]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Courier New"";
  mso-fareast-font-family:""Courier New"";color:#0033A0'><span style='mso-list:
  Ignore'>o<span style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp;&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Minimize the on screen Keyboard<o:p></o:p></span></p>
  <p class=checkboxindent style='margin-top:5.0pt;margin-right:0in;margin-bottom:
  0in;margin-left:1.0in;margin-bottom:.0001pt;text-indent:-.25in;mso-list:l0 level2 lfo5'><![if !supportLists]><span
  style='font-size:12.0pt;line-height:105%;font-family:""Courier New"";
  mso-fareast-font-family:""Courier New"";color:#0033A0'><span style='mso-list:
  Ignore'>o<span style='font:7.0pt ""Times New Roman""'>&nbsp;&nbsp; </span></span></span><![endif]><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:black'>Click Change a password</span><span style='font-size:12.0pt;
  line-height:105%;font-family:""Arial"",sans-serif;color:#404040'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2'>
  <td width=624 colspan=3 valign=top style='width:6.5in;background:white;
  padding:0in 0in 0in 0in'>
  <p class=MsoNormal style='margin-left:.3in;line-height:105%'><span
  style='font-family:""Arial"",sans-serif'><o:p>&nbsp;</o:p></span></p>
  <p class=MsoNormal style='margin-left:.3in;line-height:105%'><span
  style='font-family:""Arial"",sans-serif'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:.4in'>
  <td width=624 colspan=3 style='width:6.5in;background:#D9D9D9;padding:0in 0in 0in 0in;
  height:.4in'>
  <p class=MsoNormal style='margin-left:.3in;line-height:105%'><span
  style='font-size:12.0pt;line-height:105%;font-family:""Arial"",sans-serif'>Please
  write to<span style='color:#1F497D'> </span></span><a
  href=""mailto:CALIBER2@cognizant.com""><span style='font-size:12.0pt;
  line-height:105%;font-family:""Arial"",sans-serif;color:#0033A0'>CALIBER2@cognizant.com</span></a><span
  style='font-size:12.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:#1F497D'> </span><span style='font-size:12.0pt;line-height:105%;
  font-family:""Arial"",sans-serif'> and and mention Subject Line as Azure VM Query for any queries or clarifications.<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4'>
  <td width=624 colspan=3 valign=top style='width:6.5in;background:white;
  padding:0in 0in 0in 0in'>
  <p class=MsoNormal style='margin-left:.3in;line-height:105%'><span
  style='font-family:""Arial"",sans-serif'><o:p>&nbsp;</o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;height:.4in'>
  <td width=400 colspan=2 style='width:300.35pt;background:#0033A0;padding:
  0in 0in 0in 0in;height:.4in'>
  <p class=MsoNormal style='text-indent:21.0pt;line-height:105%;text-autospace:
  none'><a
  href=""https://be.cognizant.com/sites/cognizant-academy/SitePage/295279/academy-home""><span
  style='font-size:12.0pt;line-height:105%;font-family:""Arial"",sans-serif'>Visit
  us on Be.Cognizant</span></a><u><span style='font-size:12.0pt;line-height:
  105%;font-family:""Arial"",sans-serif;color:white'><o:p></o:p></span></u></p>
  </td>
  <td width=224 style='width:167.65pt;background:#0033A0;padding:0in 0in 0in 0in;
  height:.4in'>
  <p class=MsoNormal style='margin-right:28.5pt;line-height:105%;text-autospace:
  none'><span style='font-size:12.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:white'>OPEN.WONDER.LEARN<b><o:p></o:p></b></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;height:.3in'>
  <td width=624 colspan=3 style='width:6.5in;background:#262626;padding:0in 0in 0in 0in;
  height:.3in'>
  <p class=MsoNormal style='text-indent:.25in;line-height:105%'><span
  style='font-size:10.0pt;line-height:105%;font-family:""Arial"",sans-serif;
  color:white'>2019 Cognizant. All rights reserved.</span><span
  style='font-family:""Arial"",sans-serif'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7'>
  <td width=180 style='width:135.0pt;padding:0in 0in 0in 0in'></td>
  <td width=220 style='width:165.35pt;padding:0in 0in 0in 0in'></td>
  <td width=224 style='width:167.65pt;padding:0in 0in 0in 0in'></td>
 </tr>
 <tr style='mso-yfti-irow:8;mso-yfti-lastrow:yes'>
  <td width=180 style='width:135.0pt;padding:0in 0in 0in 0in'></td>
  <td width=220 style='width:165.35pt;padding:0in 0in 0in 0in'></td>
  <td width=224 style='width:167.65pt;padding:0in 0in 0in 0in'></td>
 </tr>
</table>

</div>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>"

}

If (Test-Path $imagePath){

    foreach($row in $usersList) {
        $EmailIdFor = "Sending Email for " + $row.EmailId
        Write-Output $EmailIdFor
        #create Outlook MailItem named Mail using CreateItem() method 
        $Mail = $Outlook.CreateItem(0) 
        #add properties as desired 
        $EmailBody = getEmailBody $row.IP
        $Mail.To = $row.EmailId
        $Mail.SentOnBehalfOfName = "CALIBER2@cognizant.com"    
        $Mail.Subject = "Azure Virtual Machine details for your team" 
        $Mail.HTMLBody = $EmailBody
        $Mail.Attachments.Add($imagePath, 0, 0)
        #send message 
        $Mail.Send() 
    }
}
else{
    Write-Output "Please copy the Caliber 2 image for the email template"
}