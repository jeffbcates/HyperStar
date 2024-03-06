namespace HyperStar
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.ListViewGroup listViewGroup4 = new System.Windows.Forms.ListViewGroup("Mobile_Phone", System.Windows.Forms.HorizontalAlignment.Left);
            System.Windows.Forms.ListViewItem listViewItem7 = new System.Windows.Forms.ListViewItem(new string[] {
            "Number",
            "sub of num 1"}, -1);
            System.Windows.Forms.ListViewItem listViewItem8 = new System.Windows.Forms.ListViewItem("Subscriber");
            System.Windows.Forms.ListViewGroup listViewGroup5 = new System.Windows.Forms.ListViewGroup("Mobile_Phone", System.Windows.Forms.HorizontalAlignment.Left);
            System.Windows.Forms.ListViewItem listViewItem9 = new System.Windows.Forms.ListViewItem(new string[] {
            "Number",
            "sub of num 1"}, -1);
            System.Windows.Forms.ListViewItem listViewItem10 = new System.Windows.Forms.ListViewItem("Subscriber");
            System.Windows.Forms.ListViewGroup listViewGroup6 = new System.Windows.Forms.ListViewGroup("Mobile_Phone", System.Windows.Forms.HorizontalAlignment.Left);
            System.Windows.Forms.ListViewItem listViewItem11 = new System.Windows.Forms.ListViewItem(new string[] {
            "Number",
            "sub of num 1"}, -1);
            System.Windows.Forms.ListViewItem listViewItem12 = new System.Windows.Forms.ListViewItem("Subscriber");
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.listView1 = new System.Windows.Forms.ListView();
            this.columnHeader1 = new System.Windows.Forms.ColumnHeader();
            this.columnHeader2 = new System.Windows.Forms.ColumnHeader();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabMappings = new System.Windows.Forms.TabPage();
            this.listMappings = new System.Windows.Forms.ListView();
            this.tabStar = new System.Windows.Forms.TabPage();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.testToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.transformToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.starToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.newTableToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.generateToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.allToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.starToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.sQLServerToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.mySQLToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stageToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.dTSXToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.sSASToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.documentationToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.listStar = new System.Windows.Forms.ListView();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.tabControl1.SuspendLayout();
            this.tabMappings.SuspendLayout();
            this.tabStar.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 24);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.listView1);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.tabControl1);
            this.splitContainer1.Size = new System.Drawing.Size(701, 391);
            this.splitContainer1.SplitterDistance = 261;
            this.splitContainer1.TabIndex = 2;
            // 
            // listView1
            // 
            this.listView1.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.columnHeader1,
            this.columnHeader2});
            this.listView1.Dock = System.Windows.Forms.DockStyle.Fill;
            listViewGroup4.Header = "Mobile_Phone";
            listViewGroup4.Name = "listViewGroup1";
            this.listView1.Groups.AddRange(new System.Windows.Forms.ListViewGroup[] {
            listViewGroup4});
            listViewItem7.Group = listViewGroup4;
            listViewItem7.StateImageIndex = 0;
            listViewItem8.Group = listViewGroup4;
            listViewItem8.StateImageIndex = 0;
            this.listView1.Items.AddRange(new System.Windows.Forms.ListViewItem[] {
            listViewItem7,
            listViewItem8});
            this.listView1.Location = new System.Drawing.Point(0, 0);
            this.listView1.Name = "listView1";
            this.listView1.ShowItemToolTips = true;
            this.listView1.Size = new System.Drawing.Size(261, 391);
            this.listView1.TabIndex = 4;
            this.listView1.UseCompatibleStateImageBehavior = false;
            this.listView1.View = System.Windows.Forms.View.Tile;
            this.listView1.SelectedIndexChanged += new System.EventHandler(this.listView1_SelectedIndexChanged);
            // 
            // columnHeader1
            // 
            this.columnHeader1.Text = "name";
            // 
            // columnHeader2
            // 
            this.columnHeader2.Text = "type";
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabMappings);
            this.tabControl1.Controls.Add(this.tabStar);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(436, 391);
            this.tabControl1.TabIndex = 0;
            // 
            // tabMappings
            // 
            this.tabMappings.Controls.Add(this.listMappings);
            this.tabMappings.Location = new System.Drawing.Point(4, 22);
            this.tabMappings.Name = "tabMappings";
            this.tabMappings.Padding = new System.Windows.Forms.Padding(3);
            this.tabMappings.Size = new System.Drawing.Size(428, 365);
            this.tabMappings.TabIndex = 0;
            this.tabMappings.Text = "Mappings";
            this.tabMappings.UseVisualStyleBackColor = true;
            // 
            // listMappings
            // 
            this.listMappings.AllowDrop = true;
            this.listMappings.Dock = System.Windows.Forms.DockStyle.Fill;
            this.listMappings.GridLines = true;
            listViewGroup5.Header = "Mobile_Phone";
            listViewGroup5.Name = "listViewGroup1";
            this.listMappings.Groups.AddRange(new System.Windows.Forms.ListViewGroup[] {
            listViewGroup5});
            listViewItem9.Group = listViewGroup5;
            listViewItem9.StateImageIndex = 0;
            listViewItem10.Group = listViewGroup5;
            listViewItem10.StateImageIndex = 0;
            this.listMappings.Items.AddRange(new System.Windows.Forms.ListViewItem[] {
            listViewItem9,
            listViewItem10});
            this.listMappings.LabelEdit = true;
            this.listMappings.Location = new System.Drawing.Point(3, 3);
            this.listMappings.Name = "listMappings";
            this.listMappings.ShowItemToolTips = true;
            this.listMappings.Size = new System.Drawing.Size(422, 359);
            this.listMappings.TabIndex = 6;
            this.listMappings.UseCompatibleStateImageBehavior = false;
            this.listMappings.View = System.Windows.Forms.View.Details;
            // 
            // tabStar
            // 
            this.tabStar.Controls.Add(this.listStar);
            this.tabStar.Location = new System.Drawing.Point(4, 22);
            this.tabStar.Name = "tabStar";
            this.tabStar.Padding = new System.Windows.Forms.Padding(3);
            this.tabStar.Size = new System.Drawing.Size(428, 365);
            this.tabStar.TabIndex = 1;
            this.tabStar.Text = "Star";
            this.tabStar.UseVisualStyleBackColor = true;
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.testToolStripMenuItem,
            this.starToolStripMenuItem,
            this.generateToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(701, 24);
            this.menuStrip1.TabIndex = 4;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // testToolStripMenuItem
            // 
            this.testToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.transformToolStripMenuItem});
            this.testToolStripMenuItem.Name = "testToolStripMenuItem";
            this.testToolStripMenuItem.Size = new System.Drawing.Size(41, 20);
            this.testToolStripMenuItem.Text = "&Test";
            // 
            // transformToolStripMenuItem
            // 
            this.transformToolStripMenuItem.Name = "transformToolStripMenuItem";
            this.transformToolStripMenuItem.Size = new System.Drawing.Size(129, 22);
            this.transformToolStripMenuItem.Text = "&Transform";
            this.transformToolStripMenuItem.Click += new System.EventHandler(this.transformToolStripMenuItem_Click);
            // 
            // starToolStripMenuItem
            // 
            this.starToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.newTableToolStripMenuItem});
            this.starToolStripMenuItem.Name = "starToolStripMenuItem";
            this.starToolStripMenuItem.Size = new System.Drawing.Size(39, 20);
            this.starToolStripMenuItem.Text = "&Star";
            // 
            // newTableToolStripMenuItem
            // 
            this.newTableToolStripMenuItem.Name = "newTableToolStripMenuItem";
            this.newTableToolStripMenuItem.Size = new System.Drawing.Size(130, 22);
            this.newTableToolStripMenuItem.Text = "&New Table";
            // 
            // generateToolStripMenuItem
            // 
            this.generateToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.allToolStripMenuItem,
            this.toolStripMenuItem1,
            this.starToolStripMenuItem1,
            this.stageToolStripMenuItem,
            this.dTSXToolStripMenuItem,
            this.sSASToolStripMenuItem,
            this.documentationToolStripMenuItem});
            this.generateToolStripMenuItem.Name = "generateToolStripMenuItem";
            this.generateToolStripMenuItem.Size = new System.Drawing.Size(66, 20);
            this.generateToolStripMenuItem.Text = "&Generate";
            // 
            // allToolStripMenuItem
            // 
            this.allToolStripMenuItem.Name = "allToolStripMenuItem";
            this.allToolStripMenuItem.Size = new System.Drawing.Size(157, 22);
            this.allToolStripMenuItem.Text = "A&ll";
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(154, 6);
            // 
            // starToolStripMenuItem1
            // 
            this.starToolStripMenuItem1.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.sQLServerToolStripMenuItem,
            this.mySQLToolStripMenuItem});
            this.starToolStripMenuItem1.Name = "starToolStripMenuItem1";
            this.starToolStripMenuItem1.Size = new System.Drawing.Size(157, 22);
            this.starToolStripMenuItem1.Text = "&Star";
            // 
            // sQLServerToolStripMenuItem
            // 
            this.sQLServerToolStripMenuItem.Name = "sQLServerToolStripMenuItem";
            this.sQLServerToolStripMenuItem.Size = new System.Drawing.Size(130, 22);
            this.sQLServerToolStripMenuItem.Text = "&SQL Server";
            // 
            // mySQLToolStripMenuItem
            // 
            this.mySQLToolStripMenuItem.Name = "mySQLToolStripMenuItem";
            this.mySQLToolStripMenuItem.Size = new System.Drawing.Size(130, 22);
            this.mySQLToolStripMenuItem.Text = "&My SQL";
            // 
            // stageToolStripMenuItem
            // 
            this.stageToolStripMenuItem.Name = "stageToolStripMenuItem";
            this.stageToolStripMenuItem.Size = new System.Drawing.Size(157, 22);
            this.stageToolStripMenuItem.Text = "Sta&ge";
            // 
            // dTSXToolStripMenuItem
            // 
            this.dTSXToolStripMenuItem.Name = "dTSXToolStripMenuItem";
            this.dTSXToolStripMenuItem.Size = new System.Drawing.Size(157, 22);
            this.dTSXToolStripMenuItem.Text = "SS&IS";
            // 
            // sSASToolStripMenuItem
            // 
            this.sSASToolStripMenuItem.Name = "sSASToolStripMenuItem";
            this.sSASToolStripMenuItem.Size = new System.Drawing.Size(157, 22);
            this.sSASToolStripMenuItem.Text = "SS&AS";
            this.sSASToolStripMenuItem.Click += new System.EventHandler(this.sSASToolStripMenuItem_Click);
            // 
            // documentationToolStripMenuItem
            // 
            this.documentationToolStripMenuItem.Name = "documentationToolStripMenuItem";
            this.documentationToolStripMenuItem.Size = new System.Drawing.Size(157, 22);
            this.documentationToolStripMenuItem.Text = "&Documentation";
            // 
            // listStar
            // 
            this.listStar.AllowDrop = true;
            this.listStar.Dock = System.Windows.Forms.DockStyle.Fill;
            this.listStar.GridLines = true;
            listViewGroup6.Header = "Mobile_Phone";
            listViewGroup6.Name = "listViewGroup1";
            this.listStar.Groups.AddRange(new System.Windows.Forms.ListViewGroup[] {
            listViewGroup6});
            listViewItem11.Group = listViewGroup6;
            listViewItem11.StateImageIndex = 0;
            listViewItem12.Group = listViewGroup6;
            listViewItem12.StateImageIndex = 0;
            this.listStar.Items.AddRange(new System.Windows.Forms.ListViewItem[] {
            listViewItem11,
            listViewItem12});
            this.listStar.LabelEdit = true;
            this.listStar.Location = new System.Drawing.Point(3, 3);
            this.listStar.Name = "listStar";
            this.listStar.ShowItemToolTips = true;
            this.listStar.Size = new System.Drawing.Size(422, 359);
            this.listStar.TabIndex = 7;
            this.listStar.UseCompatibleStateImageBehavior = false;
            this.listStar.View = System.Windows.Forms.View.Details;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(701, 415);
            this.Controls.Add(this.splitContainer1);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "Form1";
            this.Text = "Hyper Star";
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.ResumeLayout(false);
            this.tabControl1.ResumeLayout(false);
            this.tabMappings.ResumeLayout(false);
            this.tabStar.ResumeLayout(false);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem testToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem transformToolStripMenuItem;
        private System.Windows.Forms.ListView listView1;
        private System.Windows.Forms.ColumnHeader columnHeader1;
        private System.Windows.Forms.ColumnHeader columnHeader2;
        private System.Windows.Forms.ToolStripMenuItem starToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem newTableToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem generateToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem allToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem starToolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem dTSXToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem sSASToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem documentationToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem sQLServerToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem mySQLToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem stageToolStripMenuItem;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabMappings;
        private System.Windows.Forms.ListView listMappings;
        private System.Windows.Forms.TabPage tabStar;
        private System.Windows.Forms.ListView listStar;
    }
}

