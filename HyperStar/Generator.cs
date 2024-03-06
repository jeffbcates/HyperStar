using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.Serialization;
using System.IO;
using System.Windows.Forms;


namespace HyperStar
{

    [XmlRoot("Configuration")]
    public class Configuration
    {
        /*a project contains many subject areas*/
        //[XmlArray("Subjects")] public List<Subject> Subjects = new List<Subject>();

        /*list of generators*/
        [XmlElement("WorkingPath")]
        public String WorkingPath { get; set; }

        [XmlArray("Generators")]
        public List<Generator> Generators = new List<Generator>();

        //load from disk
        public static Configuration Load(String XmlFile)
        {
            Configuration config;
            XmlSerializer s = new XmlSerializer(typeof(Configuration));
            TextReader r = new StreamReader(XmlFile);
            config = (Configuration)s.Deserialize(r);
            r.Close();
            return config;
        }
        public Configuration()
        {
        }

    }

    public class Generator
    {
        [XmlAttribute("name")]
        public String Name { get; set; }
        [XmlAttribute("file")]
        public String GeneratorFile { get; set; }
        [XmlAttribute("output")]
        public String OutputFolder { get; set; }

        public void Generate(String ProjectFile, String Path)
        {
            //add our path
            Path = Path + "\\" + OutputFolder + "\\";
            //create path if not exists
            if (!Directory.Exists(Path)) Directory.CreateDirectory(Path);
            
            //load trasnformation for this generator
            String TempFile = Application.StartupPath + "\\temp.xml";
            XslTransform xs = new XslTransform();

            xs.Load(Application.StartupPath + "\\" + GeneratorFile);

            XmlDocument inDoc = new XmlDocument();
            inDoc.Load(ProjectFile);

            //create the output stream
            XmlTextWriter myWriter = new XmlTextWriter(TempFile, null);

            //add our custom extensions
            XsltArgumentList xslArgs = new XsltArgumentList();

            //create custom object
            HyperExtensions extensions = new HyperExtensions();

            //pass an instance of the custom object
            xslArgs.AddExtensionObject("urn:HyperStarExtensions", extensions);


            //transform to a temp file
            //pass the args,do the actual transform of Xml
            xs.Transform(inDoc, xslArgs, myWriter);

            myWriter.Close();


            //xs.Transform(ProjectFile,xslArgs,TempFile);

            //load the temp file
            XmlDocument results = new XmlDocument();
            results.Load(TempFile);
            TextWriter Out;
            XmlNode OutputNode = results.ChildNodes[0];
            //step through each output file in the results and save it
            for (int c = 0; c < OutputNode.ChildNodes.Count; c++) {
                //this should be an output file with a path
                Out = new StreamWriter(Path + OutputNode.ChildNodes[c].Attributes["name"].Value);
                Out.Write(OutputNode.ChildNodes[c].InnerXml.Replace("&gt;",">").Replace("&lt;","<"));
                Out.Close();
            }
            

        }

    }
}
