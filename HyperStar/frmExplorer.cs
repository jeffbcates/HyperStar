using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace HyperStar
{
    public partial class frmSources : Form
    {
        private Project Project;
        public frmSources()
        {
            InitializeComponent();
        }
        public void ShowSources(Project Project) {
            this.Project = Project;
            //load all connections
            TreeNode project = new TreeNode("Project");
            project.Tag = Project;
            trvSources.Nodes.Add(project);
            TreeNode parent = new TreeNode("Connections");
            project.Nodes.Add(parent);
            for (int c1 = 0; c1 < Project.Connections.Count; c1++){
                //add a node for this connection                
                TreeNode newNode = new TreeNode(Project.Connections[c1].Name);
                newNode.Tag = Project.Connections[c1];
                parent.Nodes.Add(newNode);
            }
            //load all sources
            parent = new TreeNode("Sources");
            project.Nodes.Add(parent);
            for (int c1 = 0; c1 < Project.Sources.Count; c1++)
            {
                //add a node for this connection                
                TreeNode newNode = new TreeNode(Project.Sources[c1].Name);
                newNode.Tag = Project.Sources[c1];
                parent.Nodes.Add(newNode);
            }
            //add a settings node
            parent = new TreeNode("Settings");
            project.Nodes.Add(parent);
            parent.Tag = Project.Settings;

            //show as a dialog
            this.ShowDialog();
        }
        private void trvSources_AfterSelect(object sender, TreeViewEventArgs e)
        {
            //show properties for selected item
            propSource.SelectedObject = e.Node.Tag;
        }

        private void addToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //if we are selecting "connections"
            if (trvSources.SelectedNode.Text == "Connections") {
                TreeNode newNode = new TreeNode("New Connection");
                newNode.Tag = new Connection("New Connection", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=\"c:\\SampleDirectory\\\";Extended Properties=\"text;HDR=Yes;FMT=Delimited\"");
                trvSources.SelectedNode.Nodes.Add(newNode);
                this.Project.Connections.Add((Connection)newNode.Tag);
            }
            //if we are selecting "sources"
            if (trvSources.SelectedNode.Text == "Sources") {
                TreeNode newNode = new TreeNode("New Source");
                newNode.Tag = new Source("New Source");
                trvSources.SelectedNode.Nodes.Add(newNode);
                this.Project.Sources.Add((Source)newNode.Tag);
            }
        }

        private void Properties_Changed(object sender, PropertyValueChangedEventArgs e)
        {
            //if we are selecting "connections"
            if (!(trvSources.SelectedNode.Parent == null))
            {
                if (trvSources.SelectedNode.Parent.Text == "Connections")
                {
                    trvSources.SelectedNode.Text = ((Connection)trvSources.SelectedNode.Tag).Name;
                }
                //if we are selecting "sources"
                if (trvSources.SelectedNode.Parent.Text == "Sources")
                {
                    trvSources.SelectedNode.Text = ((Source)trvSources.SelectedNode.Tag).Name;
                }
            }
            
        }

        private void refreshColumnsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //determine the source and connection
            Source source = (Source)trvSources.SelectedNode.Tag;
            Connection connection = null;

            //find connection on project
            connection = this.Project.FindConnection(source.Connection);

            //if a connection was found
            if (connection != null)
            {
                source.LoadColumns(connection);
            }


        }

        private void copyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //make an exact copy of the source or connection 
            if (trvSources.SelectedNode.Parent.Text == "Connections") {
                Connection NewConnection = ((Connection)trvSources.SelectedNode.Tag).Copy();
                Project.Connections.Add(NewConnection);
                TreeNode newNode = new TreeNode(NewConnection.Name);
                newNode.Tag = NewConnection;
                trvSources.SelectedNode.Parent.Nodes.Add(newNode);
            }
            if (trvSources.SelectedNode.Parent.Text == "Sources") {
                Source NewConnection = ((Source)trvSources.SelectedNode.Tag).Copy();
                Project.Sources.Add(NewConnection);
                TreeNode newNode = new TreeNode(NewConnection.Name);
                newNode.Tag = NewConnection;
                trvSources.SelectedNode.Parent.Nodes.Add(newNode);
            }
        }

        private void deleteToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //delete selected connection or source
            if (trvSources.SelectedNode.Parent.Text == "Connections")
            {
                Project.Connections.Remove((Connection)trvSources.SelectedNode.Tag);
                trvSources.SelectedNode.Remove();
            }
            if (trvSources.SelectedNode.Parent.Text == "Sources")
            {
                Project.Sources.Remove((Source)trvSources.SelectedNode.Tag);
                trvSources.SelectedNode.Remove();
            }
            
        }

        private void frmSources_Unload(object sender, EventArgs e)
        {
            //refresh main form
            
        }

        private void frmSources_Load(object sender, EventArgs e)
        {
            propSource.PropertyValueChanged += new System.Windows.Forms.PropertyValueChangedEventHandler(Properties_Changed);

        }

    }
 
}
