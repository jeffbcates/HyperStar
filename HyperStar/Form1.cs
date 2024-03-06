using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Xsl;
using System.IO;

namespace HyperStar
{

    
    
    public partial class Form1 : Form
    {
        public event ItemDragEventHandler ItemDrag;

        Project project = new Project();
        ProjectVisualizer pv = new ProjectVisualizer();
        public Form1()
        {
            InitializeComponent();

            //add drag/drop functionality
            listView1.ItemDrag += new System.Windows.Forms.ItemDragEventHandler(listView1_ItemDrag);
            listMappings.DragOver += new System.Windows.Forms.DragEventHandler(listView2_DragOver);
            listMappings.DragDrop += new System.Windows.Forms.DragEventHandler(listView2_DragDrop);

            //for testing, create a new subject area
            project.Load("..\\..\\sample.xml");
            pv.ShowSources(project.Subjects[0], this.listView1);
            pv.InitMappings(listMappings);
            pv.ShowMappings(project.Subjects[0], this.listMappings);
            pv.ShowStar(project.Subjects[0], this.listStar);
            

        }
        private void transformToolStripMenuItem_Click(object sender, EventArgs e)
        {
            XslTransform xs = new XslTransform();
            //Stream o;
            xs.Load("..\\..\\LoadProcedure.xsl");
            //XmlDocument xs = new XmlDocument();
            try
            {
                xs.Transform("..\\..\\sample.xml", "..\\..\\output.txt");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        protected void listView1_ItemDrag(object sender, System.Windows.Forms.ItemDragEventArgs e) {
            //initalize a drag and drop 
            ListViewItem Item = (ListViewItem)e.Item;
            this.DoDragDrop(Item,DragDropEffects.Link);
        }

        protected void listView2_DragOver(object sender, System.Windows.Forms.DragEventArgs e)
        {
            //initalize a drag and drop 
            e.Effect = e.AllowedEffect;
        }

        protected void listView2_DragDrop(object sender, System.Windows.Forms.DragEventArgs e) {
            //add the item to the list in the appropriate place
            
            ListViewItem Item = (ListViewItem)e.Data.GetData(typeof(ListViewItem));
            ListViewItem newItem = new ListViewItem(Item.Text);
            ListViewItem Sibling;
            newItem.SubItems.Add(Item.Text);

            //now determine where to drop that new item
            Point HoverPoint = listMappings.PointToClient(new Point(e.X, e.Y));
            Sibling = listMappings.GetItemAt(HoverPoint.X, HoverPoint.Y);
            
            
            //if no drop was specifid, create a new one
            if (Sibling == null) {
                //add this transformation to an existing mapping
                ((Mapping)Sibling.Group.Tag).Transformations.Add(new Transformation(new Column(Item.Text), new Column(Item.Text)));
                //create a new mapping
                //newItem.Group = listMappings.Groups[listMappings.Groups.Add(new ListViewGroup("New Mapping"))];
            } else {
                //add this transformation to an existing mapping
                //newItem.Group = Sibling.Group;
                ((Mapping)Sibling.Group.Tag).Transformations.Add(new Transformation(new Column(Item.Text), new Column(Item.Text)));
            }
            pv.ShowMappings(project.Subjects[0], listMappings);
            pv.ShowStar(project.Subjects[0], listStar);
            //listMappings.Items.Add(newItem);
            
        }

        private void listView1_SelectedIndexChanged(object sender, EventArgs e) {
         
        }

        private void sSASToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

    }
    class ProjectVisualizer
    {

        public void InitSources(ListView list) {
            //clear existing
            list.Items.Clear();
            list.Groups.Clear();
        }
        public void ShowSources(Subject subject, ListView list) {
            //init first
            InitSources(list);

            //create a group for each source
            for (int c = 0; c < subject.Sources.Count; c++)
            {
                //create a group for this source and save for use
                ListViewGroup newGroup = list.Groups[list.Groups.Add(new ListViewGroup(subject.Sources[c].Name))];

                //add columns as items in the group
                for (int c2 = 0; c2 < subject.Sources[c].Columns.Count; c2++)
                {
                    list.Items.Add(new ListViewItem(subject.Sources[c].Columns[c2].Name, newGroup));
                }

            }

        }

        public void InitMappings(ListView list) {
            //clear existing
            list.Items.Clear();
            list.Groups.Clear();
            list.Columns.Clear();

            //setup columns
            list.Columns.Add("Destination");
            list.Columns.Add("Source");
        }
        public void SyncMappings(Subject subject, ListView list) {
        }
        public void ShowMappings(Subject subject, ListView list) {
            //init for mappings
            InitMappings(list);

            //create a group for each source
            for (int c = 0; c < subject.Mappings.Count; c++) {
                //create a group for this mapping and save for use
                ListViewGroup newGroup = list.Groups[list.Groups.Add(new ListViewGroup(subject.Mappings[c].Name))];

                //link back for ease
                newGroup.Tag = subject.Mappings[c];
                
                //add transformations as items in the group
                for (int c2 = 0; c2 < subject.Mappings[c].Transformations.Count; c2++) {
                    //create a new item and link to group
                    ListViewItem newItem = list.Items.Add(new ListViewItem(subject.Mappings[c].Transformations[c2].Destination.Name, newGroup));
                    newItem.SubItems.Add(subject.Mappings[c].Transformations[c2].Source.Name);

                    //link back for ease
                    newItem.Tag = subject.Mappings[c].Transformations[c2];
                }

            }

        }
        public void ShowStar(Subject subject, ListView list)
        {
            //init for mappings
            InitMappings(list);

            //create a group for each source
            for (int c = 0; c < subject.Mappings.Count; c++)
            {
                //create a group for this mapping and save for use
                ListViewGroup newGroup = list.Groups[list.Groups.Add(new ListViewGroup(subject.Mappings[c].Destination))];
                //link back for ease
                newGroup.Tag = subject.Mappings[c];

                //add transformations as items in the group
                for (int c2 = 0; c2 < subject.Mappings[c].Transformations.Count; c2++)
                {
                    ListViewItem newItem = list.Items.Add(new ListViewItem(subject.Mappings[c].Transformations[c2].Destination.Name, newGroup));
                    newItem.SubItems.Add(subject.Mappings[c].Transformations[c2].Source.Name);

                    //link back for ease
                    newGroup.Tag = subject.Mappings[c].Transformations[c2];
                }

            }

        }


    }


}
