@[Link(ldflags: "#{__DIR__}/c/lan.o")]
lib LAN
  struct SockAddr
    sa_family : UInt16
    sa_data : StaticArray(LibC::Char, 14)
  end

  struct InterfaceInfo
    ifa_next : Pointer(InterfaceInfo)
    ifa_name : LibC::Char*
    ifa_flags : UInt32
    ifa_addr : Pointer(SockAddr)
    ifa_netmask : Pointer(SockAddr)
    ifa_data : Pointer(Void)
  end

  fun get_interface : Pointer(InterfaceInfo)
  fun netmask_to_i(LibC::Char*) : Int32
  fun ipaddrs_name(SockAddr*) : LibC::Char*
end

# ifa = LAN.get_interface
# pp ifa.value.ifa_addr.value

# host = LAN.ipaddrs_name(ifa.value.ifa_addr)
# i = 0
# ip_str = ""
# while (c = (host+i).value) != 0
#   ip_str += c.chr
#   i += 1
# end
# pp ip_str

# netmask = LAN.netmask_to_i "255.255.255.0"
# pp netmask
