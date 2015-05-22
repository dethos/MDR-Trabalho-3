package trabalho3.simulations;

@license(LGPL);

import inet.nodes.ethernet.Eth100G;
import inet.nodes.ethernet.Eth100M;
import inet.applications.dhcp.DHCPServer;
import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;
import inet.nodes.bgp.BGPRouter;
import inet.nodes.ethernet.EtherSwitch;
import inet.nodes.inet.Router;
import inet.nodes.inet.StandardHost;
import inet.nodes.inet.WirelessHost;
import inet.nodes.ospfv2.OSPFRouter;
import inet.nodes.wireless.AccessPoint;
import inet.world.radio.ChannelControl;

network Trabalho3
{
    parameters:
        int numHosts;
        int numAPs;
    submodules:
        host[numHosts]: WirelessHost {
            @display("r=,,#707070;p=56,359");
        }
        ap[numAPs]: AccessPoint {
            @display("p=197,256;r=,,#707070");

        }
        configurator: IPv4NetworkConfigurator {
            config = xml("<config><interface hosts='gateway' names='eth0' address='192.168.0.1' netmask='255.255.255.0'/><interface names='eth*' address='192.168.x.x' netmask='255.255.255.0'/></config>");
            @display("p=214,31");
        }
        router: Router {
            @display("p=367,103");
        }
        standardHost: StandardHost {
            @display("p=664,222");
        }
        dhcpServer: StandardHost {
            @display("p=56,31");
        }
        channelControl: ChannelControl {
            @display("p=309,30");
            numChannels = 3;
        }
        switch: EtherSwitch {
            @display("p=245,131");
        }
    connections:
        router.ethg++ <--> Eth100G <--> standardHost.ethg++;
        for i=0..numAPs-1 {
            switch.ethg++ <--> Eth100M <--> ap[i].ethg++;
        }
        dhcpServer.ethg++ <--> Eth100M <--> switch.ethg++;
        router.ethg++ <--> Eth100M <--> switch.ethg++;

}
