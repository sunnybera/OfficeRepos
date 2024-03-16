using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace IOTreeWebApplication
{
    public partial class IOTreeWebForm_1 : System.Web.UI.Page
    {
        private string Label1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack == true)
            {
                Label1 = ("Great job! Data was inserted.");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection iotreeconn = new SqlConnection("Server=tcp:np-sql-srv-001.database.windows.net,1433;Initial Catalog=np-dls-db-001;Persist Security Info=False;User ID=calib-admin;Password=Welcome@555;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            {
                SqlCommand insert = new SqlCommand("EXEC dbo.insertfullname @fullname", iotreeconn);
                insert.Parameters.AddWithValue("@fullname", TextBox1.Text);

                iotreeconn.Open();
                insert.ExecuteNonQuery();
                iotreeconn.Close();

                if (IsPostBack)
                {
                    TextBox1.Text = "";
                }
            }
        }
    }
}