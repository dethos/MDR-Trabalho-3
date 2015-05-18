package trabalho3.simulations;

@license(LGPL);

import inet.networklayer.autorouting.ipv4.IPv4NetworkConfigurator;
import inet.nodes.inet.WirelessHost;
import inet.nodes.wireless.AccessPoint;
import inet.world.radio.ChannelControl;

network Lan80211
{
    parameters:
        int numHosts;
        int numAPs;
    submodules:
    	host[numHosts]: WirelessHost {
            @display("r=,,#707070");
            wlan[*].mgmtType = "Ieee80211MgmtSTASimplified";
        }
        ap[numAPs]: AccessPoint {
            @display("p=213,174;r=,,#707070");
            wlan[*].mgmtType = "Ieee80211MgmtAPSimplified";
        }
        configurator: IPv4NetworkConfigurator {
            config=xml("<config><interface hosts='*' address='145.236.x.x' netmask='255.255.0.0'/></config>");
            @display("p=140,50");
        }
}
