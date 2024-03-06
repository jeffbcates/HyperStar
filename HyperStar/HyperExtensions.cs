using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HyperStar
{
    public class HyperExtensions{
        //test function
        public String test(){
            return "hi from c#";
        }

        //generate a guid for a value name
        private class ValueGUID {
            String Name = "";
            String GUID = "";

        }
        //private Lookup<String, String> Guids = new Lookup<string, string>();
        private Dictionary<String, String> Guids = new Dictionary<string, string>();
        public String Guid(String ValueName) {
            //declarations
            String results = null;

            //add guid if needed
            try {
                results = Guids[ValueName];
            } catch (Exception ex) {
                //don't care
            }
            if (results == null) {
                results = "{" + System.Guid.NewGuid().ToString() + "}";
                Guids.Add(ValueName, results);
            }

            //return that result
            return results;
        }

        //table name only (when table and column are concatenated)
        public String ConstraintColumn(String Constraint, String ForeignKey) {
            //declarations
            String results = ForeignKey;

            //if constraint has a period then use second half
            //otherwise we assume it is the foreign key value
            if (Constraint.Contains(".")) {
                //get the second half of the string
                results = Constraint.Substring(Constraint.IndexOf(".")+1);
            }

            //return what we found
            return results;
        }

        //column name only (when table and column are concatenated)
        public String ConstraintTable(String Constraint, String ForeignKey)
        {
            //declarations
            String results = Constraint;

            //if constraint has a period then use second half
            //otherwise we assume it is the foreign key value
            if (Constraint.Contains("."))
            {
                //get the second half of the string
                results = Constraint.Substring(0,Constraint.IndexOf("."));
            }

            //return what we found
            return results;
        }


        //return a full column name (optionally with table name)
        public String FullColumnName(String Column, String Table) {
            //declarations
            String results = Column;

            //if the column name contains a period
            //then we should use the existing name as-is it is probably a function
            //or a fully qualified column and table name
            if (! ( results.Contains(".") || results.Contains("[") ) ) {
                results = "[" + results + "]";
                
                //if a table was specified, add that too
                if (Table.Length > 0) results = Table + "." + results;
            }

            //return the results
            return results;
        }

        //replace all instances of a string
        public String ReplaceAll(String Text, String OldValue, String NewValue) {
            return Text.Replace(OldValue, NewValue);
        }

        //return a column type definition
        public String ColumnType(String Type, String Size, String Nullable) {
            //declarations
            String results = "";

            //set the type name
            results = (Type == "Identity") ? "[Int] Identity(1,1)" : "[" + Type + "]";

            //add size for types with a size
            if ("Varchar,NVarChar,Char,NChar".Contains(Type)) {
                //convert "0" and "2147483647" size to "max"
                results += " (" + ((Size == "0" || Size == "2147483647")?"max":Size) + ")";
            }

            //set nullability (identity cannot be null)
            results += (Type == "Identity") ? " NOT NULL " : " " + Nullable;

            //return
            return results;
        }
    }
}