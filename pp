install_node_exporter(){
nodeIP=`hostname -I | awk '{print $1}'|awk -F. '{print $1"."$2"."$3"."$4""}'`
nodehostname=`hostname`
rpm -qa|grep node_exporter
if [[ $? != 0 ]]; then
yum install -y http://file.abcmoreonline.com:9899/script/node_exporter-0.18.1-1.x86_64.rpm -y
fi
systemctl daemon-reload
systemctl restart node_exporter.service
systemctl enable node_exporter.service
# curl -X PUT -d '{"id": "'$nodeIP'","name": "'$nodehostname'","address": "'$nodeIP'","port": 9100,"tags": ["node"],"checks": [{"http": "http://'$nodeIP':9100/metrics","interval": "5s"}]}' http://10.8.243.200:8500/v1/agent/service/register
# curl -X PUT -d '{"id": "'$nodeIP'","name": "'$nodehostname'","address": "'$nodeIP'","port": 9100,"tags": ["node"],"Meta": {"app": "test","prod": "uat"},"checks": [{"http": "http://'$nodeIP':9100/metrics","interval": "5s"}]}' http://10.8.243.200:8500/v1/agent/service/register
}
