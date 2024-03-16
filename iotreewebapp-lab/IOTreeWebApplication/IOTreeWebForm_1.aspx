<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IOTreeWebForm_1.aspx.cs" Inherits="IOTreeWebApplication.IOTreeWebForm_1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        Type Your Full Name Here<br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server" Width="276px"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
    </form>
</body>
</html>
