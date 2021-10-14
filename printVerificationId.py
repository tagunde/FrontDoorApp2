import json
import sys

webappName = sys.argv[1]
fileName = sys.argv[2]
# Opening JSON file
f = open(fileName)
 
# returns JSON object as
# a dictionary
data = json.load(f)
 
# Iterating through the json
# list
#print(data['data'][0]['properties_customDomainVerificationId'])
for planObj in data['data']:
    if planObj['name'] == webappName:
        print(planObj['properties_customDomainVerificationId'])
        # print(planObj)
 
# Closing file
f.close()
