package trabalho3.simulations;

@license(LGPL);

import inet.nodes.ethernet.Eth100G;
import inet.nodes.ethernet.Eth100M;
import inet.applications.dhcp.DHCPServer;
import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;
import inet.nodes.bgp.BGPRouter;
import inet.nodes.ethernet.EtherHost;
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
        hostNor[numHosts]: WirelessHost {
            @display("r=100,,#707070;p=146,31");
        }
        hostSul[numHosts]: WirelessHost {
            @display("r=100,,#707070;p=146,348");
        }
        apNor[numAPs]: AccessPoint {
            @display("p=269,30;r=100,,#707070");

        }
        apSul[numAPs]: AccessPoint {
            @display("p=269,349;r=100,,#707070");

        }
        configurator: IPv4NetworkConfigurator {
            config = xml("<config><interface hosts='gateway' names='eth0' address='192.168.0.1' netmask='255.255.255.0'/><interface names='eth*' address='192.168.x.x' netmask='255.255.255.0'/></config>");
            @display("p=559,31");
        }
        router: Router {
            @display("p=719,128");
        }
        socialNetwork: StandardHost {
            @display("p=1006,333");
        }
        multimediaServer: StandardHost {
            @display("p=1006,70");
        }
        voipServer: StandardHost {
            @display("p=1006,193");
        }
        dhcpServer: StandardHost {
            @display("p=637,31");
        }
        channelControl: ChannelControl {
            @display("p=728,30");
            numChannels = 3;
        }
        switch: EtherSwitch {
            @display("p=637,125");
        }
        infoServer: StandardHost {
            @display("p=637,333");
        }
    connections:
        router.ethg++ <--> Eth100G <--> socialNetwork.ethg++;
        router.ethg++ <--> Eth100G <--> multimediaServer.ethg++;
        router.ethg++ <--> Eth100G <--> voipServer.ethg++;
        for i=0..numAPs-1 {
            switch.ethg++ <--> Eth100M <--> apNor[i].ethg++;
        }
        for i=0..numAPs-1 {
            switch.ethg++ <--> Eth100M <--> apSul[i].ethg++;
        }
        dhcpServer.ethg++ <--> Eth100M <--> switch.ethg++;
        router.ethg++ <--> Eth100M <--> switch.ethg++;
        infoServer.ethg++ <--> Eth100M <--> switch.ethg++;
}
