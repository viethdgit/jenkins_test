import requests
import json
url='http://192.168.142.216:8081/api/v4/projects/2/repository/commits/master'
# url='http://192.168.142.216:8081/api/v4/projects/2/repository/commits/4dca15ba8d95bdfbb01d766a6efa3f8a84f87297/refs?type=all'
header={
	'PRIVATE-TOKEN': 'sqY469d68-3AXmv39Q9v',
	# 'Content-Type': 'application/json'
}
resp=requests.request(method="GET", url=url,headers=header)
parsed = json.loads(resp.text)
a= (parsed['parent_ids'][0])
id_=""
while 1:
	url='http://192.168.142.216:8081/api/v4/projects/2/repository/commits/%s'%a
	# url='http://192.168.142.216:8081/api/v4/projects/2/repository/commits/e7e83d73dcb6f848f8f6ed982a0eb76538807690/refs?type=all'
	resp=requests.request(method="GET", url=url, headers=header)
	# //"status": "success",
	#http://192.168.142.216/viethd/nhansinhnhumong/-/archive/ee26daae889067659dfc0dd1c6c865982bce6d6f/nhansinhnhumong-ee26daae889067659dfc0dd1c6c865982bce6d6f.zip
	parsed = json.loads(resp.text)

	if parsed["last_pipeline"]["status"] == "success":
		print(json.dumps(parsed, indent=4, sort_keys=True))
		id_=parsed["id"]
		break
	else:
		a=parsed["parent_ids"][0]
		continue
		# print (a[0])
# print (a)

url="http://192.168.142.216/viethd/nhansinhnhumong/-/archive/%s/nhansinhnhumong-%s.zip"%(id_,id_)
# resp=requests.request(method="GET", url=url, headers=header)
print (url)