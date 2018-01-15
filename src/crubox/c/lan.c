/*
 * Use this as the basis for netgeo --lan
 * It should get:
 *  - the interface in use
 *  - the netmask
 * Using these 2, it will ping all hosts in the LAN
 * and return all the IP addresses that respond.
 *
 */

/* #define _GNU_SOURCE */
/* #include <unistd.h> */
/* #include <linux/if_link.h> */
/* #include <sys/socket.h> */
/* #include <sys/types.h> */
#include <arpa/inet.h>
#include <assert.h>
#include <ifaddrs.h>
#include <netdb.h>  // needed for getnameinfo() and NI_NUMERICHOST
#include <net/if.h> // needed for IFF_LOOPBACK
#include <stdio.h>
#include <stdlib.h>
#include <string.h> // memcpy
#include <stropts.h>

// Converts sockaddr to String representation
char *ipaddrs_name(struct sockaddr *addr) {
    char *buf = malloc(NI_MAXHOST * sizeof(char));
    int s = getnameinfo(addr,
            sizeof(struct sockaddr),
            buf,
            NI_MAXHOST,
            NULL,
            0,
            NI_NUMERICHOST);
    if (s != 0) {
        printf("getnameinfo() failed: %s\n", gai_strerror(s));
        exit(EXIT_FAILURE);
    }
    return buf;
}

struct InterfaceInfo {
    struct InterfaceInfo *ifa_next;
    char *ifa_name;
    unsigned int ifa_flags;
    struct sockaddr *ifa_addr;
    struct sockaddr *ifa_netmask;
    void *ifa_data;

};

struct InterfaceInfo *newInterfaceInfo() {
    struct InterfaceInfo *ifi = malloc(sizeof(struct InterfaceInfo));
    ifi->ifa_next = NULL;
    ifi->ifa_name = NULL;
    ifi->ifa_flags = 0;
    ifi->ifa_addr = NULL;
    ifi->ifa_netmask = NULL;
    ifi->ifa_data = NULL;
    return ifi;
}

void cleanInterfaceInfo(struct InterfaceInfo *ifi) {
    assert(ifi != NULL);
    free(ifi);
    return;
}

struct InterfaceInfo *get_interface() {
    struct ifaddrs *ifa, *curr, *prev;
    struct InterfaceInfo *ifi = newInterfaceInfo();

    if (getifaddrs(&ifa) == -1) {
        perror("getifaddrs()");
        exit(EXIT_FAILURE);
    }

    for (curr = ifa; curr != NULL; prev = curr, curr = curr->ifa_next) {
        if (curr->ifa_addr == NULL)
            continue;
        if (curr->ifa_flags & IFF_LOOPBACK)
            continue;
        if (curr->ifa_addr->sa_family == AF_INET)
            break;
    }

    if (curr != NULL) {
        ifi->ifa_name = curr->ifa_name;
        ifi->ifa_flags = curr->ifa_flags;
        ifi->ifa_addr = curr->ifa_addr;
        ifi->ifa_netmask = curr->ifa_netmask;
    }

    freeifaddrs(ifa);

    return ifi;
}

// Convert String representation of netmask (e.g. 255.255.255.0)
// into an int (e.g. 24)
int netmask_to_i(char *netmask) {
    int n;
    inet_pton(AF_INET, netmask, &n);
    int i = 0;

    while (n > 0) {
        n = n >> 1;
        i++;
    }

    return i;
}

