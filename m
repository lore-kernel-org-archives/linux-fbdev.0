From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: intelfb crash on i845
Date: Tue, 22 Mar 2005 18:25:44 +0100
Message-ID: <42405518.3090009@worldonline.fr>
References: <42402CBA.6090401@ens-lyon.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDnCG-0003oR-1d
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 09:29:40 -0800
Received: from smtp2.wanadoo.fr ([193.252.22.29])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DDnCF-0001ej-1t
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 09:29:39 -0800
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0206.wanadoo.fr (SMTP Server) with ESMTP id D570B1C00178
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Mar 2005 18:29:26 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

        Hi Brice,

    I hoped i fixed the bug but definately not. The problem comes from a=20
ressource allocation collision between the intelfb driver and the XFree=20
i830 driver. As a workaround you should disable HW acceleration on=20
intelfb (option accel=3D0).
    I think the problem occurs because XFree doesn't restore register=20
state when switching to VT. But i have to investigate more deeply.

Sylvain

Brice Goglin a =E9crit:

> Hi,
>
> Following our recent discussion about my DRM/i830 problems
> with XFree on my Dell Optiplex GX260 (see
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D111020328808689&w=3D=
2),=20
> here comes the intelfb part of my bug report.
>
> Booting with intelfb works great: As long as I don't start the
> X server, I can work and switch between the framebuffer text consoles.
>
> If I start the X server (XFree 4.3.0 from Debian testing before,
> Xorg 6.8.2 now), I can't switch back to fb text consoles:
> First time I chvt [123456], it switches to a **non-FB** text console
> for about 1 second, and then to a black screen (sometimes, a colored
> column appear when I try to type something on my keyboard).
>
> During this 1 second, there are some messages written wherever in
> the text console. They look like the begining of dmesg.
> They are mis-aligned, probably because the resolution of the text
> console is different from the FB text console.
>
> Switching back to the X server works.
> Switching back to a FB text console leads to a dirty screen
> with white and black columns on the left, and everything black
> on the right.
>
> dmesg show this when switching from X to a FB text console
> for the first time:
> intelfb: ring buffer : space: 8488 wanted 65472
> intelfb: lockup - turning off hardware acceleration
>
> Note that disabling DRI in Xorg doesn't change anything.
>
> dmesg, lspci et config are attached.
>
> This is with 2.6.11. But I don't remember having seen intelfb
> works since it was introduced in vanilla.
> 2.6.12-rc1 and 2.6.12-rc1-mm1 don't change anything, except
> maybe the dirtiness of the FB screen.
>
> Regards
> Brice Goglin
>
>------------------------------------------------------------------------
>
>#
># Automatically generated make config: don't edit
># Linux kernel version: 2.6.11
># Tue Mar  8 10:19:50 2005
>#
>CONFIG_X86=3Dy
>CONFIG_MMU=3Dy
>CONFIG_UID16=3Dy
>CONFIG_GENERIC_ISA_DMA=3Dy
>CONFIG_GENERIC_IOMAP=3Dy
>
>#
># Code maturity level options
>#
>CONFIG_EXPERIMENTAL=3Dy
># CONFIG_CLEAN_COMPILE is not set
>CONFIG_BROKEN=3Dy
>CONFIG_BROKEN_ON_SMP=3Dy
>CONFIG_LOCK_KERNEL=3Dy
>
>#
># General setup
>#
>CONFIG_LOCALVERSION=3D"=3DMacvin"
>CONFIG_SWAP=3Dy
>CONFIG_SYSVIPC=3Dy
># CONFIG_POSIX_MQUEUE is not set
>CONFIG_BSD_PROCESS_ACCT=3Dy
># CONFIG_BSD_PROCESS_ACCT_V3 is not set
>CONFIG_SYSCTL=3Dy
># CONFIG_AUDIT is not set
>CONFIG_LOG_BUF_SHIFT=3D17
>CONFIG_HOTPLUG=3Dy
>CONFIG_KOBJECT_UEVENT=3Dy
>CONFIG_IKCONFIG=3Dy
>CONFIG_IKCONFIG_PROC=3Dy
># CONFIG_EMBEDDED is not set
>CONFIG_KALLSYMS=3Dy
>CONFIG_KALLSYMS_ALL=3Dy
># CONFIG_KALLSYMS_EXTRA_PASS is not set
>CONFIG_FUTEX=3Dy
>CONFIG_EPOLL=3Dy
># CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
>CONFIG_SHMEM=3Dy
>CONFIG_CC_ALIGN_FUNCTIONS=3D0
>CONFIG_CC_ALIGN_LABELS=3D0
>CONFIG_CC_ALIGN_LOOPS=3D0
>CONFIG_CC_ALIGN_JUMPS=3D0
># CONFIG_TINY_SHMEM is not set
>
>#
># Loadable module support
>#
>CONFIG_MODULES=3Dy
>CONFIG_MODULE_UNLOAD=3Dy
># CONFIG_MODULE_FORCE_UNLOAD is not set
>CONFIG_OBSOLETE_MODPARM=3Dy
># CONFIG_MODVERSIONS is not set
># CONFIG_MODULE_SRCVERSION_ALL is not set
>CONFIG_KMOD=3Dy
>
>#
># Processor type and features
>#
>CONFIG_X86_PC=3Dy
># CONFIG_X86_ELAN is not set
># CONFIG_X86_VOYAGER is not set
># CONFIG_X86_NUMAQ is not set
># CONFIG_X86_SUMMIT is not set
># CONFIG_X86_BIGSMP is not set
># CONFIG_X86_VISWS is not set
># CONFIG_X86_GENERICARCH is not set
># CONFIG_X86_ES7000 is not set
># CONFIG_M386 is not set
># CONFIG_M486 is not set
># CONFIG_M586 is not set
># CONFIG_M586TSC is not set
># CONFIG_M586MMX is not set
># CONFIG_M686 is not set
># CONFIG_MPENTIUMII is not set
># CONFIG_MPENTIUMIII is not set
># CONFIG_MPENTIUMM is not set
>CONFIG_MPENTIUM4=3Dy
># CONFIG_MK6 is not set
># CONFIG_MK7 is not set
># CONFIG_MK8 is not set
># CONFIG_MCRUSOE is not set
># CONFIG_MEFFICEON is not set
># CONFIG_MWINCHIPC6 is not set
># CONFIG_MWINCHIP2 is not set
># CONFIG_MWINCHIP3D is not set
># CONFIG_MCYRIXIII is not set
># CONFIG_MVIAC3_2 is not set
># CONFIG_X86_GENERIC is not set
>CONFIG_X86_CMPXCHG=3Dy
>CONFIG_X86_XADD=3Dy
>CONFIG_X86_L1_CACHE_SHIFT=3D7
>CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
>CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
>CONFIG_X86_WP_WORKS_OK=3Dy
>CONFIG_X86_INVLPG=3Dy
>CONFIG_X86_BSWAP=3Dy
>CONFIG_X86_POPAD_OK=3Dy
>CONFIG_X86_GOOD_APIC=3Dy
>CONFIG_X86_INTEL_USERCOPY=3Dy
>CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
># CONFIG_HPET_TIMER is not set
># CONFIG_SMP is not set
>CONFIG_PREEMPT=3Dy
>CONFIG_PREEMPT_BKL=3Dy
># CONFIG_X86_UP_APIC is not set
>CONFIG_X86_TSC=3Dy
>CONFIG_X86_MCE=3Dy
>CONFIG_X86_MCE_NONFATAL=3Dy
># CONFIG_TOSHIBA is not set
># CONFIG_I8K is not set
># CONFIG_MICROCODE is not set
># CONFIG_X86_MSR is not set
># CONFIG_X86_CPUID is not set
>
>#
># Firmware Drivers
>#
>CONFIG_EDD=3Dm
>CONFIG_NOHIGHMEM=3Dy
># CONFIG_HIGHMEM4G is not set
># CONFIG_HIGHMEM64G is not set
># CONFIG_MATH_EMULATION is not set
>CONFIG_MTRR=3Dy
># CONFIG_EFI is not set
>CONFIG_HAVE_DEC_LOCK=3Dy
># CONFIG_REGPARM is not set
>
>#
># Power management options (ACPI, APM)
>#
>CONFIG_PM=3Dy
># CONFIG_PM_DEBUG is not set
># CONFIG_SOFTWARE_SUSPEND is not set
>
>#
># ACPI (Advanced Configuration and Power Interface) Support
>#
>CONFIG_ACPI=3Dy
>CONFIG_ACPI_BOOT=3Dy
>CONFIG_ACPI_INTERPRETER=3Dy
>CONFIG_ACPI_SLEEP=3Dy
>CONFIG_ACPI_SLEEP_PROC_FS=3Dy
>CONFIG_ACPI_AC=3Dy
># CONFIG_ACPI_BATTERY is not set
>CONFIG_ACPI_BUTTON=3Dy
>CONFIG_ACPI_VIDEO=3Dy
>CONFIG_ACPI_FAN=3Dy
>CONFIG_ACPI_PROCESSOR=3Dy
>CONFIG_ACPI_THERMAL=3Dy
># CONFIG_ACPI_ASUS is not set
># CONFIG_ACPI_IBM is not set
># CONFIG_ACPI_TOSHIBA is not set
># CONFIG_ACPI_CUSTOM_DSDT is not set
>CONFIG_ACPI_BLACKLIST_YEAR=3D0
># CONFIG_ACPI_DEBUG is not set
>CONFIG_ACPI_BUS=3Dy
>CONFIG_ACPI_EC=3Dy
>CONFIG_ACPI_POWER=3Dy
>CONFIG_ACPI_PCI=3Dy
>CONFIG_ACPI_SYSTEM=3Dy
>CONFIG_X86_PM_TIMER=3Dy
>CONFIG_ACPI_CONTAINER=3Dm
>
>#
># APM (Advanced Power Management) BIOS Support
>#
># CONFIG_APM is not set
>
>#
># CPU Frequency scaling
>#
># CONFIG_CPU_FREQ is not set
>
>#
># Bus options (PCI, PCMCIA, EISA, MCA, ISA)
>#
>CONFIG_PCI=3Dy
># CONFIG_PCI_GOBIOS is not set
># CONFIG_PCI_GOMMCONFIG is not set
># CONFIG_PCI_GODIRECT is not set
>CONFIG_PCI_GOANY=3Dy
>CONFIG_PCI_BIOS=3Dy
>CONFIG_PCI_DIRECT=3Dy
>CONFIG_PCI_MMCONFIG=3Dy
># CONFIG_PCIEPORTBUS is not set
>CONFIG_PCI_LEGACY_PROC=3Dy
>CONFIG_PCI_NAMES=3Dy
>CONFIG_ISA=3Dy
># CONFIG_EISA is not set
># CONFIG_MCA is not set
># CONFIG_SCx200 is not set
>
>#
># PCCARD (PCMCIA/CardBus) support
>#
># CONFIG_PCCARD is not set
>
>#
># PC-card bridges
>#
>CONFIG_PCMCIA_PROBE=3Dy
>
>#
># PCI Hotplug Support
>#
># CONFIG_HOTPLUG_PCI is not set
>
>#
># Executable file formats
>#
>CONFIG_BINFMT_ELF=3Dy
>CONFIG_BINFMT_AOUT=3Dy
>CONFIG_BINFMT_MISC=3Dy
>
>#
># Device Drivers
>#
>
>#
># Generic Driver Options
>#
># CONFIG_STANDALONE is not set
># CONFIG_PREVENT_FIRMWARE_BUILD is not set
># CONFIG_FW_LOADER is not set
># CONFIG_DEBUG_DRIVER is not set
>
>#
># Memory Technology Devices (MTD)
>#
># CONFIG_MTD is not set
>
>#
># Parallel port support
>#
># CONFIG_PARPORT is not set
>
>#
># Plug and Play support
>#
>CONFIG_PNP=3Dy
># CONFIG_PNP_DEBUG is not set
>
>#
># Protocols
>#
># CONFIG_ISAPNP is not set
>CONFIG_PNPBIOS=3Dy
>CONFIG_PNPBIOS_PROC_FS=3Dy
>CONFIG_PNPACPI=3Dy
>
>#
># Block devices
>#
>CONFIG_BLK_DEV_FD=3Dm
># CONFIG_BLK_DEV_XD is not set
># CONFIG_BLK_CPQ_DA is not set
># CONFIG_BLK_CPQ_CISS_DA is not set
># CONFIG_BLK_DEV_DAC960 is not set
># CONFIG_BLK_DEV_UMEM is not set
># CONFIG_BLK_DEV_COW_COMMON is not set
>CONFIG_BLK_DEV_LOOP=3Dm
># CONFIG_BLK_DEV_CRYPTOLOOP is not set
># CONFIG_BLK_DEV_NBD is not set
># CONFIG_BLK_DEV_SX8 is not set
># CONFIG_BLK_DEV_UB is not set
># CONFIG_BLK_DEV_RAM is not set
>CONFIG_BLK_DEV_RAM_COUNT=3D16
>CONFIG_INITRAMFS_SOURCE=3D""
># CONFIG_LBD is not set
># CONFIG_CDROM_PKTCDVD is not set
>
>#
># IO Schedulers
>#
>CONFIG_IOSCHED_NOOP=3Dy
>CONFIG_IOSCHED_AS=3Dy
>CONFIG_IOSCHED_DEADLINE=3Dy
>CONFIG_IOSCHED_CFQ=3Dy
># CONFIG_ATA_OVER_ETH is not set
>
>#
># ATA/ATAPI/MFM/RLL support
>#
>CONFIG_IDE=3Dy
>CONFIG_BLK_DEV_IDE=3Dy
>
>#
># Please see Documentation/ide.txt for help/info on IDE drives
>#
># CONFIG_BLK_DEV_IDE_SATA is not set
># CONFIG_BLK_DEV_HD_IDE is not set
>CONFIG_BLK_DEV_IDEDISK=3Dy
>CONFIG_IDEDISK_MULTI_MODE=3Dy
>CONFIG_BLK_DEV_IDECD=3Dy
># CONFIG_BLK_DEV_IDETAPE is not set
># CONFIG_BLK_DEV_IDEFLOPPY is not set
># CONFIG_BLK_DEV_IDESCSI is not set
># CONFIG_IDE_TASK_IOCTL is not set
>
>#
># IDE chipset support/bugfixes
>#
>CONFIG_IDE_GENERIC=3Dy
>CONFIG_BLK_DEV_CMD640=3Dy
># CONFIG_BLK_DEV_CMD640_ENHANCED is not set
># CONFIG_BLK_DEV_IDEPNP is not set
>CONFIG_BLK_DEV_IDEPCI=3Dy
>CONFIG_IDEPCI_SHARE_IRQ=3Dy
># CONFIG_BLK_DEV_OFFBOARD is not set
>CONFIG_BLK_DEV_GENERIC=3Dy
># CONFIG_BLK_DEV_OPTI621 is not set
># CONFIG_BLK_DEV_RZ1000 is not set
>CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
># CONFIG_BLK_DEV_IDEDMA_FORCED is not set
>CONFIG_IDEDMA_PCI_AUTO=3Dy
># CONFIG_IDEDMA_ONLYDISK is not set
># CONFIG_BLK_DEV_AEC62XX is not set
># CONFIG_BLK_DEV_ALI15X3 is not set
># CONFIG_BLK_DEV_AMD74XX is not set
># CONFIG_BLK_DEV_ATIIXP is not set
># CONFIG_BLK_DEV_CMD64X is not set
># CONFIG_BLK_DEV_TRIFLEX is not set
># CONFIG_BLK_DEV_CY82C693 is not set
># CONFIG_BLK_DEV_CS5520 is not set
># CONFIG_BLK_DEV_CS5530 is not set
># CONFIG_BLK_DEV_HPT34X is not set
># CONFIG_BLK_DEV_HPT366 is not set
># CONFIG_BLK_DEV_SC1200 is not set
>CONFIG_BLK_DEV_PIIX=3Dy
># CONFIG_BLK_DEV_NS87415 is not set
># CONFIG_BLK_DEV_PDC202XX_OLD is not set
># CONFIG_BLK_DEV_PDC202XX_NEW is not set
># CONFIG_BLK_DEV_SVWKS is not set
># CONFIG_BLK_DEV_SIIMAGE is not set
># CONFIG_BLK_DEV_SIS5513 is not set
># CONFIG_BLK_DEV_SLC90E66 is not set
># CONFIG_BLK_DEV_TRM290 is not set
># CONFIG_BLK_DEV_VIA82CXXX is not set
># CONFIG_IDE_ARM is not set
># CONFIG_IDE_CHIPSETS is not set
>CONFIG_BLK_DEV_IDEDMA=3Dy
># CONFIG_IDEDMA_IVB is not set
>CONFIG_IDEDMA_AUTO=3Dy
># CONFIG_BLK_DEV_HD is not set
>
>#
># SCSI device support
>#
>CONFIG_SCSI=3Dy
>CONFIG_SCSI_PROC_FS=3Dy
>
>#
># SCSI support type (disk, tape, CD-ROM)
>#
>CONFIG_BLK_DEV_SD=3Dm
># CONFIG_CHR_DEV_ST is not set
># CONFIG_CHR_DEV_OSST is not set
># CONFIG_BLK_DEV_SR is not set
># CONFIG_CHR_DEV_SG is not set
>
>#
># Some SCSI devices (e.g. CD jukebox) support multiple LUNs
>#
># CONFIG_SCSI_MULTI_LUN is not set
># CONFIG_SCSI_CONSTANTS is not set
># CONFIG_SCSI_LOGGING is not set
>
>#
># SCSI Transport Attributes
>#
># CONFIG_SCSI_SPI_ATTRS is not set
># CONFIG_SCSI_FC_ATTRS is not set
># CONFIG_SCSI_ISCSI_ATTRS is not set
>
>#
># SCSI low-level drivers
>#
># CONFIG_BLK_DEV_3W_XXXX_RAID is not set
># CONFIG_SCSI_3W_9XXX is not set
># CONFIG_SCSI_7000FASST is not set
># CONFIG_SCSI_ACARD is not set
># CONFIG_SCSI_AHA152X is not set
># CONFIG_SCSI_AHA1542 is not set
># CONFIG_SCSI_AACRAID is not set
># CONFIG_SCSI_AIC7XXX is not set
># CONFIG_SCSI_AIC7XXX_OLD is not set
># CONFIG_SCSI_AIC79XX is not set
># CONFIG_SCSI_DPT_I2O is not set
># CONFIG_SCSI_ADVANSYS is not set
># CONFIG_SCSI_IN2000 is not set
># CONFIG_MEGARAID_NEWGEN is not set
># CONFIG_MEGARAID_LEGACY is not set
># CONFIG_SCSI_SATA is not set
># CONFIG_SCSI_BUSLOGIC is not set
># CONFIG_SCSI_CPQFCTS is not set
># CONFIG_SCSI_DMX3191D is not set
># CONFIG_SCSI_DTC3280 is not set
># CONFIG_SCSI_EATA is not set
># CONFIG_SCSI_EATA_PIO is not set
># CONFIG_SCSI_FUTURE_DOMAIN is not set
># CONFIG_SCSI_GDTH is not set
># CONFIG_SCSI_GENERIC_NCR5380 is not set
># CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
># CONFIG_SCSI_IPS is not set
># CONFIG_SCSI_INITIO is not set
># CONFIG_SCSI_INIA100 is not set
># CONFIG_SCSI_NCR53C406A is not set
># CONFIG_SCSI_SYM53C8XX_2 is not set
># CONFIG_SCSI_IPR is not set
># CONFIG_SCSI_PAS16 is not set
># CONFIG_SCSI_PCI2000 is not set
># CONFIG_SCSI_PCI2220I is not set
># CONFIG_SCSI_PSI240I is not set
># CONFIG_SCSI_QLOGIC_FAS is not set
># CONFIG_SCSI_QLOGIC_ISP is not set
># CONFIG_SCSI_QLOGIC_FC is not set
># CONFIG_SCSI_QLOGIC_1280 is not set
>CONFIG_SCSI_QLA2XXX=3Dy
># CONFIG_SCSI_QLA21XX is not set
># CONFIG_SCSI_QLA22XX is not set
># CONFIG_SCSI_QLA2300 is not set
># CONFIG_SCSI_QLA2322 is not set
># CONFIG_SCSI_QLA6312 is not set
># CONFIG_SCSI_SEAGATE is not set
># CONFIG_SCSI_SYM53C416 is not set
># CONFIG_SCSI_DC395x is not set
># CONFIG_SCSI_DC390T is not set
># CONFIG_SCSI_T128 is not set
># CONFIG_SCSI_U14_34F is not set
># CONFIG_SCSI_ULTRASTOR is not set
># CONFIG_SCSI_NSP32 is not set
># CONFIG_SCSI_DEBUG is not set
>
>#
># Old CD-ROM drivers (not SCSI, not IDE)
>#
># CONFIG_CD_NO_IDESCSI is not set
>
>#
># Multi-device support (RAID and LVM)
>#
>CONFIG_MD=3Dy
># CONFIG_BLK_DEV_MD is not set
>CONFIG_BLK_DEV_DM=3Dm
># CONFIG_DM_CRYPT is not set
># CONFIG_DM_SNAPSHOT is not set
># CONFIG_DM_MIRROR is not set
># CONFIG_DM_ZERO is not set
>
>#
># Fusion MPT device support
>#
># CONFIG_FUSION is not set
>
>#
># IEEE 1394 (FireWire) support
>#
># CONFIG_IEEE1394 is not set
>
>#
># I2O device support
>#
># CONFIG_I2O is not set
>
>#
># Networking support
>#
>CONFIG_NET=3Dy
>
>#
># Networking options
>#
>CONFIG_PACKET=3Dy
>CONFIG_PACKET_MMAP=3Dy
># CONFIG_NETLINK_DEV is not set
>CONFIG_UNIX=3Dy
># CONFIG_NET_KEY is not set
>CONFIG_INET=3Dy
>CONFIG_IP_MULTICAST=3Dy
>CONFIG_IP_ADVANCED_ROUTER=3Dy
># CONFIG_IP_MULTIPLE_TABLES is not set
># CONFIG_IP_ROUTE_MULTIPATH is not set
># CONFIG_IP_ROUTE_VERBOSE is not set
># CONFIG_IP_PNP is not set
># CONFIG_NET_IPIP is not set
># CONFIG_NET_IPGRE is not set
># CONFIG_IP_MROUTE is not set
># CONFIG_ARPD is not set
># CONFIG_SYN_COOKIES is not set
># CONFIG_INET_AH is not set
># CONFIG_INET_ESP is not set
># CONFIG_INET_IPCOMP is not set
># CONFIG_INET_TUNNEL is not set
>CONFIG_IP_TCPDIAG=3Dy
># CONFIG_IP_TCPDIAG_IPV6 is not set
>
>#
># IP: Virtual Server Configuration
>#
># CONFIG_IP_VS is not set
># CONFIG_IPV6 is not set
>CONFIG_NETFILTER=3Dy
># CONFIG_NETFILTER_DEBUG is not set
>
>#
># IP: Netfilter Configuration
>#
>CONFIG_IP_NF_CONNTRACK=3Dm
># CONFIG_IP_NF_CT_ACCT is not set
># CONFIG_IP_NF_CONNTRACK_MARK is not set
># CONFIG_IP_NF_CT_PROTO_SCTP is not set
># CONFIG_IP_NF_FTP is not set
># CONFIG_IP_NF_IRC is not set
># CONFIG_IP_NF_TFTP is not set
># CONFIG_IP_NF_AMANDA is not set
># CONFIG_IP_NF_QUEUE is not set
>CONFIG_IP_NF_IPTABLES=3Dm
># CONFIG_IP_NF_MATCH_LIMIT is not set
># CONFIG_IP_NF_MATCH_IPRANGE is not set
># CONFIG_IP_NF_MATCH_MAC is not set
># CONFIG_IP_NF_MATCH_PKTTYPE is not set
># CONFIG_IP_NF_MATCH_MARK is not set
># CONFIG_IP_NF_MATCH_MULTIPORT is not set
># CONFIG_IP_NF_MATCH_TOS is not set
># CONFIG_IP_NF_MATCH_RECENT is not set
># CONFIG_IP_NF_MATCH_ECN is not set
># CONFIG_IP_NF_MATCH_DSCP is not set
># CONFIG_IP_NF_MATCH_AH_ESP is not set
># CONFIG_IP_NF_MATCH_LENGTH is not set
># CONFIG_IP_NF_MATCH_TTL is not set
># CONFIG_IP_NF_MATCH_TCPMSS is not set
># CONFIG_IP_NF_MATCH_HELPER is not set
>CONFIG_IP_NF_MATCH_STATE=3Dm
>CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
># CONFIG_IP_NF_MATCH_OWNER is not set
># CONFIG_IP_NF_MATCH_ADDRTYPE is not set
># CONFIG_IP_NF_MATCH_REALM is not set
># CONFIG_IP_NF_MATCH_SCTP is not set
># CONFIG_IP_NF_MATCH_COMMENT is not set
># CONFIG_IP_NF_MATCH_HASHLIMIT is not set
>CONFIG_IP_NF_FILTER=3Dm
>CONFIG_IP_NF_TARGET_REJECT=3Dm
>CONFIG_IP_NF_TARGET_LOG=3Dm
># CONFIG_IP_NF_TARGET_ULOG is not set
># CONFIG_IP_NF_TARGET_TCPMSS is not set
>CONFIG_IP_NF_NAT=3Dm
>CONFIG_IP_NF_NAT_NEEDED=3Dy
>CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
>CONFIG_IP_NF_TARGET_REDIRECT=3Dm
># CONFIG_IP_NF_TARGET_NETMAP is not set
># CONFIG_IP_NF_TARGET_SAME is not set
># CONFIG_IP_NF_NAT_SNMP_BASIC is not set
># CONFIG_IP_NF_MANGLE is not set
># CONFIG_IP_NF_RAW is not set
># CONFIG_IP_NF_ARPTABLES is not set
>
>#
># SCTP Configuration (EXPERIMENTAL)
>#
># CONFIG_IP_SCTP is not set
># CONFIG_ATM is not set
># CONFIG_BRIDGE is not set
># CONFIG_VLAN_8021Q is not set
># CONFIG_DECNET is not set
># CONFIG_LLC2 is not set
># CONFIG_IPX is not set
># CONFIG_ATALK is not set
># CONFIG_X25 is not set
># CONFIG_LAPB is not set
># CONFIG_NET_DIVERT is not set
># CONFIG_ECONET is not set
># CONFIG_WAN_ROUTER is not set
>
>#
># QoS and/or fair queueing
>#
># CONFIG_NET_SCHED is not set
># CONFIG_NET_CLS_ROUTE is not set
>
>#
># Network testing
>#
># CONFIG_NET_PKTGEN is not set
>CONFIG_NETPOLL=3Dy
># CONFIG_NETPOLL_RX is not set
># CONFIG_NETPOLL_TRAP is not set
>CONFIG_NET_POLL_CONTROLLER=3Dy
># CONFIG_HAMRADIO is not set
># CONFIG_IRDA is not set
># CONFIG_BT is not set
>CONFIG_NETDEVICES=3Dy
>CONFIG_DUMMY=3Dm
># CONFIG_BONDING is not set
># CONFIG_EQUALIZER is not set
>CONFIG_TUN=3Dm
># CONFIG_NET_SB1000 is not set
>
>#
># ARCnet devices
>#
># CONFIG_ARCNET is not set
>
>#
># Ethernet (10 or 100Mbit)
>#
># CONFIG_NET_ETHERNET is not set
>
>#
># Ethernet (1000 Mbit)
>#
># CONFIG_ACENIC is not set
># CONFIG_DL2K is not set
>CONFIG_E1000=3Dy
># CONFIG_E1000_NAPI is not set
># CONFIG_NS83820 is not set
># CONFIG_HAMACHI is not set
># CONFIG_YELLOWFIN is not set
># CONFIG_R8169 is not set
># CONFIG_SK98LIN is not set
># CONFIG_TIGON3 is not set
>
>#
># Ethernet (10000 Mbit)
>#
># CONFIG_IXGB is not set
># CONFIG_S2IO is not set
>
>#
># Token Ring devices
>#
># CONFIG_TR is not set
>
>#
># Wireless LAN (non-hamradio)
>#
># CONFIG_NET_RADIO is not set
>
>#
># Wan interfaces
>#
># CONFIG_WAN is not set
># CONFIG_FDDI is not set
># CONFIG_HIPPI is not set
>CONFIG_PPP=3Dm
># CONFIG_PPP_MULTILINK is not set
># CONFIG_PPP_FILTER is not set
>CONFIG_PPP_ASYNC=3Dm
># CONFIG_PPP_SYNC_TTY is not set
>CONFIG_PPP_DEFLATE=3Dm
>CONFIG_PPP_BSDCOMP=3Dm
># CONFIG_PPPOE is not set
># CONFIG_SLIP is not set
># CONFIG_NET_FC is not set
># CONFIG_SHAPER is not set
>CONFIG_NETCONSOLE=3Dm
>
>#
># ISDN subsystem
>#
># CONFIG_ISDN is not set
>
>#
># Telephony Support
>#
># CONFIG_PHONE is not set
>
>#
># Input device support
>#
>CONFIG_INPUT=3Dy
>
>#
># Userland interfaces
>#
>CONFIG_INPUT_MOUSEDEV=3Dy
>CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
>CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
>CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
># CONFIG_INPUT_JOYDEV is not set
># CONFIG_INPUT_TSDEV is not set
>CONFIG_INPUT_EVDEV=3Dy
># CONFIG_INPUT_EVBUG is not set
>
>#
># Input I/O drivers
>#
># CONFIG_GAMEPORT is not set
>CONFIG_SOUND_GAMEPORT=3Dy
>CONFIG_SERIO=3Dy
>CONFIG_SERIO_I8042=3Dy
># CONFIG_SERIO_SERPORT is not set
># CONFIG_SERIO_CT82C710 is not set
># CONFIG_SERIO_PCIPS2 is not set
>CONFIG_SERIO_LIBPS2=3Dy
># CONFIG_SERIO_RAW is not set
>
>#
># Input Device Drivers
>#
>CONFIG_INPUT_KEYBOARD=3Dy
>CONFIG_KEYBOARD_ATKBD=3Dy
># CONFIG_KEYBOARD_SUNKBD is not set
># CONFIG_KEYBOARD_LKKBD is not set
># CONFIG_KEYBOARD_XTKBD is not set
># CONFIG_KEYBOARD_NEWTON is not set
>CONFIG_INPUT_MOUSE=3Dy
>CONFIG_MOUSE_PS2=3Dy
># CONFIG_MOUSE_SERIAL is not set
># CONFIG_MOUSE_INPORT is not set
># CONFIG_MOUSE_LOGIBM is not set
># CONFIG_MOUSE_PC110PAD is not set
># CONFIG_MOUSE_VSXXXAA is not set
># CONFIG_INPUT_JOYSTICK is not set
># CONFIG_INPUT_TOUCHSCREEN is not set
>CONFIG_INPUT_MISC=3Dy
>CONFIG_INPUT_PCSPKR=3Dy
># CONFIG_INPUT_UINPUT is not set
>
>#
># Character devices
>#
>CONFIG_VT=3Dy
>CONFIG_VT_CONSOLE=3Dy
>CONFIG_HW_CONSOLE=3Dy
># CONFIG_SERIAL_NONSTANDARD is not set
>
>#
># Serial drivers
>#
># CONFIG_SERIAL_8250 is not set
>
>#
># Non-8250 serial port support
>#
>CONFIG_UNIX98_PTYS=3Dy
>CONFIG_LEGACY_PTYS=3Dy
>CONFIG_LEGACY_PTY_COUNT=3D256
>
>#
># IPMI
>#
># CONFIG_IPMI_HANDLER is not set
>
>#
># Watchdog Cards
>#
># CONFIG_WATCHDOG is not set
># CONFIG_HW_RANDOM is not set
># CONFIG_NVRAM is not set
># CONFIG_RTC is not set
># CONFIG_GEN_RTC is not set
># CONFIG_DTLK is not set
># CONFIG_R3964 is not set
># CONFIG_APPLICOM is not set
># CONFIG_SONYPI is not set
>
>#
># Ftape, the floppy tape device driver
>#
># CONFIG_FTAPE is not set
>CONFIG_AGP=3Dy
># CONFIG_AGP_ALI is not set
># CONFIG_AGP_ATI is not set
># CONFIG_AGP_AMD is not set
># CONFIG_AGP_AMD64 is not set
>CONFIG_AGP_INTEL=3Dy
># CONFIG_AGP_INTEL_MCH is not set
># CONFIG_AGP_NVIDIA is not set
># CONFIG_AGP_SIS is not set
># CONFIG_AGP_SWORKS is not set
># CONFIG_AGP_VIA is not set
># CONFIG_AGP_EFFICEON is not set
>CONFIG_DRM=3Dy
># CONFIG_DRM_TDFX is not set
># CONFIG_DRM_GAMMA is not set
># CONFIG_DRM_R128 is not set
># CONFIG_DRM_RADEON is not set
># CONFIG_DRM_I810 is not set
>CONFIG_DRM_I830=3Dm
>CONFIG_DRM_I915=3Dm
># CONFIG_DRM_MGA is not set
># CONFIG_DRM_SIS is not set
># CONFIG_MWAVE is not set
># CONFIG_RAW_DRIVER is not set
># CONFIG_HPET is not set
># CONFIG_HANGCHECK_TIMER is not set
>
>#
># I2C support
>#
># CONFIG_I2C is not set
>
>#
># Dallas's 1-wire bus
>#
># CONFIG_W1 is not set
>
>#
># Misc devices
>#
># CONFIG_IBM_ASM is not set
>
>#
># Multimedia devices
>#
>CONFIG_VIDEO_DEV=3Dm
>
>#
># Video For Linux
>#
>
>#
># Video Adapters
>#
># CONFIG_VIDEO_PMS is not set
># CONFIG_VIDEO_CPIA is not set
># CONFIG_VIDEO_STRADIS is not set
># CONFIG_VIDEO_MXB is not set
># CONFIG_VIDEO_DPC is not set
># CONFIG_VIDEO_HEXIUM_ORION is not set
># CONFIG_VIDEO_HEXIUM_GEMINI is not set
># CONFIG_VIDEO_CX88 is not set
>
>#
># Radio Adapters
>#
># CONFIG_RADIO_CADET is not set
># CONFIG_RADIO_RTRACK is not set
># CONFIG_RADIO_RTRACK2 is not set
># CONFIG_RADIO_AZTECH is not set
># CONFIG_RADIO_GEMTEK is not set
># CONFIG_RADIO_GEMTEK_PCI is not set
># CONFIG_RADIO_MAXIRADIO is not set
># CONFIG_RADIO_MAESTRO is not set
># CONFIG_RADIO_SF16FMI is not set
># CONFIG_RADIO_SF16FMR2 is not set
># CONFIG_RADIO_TERRATEC is not set
># CONFIG_RADIO_TRUST is not set
># CONFIG_RADIO_TYPHOON is not set
># CONFIG_RADIO_ZOLTRIX is not set
>
>#
># Digital Video Broadcasting Devices
>#
># CONFIG_DVB is not set
>
>#
># Graphics support
>#
>CONFIG_FB=3Dy
>CONFIG_FB_MODE_HELPERS=3Dy
># CONFIG_FB_TILEBLITTING is not set
># CONFIG_FB_CIRRUS is not set
># CONFIG_FB_PM2 is not set
># CONFIG_FB_CYBER2000 is not set
># CONFIG_FB_ASILIANT is not set
># CONFIG_FB_IMSTT is not set
># CONFIG_FB_VGA16 is not set
># CONFIG_FB_VESA is not set
>CONFIG_VIDEO_SELECT=3Dy
># CONFIG_FB_HGA is not set
># CONFIG_FB_RIVA is not set
># CONFIG_FB_I810 is not set
>CONFIG_FB_INTEL=3Dy
># CONFIG_FB_INTEL_DEBUG is not set
># CONFIG_FB_MATROX is not set
># CONFIG_FB_RADEON_OLD is not set
># CONFIG_FB_RADEON is not set
># CONFIG_FB_ATY128 is not set
># CONFIG_FB_ATY is not set
># CONFIG_FB_SAVAGE is not set
># CONFIG_FB_SIS is not set
># CONFIG_FB_NEOMAGIC is not set
># CONFIG_FB_KYRO is not set
># CONFIG_FB_3DFX is not set
># CONFIG_FB_VOODOO1 is not set
># CONFIG_FB_TRIDENT is not set
># CONFIG_FB_PM3 is not set
># CONFIG_FB_VIRTUAL is not set
>
>#
># Console display driver support
>#
>CONFIG_VGA_CONSOLE=3Dy
># CONFIG_MDA_CONSOLE is not set
>CONFIG_DUMMY_CONSOLE=3Dy
>CONFIG_FRAMEBUFFER_CONSOLE=3Dy
># CONFIG_FONTS is not set
>CONFIG_FONT_8x8=3Dy
>CONFIG_FONT_8x16=3Dy
>
>#
># Logo configuration
>#
>CONFIG_LOGO=3Dy
>CONFIG_LOGO_LINUX_MONO=3Dy
>CONFIG_LOGO_LINUX_VGA16=3Dy
>CONFIG_LOGO_LINUX_CLUT224=3Dy
># CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>
>#
># Sound
>#
>CONFIG_SOUND=3Dy
>
>#
># Advanced Linux Sound Architecture
>#
>CONFIG_SND=3Dy
>CONFIG_SND_TIMER=3Dy
>CONFIG_SND_PCM=3Dy
>CONFIG_SND_RAWMIDI=3Dm
>CONFIG_SND_SEQUENCER=3Dy
>CONFIG_SND_SEQ_DUMMY=3Dy
>CONFIG_SND_OSSEMUL=3Dy
>CONFIG_SND_MIXER_OSS=3Dy
>CONFIG_SND_PCM_OSS=3Dy
>CONFIG_SND_SEQUENCER_OSS=3Dy
># CONFIG_SND_VERBOSE_PRINTK is not set
># CONFIG_SND_DEBUG is not set
>
>#
># Generic devices
>#
>CONFIG_SND_DUMMY=3Dm
>CONFIG_SND_VIRMIDI=3Dm
># CONFIG_SND_MTPAV is not set
># CONFIG_SND_SERIAL_U16550 is not set
># CONFIG_SND_MPU401 is not set
>
>#
># ISA devices
>#
># CONFIG_SND_AD1848 is not set
># CONFIG_SND_CS4231 is not set
># CONFIG_SND_CS4232 is not set
># CONFIG_SND_CS4236 is not set
># CONFIG_SND_ES1688 is not set
># CONFIG_SND_ES18XX is not set
># CONFIG_SND_GUSCLASSIC is not set
># CONFIG_SND_GUSEXTREME is not set
># CONFIG_SND_GUSMAX is not set
># CONFIG_SND_INTERWAVE is not set
># CONFIG_SND_INTERWAVE_STB is not set
># CONFIG_SND_OPTI92X_AD1848 is not set
># CONFIG_SND_OPTI92X_CS4231 is not set
># CONFIG_SND_OPTI93X is not set
># CONFIG_SND_SB8 is not set
># CONFIG_SND_SB16 is not set
># CONFIG_SND_SBAWE is not set
># CONFIG_SND_WAVEFRONT is not set
># CONFIG_SND_CMI8330 is not set
># CONFIG_SND_OPL3SA2 is not set
># CONFIG_SND_SGALAXY is not set
># CONFIG_SND_SSCAPE is not set
>
>#
># PCI devices
>#
>CONFIG_SND_AC97_CODEC=3Dm
># CONFIG_SND_ALI5451 is not set
># CONFIG_SND_ATIIXP is not set
># CONFIG_SND_ATIIXP_MODEM is not set
># CONFIG_SND_AU8810 is not set
># CONFIG_SND_AU8820 is not set
># CONFIG_SND_AU8830 is not set
># CONFIG_SND_AZT3328 is not set
># CONFIG_SND_BT87X is not set
># CONFIG_SND_CS46XX is not set
># CONFIG_SND_CS4281 is not set
># CONFIG_SND_EMU10K1 is not set
># CONFIG_SND_EMU10K1X is not set
># CONFIG_SND_CA0106 is not set
># CONFIG_SND_KORG1212 is not set
># CONFIG_SND_MIXART is not set
># CONFIG_SND_NM256 is not set
># CONFIG_SND_RME32 is not set
># CONFIG_SND_RME96 is not set
># CONFIG_SND_RME9652 is not set
># CONFIG_SND_HDSP is not set
># CONFIG_SND_TRIDENT is not set
># CONFIG_SND_YMFPCI is not set
># CONFIG_SND_ALS4000 is not set
># CONFIG_SND_CMIPCI is not set
># CONFIG_SND_ENS1370 is not set
># CONFIG_SND_ENS1371 is not set
># CONFIG_SND_ES1938 is not set
># CONFIG_SND_ES1968 is not set
># CONFIG_SND_MAESTRO3 is not set
># CONFIG_SND_FM801 is not set
># CONFIG_SND_ICE1712 is not set
># CONFIG_SND_ICE1724 is not set
>CONFIG_SND_INTEL8X0=3Dm
># CONFIG_SND_INTEL8X0M is not set
># CONFIG_SND_SONICVIBES is not set
># CONFIG_SND_VIA82XX is not set
># CONFIG_SND_VIA82XX_MODEM is not set
># CONFIG_SND_VX222 is not set
>
>#
># USB devices
>#
># CONFIG_SND_USB_AUDIO is not set
># CONFIG_SND_USB_USX2Y is not set
>
>#
># Open Sound System
>#
># CONFIG_SOUND_PRIME is not set
>
>#
># USB support
>#
>CONFIG_USB=3Dy
># CONFIG_USB_DEBUG is not set
>
>#
># Miscellaneous USB options
>#
>CONFIG_USB_DEVICEFS=3Dy
>CONFIG_USB_BANDWIDTH=3Dy
># CONFIG_USB_DYNAMIC_MINORS is not set
># CONFIG_USB_SUSPEND is not set
># CONFIG_USB_OTG is not set
>CONFIG_USB_ARCH_HAS_HCD=3Dy
>CONFIG_USB_ARCH_HAS_OHCI=3Dy
>
>#
># USB Host Controller Drivers
>#
>CONFIG_USB_EHCI_HCD=3Dm
># CONFIG_USB_EHCI_SPLIT_ISO is not set
># CONFIG_USB_EHCI_ROOT_HUB_TT is not set
># CONFIG_USB_OHCI_HCD is not set
>CONFIG_USB_UHCI_HCD=3Dm
># CONFIG_USB_SL811_HCD is not set
>
>#
># USB Device Class drivers
>#
># CONFIG_USB_AUDIO is not set
># CONFIG_USB_BLUETOOTH_TTY is not set
># CONFIG_USB_MIDI is not set
># CONFIG_USB_ACM is not set
># CONFIG_USB_PRINTER is not set
>
>#
># NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be ne=
eded; see USB_STORAGE Help for more information
>#
>CONFIG_USB_STORAGE=3Dm
># CONFIG_USB_STORAGE_DEBUG is not set
># CONFIG_USB_STORAGE_RW_DETECT is not set
># CONFIG_USB_STORAGE_DATAFAB is not set
># CONFIG_USB_STORAGE_FREECOM is not set
># CONFIG_USB_STORAGE_ISD200 is not set
># CONFIG_USB_STORAGE_DPCM is not set
># CONFIG_USB_STORAGE_HP8200e is not set
># CONFIG_USB_STORAGE_SDDR09 is not set
># CONFIG_USB_STORAGE_SDDR55 is not set
># CONFIG_USB_STORAGE_JUMPSHOT is not set
>
>#
># USB Input Devices
>#
>CONFIG_USB_HID=3Dm
>CONFIG_USB_HIDINPUT=3Dy
># CONFIG_HID_FF is not set
>CONFIG_USB_HIDDEV=3Dy
>
>#
># USB HID Boot Protocol drivers
>#
># CONFIG_USB_KBD is not set
># CONFIG_USB_MOUSE is not set
># CONFIG_USB_AIPTEK is not set
># CONFIG_USB_WACOM is not set
># CONFIG_USB_KBTAB is not set
># CONFIG_USB_POWERMATE is not set
># CONFIG_USB_MTOUCH is not set
># CONFIG_USB_EGALAX is not set
># CONFIG_USB_XPAD is not set
># CONFIG_USB_ATI_REMOTE is not set
>
>#
># USB Imaging devices
>#
># CONFIG_USB_MDC800 is not set
># CONFIG_USB_MICROTEK is not set
># CONFIG_USB_HPUSBSCSI is not set
>
>#
># USB Multimedia devices
>#
># CONFIG_USB_DABUSB is not set
># CONFIG_USB_VICAM is not set
># CONFIG_USB_DSBR is not set
># CONFIG_USB_IBMCAM is not set
># CONFIG_USB_KONICAWC is not set
># CONFIG_USB_OV511 is not set
># CONFIG_USB_SE401 is not set
># CONFIG_USB_SN9C102 is not set
># CONFIG_USB_STV680 is not set
>
>#
># USB Network Adapters
>#
># CONFIG_USB_CATC is not set
># CONFIG_USB_KAWETH is not set
># CONFIG_USB_PEGASUS is not set
># CONFIG_USB_RTL8150 is not set
># CONFIG_USB_USBNET is not set
>
>#
># USB port drivers
>#
>
>#
># USB Serial Converter support
>#
>CONFIG_USB_SERIAL=3Dm
># CONFIG_USB_SERIAL_GENERIC is not set
># CONFIG_USB_SERIAL_BELKIN is not set
># CONFIG_USB_SERIAL_WHITEHEAT is not set
># CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
># CONFIG_USB_SERIAL_CYPRESS_M8 is not set
># CONFIG_USB_SERIAL_EMPEG is not set
># CONFIG_USB_SERIAL_FTDI_SIO is not set
>CONFIG_USB_SERIAL_VISOR=3Dm
># CONFIG_USB_SERIAL_IPAQ is not set
># CONFIG_USB_SERIAL_IR is not set
># CONFIG_USB_SERIAL_EDGEPORT is not set
># CONFIG_USB_SERIAL_EDGEPORT_TI is not set
># CONFIG_USB_SERIAL_GARMIN is not set
># CONFIG_USB_SERIAL_IPW is not set
># CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
># CONFIG_USB_SERIAL_KEYSPAN is not set
># CONFIG_USB_SERIAL_KLSI is not set
># CONFIG_USB_SERIAL_KOBIL_SCT is not set
># CONFIG_USB_SERIAL_MCT_U232 is not set
># CONFIG_USB_SERIAL_PL2303 is not set
># CONFIG_USB_SERIAL_SAFE is not set
># CONFIG_USB_SERIAL_TI is not set
># CONFIG_USB_SERIAL_CYBERJACK is not set
># CONFIG_USB_SERIAL_XIRCOM is not set
># CONFIG_USB_SERIAL_OMNINET is not set
>
>#
># USB Miscellaneous drivers
>#
># CONFIG_USB_EMI62 is not set
># CONFIG_USB_EMI26 is not set
># CONFIG_USB_AUERSWALD is not set
># CONFIG_USB_RIO500 is not set
># CONFIG_USB_LEGOTOWER is not set
># CONFIG_USB_LCD is not set
># CONFIG_USB_LED is not set
># CONFIG_USB_CYTHERM is not set
># CONFIG_USB_PHIDGETKIT is not set
># CONFIG_USB_PHIDGETSERVO is not set
># CONFIG_USB_IDMOUSE is not set
># CONFIG_USB_TEST is not set
>
>#
># USB ATM/DSL drivers
>#
>
>#
># USB Gadget Support
>#
># CONFIG_USB_GADGET is not set
>
>#
># MMC/SD Card support
>#
># CONFIG_MMC is not set
>
>#
># InfiniBand support
>#
># CONFIG_INFINIBAND is not set
>
>#
># File systems
>#
>CONFIG_EXT2_FS=3Dy
># CONFIG_EXT2_FS_XATTR is not set
>CONFIG_EXT3_FS=3Dy
>CONFIG_EXT3_FS_XATTR=3Dy
>CONFIG_EXT3_FS_POSIX_ACL=3Dy
># CONFIG_EXT3_FS_SECURITY is not set
>CONFIG_JBD=3Dy
># CONFIG_JBD_DEBUG is not set
>CONFIG_FS_MBCACHE=3Dy
>CONFIG_REISERFS_FS=3Dm
># CONFIG_REISERFS_CHECK is not set
>CONFIG_REISERFS_PROC_INFO=3Dy
>CONFIG_REISERFS_FS_XATTR=3Dy
>CONFIG_REISERFS_FS_POSIX_ACL=3Dy
># CONFIG_REISERFS_FS_SECURITY is not set
># CONFIG_JFS_FS is not set
>CONFIG_FS_POSIX_ACL=3Dy
>
>#
># XFS support
>#
># CONFIG_XFS_FS is not set
># CONFIG_MINIX_FS is not set
># CONFIG_ROMFS_FS is not set
># CONFIG_QUOTA is not set
>CONFIG_DNOTIFY=3Dy
>CONFIG_AUTOFS_FS=3Dm
>CONFIG_AUTOFS4_FS=3Dm
>
>#
># CD-ROM/DVD Filesystems
>#
>CONFIG_ISO9660_FS=3Dm
>CONFIG_JOLIET=3Dy
>CONFIG_ZISOFS=3Dy
>CONFIG_ZISOFS_FS=3Dm
>CONFIG_UDF_FS=3Dm
>CONFIG_UDF_NLS=3Dy
>
>#
># DOS/FAT/NT Filesystems
>#
>CONFIG_FAT_FS=3Dm
>CONFIG_MSDOS_FS=3Dm
>CONFIG_VFAT_FS=3Dm
>CONFIG_FAT_DEFAULT_CODEPAGE=3D850
>CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-15"
># CONFIG_NTFS_FS is not set
>
>#
># Pseudo filesystems
>#
>CONFIG_PROC_FS=3Dy
>CONFIG_PROC_KCORE=3Dy
>CONFIG_SYSFS=3Dy
>CONFIG_DEVFS_FS=3Dy
># CONFIG_DEVFS_MOUNT is not set
># CONFIG_DEVFS_DEBUG is not set
># CONFIG_DEVPTS_FS_XATTR is not set
>CONFIG_TMPFS=3Dy
>CONFIG_TMPFS_XATTR=3Dy
>CONFIG_TMPFS_SECURITY=3Dy
># CONFIG_HUGETLBFS is not set
># CONFIG_HUGETLB_PAGE is not set
>CONFIG_RAMFS=3Dy
>
>#
># Miscellaneous filesystems
>#
># CONFIG_ADFS_FS is not set
># CONFIG_AFFS_FS is not set
># CONFIG_HFS_FS is not set
># CONFIG_HFSPLUS_FS is not set
># CONFIG_BEFS_FS is not set
># CONFIG_BFS_FS is not set
># CONFIG_EFS_FS is not set
># CONFIG_CRAMFS is not set
># CONFIG_VXFS_FS is not set
># CONFIG_HPFS_FS is not set
># CONFIG_QNX4FS_FS is not set
># CONFIG_SYSV_FS is not set
># CONFIG_UFS_FS is not set
>
>#
># Network File Systems
>#
>CONFIG_NFS_FS=3Dm
>CONFIG_NFS_V3=3Dy
># CONFIG_NFS_V4 is not set
># CONFIG_NFS_DIRECTIO is not set
>CONFIG_NFSD=3Dm
>CONFIG_NFSD_V3=3Dy
># CONFIG_NFSD_V4 is not set
>CONFIG_NFSD_TCP=3Dy
>CONFIG_LOCKD=3Dm
>CONFIG_LOCKD_V4=3Dy
>CONFIG_EXPORTFS=3Dm
>CONFIG_SUNRPC=3Dm
># CONFIG_RPCSEC_GSS_KRB5 is not set
># CONFIG_RPCSEC_GSS_SPKM3 is not set
>CONFIG_SMB_FS=3Dm
>CONFIG_SMB_NLS_DEFAULT=3Dy
>CONFIG_SMB_NLS_REMOTE=3D"cp850"
>CONFIG_CIFS=3Dm
>CONFIG_CIFS_STATS=3Dy
>CONFIG_CIFS_XATTR=3Dy
>CONFIG_CIFS_POSIX=3Dy
># CONFIG_CIFS_EXPERIMENTAL is not set
># CONFIG_NCP_FS is not set
># CONFIG_CODA_FS is not set
># CONFIG_AFS_FS is not set
>
>#
># Partition Types
>#
># CONFIG_PARTITION_ADVANCED is not set
>CONFIG_MSDOS_PARTITION=3Dy
>
>#
># Native Language Support
>#
>CONFIG_NLS=3Dy
>CONFIG_NLS_DEFAULT=3D"iso8859-15"
>CONFIG_NLS_CODEPAGE_437=3Dm
># CONFIG_NLS_CODEPAGE_737 is not set
># CONFIG_NLS_CODEPAGE_775 is not set
>CONFIG_NLS_CODEPAGE_850=3Dm
># CONFIG_NLS_CODEPAGE_852 is not set
># CONFIG_NLS_CODEPAGE_855 is not set
># CONFIG_NLS_CODEPAGE_857 is not set
># CONFIG_NLS_CODEPAGE_860 is not set
># CONFIG_NLS_CODEPAGE_861 is not set
># CONFIG_NLS_CODEPAGE_862 is not set
># CONFIG_NLS_CODEPAGE_863 is not set
># CONFIG_NLS_CODEPAGE_864 is not set
># CONFIG_NLS_CODEPAGE_865 is not set
># CONFIG_NLS_CODEPAGE_866 is not set
># CONFIG_NLS_CODEPAGE_869 is not set
># CONFIG_NLS_CODEPAGE_936 is not set
># CONFIG_NLS_CODEPAGE_950 is not set
># CONFIG_NLS_CODEPAGE_932 is not set
># CONFIG_NLS_CODEPAGE_949 is not set
># CONFIG_NLS_CODEPAGE_874 is not set
># CONFIG_NLS_ISO8859_8 is not set
># CONFIG_NLS_CODEPAGE_1250 is not set
># CONFIG_NLS_CODEPAGE_1251 is not set
># CONFIG_NLS_ASCII is not set
>CONFIG_NLS_ISO8859_1=3Dm
># CONFIG_NLS_ISO8859_2 is not set
># CONFIG_NLS_ISO8859_3 is not set
># CONFIG_NLS_ISO8859_4 is not set
># CONFIG_NLS_ISO8859_5 is not set
># CONFIG_NLS_ISO8859_6 is not set
># CONFIG_NLS_ISO8859_7 is not set
># CONFIG_NLS_ISO8859_9 is not set
># CONFIG_NLS_ISO8859_13 is not set
># CONFIG_NLS_ISO8859_14 is not set
>CONFIG_NLS_ISO8859_15=3Dm
># CONFIG_NLS_KOI8_R is not set
># CONFIG_NLS_KOI8_U is not set
>CONFIG_NLS_UTF8=3Dm
>
>#
># Profiling support
>#
># CONFIG_PROFILING is not set
>
>#
># Kernel hacking
>#
>CONFIG_DEBUG_KERNEL=3Dy
>CONFIG_MAGIC_SYSRQ=3Dy
>CONFIG_SCHEDSTATS=3Dy
># CONFIG_DEBUG_SLAB is not set
>CONFIG_DEBUG_PREEMPT=3Dy
># CONFIG_DEBUG_SPINLOCK is not set
># CONFIG_DEBUG_SPINLOCK_SLEEP is not set
># CONFIG_DEBUG_KOBJECT is not set
>CONFIG_DEBUG_BUGVERBOSE=3Dy
># CONFIG_DEBUG_INFO is not set
>CONFIG_DEBUG_FS=3Dy
># CONFIG_FRAME_POINTER is not set
>CONFIG_EARLY_PRINTK=3Dy
>CONFIG_DEBUG_STACKOVERFLOW=3Dy
># CONFIG_KPROBES is not set
># CONFIG_DEBUG_STACK_USAGE is not set
># CONFIG_DEBUG_PAGEALLOC is not set
>CONFIG_4KSTACKS=3Dy
>
>#
># Security options
>#
># CONFIG_KEYS is not set
># CONFIG_SECURITY is not set
>
>#
># Cryptographic options
>#
># CONFIG_CRYPTO is not set
>
>#
># Hardware crypto devices
>#
>
>#
># Library routines
>#
>CONFIG_CRC_CCITT=3Dm
>CONFIG_CRC32=3Dy
># CONFIG_LIBCRC32C is not set
>CONFIG_ZLIB_INFLATE=3Dm
>CONFIG_ZLIB_DEFLATE=3Dm
>CONFIG_GENERIC_HARDIRQS=3Dy
>CONFIG_GENERIC_IRQ_PROBE=3Dy
>CONFIG_X86_BIOS_REBOOT=3Dy
>CONFIG_PC=3Dy
> =20
>
>------------------------------------------------------------------------
>
>Linux version 2.6.11=3DMacvin (bgoglin@macvin) (version gcc 3.3.5 (Debia=
n 1:3.3.5-8)) #2 Tue Mar 8 10:20:10 CET 2005
>BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000001fe71000 (usable)
> BIOS-e820: 000000001fe71000 - 000000001fe73000 (ACPI NVS)
> BIOS-e820: 000000001fe73000 - 000000001fe94000 (ACPI data)
> BIOS-e820: 000000001fe94000 - 000000001ff00000 (reserved)
> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
> BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
>510MB LOWMEM available.
>On node 0 totalpages: 130673
>  DMA zone: 4096 pages, LIFO batch:1
>  Normal zone: 126577 pages, LIFO batch:16
>  HighMem zone: 0 pages, LIFO batch:1
>DMI 2.3 present.
>ACPI: RSDP (v000 DELL                                  ) @ 0x000feba0
>ACPI: RSDT (v001 DELL    GX260   0x00000009 ASL  0x00000061) @ 0x000fd50=
9
>ACPI: FADT (v001 DELL    GX260   0x00000009 ASL  0x00000061) @ 0x000fd54=
1
>ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffdacc=
c
>ACPI: MADT (v001 DELL    GX260   0x00000009 ASL  0x00000061) @ 0x000fd5b=
5
>ACPI: BOOT (v001 DELL    GX260   0x00000009 ASL  0x00000061) @ 0x000fd62=
1
>ACPI: ASF! (v016 DELL    GX260   0x00000009 ASL  0x00000061) @ 0x000fd64=
9
>ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x0000000=
0
>ACPI: PM-Timer IO Port: 0x808
>Allocating PCI resources starting at 1ff00000 (gap: 1ff00000:ded00000)
>Built 1 zonelists
>Kernel command line: BOOT_IMAGE=3D2.6.11-fb ro root=3D301
>Initializing CPU#0
>CPU 0 irqstacks, hard=3Dc045a000 soft=3Dc0459000
>PID hash table entries: 2048 (order: 11, 32768 bytes)
>Detected 2391.541 MHz processor.
>Using pmtmr for high-res timesource
>Console: colour VGA+ 80x25
>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>Memory: 513920k/522692k available (2200k kernel code, 8204k reserved, 10=
44k data, 156k init, 0k highmem)
>Checking if this processor honours the WP bit even in supervisor mode...=
 Ok.
>Calibrating delay loop... 4734.97 BogoMIPS (lpj=3D2367488)
>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
>CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0=
0004400 00000000 00000000
>CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00=
004400 00000000 00000000
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400=
 00000000 00000000
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
>CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>ACPI: setting ELCR to 0200 (from 0e08)
>NET: Registered protocol family 16
>PCI: PCI BIOS revision 2.10 entry at 0xfbdea, last bus=3D1
>PCI: Using configuration type 1
>mtrr: v2.0 (20020519)
>ACPI: Subsystem revision 20050211
>ACPI: Interpreter enabled
>ACPI: Using PIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (00:00)
>PCI: Probing PCI hardware (bus 00)
>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
>PCI: Transparent bridge - 0000:00:1e.0
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 15)
>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 15)
>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 15)
>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disab=
led.
>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disab=
led.
>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disab=
led.
>ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 15)
>Linux Plug and Play Support v0.97 (c) Adam Belay
>pnp: PnP ACPI init
>pnp: PnP ACPI: found 11 devices
>PnPBIOS: Disabled by ACPI PNP
>SCSI subsystem initialized
>usbcore: registered new driver usbfs
>usbcore: registered new driver hub
>PCI: Using ACPI for IRQ routing
>** PCI interrupts are no longer routed automatically.  If this
>** causes a device to stop working, it is probably because the
>** driver failed to call pci_enable_device().  As a temporary
>** workaround, the "pci=3Drouteirq" argument restores the old
>** behavior.  If this argument makes the device work again,
>** please email the output of "lspci" to bjorn.helgaas@hp.com
>** so I can fix the driver.
>pnp: 00:0a: ioport range 0x800-0x85f could not be reserved
>pnp: 00:0a: ioport range 0xc00-0xc7f has been reserved
>pnp: 00:0a: ioport range 0x860-0x8ff could not be reserved
>Simple Boot Flag at 0x7a set to 0x80
>Machine check exception polling timer started.
>devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
>devfs: boot_options: 0x0
>ACPI: Power Button (FF) [PWRF]
>Linux agpgart interface v0.100 (c) Dave Jones
>agpgart: Detected an Intel 845G Chipset.
>agpgart: Maximum main memory to use for agp memory: 438M
>agpgart: Detected 892K stolen memory.
>agpgart: AGP aperture is 128M @ 0xe8000000
>[drm] Initialized drm 1.0.0 20040925
>intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G chip=
sets
>intelfb: Version 0.9.2
>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
>PCI: setting IRQ 9 as level-triggered
>ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 9 (level, low) -> IRQ 9
>intelfb: 00:02.0: Intel(R) 845G, aperture size 128MB, stolen memory 892k=
B
>intelfb: Mode is interlaced.
>intelfb: Initial video mode is 1024x768-16@60.
>Console: switching to colour frame buffer device 128x48
>ACPI: PS/2 Keyboard Controller [KBD] at I/O 0x60, 0x64, irq 1
>ACPI: PS/2 Mouse Controller [MOU] at irq 12
>serio: i8042 AUX port at 0x60,0x64 irq 12
>serio: i8042 KBD port at 0x60,0x64 irq 1
>io scheduler noop registered
>io scheduler anticipatory registered
>io scheduler deadline registered
>io scheduler cfq registered
>Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2
>Copyright (c) 1999-2004 Intel Corporation.
>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
>PCI: setting IRQ 10 as level-triggered
>ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
>e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
>ICH4: IDE controller at PCI slot 0000:00:1f.1
>PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
>ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
>ICH4: chipset revision 1
>ICH4: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
>Probing IDE interface ide0...
>hda: IC35L060AVV207-0, ATA DISK drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>Probing IDE interface ide1...
>hdc: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
>ide1 at 0x170-0x177,0x376 on irq 15
>Probing IDE interface ide2...
>Probing IDE interface ide3...
>Probing IDE interface ide4...
>Probing IDE interface ide5...
>hda: max request size: 1024KiB
>hda: 78125000 sectors (40000 MB) w/1821KiB Cache, CHS=3D16383/255/63, UD=
MA(100)
>hda: cache flushes supported
> /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
>hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
>Uniform CD-ROM driver Revision: 3.20
>mice: PS/2 mouse device common for all mice
>input: AT Translated Set 2 keyboard on isa0060/serio0
>input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
>input: PC Speaker
>Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39=
:32 2005 UTC).
>ALSA device list:
>  No soundcards found.
>NET: Registered protocol family 2
>IP: routing cache hash table of 4096 buckets, 32Kbytes
>TCP established hash table entries: 16384 (order: 5, 131072 bytes)
>TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
>TCP: Hash tables configured (established 16384 bind 16384)
>NET: Registered protocol family 1
>NET: Registered protocol family 17
>ACPI wakeup devices:=20
>VBTN PCI0 USB0 USB1 USB2 PCI1  KBD=20
>ACPI: (supports S0 S1 S3 S4 S5)
>VFS: Mounted root (ext2 filesystem) readonly.
>Freeing unused kernel memory: 156k freed
>Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1
>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
>PCI: setting IRQ 11 as level-triggered
>ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
>PCI: Setting latency timer of device 0000:00:1f.5 to 64
>intel8x0_measure_ac97_clock: measured 49237 usecs
>intel8x0: clocking to 48000
>kjournald starting.  Commit interval 5 seconds
>EXT3 FS on hda5, internal journal
>EXT3-fs: mounted filesystem with ordered data mode.
>kjournald starting.  Commit interval 5 seconds
>EXT3 FS on hda3, internal journal
>EXT3-fs: mounted filesystem with ordered data mode.
>kjournald starting.  Commit interval 5 seconds
>EXT3 FS on hda6, internal journal
>EXT3-fs: mounted filesystem with ordered data mode.
>ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 3
>PCI: setting IRQ 3 as level-triggered
>ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 3 (level, low) -> IRQ 3
>ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHC=
I Controller
>PCI: Setting latency timer of device 0000:00:1d.7 to 64
>ehci_hcd 0000:00:1d.7: irq 3, pci mem 0xffa00800
>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
>PCI: cache line size of 128 is not supported by device 0000:00:1d.7
>ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 200=
4
>hub 1-0:1.0: USB hub found
>hub 1-0:1.0: 6 ports detected
>USB Universal Host Controller Interface driver v2.2
>ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 9 (level, low) -> IRQ 9
>uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) =
USB UHCI Controller #1
>PCI: Setting latency timer of device 0000:00:1d.0 to 64
>uhci_hcd 0000:00:1d.0: irq 9, io base 0xff80
>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
>hub 2-0:1.0: USB hub found
>hub 2-0:1.0: 2 ports detected
>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
>ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
>uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) =
USB UHCI Controller #2
>PCI: Setting latency timer of device 0000:00:1d.1 to 64
>uhci_hcd 0000:00:1d.1: irq 11, io base 0xff60
>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
>hub 3-0:1.0: USB hub found
>hub 3-0:1.0: 2 ports detected
>ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
>uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) =
USB UHCI Controller #3
>PCI: Setting latency timer of device 0000:00:1d.2 to 64
>uhci_hcd 0000:00:1d.2: irq 10, io base 0xff40
>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
>hub 4-0:1.0: USB hub found
>hub 4-0:1.0: 2 ports detected
>Floppy drive(s): fd0 is 1.44M
>FDC 0 is a post-1991 82077
>e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
>ip_tables: (C) 2000-2002 Netfilter core team
>ip_conntrack version 2.1 (4083 buckets, 32664 max) - 212 bytes per connt=
rack
>device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
>tun: Universal TUN/TAP device driver, 1.6
>tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
>intelfb: ring buffer : space: 8488 wanted 65472
>intelfb: lockup - turning off hardware acceleration
> =20
>
>------------------------------------------------------------------------
>
>0000:00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM =
Controller/Host-Hub Interface (rev 01)
>	Subsystem: Dell: Unknown device 0126
>	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort+ >SERR- <PERR-
>	Latency: 0
>	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=3D128M]
>	Capabilities: <available only to root>
>
>0000:00:02.0 VGA compatible controller: Intel Corp. 82845G/GL[Brookdale-=
G]/GE Chipset Integrated Graphics Device (rev 01) (prog-if 00 [VGA])
>	Subsystem: Dell: Unknown device 0126
>	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR-
>	Interrupt: pin A routed to IRQ 9
>	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=3D128M]
>	Region 1: Memory at ff680000 (32-bit, non-prefetchable) [size=3D512K]
>	Capabilities: <available only to root>
>
>0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/IC=
H4-M) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
>	Subsystem: Dell: Unknown device 0126
>	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
>	Latency: 0
>	Interrupt: pin A routed to IRQ 9
>	Region 4: I/O ports at ff80 [size=3D32]
>
>0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/IC=
H4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
>	Subsystem: Dell: Unknown device 0126
>	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
>	Latency: 0
>	Interrupt: pin B routed to IRQ 11
>	Region 4: I/O ports at ff60 [size=3D32]
>
>0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/IC=
H4-M) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
>	Subsystem: Dell: Unknown device 0126
>	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
>	Latency: 0
>	Interrupt: pin C routed to IRQ 10
>	Region 4: I/O ports at ff40 [size=3D32]
>
>0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2=
.0 EHCI Controller (rev 01) (prog-if 20 [EHCI])
>	Subsystem: Dell: Unknown device 0126
>	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
>	Latency: 0
>	Interrupt: pin D routed to IRQ 3
>	Region 0: Memory at ffa00800 (32-bit, non-prefetchable) [size=3D1K]
>	Capabilities: <available only to root>
>
>0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81) (prog-if =
00 [Normal decode])
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbor=
t- <MAbort- >SERR- <PERR+
>	Latency: 0
>	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
>	I/O behind bridge: 0000e000-0000efff
>	Memory behind bridge: ff800000-ff9fffff
>	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
>
>0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridg=
e (rev 01)
>	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
>	Latency: 0
>
>0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraA=
TA-100 IDE Controller (rev 01) (prog-if 8a [Master SecP PriP])
>	Subsystem: Dell: Unknown device 0126
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
>	Latency: 0
>	Interrupt: pin A routed to IRQ 10
>	Region 0: I/O ports at <unassigned>
>	Region 1: I/O ports at <unassigned>
>	Region 2: I/O ports at <unassigned>
>	Region 3: I/O ports at <unassigned>
>	Region 4: I/O ports at ffa0 [size=3D16]
>	Region 5: Memory at 1ff00000 (32-bit, non-prefetchable) [size=3D1K]
>
>0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMB=
us Controller (rev 01)
>	Subsystem: Dell: Unknown device 0126
>	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
>	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
>	Interrupt: pin B routed to IRQ 11
>	Region 4: I/O ports at dc80 [size=3D32]
>
>0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (I=
CH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
>	Subsystem: Dell: Unknown device 0126
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste=
pping- SERR- FastB2B-
>	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
>	Latency: 0
>	Interrupt: pin B routed to IRQ 11
>	Region 0: I/O ports at d800 [size=3D256]
>	Region 1: I/O ports at dc40 [size=3D64]
>	Region 2: Memory at ffa00400 (32-bit, non-prefetchable) [size=3D512]
>	Region 3: Memory at ffa00000 (32-bit, non-prefetchable) [size=3D256]
>	Capabilities: <available only to root>
>
>0000:01:0c.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet C=
ontroller (rev 02)
>	Subsystem: Dell: Unknown device 002e
>	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Ste=
pping- SERR+ FastB2B-
>	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
>	Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
>	Interrupt: pin A routed to IRQ 10
>	Region 0: Memory at ff8e0000 (32-bit, non-prefetchable) [size=3D128K]
>	Region 2: I/O ports at ecc0 [size=3D64]
>	Capabilities: <available only to root>
>
> =20
>





-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
