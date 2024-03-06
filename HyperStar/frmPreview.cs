using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.OleDb;

namespace HyperStar
{
    public partial class frmPreview : Form
    {
        public frmPreview()
        {
            InitializeComponent();
        }

        public void PreviewSource(Source source, Connection connection) {
            string strProvider = connection.ConnectionString;
            string strSql = "SELECT top 10 * FROM " + source.FormattedTable() + "";
            OleDbConnection con = new OleDbConnection(strProvider);
            OleDbCommand cmd = new OleDbCommand(strSql, con);
            con.Open();
            cmd.CommandType = CommandType.Text;
            OleDbDataAdapter da = new OleDbDataAdapter(cmd);
            DataTable previewdata = new DataTable();
            da.Fill(previewdata);
            dataGridView1.DataSource = previewdata;
            con.Close();
        }
    }
}
