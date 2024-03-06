using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace HyperStar
{

    class ProjectVisualizer
    {
        Project _project;
        ListView _sources, _mappings, _star;
        public void ShowProject(Project project, ListView sources, ListView mappings, ListView star) {
            _project = project;
            _sources = sources;
            _mappings = mappings;
            _star = star;
            ShowSources(project, _sources);
            //InitMappings(_mappings);
            ShowMappings(project, _mappings);
            ShowStar(project, _star);

        }
        public void InitSources(ListView list)
        {
            //clear existing
            list.Items.Clear();
            list.Groups.Clear();
        }
        public void ShowSources(Project subject, ListView list)
        {
            //init first
            InitSources(list);

            //create a group for each source
            for (int c = 0; c < subject.Sources.Count; c++)
            {
                //create a group for this source and save for use
                ListViewGroup newGroup = list.Groups[list.Groups.Add(new ListViewGroup(subject.Sources[c].Name))];
                newGroup.Tag = subject.Sources[c];
                //add columns as items in the group
                for (int c2 = 0; c2 < subject.Sources[c].Columns.Count; c2++)
                {
                    ListViewItem newItem = new ListViewItem(subject.Sources[c].Columns[c2].Alias, newGroup);
                    newItem.Tag = subject.Sources[c].Columns[c2];
                    list.Items.Add(newItem);
                }

            }

        }

        public void InitMappings(ListView list)
        {
            //clear existing
            list.Items.Clear();
            list.Groups.Clear();
            list.Columns.Clear();

            //setup columns
            list.Columns.Add("Destination");
            list.Columns.Add("Source");
        }
        private ListViewGroup FindGroupByTag(ListView list, Object tag)
        {
            ListViewGroup results = null;
            for (int c = 0; c < list.Groups.Count; c++)
            {   
                if  (   ( list.Groups[c].Tag.GetType() == typeof(String) && list.Groups[c].Tag.ToString() == tag.ToString() ) || 
                        ( list.Groups[c].Tag.GetType() != typeof(String) && list.Groups[c].Tag == tag )
                    )
                {
                    results = list.Groups[c];
                    c = list.Groups.Count;
                }
            }
            return results;
        }
        private ListViewItem FindItemByTag(ListView list, Object tag)
        {
            ListViewItem results = null;
            for (int c = 0; c < list.Items.Count; c++)
            {
                if ((list.Items[c].Tag.GetType() == typeof(String) && list.Items[c].Tag.ToString() == tag.ToString()) ||
                        (list.Items[c].Tag.GetType() != typeof(String) && list.Items[c].Tag == tag)
                    )
                {
                    results = list.Items[c];
                    c = list.Items.Count;
                }
            }
            return results;
        }

        public void SyncMappings(Project subject, ListView list)
        {
            //create a group for each source
            for (int c = 0; c < subject.Mappings.Count; c++)
            {

                //create a group for this mapping and save for use
                ListViewGroup newGroup = FindGroupByTag(list, subject.Mappings[c]);

                //create groups for new mappings
                if (newGroup == null)
                {
                    newGroup = list.Groups[list.Groups.Add(new ListViewGroup(subject.Mappings[c].Name))];
                    //link back for ease
                    newGroup.Tag = subject.Mappings[c];
                }
                else {
                    //update name
                    newGroup.Header = ((Mapping)newGroup.Tag).Name;
                }


                //add transformations as items in the group
                for (int c2 = 0; c2 < subject.Mappings[c].Transformations.Count; c2++)
                {
                    //find existing item
                    ListViewItem newItem = FindItemByTag(list, subject.Mappings[c].Transformations[c2]);

                    //create if needed
                    if (newItem == null)
                    {
                        newItem = list.Items.Add(new ListViewItem(subject.Mappings[c].Transformations[c2].Destination, newGroup));
                        newItem.SubItems.Add(subject.Mappings[c].Transformations[c2].Source);
                        //link back for ease
                        newItem.Tag = subject.Mappings[c].Transformations[c2];
                    }
                    //otherwise make sure the names are in sync
                    else
                    {
                        newItem.Text = ((Transformation)newItem.Tag).Destination;
                        newItem.SubItems[1].Text = ((Transformation)newItem.Tag).Source;
                    }



                }

            }
        }
        public void ShowMappings(Project subject, ListView list)
        {
            //init for mappings
            InitMappings(list);

            //now sync mappings
            SyncMappings(subject, list);


        }
        public void SyncStar(Project subject, ListView list)
        {
            //create a group for each source
            for (int c = 0; c < subject.Mappings.Count; c++)
            {

                //create a group for this mapping and save for use
                ListViewGroup newGroup = FindGroupByTag(list, subject.Mappings[c].Destination);

                //create groups for new mappings
                if (newGroup == null)
                {
                    newGroup = list.Groups[list.Groups.Add(new ListViewGroup(subject.Mappings[c].Destination.Name))];
                    //link back for ease
                    newGroup.Tag = subject.Mappings[c].Destination;
                }


                //add transformations as items in the group
                for (int c2 = 0; c2 < subject.Mappings[c].Transformations.Count; c2++)
                {
                    //find existing item
                    ListViewItem newItem = FindItemByTag(list, subject.Mappings[c].Transformations[c2].Destination);

                    //create if needed
                    if (newItem == null)
                    {
                        newItem = list.Items.Add(new ListViewItem(subject.Mappings[c].Transformations[c2].Destination, newGroup));
                        newItem.SubItems.Add(subject.Mappings[c].Transformations[c2].Source);
                        //link back for ease
                        newItem.Tag = subject.Mappings[c].Transformations[c2].Destination;
                    }



                }

            }
        }
        public void ShowStar(Project subject, ListView list)
        {
            //init for mappings
            InitMappings(list);

            //sync star
            SyncStar(subject, list);
        }

    }

}
