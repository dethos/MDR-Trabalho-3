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
import inet.nodes.internetcloud.InternetCloud;
import inet.nodes.ospfv2.OSPFRouter;
import inet.nodes.wireless.AccessPoint;
import inet.world.radio.ChannelControl;

network Trabalho3
{
    parameters:
        int numHosts;
        int numAPs=1;
        @display("bgb=829,412");
    submodules:
        hostNor[numHosts]: WirelessHost {
            @display("r=,,#707070;p=100,10");
        }
        hostSul[numHosts]: WirelessHost {
            @display("r=,,#707070;p=100,110");
        }
        apNor[numAPs]: AccessPoint {
            @display("p=150,10;r=50,,#707070");

        }
        apSul[numAPs]: AccessPoint {
            @display("p=150,110;r=50,,#707070");

        }
        configurator: IPv4NetworkConfigurator {
            config = xml("<config><interface hosts='gateway' names='eth0' address='192.168.0.1' netmask='255.255.255.0'/><interface names='eth*' address='192.168.x.x' netmask='255.255.255.0'/></config>");
            @display("p=517,32");
        }
        router: Router {
            @display("p=517,307");
        }
        socialNetwork: StandardHost {
            @display("p=638,272");
        }
        multimediaServer: StandardHost {
            @display("p=638,129");
        }
        voipServer: StandardHost {
            @display("p=638,193");
        }
        dhcpServer: StandardHost {
            @display("p=434,110");
        }
        channelControl: ChannelControl {
            @display("p=414,31");
            numChannels = 3;
        }
        switch: EtherSwitch {
            @display("p=434,192");
        }
        infoServer: StandardHost {
            @display("p=434,307");
        }

    connections:
        switch.ethg++ <--> Eth100M <--> socialNetwork.ethg++;
        switch.ethg++ <--> Eth100M <--> voipServer.ethg++;
        switch.ethg++ <--> Eth100M <--> multimediaServer.ethg++;
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
