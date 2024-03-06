using System;
using System.ComponentModel;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.IO;
using System.Xml.Serialization;
using System.Data.OleDb;

namespace HyperStar
{

    public enum TransformationType {
        Copy,
        Lookup,
        Key
    }

    public enum MappingType {
        Static,
        Changing,
        Incremental
    }

    [TypeConverter(typeof(ValuePairConverter)), DefaultProperty("Name"), Serializable()]
    public class Setting{ 
  /***conversion class for property grid***/
        internal class ValuePairConverter : ExpandableObjectConverter
        {
            public override object ConvertTo(ITypeDescriptorContext context,
                                     System.Globalization.CultureInfo culture,
                                     object value, Type destType)
            {
                if (destType == typeof(string) && value is Setting)
                {
                    Setting obj = (Setting)value;
                    return obj.Name + ": " + obj.Value;
                }
                return base.ConvertTo(context, culture, value, destType);
            }
        }

        [XmlAttribute("name"),Category("General"),Description("The name in the value pair")]
        public String Name {get;set;}
        [XmlAttribute("value"),Category("General"),Description("The value in the value pair")]
        public String Value {get;set;}
    }

    [TypeConverter(typeof(TableConverter)), DefaultProperty("Name"), Serializable()]
    public class Table
    {
        /***conversion class for property grid***/
        internal class TableConverter : ExpandableObjectConverter
        {
            public override object ConvertTo(ITypeDescriptorContext context,
                                     System.Globalization.CultureInfo culture,
                                     object value, Type destType)
            {
                if (destType == typeof(string) && value is Lookup)
                {
                    Lookup obj = (Lookup)value;
                    return obj.Destination;
                }
                return base.ConvertTo(context, culture, value, destType);
            }
        }
        //column has a name
        [XmlAttribute("name"), Category("General"), Description("The physical column name in the lookup table")]
        public String Name { get; set; }
        public Table(String Name)
        {
            this.Name = Name;
        }
        public Table() { }

    }

    public enum ValueType {
        VarChar, Int, NVarChar, Char, NChar, Float, Money, DateTime, Identity
    }

    [TypeConverter(typeof(ColumnConverter)), DefaultProperty("Name"), Serializable()]
    public class Column
    {
        /***conversion class for property grid***/
        internal class ColumnConverter : ExpandableObjectConverter
        {
            public override object ConvertTo(ITypeDescriptorContext context,
                                     System.Globalization.CultureInfo culture,
                                     object value, Type destType)
            {
                if (destType == typeof(string) && value is Lookup)
                {
                    Lookup obj = (Lookup)value;
                    return obj.Destination;
                }
                return base.ConvertTo(context, culture, value, destType);
            }
        }
        //column has a name
        [XmlAttribute("name"),Category("General"),Description("The physical column name in the lookup table")]
        public String Name {get;set;}
        [XmlAttribute("alias"),Category("General"), Description("An alias name given to the column for the purpose of the lookup")]
        public String Alias { get; set; }
        //should we ignore this column?
        [XmlAttribute("ignore"), Category("General"), Description("Is the column ignored when copying from source to target (or stage)")]
        public Boolean Ignore { get; set; }

        [XmlAttribute("type"), Category("General"), Description("An alias name given to the column for the purpose of the lookup")]
        public ValueType Type { get; set; }
        //should we ignore this column?
        [XmlAttribute("size"), Category("General"), Description("Is the column ignored when copying from source to target (or stage)")]
        public int Size { get; set; }

        public void SetType(String OleDBTypeName, int Size) {
            switch (OleDBTypeName)
            {
                case "Decimal":
                case "Double":
                    this.Type = ValueType.Float;
                    this.Size = 0;
                    break;
                case "Int32":
                case "DBTYPE_I4":
                    this.Type = ValueType.Int;
                    this.Size = 0;
                    break;
                case "String":
                case "DBTYPE_STR":
                    this.Type = ValueType.VarChar;
                    this.Size = Size;
                    break;
                case "DateTime":
                case "DBTYPE_DATE":
                    this.Type = ValueType.DateTime;
                    this.Size = 0;
                    break;

            }
        }
        public Column(String Name) {
            this.Name = Name;
        }
        public Column(String Name, String Alias) {
            this.Name = Name;
            this.Alias = Alias;
        }
        public Column(){}

    }

    public enum CreateAt {
        Stage, Package, Core
    }
    [TypeConverter(typeof(ColumnConverter)), DefaultProperty("Name"), Serializable()]
    public class DWColumn : Column
    {
        //column has a name
        //should we ignore this column?
        [XmlAttribute("default"), Category("General"), Description("Sets the default value of the column in the area of instantiation")]
        public String DefaultValue { get; set; }
        [XmlAttribute("insert"), Category("General"), Description("Sets the insert value in the area of instantiation")]
        public String InsertValue { get; set; }
        [XmlAttribute("update"), Category("General"), Description("Sets the update value for static and changing updates (only applicable to the core layer)")]
        public String UpdateValue { get; set; }
        [XmlAttribute("createat"), Category("General"), Description("Determines at what layer in the data flow this value is created (core, stage, or package)")]
        public CreateAt CreateAt { get; set; }
        [XmlAttribute("loadfilter"), Category("General"), Description("Determines if this value is also passed as a parameter to load procedures to filter the loads (for example a load id)")]
        public Boolean LoadFilter { get; set; }
        [XmlAttribute("type"), Category("General"), Description("An alias name given to the column for the purpose of the lookup")]
        public ValueType Type { get; set; }
        //should we ignore this column?
        [XmlAttribute("size"), Category("General"), Description("Is the column ignored when copying from source to target (or stage)")]
        public int Size { get; set; }

        //defines the value inserted for unknown records
        [XmlAttribute("unknown"), Category("General"), Description("The value inserted for this column when creating unknown records")]
        public String UnknownValue { get; set; }

        public DWColumn() { }

    }

    [TypeConverter(typeof(LookupConverter)), DefaultProperty("Name")]
    public class Lookup
    {
        /***conversion class for property grid***/
        internal class LookupConverter : ExpandableObjectConverter
        {
            public override object ConvertTo(ITypeDescriptorContext context,
                                     System.Globalization.CultureInfo culture,
                                     object value, Type destType)
            {
                if (destType == typeof(string) && value is Lookup)
                {
                    Lookup obj= (Lookup)value;
                    return obj.Destination;
                }
                return base.ConvertTo(context, culture, value, destType);
            }
        }

        /*transformation contains a destination and source column name from the mapping*/
        [XmlAttribute("destination"),Category("General"),Description("Lookup physical column")]
        public String Destination {get;set;} //destination table
        [XmlElement("Filter"),Category("General"),Description("Lookup filter SQL")]
        public String Filter {get;set;}
        [XmlElement("Column"),Category("Columns"), Description("Column aliases for this lookup")]
        public List<Column> Columns {get;set;} //= new List<Column>();


        public Lookup() {
            this.Columns = new List<Column>();
        }
        public Lookup Copy() {
            Lookup copy = new Lookup();
            copy.Destination = this.Destination;
            copy.Filter = this.Filter;
            for (int c = 0; c < this.Columns.Count; c++) {
                copy.Columns.Add(new Column(this.Columns[c].Name, this.Columns[c].Alias));
            }
            return copy;
        }
    }
    [XmlRoot("Transformation")]
    public class Transformation {
        /*transformation contains a destination and source column name from the mapping*/
        [XmlAttribute("source"),Category("General"), Description("Source column of the transformation")]
        public String Source { get; set; }//= new Column(); //source column
        [XmlAttribute("destination"),Category("Destination"), Description("Destination column of the transformation")]
        public String Destination {get;set;} //= new Column(); //destination column

        [XmlAttribute("outputType"), Category("Destination"), Description("Type of the output column ")]
        public ValueType OutputType { get; set; }
        //should we ignore this column?
        [XmlAttribute("outputSize"), Category("Destination"), Description("Size of the output column (ignored for date and numeric values)")]
        public int OutputSize { get; set; }

        [XmlAttribute("UnknownValue"), Category("Destination"), Description("The SQL value used for the unknown value of this column (only applicable for dimensions)")]
        public String UnknownValue { get; set; }

        [XmlAttribute("ignore"), Category("General"), Description("set to TRUE for all columns which should be ignored in checksum fucntions (SCD and Static dimension change detection)")]
        public Boolean Ignore { get; set; }

        //transformation has a type (either lookup or copy)
        [XmlAttribute("type"),Category("General"), Description("Transformation type (copy, key, or lookup)")]
        public TransformationType Type { get; set; }
        
        
        [XmlAttribute("constraint"),Category("General"),Description("Foreign table object of a constraint against the destination of this transformation")]
        public String Constraint {get;set;} //name of the table to apply constraint
        [XmlElement("Lookup")]
        public Lookup Lookup { get; set; }


        public Transformation() {
            this.Lookup = new Lookup();
        }
        public Transformation(String Source, String Destination) {
            this.Source = Source;
            this.Destination = Destination;
            this.Lookup = new Lookup();

        }
        public Transformation Copy() {
            Transformation copy = new Transformation();
            copy.Constraint = this.Constraint;
            copy.Destination = this.Destination;
            copy.Lookup = this.Lookup.Copy();
            copy.Source = this.Source;
            copy.Type = this.Type;
            copy.OutputType = this.OutputType;
            copy.OutputSize = this.OutputSize;
            return copy;
        }
    }
    [XmlRoot("Mapping")]
    public class Mapping {
        /*a mapping contains many transformations*/
        [XmlAttribute("name"),Category("General"),Description("Friendly name for the mapping")]
        public String Name {get;set;}
        [XmlAttribute("type"), Category("General"), Description("Sets the type of mapping (static dimension, changing dimension, or incremental fact)")]
        public MappingType Type { get; set; }
        [XmlAttribute("order"), Category("General"), Description("Load order of the mapping when loaded as part of a subject-area load")]
        public Double Order {get;set;}
        [XmlElement("Source"), Category("General"), Description("Source table name for the mapping")]
        public Table Source {get;set;}
        [XmlElement("Destination"),Category("General"), Description("Destination table name for the mapping")]
        public Table Destination {get;set;}
        [XmlElement("CreateIdentity"), Category("General"), Description("For static dimensions - should we create an identity column in addition to the natural key")]
        public Boolean CreateIdentity { get; set; }
        
        //this is not a property so it doesn't show in the property grid
        [XmlArray("Transformations")] public List<Transformation> Transformations = new List<Transformation>();
        
        //load a mapping from an xml node
        public Mapping() { }

        public Mapping(String Name, String Source, String Destination) {
            this.Name = Name;
            this.Source = new Table(Source);
            this.Destination = new Table(Destination);
        }

    }
    [XmlRoot("Connection")]
    public class Connection
    {
        /*a mapping contains many transformations*/
        [XmlAttribute("name"), Category("General"), Description("Friendly name for the mapping")]
        public String Name { get; set; }
        [XmlAttribute("type"), Category("General"), Description("type for the connection (for display only)")]
        public String ConnectionType { get; set; }
        [XmlElement("ConnectionString"), Category("General"), Description("Source table name for the mapping")]
        public String ConnectionString { get; set; }
        [XmlElement("StagingArea"), Category("General"), Description("Staging Area for this Connection")]
        public String StagingARea { get; set; }

        //make a copy of this connection
        public Connection Copy() {
            Connection NewConnection = new Connection();
            NewConnection.Name = "Copy of " + this.Name;
            NewConnection.ConnectionType = this.ConnectionType;
            NewConnection.ConnectionString = this.ConnectionString;
            return NewConnection;
        }

        //load a mapping from an xml node
        public Connection() { }

        public Connection(String Name,String ConnectionString )
        {
            this.Name = Name;
            this.ConnectionString = ConnectionString;
        }

    }

    [Serializable()]
    public class Settings {
        /*mapping settings*/
        [Category("SDC Settings"), XmlElement("StartDate"), Description("Effective from date column name for slowly changing dimensions")]
        public String StartDate { get; set; }
        [Category("SDC Settings"), XmlElement("EndDate"), Description("Effective through date column name for slowly changing dimensions")]
        public String EndDate { get; set; }
        [Category("SDC Settings"), XmlElement("Active"), Description("Name of column identifying active records")]
        public String Active { get; set; }
        [Category("Unknown Values"), XmlElement("UnknownKey"), Description("Default value for unknown keys (typically 0)")]
        public String UnknownKey { get; set; }
        [Category("Naming Conventions"), XmlElement("LoadProcedureNameTemplate"), Description("Default value for unknown keys (typically 0)")]
        public String LoadProcedureNameTemplate { get; set; }
        [Category("Logging"), XmlElement("StepPreSQL"), Description("Default value for unknown keys (typically 0)")]
        public String StepPreSQL { get; set; }
        [Category("Logging"), XmlElement("StepPostSQL"), Description("Default value for unknown keys (typically 0)")]
        public String StepPostSQL { get; set; }
        [Category("DW Tracking"), XmlArray("DWColumns"), Description("Default value for unknown keys (typically 0)")]
        public List<DWColumn> DWColumns { get; set; }
        [Category("Staging"), XmlElement("StagingArea"), Description("The staging area location")]
        public String StagingArea { get; set; }
        [Category("Naming Conventions"), XmlElement("ConstraintProcedureNameTemplate"), Description("Naming template for add/drop constraints, keywords: %Subject.Name%, %Operation%")]
        public String ConstraintProcedureNameTemplate { get; set; }
        [Category("General"), XmlElement("OutputPath"), Description("Output path for the project")]
        public String OutputPath { get; set; }

        [Category("More Settings"), XmlArray("Other"), Description("value pairs used in the templating engine")]
        public List<Setting> OtherSettings { get; set; }

        //get the project output path
        public String FormatOutputPath(){
            //declarations
            String results = OutputPath;
            
            //replace some keywords - that is our point here
            results = results.Replace("%desktop%", Environment.GetFolderPath(Environment.SpecialFolder.Desktop));
            results = results.Replace("%documents%", Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments));
            

            //return results
            return results;
        }
        
    }
    [XmlRoot("Project")]
    public class Project {
        /*a project contains many subject areas*/
        //[XmlArray("Subjects")] public List<Subject> Subjects = new List<Subject>();

        /*a subject area contains many mappings and many sources*/
        [Category("General"),XmlElement("Subject")]
        public String Subject { get; set; }
        [XmlArray("Mappings")]
        public List<Mapping> Mappings = new List<Mapping>();
        [XmlArray("Sources")]
        public List<Source> Sources = new List<Source>();
        [XmlArray("Connections")]
        public List<Connection> Connections = new List<Connection>();
        [XmlElement("Settings")]
        public Settings Settings { get; set; }

        //get the project output path

        //sync types between transformation and sources
        public void SyncTypes() {
            //declarations
            Source LastSource;
            Column LastColumn;

            //for each mapping
            for (int c = 0; c < this.Mappings.Count; c++) {
                //get this source
                LastSource = this.FindSource(this.Mappings[c].Source.Name);

                //if found update
                if (LastSource != null)
                {

                    //for each transformation in this mappiong
                    for (int c2 = 0; c2 < this.Mappings[c].Transformations.Count; c2++)
                    {
                        //find column
                        LastColumn = LastSource.FindColumn(this.Mappings[c].Transformations[c2].Source);

                        //if found, update
                        if (LastColumn != null)
                        {
                            this.Mappings[c].Transformations[c2].OutputType = LastColumn.Type;
                            this.Mappings[c].Transformations[c2].OutputSize = LastColumn.Size;

                        }


                    }
                }
            }

        }


        /*
        //load a project from an xml file
        public void Load(String XmlFile) {
            //our own document
            XmlDocument ProjectDoc = new XmlDocument();

            //open the file and load from it
            ProjectDoc.Load(XmlFile);
            this.Load(ProjectDoc);

            //close document
            ProjectDoc = null;
        }
         * */

        //save the project back to disk
        public static void Save(String XmlFile,Project project) {
            // Open a file and serialize the object into it in binary format.
            // EmployeeInfo.osl is the file that we are creating. 
            // Note:- you can give any extension you want for your file
            // If you use custom extensions, then the user will now 
            //   that the file is associated with your program.
            //Stream stream = File.Open(XmlFile, FileMode.Create);
            TextWriter w = new StreamWriter(XmlFile);
            try
            {
                XmlSerializer s = new XmlSerializer(typeof(Project));
                
                s.Serialize(w, project);
            }
            catch (Exception e) {
                System.Windows.Forms.MessageBox.Show(e.Message);
            }
            w.Close();
            

            //Console.WriteLine("Writing Employee Information");
            //bformatter.Serialize(stream, mp);
            //stream.Close();

        }
        
        //find a source by name
        public Source FindSource(String Name) {
            Source results = null;
            //check all sources
            for (int c = 0; c < Sources.Count; c++) {
                //is this the one?
                if (Sources[c].Name == Name){
                    results = Sources[c];
                    break;
                }
            }
            //return what we found
            return results;
        }
        //find a connection by name
        public Connection FindConnection(String Name) {
            Connection results = null;
            //look for connection by name
            for (int c = 0; c < Connections.Count; c++)
            {
                if (Connections[c].Name == Name)
                {
                    results = Connections[c];
                    break;
                }
            }
            return results;
        }
        //load from disk
        public static Project Load(String XmlFile)
        {
            Project project;
            XmlSerializer s = new XmlSerializer(typeof(Project)); 
            TextReader r = new StreamReader(XmlFile);
            project = (Project)s.Deserialize(r);
            r.Close();
            return project;
        }
        public Project() {
            this.Settings = new Settings();
        }
        
    }

    public class Source {
        //source contains a name, connection info and columns
        [Category("General"),XmlAttribute("name")] public String Name {get;set;}
        [Category("Connection"), XmlAttribute("connection")] public String Connection { get; set; }
        [Category("Connection"), XmlAttribute("table")] public String Table { get; set; }
        [Category("General"),XmlElement("Column")] public List<Column> Columns {get;set;}
        [XmlElement("Derived"), Category("General"), Description("If TRUE then no staging layer objects are generated, the data may come from a view derived from other or existing tables")]
        public Boolean Derived { get; set; }


        //return the formatted table name (with proper brackets)
        public String FormattedTable() {
            String results = this.Table;
            results = (this.Table.Contains("[")) ? results : "[" + results + "]";
            return results;
        }

        public OleDbDataReader Preview(Connection connection, int Rows) {
            OleDbConnection x = new OleDbConnection();
            OleDbDataReader r;
            x.ConnectionString = connection.ConnectionString; // "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=\"e:\\stagingfiles\\mobile\\\";Extended Properties=\"text;HDR=Yes;FMT=Delimited\"";
            x.Open();

            OleDbCommand cm = new OleDbCommand("select top 10 * from " + this.FormattedTable() + " c", x);
            r = cm.ExecuteReader();
            return r;
        }

        //find a source by name
        public Column FindColumn(String Name)
        {
            Column results = null;
            //check all sources
            for (int c = 0; c < Columns.Count; c++)
            {
                //is this the one?
                if (Columns[c].Name == Name || Columns[c].Alias == Name)
                {
                    results = Columns[c];
                    break;
                }
            }
            //return what we found
            return results;
        }
        public void LoadColumns(Connection connection)
        {
            OleDbConnection x = new OleDbConnection();
                x.ConnectionString = connection.ConnectionString; // "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=\"e:\\stagingfiles\\mobile\\\";Extended Properties=\"text;HDR=Yes;FMT=Delimited\"";
                x.Open();
                OleDbCommand cm = new OleDbCommand("select top 1 * from " + this.FormattedTable() + " c", x);
                OleDbDataReader r = cm.ExecuteReader(System.Data.CommandBehavior.SchemaOnly);
                this.Columns.Clear();
                System.Data.DataTable schema = r.GetSchemaTable();
                for (int c = 0; c < schema.Rows.Count; c++)
                {
                    //create a new column in the source based on actual column name
                    //do some simple cleanup on the column name as well
                    Column NewColumn = new Column(schema.Rows[c]["ColumnName"].ToString());
                    NewColumn.Alias = NewColumn.Name.Replace("_", " ");
                    //remove double spaces
                    while (NewColumn.Alias.Contains("  "))
                    {
                        NewColumn.Alias = NewColumn.Alias.Replace("  ", " ");
                    }
                    //trim up the string
                    Console.WriteLine(((Type)schema.Rows[c]["DataType"]).Name);
                    NewColumn.Alias = NewColumn.Alias.Trim();
                    NewColumn.SetType(((Type)schema.Rows[c]["DataType"]).Name,int.Parse(schema.Rows[c]["ColumnSize"].ToString()));
                    this.Columns.Add(NewColumn);
                }
                x.Close();

        }
        public Source() {
            Columns = new List<Column>();
        }
        public Source(String Name ) {
            this.Name = Name;
            Columns = new List<Column>();
        }
        public Source(String Name, Column[] Columns) {
            this.Name = Name;
            this.Columns = new List<Column>();
            for (int c = 0; c < Columns.Length; c++) {
                this.Columns.Add(Columns[c]);
            }
        }

        //make a copy of this source (and all its columns)
        public Source Copy()
        {
            Source NewSource = new Source();
            NewSource.Name = "Copy of " + this.Name;
            NewSource.Connection = this.Connection;
            NewSource.Table = this.Table;
            NewSource.Columns = new List<Column>();
            for (int c = 0; c < this.Columns.Count; c++) {
                NewSource.Columns.Add(new Column(this.Columns[c].Name, this.Columns[c].Alias));
            }
            return NewSource;
        }



    }

}
