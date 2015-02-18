#!/bin/sh

# Copyright 2015 NEC Corporation.                                          #
#                                                                          #
# Licensed under the Apache License, Version 2.0 (the "License");          #
# you may not use this file except in compliance with the License.         #
# You may obtain a copy of the License at                                  #
#                                                                          #
#   http://www.apache.org/licenses/LICENSE-2.0                             #
#                                                                          #
# Unless required by applicable law or agreed to in writing, software      #
# distributed under the License is distributed on an "AS IS" BASIS,        #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
# See the License for the specific language governing permissions and      #
# limitations under the License.                                           #

## remove proxy
unset http_proxy

FORMAT="\n%{url_effective}, %{response_code}\n\n"

ADDRESS=127.0.0.1

# (network1) ---- [Aggregator] ----  (network0) 

# create NetworkComponent , Aggregator 
#curl http://$ADDRESS:10080/systemmanager/component_managers | python -mjson.tool
curl -w "$FORMAT" http://$ADDRESS:10080/systemmanager/components/network0 -X PUT -d '{"type": "Network", "id": "network0", "cm_id": "romgr1"}'
curl -w "$FORMAT" http://$ADDRESS:10080/systemmanager/components/network1 -X PUT -d '{"type": "Network", "id": "network1", "cm_id": "romgr1"}'
curl -w "$FORMAT" http://$ADDRESS:10080/systemmanager/components/aggre -X PUT -d '{"type": "Aggregator", "id": "aggre", "cm_id": "romgr1"}'
curl http://$ADDRESS:10080/systemmanager/components | python -mjson.tool

# connect Components
curl -w "$FORMAT" http://$ADDRESS:10080/systemmanager/connections/aggregated -X PUT -d '{"id": "aggregated", "type": "LogicAndNetwork", "connection_type": "aggregated", "logic_id": "aggre", "network_id":"network1"}'
curl -w "$FORMAT" http://$ADDRESS:10080/systemmanager/connections/original -X PUT -d '{"id": "original", "type": "LogicAndNetwork", "connection_type": "original", "logic_id": "aggre", "network_id":"network0"}'
curl http://$ADDRESS:10080/systemmanager/connections | python -mjson.tool

# make Topology

sleep 1
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node001 -X PUT -d '{"node_id": "node001", "type": "Node", "version": "0", "ports": {}, "attributes": {"physical_id":"001", "oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node002 -X PUT -d '{"node_id": "node002", "type": "Node", "version": "0", "ports": {}, "attributes": {"physical_id":"002", "oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node003 -X PUT -d '{"node_id": "node003", "type": "Node", "version": "0", "ports": {}, "attributes": {"physical_id":"003"}}'
sleep 1
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node001/ports/port0011 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node001", "port_id": "port0011", "out_link": null, "in_link": null, "attributes": {"physical_id":"0011@001", "oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node001/ports/port0012 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node001", "port_id": "port0012", "out_link": null, "in_link": null, "attributes": {"physical_id":"0012@001", "oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node001/ports/port0013 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node001", "port_id": "port0013", "out_link": null, "in_link": null, "attributes": {"physical_id":"0013@001", "oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node002/ports/port0021 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node002", "port_id": "port0021", "out_link": null, "in_link": null, "attributes": {"physical_id":"0021@002", "oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node002/ports/port0022 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node002", "port_id": "port0022", "out_link": null, "in_link": null, "attributes": {"physical_id":"0022@002", "oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node002/ports/port0023 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node002", "port_id": "port0023", "out_link": null, "in_link": null, "attributes": {"physical_id":"0023@002", "oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node002/ports/port0024 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node002", "port_id": "port0024", "out_link": null, "in_link": null, "attributes": {"physical_id":"0024@002", "oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node003/ports/port0031 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node003", "port_id": "port0031", "out_link": null, "in_link": null, "attributes": {"physical_id":"0031@003"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node003/ports/port0032 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node003", "port_id": "port0032", "out_link": null, "in_link": null, "attributes": {"physical_id":"0032@003"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/nodes/node003/ports/port0033 -X PUT -d '{"type": "Port", "version": "0", "node_id": "node003", "port_id": "port0033", "out_link": null, "in_link": null, "attributes": {"physical_id":"0033@003"}}'
sleep 1
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/links/link0012 -X PUT -d '{"type": "Link", "version": "0", "link_id": "link0012", "src_node": "node001", "src_port": "port0012", "dst_node": "node002", "dst_port": "port0021", "attributes": {"oper_status":"UP", "cost":"0"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/links/link0021 -X PUT -d '{"type": "Link", "version": "0", "link_id": "link0021", "src_node": "node002", "src_port": "port0021", "dst_node": "node001", "dst_port": "port0012", "attributes": {"oper_status":"UP", "cost":"0"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/links/link0023 -X PUT -d '{"type": "Link", "version": "0", "link_id": "link0023", "src_node": "node002", "src_port": "port0022", "dst_node": "node003", "dst_port": "port0031", "attributes": {"oper_status":"UP"}}'
curl -w "$FORMAT" http://$ADDRESS:10080/network0/topology/links/link0032 -X PUT -d '{"type": "Link", "version": "0", "link_id": "link0032", "src_node": "node003", "src_port": "port0031", "dst_node": "node002", "dst_port": "port0022", "attributes": {"oper_status":"UP"}}'

sleep 1
echo "------ original network -------" 
curl http://$ADDRESS:10080/systemmanager/components/network0/topology -X GET | python -mjson.tool
echo "------ aggregated network -------" 
curl http://$ADDRESS:10080/systemmanager/components/network1/topology -X GET | python -mjson.tool

sleep 1
echo "------ POST Flow (to aggregated network) -------" 
curl -w "$FORMAT" http://localhost:10080/network1/flows -X POST -d '{"version":"0","flow_id":"flow01","owner":"logic","enabled":true,"status":"establishing","attributes":{"bandwidth":"0", "req_bandwidth":"0", "latency":"0"},"type":"OFPFlow","idle_timeout":60,"hard_timeout":60,"matches":[{"type":"OFPFlowMatch","in_node":"aggre","in_port":"node001_port0011","eth_src":"ff:aa:ff:aa:ff:aa","eth_dst":"bb:ff:bb:ff:bb:ff","vlan_vid":0,"vlan_pcp":0,"eth_type":2048,"ip_proto":6,"ipv4_src":"10.0.0.1","ipv4_dst":"10.0.0.2","tcp_src":10000,"tcp_dst":10001}],"path":["link0012","link0023"],"edge_actions":{"node1":[{"type":"FlowActionOutput","output":"node003_port0033"},{"type":"OFPFlowActionSetField","match": {"type":"OFPFlowMatch","eth_src":"ab:ff:ab:ff:ab:ff"}}]}}'
curl -w "$FORMAT" http://localhost:10080/network1/flows -X POST -d '{"version":"0","flow_id":"flow02","owner":"logic","enabled":true,"status":"established","attributes":{"latency":"0", "req_latency":"0", "bandwidth":"0"},"type":"OFPFlow","idle_timeout":90,"hard_timeout":90,"matches":[{"type":"OFPFlowMatch","in_node":"aggre","in_port":"node003_port0033","eth_src":"bb:ff:bb:ff:bb:ff","eth_dst":"ff:aa:ff:aa:ff:aa","vlan_vid":0,"vlan_pcp":0,"eth_type":2048,"ip_proto":6,"ipv4_src":"10.0.0.2","ipv4_dst":"10.0.0.1","tcp_src":10000,"tcp_dst":10001}],"path":["link0032","link0021"],"edge_actions":{"node1":[{"type":"FlowActionOutput","output":"node001_port0011"},{"type":"OFPFlowActionSetField","match": {"type":"OFPFlowMatch","eth_src":"ff:ab:ff:ab:ff:ab"}}]}}'

echo "------ PUT Flow (to aggregated network) -------" 
curl -w "$FORMAT" http://localhost:10080/network1/flows/flow03 -X PUT -d '{"version":"0","flow_id":"flow03","owner":"logic","enabled":true,"status":"established","attributes":{"bandwidth":"0", "req_bandwidth":"0", "latency":"0"},"type":"OFPFlow","idle_timeout":60,"hard_timeout":60,"matches":[{"type":"OFPFlowMatch","in_node":"aggre","in_port":"node001_port0011","eth_src":"ff:aa:ff:aa:ff:aa","eth_dst":"bb:ff:bb:ff:bb:ff","vlan_vid":0,"vlan_pcp":0,"eth_type":2048,"ip_proto":6,"ipv4_src":"10.0.0.1","ipv4_dst":"10.0.0.2","tcp_src":10000,"tcp_dst":10001}],"path":["link0012","link0023"],"edge_actions":{"node1":[{"type":"FlowActionOutput","output":"node003_port0033"}, {"type":"OFPFlowActionSetField","match": {"type":"OFPFlowMatch","eth_src":"ab:ff:ab:ff:ab:ff"}}]}}'
curl -w "$FORMAT" http://localhost:10080/network1/flows/flow04 -X PUT -d '{"version":"0","flow_id":"flow04","owner":"logic","enabled":true,"status":"establishing","attributes":{"latency":"0", "req_latency":"0", "bandwidth":"0"},"type":"OFPFlow","idle_timeout":90,"hard_timeout":90,"matches":[{"type":"OFPFlowMatch","in_node":"aggre","in_port":"node003_port0033","eth_src":"bb:ff:bb:ff:bb:ff","eth_dst":"ff:aa:ff:aa:ff:aa","vlan_vid":0,"vlan_pcp":0,"eth_type":2048,"ip_proto":6,"ipv4_src":"10.0.0.2","ipv4_dst":"10.0.0.1","tcp_src":10000,"tcp_dst":10001}],"path":["link0032","link0021"],"edge_actions":{"node1":[{"type":"FlowActionOutput","output":"node001_port0011"},{"type":"OFPFlowActionSetField","match": {"type":"OFPFlowMatch","eth_src":"ff:ab:ff:ab:ff:ab"}}]}}'


sleep 2 
echo "---------------- flow (network0)-------------------"
curl http://$ADDRESS:10080/systemmanager/components/network0/flows -X GET | python -mjson.tool
echo "---------------- flow (network1)-------------------"
curl http://$ADDRESS:10080/systemmanager/components/network1/flows -X GET | python -mjson.tool

echo ""
echo "*************************************************"
echo "***************[ Result ]************************"
echo "*************************************************"
echo ""

echo "/////////////////////////////////////////////////"
echo "//////////////// search Flow (to original network) ////////////////////"
echo "/////////////////////////////////////////////////"
curl -w "$FORMAT" http://$ADDRESS:10080/network0/flows?'type=OFPFlow' -X GET
curl -w "$FORMAT" http://$ADDRESS:10080/network0/flows?'type=OFPFlow&attributes="bandwidth=0,req_bandwidth=0"' -X GET
curl -w "$FORMAT" http://$ADDRESS:10080/network0/flows?'type=OFPFlow&attributes="latency=0"' -X GET
curl -w "$FORMAT" http://$ADDRESS:10080/network0/flows?'type=OFPFlow&enabled=true&match="type=OFPFlowMatch,in_node=node001"&path="link_id=link0012"' -X GET
curl -w "$FORMAT" http://$ADDRESS:10080/network0/flows?'type=OFPFlow&actions="type=FlowActionOutput,edge_node=node001,output=port0011"' -X GET
curl -w "$FORMAT" http://$ADDRESS:10080/network0/flows?'type=OFPFlow&actions="type=OFPFlowActionSetField,eth_src=ab:ff:ab:ff:ab:ff"&actions="type=FlowActionOutput,edge_node=node001,output=port0011"' -X GET
curl -w "$FORMAT" http://$ADDRESS:10080/network0/flows?'type=OFPFlow&match="type=OFPFlowMatch,in_node=node001"&path="link_id=link0012"&actions="type=OFPFlowActionSetField,eth_src=ab:ff:ab:ff:ab:ff"&attributes="latency=0"' -X GET
