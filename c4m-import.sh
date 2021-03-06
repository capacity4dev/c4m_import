#!/bin/bash

# --------------------------------------------------------------------------- #
# Script to import all data but stop after the groups.
# --------------------------------------------------------------------------- #



# Helper function to stop the process early.
function quit_early {
  echo
  echo "-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-"
  echo "-x-                          QUIT EARLY                               -x-"
  echo "-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-"
  echo
  
  exit 0
}



# Make sure no demo content module enabled.
drush -y dis c4m_demo

# Replace admin_menu by default toolbar.
drush -y dis admin_menu
drush -y en toolbar
echo

# Make sure that migrate detected all migration scripts.
drush ms
echo


# Users & Roles
echo "Users & Roles"
drush mi --instrument --feedback="30 seconds" C4dMigrateImportRoles
drush mi --instrument --feedback="30 seconds" C4dMigrateImportUsers
echo

# Topics
echo "Topics"
drush mi --instrument --feedback="30 seconds" C4dMigrateCreateCSVTermTopic

# Content outside groups
echo "Content outside groups"
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeArticle
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeBookPage
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeHelpPage

# Organisations
drush mi --instrument --feedback="30 seconds" C4dMigrateCreateCSVNodeOrganisations

# Groups & Projects
echo "Groups & Projects"
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeGroup
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeProject
drush mi --instrument --feedback="30 seconds" C4dMigrateImportOGFeatures
drush mi --instrument --feedback="30 seconds" C4dMigrateImportOGMemberships
drush mi --instrument --feedback="30 seconds" C4dMigrateImportOGUserRoles

# Group & Project vocabularies
drush mi --instrument --feedback="30 seconds" C4dMigrateImportVocabOGCategories
drush mi --instrument --feedback="30 seconds" C4dMigrateImportVocabOGTags

# Topics nodes
echo "Content types that need Groups"
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeTopic
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeFeed


# Content inside groups
echo "Content within Groups & Projects"
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeOGDocument
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeOGMinisite
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeOGDiscussion
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeOGEvent
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeOGPhotoalbum
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeOGPhoto
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeOGTasklist
drush mi --instrument --feedback="30 seconds" C4dMigrateImportNodeOGTask

# Comments
drush mi --instrument --feedback="30 seconds" C4dMigrateImportCommentArticle
drush mi --instrument --feedback="30 seconds" C4dMigrateImportCommentOGDocument
drush mi --instrument --feedback="30 seconds" C4dMigrateImportCommentOGMinisite
drush mi --instrument --feedback="30 seconds" C4dMigrateImportCommentOGDiscussion
drush mi --instrument --feedback="30 seconds" C4dMigrateImportCommentOGEvent
drush mi --instrument --feedback="30 seconds" C4dMigrateImportCommentOGPhotoalbum
drush mi --instrument --feedback="30 seconds" C4dMigrateImportCommentOGTask



echo
echo "#########################################################################"
echo "#                             COMPLETE                                  #"
echo "#########################################################################"
echo
exit 0
