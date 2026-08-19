-   [25 Useful IPtable Firewall Rules Every Linux Administrator Should Know](https://www.tecmint.com/linux-iptables-firewall-rules-examples-commands/)
-   [How to Set Up a Firewall Using Iptables](https://www.youtube.com/watch?v=qPEA6J9pjG8&t=608s)
-   [iptables Complete Guide](https://www.youtube.com/watch?v=6Ra17Qpj68c&t=410s)

---

#### Firewall

```sh
#!/bin/bash
/etc/firewallsetup/firewall-down
/etc/firewallsetup/firewall
```

#### UFW

[Linux Security - UFW Complete Guide (Uncomplicated Firewall)](https://www.youtube.com/watch?v=-CzvPjZ9hp8)

-   `$ sudo ufw status`
-   `$ sudo ufw disable`
-   `$ sudo ufw reset` (dangerous.)
-   `$ sudo ufw default deny incoming`
-   `$ sudo ufw default allow outgoing`
-   `$ sudo systemctl status ufw`
-   `$ sudo systemctl stop ufw`
-   `$ sudo ufw allow ssh`
-   `$ sudo ufw allow http`
-   `$ sudo ufw allow https`
-   `$ sudo ufw allow ftp`
-   `$ sudo ufw allow from 124.02.0.1`
-   `$ sudo ufw allow from 124.02.0.1 to any port 22`
-   `$ sudo ufw allow from 124.02.0.1/24 to any port 22`
-   `$ sudo systemctl start ufw`
-   `$ sudo ufw  enable`
-   `$ sudo ufw status`
-   `$ sudo ufw status numbered`
-   `$ sudo ufw delete 5`
-   `$ sudo ufw `
-   `$ sudo ufw `
-   `$ `

#### iptable

```sh
#!/bin/bash
#
# iptables example configuration script

# Drop ICMP echo-request messages sent to broadcast or multicast addresses
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts

# Drop source routed packets
echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route

# Enable TCP SYN cookie protection from SYN floods
echo 1 > /proc/sys/net/ipv4/tcp_syncookies

# Don't accept ICMP redirect messages
echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects

# Don't send ICMP redirect messages
echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects

# Enable source address spoofing protection
echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter

# Log packets with impossible source addresses
echo 1 > /proc/sys/net/ipv4/conf/all/log_martians

# Flush all chains
/sbin/iptables --flush

# Allow unlimited traffic on the loopback interface
/sbin/iptables -A INPUT -i lo -j ACCEPT
    # `-A`|`I` (Append|Insert); `-j` (Target)

/sbin/iptables -A OUTPUT -o lo -j ACCEPT

# Set default policies
/sbin/iptables --policy INPUT DROP
/sbin/iptables --policy OUTPUT DROP
/sbin/iptables --policy FORWARD DROP

# the rules allow us to reconnect by opening up all traffic.
/sbin/iptables -P INPUT ACCEPT
/sbin/iptables -P FORWARD ACCEPT
/sbin/iptables -P OUTPUT ACCEPT

# Previously initiated and accepted exchanges bypass rule checking
# Allow unlimited outbound traffic
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

#Ratelimit SSH for attack protection
/sbin/iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
/sbin/iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
/sbin/iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT

# Allow certain ports to be accessible from the outside
/sbin/iptables -A INPUT -p tcp --dport 25565 -m state --state NEW -j ACCEPT  #Minecraft
/sbin/iptables -A INPUT -p tcp --dport 8123 -m state --state NEW -j ACCEPT   #Dynmap plugin

# Other rules for future use if needed.  Uncomment to activate
# /sbin/iptables -A INPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT    # http
# /sbin/iptables -A INPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT   # https

# UDP packet rule.  This is just a random udp packet rule as an example only
# /sbin/iptables -A INPUT -p udp --dport 5021 -m state --state NEW -j ACCEPT

# Allow pinging of your server
/sbin/iptables -A INPUT -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT


# Drop all other traffic
/sbin/iptables -A INPUT -j DROP

# print the activated rules to the console when script is completed
/sbin/iptables -nL

#!/bin/bash

/sbin/iptables -F
/sbin/iptables -X
/sbin/iptables -t nat -F
/sbin/iptables -t nat -X
/sbin/iptables -t mangle -F
/sbin/iptables -t mangle -X



# print out all rules to the console after running this file.
/sbin/iptables -nL
```
