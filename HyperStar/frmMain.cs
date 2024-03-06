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

    
    
    public partial class frmMain : Form
    {
        public event ItemDragEventHandler ItemDrag;

        private List<Transformation> ClipboardTran;
        private Configuration config = new Configuration();

        private String LoadProcedureXSL = "..\\..\\LoadProcedure.xsl";
        private String StageXSL = "..\\..\\StageSchema.xsl";
        private String StarXSL = "..\\..\\StarSchema.xsl";
        private String PackageXSL = "..\\..\\SSIS.xsl";
        private String ConstraintXSL = "..\\..\\Constraints.xsl";


        public Project project = new Project();
        public String ProjectFile = "";
        //private Generator gen = new Generator();
        ProjectVisualizer pv = new ProjectVisualizer();
        //TransformationVisualizer tranProps = new TransformationVisualizer();

        public void LoadConfig(){
            //load config file (includes generators)
            config = Configuration.Load("..//..//config.xml");

            //create menu items for each generator
            for (int c = 0; c < config.Generators.Count; c++)
            {
                //toolStripComboBox1.Items.Add(config.Generators[c].Name);
                //generate new menu item
                generateToolStripMenuItem.DropDownItems.Add(config.Generators[c].Name);
                //set its click event to generic click event handler
                generateToolStripMenuItem.DropDownItems[generateToolStripMenuItem.DropDownItems.Count - 1].Click += new System.EventHandler(this.GeneratorMenu_Click);
            }


        }
        public frmMain()
        {
            InitializeComponent();

            //load config
            this.LoadConfig();

            //add drag/drop functionality
            listView1.ItemDrag += new System.Windows.Forms.ItemDragEventHandler(listView1_ItemDrag);
            listMappings.DragOver += new System.Windows.Forms.DragEventHandler(listView2_DragOver);
            listMappings.DragDrop += new System.Windows.Forms.DragEventHandler(listView2_DragDrop);
            propMapping.PropertyValueChanged += new System.Windows.Forms.PropertyValueChangedEventHandler(MappingProperties_Changed);
            propTransformation.PropertyValueChanged += new System.Windows.Forms.PropertyValueChangedEventHandler(MappingProperties_Changed);
            //gridProperties.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(gridProperties_EndEdit);
            //gridMapping.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(gridMapping_EndEdit);

            //for testing, create a new subject area
            //Project.Load("..\\..\\sample.xml", project);
            //Project.Load("..\\..\\sample.xml", project);
            //mapProps.GridView = gridMapping;
            //tranProps.GridView = gridProperties;
            //lookupProps.GridView = gridLookups;
            

        }
        private void MappingProperties_Changed(object sender, PropertyValueChangedEventArgs e) {
            //just refresh mapping list
            pv.SyncMappings(project, this.listMappings);
            pv.ShowStar(project, this.listStar);
            //pv.SyncStar(project.Subjects[0], this.listStar);
        }
        private void transformToolStripMenuItem_Click(object sender, EventArgs e)
        {
            XslTransform xs = new XslTransform();
            //Stream o;
            xs.Load("..\\..\\LoadProcedure.xsl");
            //XmlDocument xs = new XmlDocument();
            ProjectFile = "c:\\jbc\\test5.xml";
            try
            {
                xs.Transform(ProjectFile, "..\\..\\output2.txt");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        protected void listView1_ItemDrag(object sender, System.Windows.Forms.ItemDragEventArgs e) {
            //initalize a drag and drop 
            //MessageBox.Show(listView1.SelectedItems.Count.ToString());
            //ListViewItem Item = (ListViewItem)e.Item;
            //drag all selectd items not just the identified in the drag operation
            this.DoDragDrop(listView1.SelectedItems,DragDropEffects.Link);
        }

        protected void listView2_DragOver(object sender, System.Windows.Forms.DragEventArgs e)
        {
            //initalize a drag and drop 
            e.Effect = e.AllowedEffect;            
        }
        private void AddTransformation(ListViewItem Item, Mapping ParentMapping, ListViewItem Sibling, ListView NewList) {
            ListViewItem newItem = new ListViewItem(Item.Text);
            newItem.SubItems.Add(Item.Text);
            Transformation NewTran = new Transformation(Item.Text, Item.Text);
            NewTran.OutputType = ((Column)Item.Tag).Type;
            NewTran.OutputSize = ((Column)Item.Tag).Size;
            ParentMapping.Transformations.Add(NewTran);
        }
        protected void listView2_DragDrop(object sender, System.Windows.Forms.DragEventArgs e) {
            //add the item to the list in the appropriate place
            ListViewItem Sibling;

            //now determine where to drop that new item
            Point HoverPoint = listMappings.PointToClient(new Point(e.X, e.Y));
            Sibling = listMappings.GetItemAt(HoverPoint.X, HoverPoint.Y);
            Mapping NewMapping;

            //get a list of columns dragged
            ListView.SelectedListViewItemCollection NewItems = (ListView.SelectedListViewItemCollection)e.Data.GetData(typeof(ListView.SelectedListViewItemCollection));

            //craete a new mapping if needed
            //if no drop was specifid, create a new one
            if (Sibling == null) {
                //add this transformation to an existing mapping
                NewMapping = new Mapping("New Mapping", NewItems[0].Group.Header, "New Table");
                project.Mappings.Add(NewMapping);
            }
            else {
                //add this transformation to an existing mapping
                //newItem.Group = Sibling.Group;
                NewMapping = ((Mapping)Sibling.Group.Tag);
            }

            //add each transformation
            for (int c = 0; c < NewItems.Count; c++) {
                //add this item
                AddTransformation(NewItems[c],NewMapping,Sibling, listMappings);
            }
            

            //sync lists with updates
            pv.SyncMappings(project, listMappings);
            pv.SyncStar(project, listStar);
            
        }

        private void listView1_SelectedIndexChanged(object sender, EventArgs e) {
         
        }

        private void sSASToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void lstProperties_LabelEdit(object sender, LabelEditEventArgs e){
            e.CancelEdit = false;

        }
        private void lstProperties_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void formToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void gridProperties_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void deleteToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void openToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (openFile.ShowDialog() == DialogResult.OK) {
                ProjectFile = openFile.FileName;
                project = Project.Load(ProjectFile);
                
                pv.ShowProject(project, listView1, listMappings, listStar);
            }

        }

        private void saveToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (ProjectFile != "") {
                Project.Save(ProjectFile, project);
            }
            else {
                saveAsToolStripMenuItem_Click(sender, e);
            }

        }

        private void saveAsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (saveFile.ShowDialog() == DialogResult.OK)
            {
                ProjectFile = saveFile.FileName;
                Project.Save(ProjectFile,project);
            }

        }
        public void RefreshProject(){
            pv.ShowProject(project, listView1, listMappings, listStar);
        }
        private void NewProject() {
            project = new Project();

            //testing:
            project.Connections = new List<Connection>();
            project.Sources = new List<Source>();
            project.Mappings = new List<Mapping>();
            /*
            project.Subject = "New Subject";
            Column[] s1 = {new Column("CarrierKey"),new Column("Carrier")};
            Column[] s2 = { new Column("PhoneNumber"), new Column("Subscriber"), new Column("[Device Type]"), new Column("[Device Usage]") };
            Column[] s3 = { new Column("Wireless Number"), new Column("Total Current Charges"), new Column("total kb data usage"), new Column("monthly access  charges"), new Column("CarrierKey"), new Column("HR_EmployeeID") };
            Column[] s4 = { new Column("Wireless Number"), new Column("Total Current Charges"), new Column("total kb data usage"), new Column("monthly access  charges"), new Column("CarrierKey"), new Column("HR_EmployeeID") };
            Column[] s5 = { new Column("Wireless Number"), new Column("Total Current Charges"), new Column("total kb data usage"), new Column("monthly access  charges"), new Column("CarrierKey"), new Column("HR_EmployeeID") };
            Column[] s6 = { new Column("Wireless Number"), new Column("Total Current Charges"), new Column("total kb data usage"), new Column("monthly access  charges"), new Column("CarrierKey"), new Column("HR_EmployeeID") };
            project.Sources.Add(new Source("[DWStaging].[dbo].[Mobile_Carrier]", s1));            
            project.Sources.Add(new Source("[DWStaging].[dbo].[Mobile_PhoneMapping]", s2));
            project.Sources.Add(new Source("[DWStaging].[dbo].[Mobile_ATT]", s3));
            project.Sources.Add(new Source("[DWStaging].[dbo].[Mobile_Sprint]", s4));
            project.Sources.Add(new Source("[DWStaging].[dbo].[Mobile_TMobile]", s5));
            project.Sources.Add(new Source("[DWStaging].[dbo].[Mobile_Verizon]", s6));
            */

            RefreshProject();

        }

        private void newToolStripMenuItem_Click(object sender, EventArgs e)
        {
            NewProject();
        }


        private void connectionsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmSources f = new frmSources();
            f.Hide();
            f.ShowSources(this.project);
            this.RefreshProject();
            
        }

        private void listMappings_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            if (listMappings.SelectedItems.Count > 0)
            {   //build a list of selected transformations
                Transformation[] trans = new Transformation[listMappings.SelectedItems.Count];
                for (int c = 0; c < listMappings.SelectedItems.Count; c++)
                {
                    trans[c] = (Transformation)listMappings.SelectedItems[c].Tag;
                }
                propTransformation.SelectedObjects = trans;



                //propTransformation.SelectedObject = listMappings.SelectedItems[0].Tag;

                //this.tranProps.ShowProperties((Transformation)listMappings.SelectedItems[0].Tag);
                //show mapping properties
                this.propMapping.SelectedObject = (Mapping)listMappings.SelectedItems[0].Group.Tag;
                //this.mapProps.ShowProperties((Mapping)listMappings.SelectedItems[0].Group.Tag);
                //show lookup properites
                //this.lookupProps.ShowProperties(((Transformation)listMappings.SelectedItems[0].Tag).Lookup);
            }

        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            //start with a new project
            NewProject();
        }

        private void previewToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //preview the selected source
            if (listView1.SelectedItems.Count > 0)
            {
                Source source = (Source)listView1.SelectedItems[0].Group.Tag;
                Connection connection = project.FindConnection(source.Connection);
                frmPreview p = new frmPreview();
                p.Show();
                p.PreviewSource(source, connection);
            }
        }

        private void copyToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void pasteToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void deleteToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            //for each selected trasnformation
            ListView.SelectedListViewItemCollection items = listMappings.SelectedItems;
            while (items.Count > 0)
            {
                //get mapping from tag
                Mapping OldMapping = (Mapping)items[0].Group.Tag;
                Transformation OldTrans = (Transformation)items[0].Tag;

                //remove trans from mapping and from list
                OldMapping.Transformations.Remove(OldTrans);

                //if the mapping contains no transformations, delete it too
                if (OldMapping.Transformations.Count == 0)
                {
                    project.Mappings.Remove(OldMapping);
                    listMappings.Groups.Remove(items[0].Group);
                }

                //remove the list item
                items[0].Remove();
            }


        }

        private void copyToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            //save to internal cache
            ClipboardTran = new List<Transformation>();
            for (int c = 0; c < listMappings.SelectedItems.Count; c++)
            {
                //add this transformatino
                ClipboardTran.Add((Transformation)listMappings.SelectedItems[c].Tag);
            }

        }

        private void pasteToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            //paste to current group
            Mapping mapping = (Mapping)listMappings.SelectedItems[0].Group.Tag;

            for (int c = 0; c < ClipboardTran.Count; c++)
            {
                //add this transformatino
                mapping.Transformations.Add(ClipboardTran[c].Copy());
            }
            pv.SyncMappings(project, listMappings);

        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        /****GENERATION MENU ITEMS****/
        private void stageToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //gen.Generate(ProjectFile, StageXSL, project.Settings.OutputPath + "\\Stage Schema\\");
        }
        private void loadProceduresToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //gen.Generate(ProjectFile, LoadProcedureXSL, project.Settings.OutputPath + "\\Load Procedures\\");
        }
        private void starToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            //gen.Generate(ProjectFile, StarXSL, project.Settings.OutputPath + "\\Star Schema\\");
            //gen.Generate(ProjectFile, ConstraintXSL, project.Settings.OutputPath + "\\Star Schema\\");
        }

        private void allToolStripMenuItem_Click(object sender, EventArgs e)
        {   //save the project before generating
            Project.Save(ProjectFile, project);
            //run all generators
            for (int c = 0; c < config.Generators.Count; c++)
            {
                    config.Generators[c].Generate(ProjectFile, project.Settings.FormatOutputPath());
            }
        }
        private void GeneratorMenu_Click(object sender, EventArgs e) {
            //save the project before generating
            Project.Save(ProjectFile, project);
            
            //find generator based on name
            for (int c = 0; c < config.Generators.Count; c++) {
                if (config.Generators[c].Name == ((ToolStripMenuItem)sender).Text){
                    config.Generators[c].Generate(ProjectFile, project.Settings.FormatOutputPath());
                }
            }
        }
        private void dTSXToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //gen.Generate(ProjectFile, PackageXSL, project.Settings.OutputPath + "\\");
        }

        private void syncTypesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //sync types between transformations and their source columns
            project.SyncTypes();
        }

        private void openFile_FileOk(object sender, CancelEventArgs e)
        {

        }

        private void toolStripComboBox1_Click(object sender, EventArgs e)
        {
            //generate the selected item
        }

        private void refreshToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //refresh generators
            
        }


    }


}
