MYSQL_SERVER_NAME=mysql-$APPNAME-$UNIQUEID
MYSQL_ADMIN_USERNAME=myadmin
MYSQL_ADMIN_PASSWORD=My5up3rStr0ngPaSw0rd!
DATABASE_NAME=petclinic
      
az mysql flexible-server create \
    --admin-user myadmin \
    --admin-password ${MYSQL_ADMIN_PASSWORD} \
    --name ${MYSQL_SERVER_NAME} \
    --resource-group ${RESOURCE_GROUP} 

# Output
# Try using az 'mysql flexible-server connect' command to test out connection.
# {
#   "connectionString": "mysql flexibleserverdb --host mysql-petclinic-0849f2.mysql.database.azure.com --user myadmin --password=My5up3rStr0ngPaSw0rd!",
#   "databaseName": "flexibleserverdb",
#   "host": "mysql-petclinic-0849f2.mysql.database.azure.com",
#   "id": "/subscriptions/e8ae8ad0-8a4c-4ed0-96be-f7f3e19678db/resourceGroups/rg-petclinic-0849f2/providers/Microsoft.DBforMySQL/flexibleServers/mysql-petclinic-0849f2",
#   "location": "East US",
#   "password": "My5up3rStr0ngPaSw0rd!",
#   "resourceGroup": "rg-petclinic-0849f2",
#   "skuname": "Standard_B1ms",
#   "username": "myadmin",
#   "version": "5.7"
# }

# Create a database in the server
az mysql flexible-server db create \
     --server-name $MYSQL_SERVER_NAME \
     --resource-group $RESOURCE_GROUP \
     -d $DATABASE_NAME

# Creating database with utf8 charset and utf8_general_ci collation
# {
#   "charset": "utf8",
#   "collation": "utf8_general_ci",
#   "id": "/subscriptions/e8ae8ad0-8a4c-4ed0-96be-f7f3e19678db/resourceGroups/rg-petclinic-0849f2/providers/Microsoft.DBforMySQL/flexibleServers/mysql-petclinic-0849f2/databases/petclinic",
#   "name": "petclinic",
#   "resourceGroup": "rg-petclinic-0849f2",
#   "systemData": null,
#   "type": "Microsoft.DBforMySQL/flexibleServers/databases"
# }

# Create a firewall rule for the server
 az mysql flexible-server firewall-rule create \
     --rule-name allAzureIPs \
     --name ${MYSQL_SERVER_NAME} \
     --resource-group ${RESOURCE_GROUP} \
     --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

# Output
# #{
#   "endIpAddress": "0.0.0.0",
#   "id": "/subscriptions/e8ae8ad0-8a4c-4ed0-96be-f7f3e19678db/resourceGroups/rg-petclinic-0849f2/providers/Microsoft.DBforMySQL/flexibleServers/mysql-petclinic-0849f2/firewallRules/allAzureIPs",
#   "name": "allAzureIPs",
#   "resourceGroup": "rg-petclinic-0849f2",
#   "startIpAddress": "0.0.0.0",
#   "systemData": null,
#   "type": "Microsoft.DBforMySQL/flexibleServers/firewallRules"
# }


