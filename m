From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Subject: radeonfb doesn't work with an ati X800 pcie card
Date: Tue, 27 Mar 2007 17:49:54 +0200
Message-ID: <46093D22.3090401@gmx.net>
Reply-To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030303080806070008000502"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWDwY-000125-GU for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 08:50:43 -0700
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]
	helo=snowman.cryosphere.shacknet.nu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWDwU-00075s-E4
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 08:50:42 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: benh@kernel.crashing.org, kronos.it@gmail.com, pizza@shaftnet.org

This is a multi-part message in MIME format.
--------------030303080806070008000502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

i'm trying to get my X800 XL pcie card working without more success 
(that "genuine" ati card gives me quite a lot of headache ). It just 
hard locks up with a black screen of the death after loading radeonfb.

Thank to Solomon Peachy <pizza@shaftnet.org>, Luca Tettamanti 
<kronos.it@gmail.com> and Benjamin Herrenschmidt 
<benh@kernel.crashing.org>, i was able to patch the 2.6.20 kernel 
radeonfb module and make it more tolerant. (See attachements)
The driver compiles well and doesn't oops, but the screen still stays 
black and goes in standby mode as soon as the radeonfb was loaded.

Fortunately, at boot time when loading in that order the vga16fb module 
framebuffer as /dev/fb0  and afterward the readeonfb as /dev/fb1, i'm 
able to see some messages returned from the driver. The pc doesn't lock 
up. That will for sure help to diagnose the issue. Moreover, X11 with 
GPL radeon driver works well.

Certainly not related to the current issue, radeonfb and x11 disagree 
how many memories the video card really has. radeonfb found half the 
content and detects the dvi connector where the flat screen is attached 
to quite well but identifies a CRT monitor instead of a TMDS.

I'm not sure the patches i applied were the most recent available. Any 
informations are welcome.

The options i used (i will try more or less of them and see if there are 
any improvements)
options radeonfb mode_option=1680x1050-32@60
#options radeonfb mirror=1
options radeonfb radeonfb_debug=1
options radeonfb monitor_layout=TMDS,NONE

# scripts/ver_linux

Linux seal 2.6.20-vs2.3.0.11-gentoo #27 PREEMPT Mon Mar 26 19:06:31 CEST 
2007 x86_64 AMD Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17.50.0.12
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
reiserfsprogs          3.6.19
Linux C Library        > libc.2.5
Dynamic linker (ldd)   2.5
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               6.7
udev                   107
Modules Loaded         powernow_k8 freq_table processor nfsd exportfs 
lockd nfs_acl sunrpc eeprom it87 hwmon_vid i2c_isa snd_seq_midi 
snd_pcm_oss snd_mixer_oss snd_seq_oss snd_usb_audio snd_usb_lib 
snd_hwdep dm_mod snd_seq_virmidi snd_seq_midi_event snd_seq pktcdvd lp 
snd_rtctimer hangcheck_timer nvram softdog uinput eth1394 snd_mpu401 
snd_mpu401_uart snd_rawmidi snd_seq_device ohci1394 ieee1394 parport_pc 
parport analog gameport floppy rtc sr_mod cdrom radeonfb k8temp hwmon 
pcspkr usbhid hid sg raid1 md_mod snd_intel8x0 snd_ac97_codec snd_pcm 
snd_timer snd soundcore snd_page_alloc ac97_bus marvell libphy forcedeth 
usb_storage libusual ohci_hcd ehci_hcd usbcore evdev ext3 jbd ext2 
mbcache sata_nv pata_amd ata_generic libata sd_mod scsi_mod vga16fb 
vgastate fb_ddc cfbfillrect cfbimgblt cfbcopyarea i2c_nforce2 
i2c_algo_bit i2c_dev i2c_core fbcon bitblit fbcon_rotate fbcon_cw 
fbcon_ud fbcon_ccw softcursor fb font crc32

I've added some debug output from dmesg, radeonfb and xorg, as well.

# cat /var/log/kern.log
Mar 27 11:06:11 seal radeonfb_pci_register BEGIN
Mar 27 11:06:11 seal ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
Mar 27 11:06:11 seal ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC3] 
-> GSI 18 (level, low) -> IRQ 18
Mar 27 11:06:11 seal radeonfb (0000:01:00.0): Found 131072k of DDR 256 
bits wide videoram
Mar 27 11:06:11 seal radeonfb (0000:01:00.0): mapped 16384k videoram
Mar 27 11:06:11 seal radeonfb: Found Intel x86 BIOS ROM Image
Mar 27 11:06:11 seal Retrieved PLL infos from ATOM BIOS
Mar 27 11:06:11 seal radeonfb: Reference=27.00 MHz (RefDiv=2) 
Memory=500.00 Mhz, System=500.00 MHz
Mar 27 11:06:11 seal PLL min 20000 max 50000
Mar 27 11:06:11 seal TMDS PLL from BIOS: 16500 b011c
Mar 27 11:06:11 seal index 0 port 1 conn 1 dac 0 ddc 1 tmds -1
Mar 27 11:06:11 seal index 2 port 0 conn 5 dac 1 ddc 2 tmds -1
Mar 27 11:06:11 seal index 3 port 2 conn 2 dac -1 ddc 0 tmds 0
Mar 27 11:06:11 seal index 4 port 2 conn 2 dac 1 ddc 0 tmds -1
Mar 27 11:06:11 seal Using specified monitor layout: TMDS,NONE
Mar 27 11:06:11 seal radeonfb: I2C (port 0) ... found CRT display
Mar 27 11:06:11 seal * Connector 1 is DVI-I. Head 0, Monitor: CRT (EDID 
probed)
Mar 27 11:06:11 seal ddc port: 0, dac: 1, tmds: 0
Mar 27 11:06:11 seal * Connector 3 is S-Video. Head -1, Monitor: Not 
Probed Yet
Mar 27 11:06:11 seal ddc port: 2, dac: 1, tmds: -1
Mar 27 11:06:11 seal modedb fb_find_mode: Trying specified video mode 
1680x1050
Mar 27 11:06:11 seal modedb fb_try_mode: Trying mode noname 1680x1050-32@59
Mar 27 11:06:11 seal modedb fb_try_mode: Trying mode noname 1680x1050-32@59
Mar 27 11:06:11 seal radeonfb (0000:01:00.0): ATI Radeon ]W
Mar 27 11:06:11 seal radeonfb_pci_register END

# lspci

01:00.0 VGA compatible controller: ATI Technologies Inc R423 5F57 
[Radeon X800XT (PCIE)]

# cat /var/log/Xorg.0.log

(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon X800XT (R423) 5D57 (PCIE)" (ChipID 
= 0x5d57)
(--) RADEON(0): Linear framebuffer at 0xc0000000
(--) RADEON(0): BIOS at 0xd0000000
(II) RADEON(0): PCIE card detected
(**) RADEON(0): Forced into PCI Express mode
(II) RADEON(0): Generation 2 PCI interface, using max accessible memory
(II) RADEON(0): Detected total video RAM=262144K, accessible=262144K 
(PCI BAR=262144K)
(--) RADEON(0): Mapped VideoRAM: 262144 kByte (256 bit DDR SDRAM)

[...]

(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): ATOM BIOS detected
(II) RADEON(0): Port0: DDCType-2, DACType-0, TMDSType--1, ConnectorType-1
(II) RADEON(0): Port1: DDCType-1, DACType-1, TMDSType-0, ConnectorType-2
(**) RADEON(0): MonitorLayout Option:
        Monitor1--Type TMDS, Monitor2--Type CRT

(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 1, Detected Type: 3
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 2, Detected Type: 0
(II) RADEON(0): EDID data from the display on port 1 ----------------------
(II) RADEON(0): Manufacturer: ACR  Model: ad74  Serial#: 1694504369
(II) RADEON(0): Year: 2006  Week: 50
(II) RADEON(0): EDID Version: 1.3
(II) RADEON(0): Digital Display Input

[...]

(II) RADEON(0): Supported additional Video Mode:
(II) RADEON(0): clock: 146.2 MHz   Image Size:  473 x 296 mm
(II) RADEON(0): h_active: 1680  h_sync: 1784  h_sync_end 1960 
h_blank_end 2240 h_border: 0
(II) RADEON(0): v_active: 1050  v_sync: 1053  v_sync_end 1059 
v_blanking: 1089 v_border: 0
(II) RADEON(0): Ranges: V min: 56  V max: 76 Hz, H min: 30  H max: 82 
kHz, PixClock max 160 MHz
(II) RADEON(0): Monitor name: Acer AL2216W
(II) RADEON(0): Serial No: L74090466420
(II) RADEON(0): EDID (in hex):
(II) RADEON(0):         00ffffffffffff00047274adb1150065
(II) RADEON(0):         32100103e82f1e782ec585a459499a24
(II) RADEON(0):         125054bfef0081808140714f9500950f
(II) RADEON(0):         b30081c08bc021399030621a274068b0
(II) RADEON(0):         3600d9281100001c000000fd00384c1e
(II) RADEON(0):         5210000a202020202020000000fc0041
(II) RADEON(0):         63657220414c32323136570a000000ff
(II) RADEON(0):         004c373430393034363634323020003e
(II) RADEON(0):
(II) RADEON(0): Primary:
 Monitor   -- TMDS
 Connector -- DVI-I
 DAC Type  -- TVDAC/ExtDAC
 TMDS Type -- Internal
 DDC Type  -- MONID
(II) RADEON(0): Secondary:
 Monitor   -- CRT
 Connector -- VGA
 DAC Type  -- Primary
 TMDS Type -- NONE
 DDC Type  -- DVI_DDC
(II) RADEON(0): ref_freq: 2700, min_pll: 20000, max_pll: 50000, xclk: 
40000, sclk: 500.000000, mclk: 500.000000
(II) RADEON(0): PLL parameters: rf=2700 rd=2 min=20000 
max=47742856512336; xclk=40000
(WW) RADEON(0): Failed to detect secondary monitor DDC, default HSync 
and VRefresh used
(II) RADEON(0): MergedFB mode forced off.
(**) RADEON(0): Using gamma correction (0.5, 0.5, 0.5)
(II) RADEON(0): Validating modes on Primary head ---------
(II) RADEON(0): TMDS PLL from BIOS: 16500 b011c
(II) RADEON(0): Panel infos found from DDC detailed: 1680x1050
(II) RADEON(0): Valid Mode from Detailed timing table: 1680x1050
(II) RADEON(0): Total of 1 mode(s) found.
(II) RADEON(0): Total number of valid DDC mode(s) found: 1
(II) RADEON(0): Valid mode using on-chip RMX: 1680x1050
(II) RADEON(0): Valid mode using on-chip RMX: 1440x900
(II) RADEON(0): Valid mode using on-chip RMX: 1280x960
(II) RADEON(0): Valid mode using on-chip RMX: 1024x640
(II) RADEON(0): Valid mode using on-chip RMX: 800x500
(II) RADEON(0): Total number of valid FP mode(s) found: 5

[...]

(II) RADEON(0): MM_TABLE: 8a-fa-80-e7-8c-52-80-e2-11-d0-e2-0a-fa-5a
(II) RADEON(0): This card has MM_TABLE we do not recognize.

[3.] Keywords (i.e., modules, networking, kernel):
modules, radeonfb, framebuffer, console, kernel
[4.] Kernel information
[4.1.] Kernel version (from /proc/version):
Linux version 2.6.20-vs2.3.0.11-gentoo (root@seal) (version gcc 4.1.2 
(Gentoo 4.1.2)) #27 PREEMPT Mon Mar 26 19:06:31 CEST 2007

[4.2.] Kernel .config file:
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_ZONE_DMA32=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_DMI=y
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_IPC_NS=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_UTS_NS=y
CONFIG_IKCONFIG=m
CONFIG_IKCONFIG_PROC=y
CONFIG_RELAY=y
CONFIG_INITRAMFS_SOURCE="/usr/src/initramfs.lst"
CONFIG_INITRAMFS_ROOT_UID=0
CONFIG_INITRAMFS_ROOT_GID=0
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_TASK_XACCT=y
CONFIG_SYSCTL=y
CONFIG_UID16=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y

CONFIG_BLOCK=y

CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=m
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=m
CONFIG_DEFAULT_DEADLINE=y
CONFIG_DEFAULT_IOSCHED="deadline"

CONFIG_X86_PC=y
CONFIG_MK8=y
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTERNODE_CACHE_BYTES=64
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y

CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_HPET_TIMER=y
CONFIG_IOMMU=y
CONFIG_SWIOTLB=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_AMD=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_SECCOMP=y
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_REORDER=y
CONFIG_K8_NB=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_ISA_DMA_API=y

CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION=""

CONFIG_ACPI=y
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=m
CONFIG_CPU_FREQ_STAT=m
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_POWERNOW_K8_ACPI=y
CONFIG_X86_ACPI_CPUFREQ=m


CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCIEPORTBUS=y
CONFIG_PCIEAER=y
CONFIG_PCI_MSI=y
CONFIG_HT_IRQ=y



CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IA32_EMULATION=y
CONFIG_IA32_AOUT=m
CONFIG_COMPAT=y
CONFIG_SYSVIPC_COMPAT=y

CONFIG_NET=y

CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_NET_IPIP=m
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_CUBIC=m
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_DEFAULT_BIC=y
CONFIG_DEFAULT_TCP_CONG="bic"




CONFIG_NET_SCHED=y
CONFIG_NET_SCH_FIFO=y
CONFIG_NET_SCH_CLK_JIFFIES=y

CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m

CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_CLS_IND=y
CONFIG_NET_ESTIMATOR=y

CONFIG_IRDA=m

CONFIG_IRLAN=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y


CONFIG_IRTTY_SIR=m


CONFIG_IRPORT_SIR=m


CONFIG_USB_IRDA=m
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m

CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_IEEE80211=m
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_SOFTMAC=m
CONFIG_WIRELESS_EXT=y
CONFIG_FIB_RULES=y


CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m

CONFIG_CONNECTOR=m

CONFIG_MTD=m

CONFIG_MTD_CHAR=m
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m

CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m

CONFIG_MTD_CK804XROM=m

CONFIG_MTD_PHRAM=m




CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y

CONFIG_PNP=y

CONFIG_PNPACPI=y

CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_VROOT=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8

CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m

CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_IDE_TASK_IOCTL=y

CONFIG_IDE_GENERIC=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_AMD74XX=m
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

CONFIG_SCSI=m

CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m

CONFIG_SCSI_MULTI_LUN=y



CONFIG_ATA=m
CONFIG_SATA_NV=m
CONFIG_PATA_AMD=m
CONFIG_ATA_GENERIC=m

CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_RAID5_RESHAPE=y
CONFIG_MD_FAULTY=m
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_BLK_DEV_DM_BBR=m


CONFIG_IEEE1394=m

CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
CONFIG_IEEE1394_CONFIG_ROM_IP1394=y

CONFIG_IEEE1394_OHCI1394=m

CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m


CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m


CONFIG_PHYLIB=m

CONFIG_MARVELL_PHY=m

CONFIG_NET_ETHERNET=y
CONFIG_MII=m

CONFIG_NET_PCI=y
CONFIG_FORCEDETH=m

CONFIG_SKGE=m

CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=y

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y

CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_NR_UARTS=1
CONFIG_SERIAL_8250_RUNTIME_UARTS=1

CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=m


CONFIG_WATCHDOG=y

CONFIG_SOFT_WATCHDOG=m


CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_DRM=m
CONFIG_DRM_RADEON=m
CONFIG_HPET=y
CONFIG_HPET_RTC_IRQ=y
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m


CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

CONFIG_I2C_ALGOBIT=m

CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_STUB=m

CONFIG_SENSORS_EEPROM=m



CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_IT87=m

CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=y


CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_OV7670=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_CX25840=m
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_SAA5246A=m
CONFIG_VIDEO_SAA5249=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_HEXIUM_GEMINI=m
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CAFE_CCIC=m

CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_29XXX=y
CONFIG_VIDEO_PVRUSB2_24XXX=y
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_USBVISION=m


CONFIG_DVB=y
CONFIG_DVB_CORE=m
CONFIG_DVB_CORE_ATTACH=y


CONFIG_DVB_USB=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
CONFIG_DVB_USB_DIBUSB_MB_FAULTY=y
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_DVB_CINERGYT2=m
CONFIG_DVB_CINERGYT2_TUNING=y
CONFIG_DVB_CINERGYT2_STREAM_URB_COUNT=32
CONFIG_DVB_CINERGYT2_STREAM_BUF_SIZE=512
CONFIG_DVB_CINERGYT2_QUERY_INTERVAL=250
CONFIG_DVB_CINERGYT2_ENABLE_RC_INPUT_DEVICE=y
CONFIG_DVB_CINERGYT2_RC_QUERY_INTERVAL=50



CONFIG_DVB_PLUTO2=m


CONFIG_DVB_FE_CUSTOMISE=y

CONFIG_DVB_STV0299=m
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_MT312=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_TDA10086=m

CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m

CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_STV0297=m

CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m

CONFIG_DVB_PLL=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUNER_MT2060=m
CONFIG_DVB_TUNER_LGH06XF=m

CONFIG_DVB_LNBP21=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_TUA6100=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_VIDEO_VIDEOBUF=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m
CONFIG_VIDEO_TVEEPROM=m

CONFIG_FIRMWARE_EDID=y
CONFIG_FB=m
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_VGA16=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_DEBUG=y

CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_DEVICE=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_DEVICE=y

CONFIG_SPEAKUP=m
CONFIG_SPEAKUP_SFTSYN=m

CONFIG_SPEAKUP_DEFAULT="sftsyn"

CONFIG_SOUND=m

CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_VERBOSE_PROCFS=y

CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MPU401=m

CONFIG_SND_INTEL8X0=m
CONFIG_SND_AC97_POWER_SAVE=y

CONFIG_SND_USB_AUDIO=m

CONFIG_AC97_BUS=m

CONFIG_HID=m

CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m

CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_SUSPEND=y

CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y

CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m


CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_LIBUSUAL=y

CONFIG_USB_HID=m
CONFIG_HID_FF=y
CONFIG_LOGITECH_FF=y
CONFIG_USB_HIDDEV=y

CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m


CONFIG_USB_MON=y


CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y

CONFIG_USB_LD=m




CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m


CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_IDE_DISK=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m


CONFIG_EDAC=m

CONFIG_EDAC_MM_EDAC=m
CONFIG_EDAC_POLL=y

CONFIG_RTC_LIB=m
CONFIG_RTC_CLASS=m

CONFIG_RTC_INTF_SYSFS=m
CONFIG_RTC_INTF_PROC=m
CONFIG_RTC_INTF_DEV=m
CONFIG_RTC_INTF_DEV_UIE_EMUL=y


CONFIG_DMA_ENGINE=y

CONFIG_NET_DMA=y


CONFIG_KVM=m
CONFIG_KVM_AMD=m

CONFIG_EDD=m

CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4DEV_FS=m
CONFIG_EXT4DEV_FS_XATTR=y
CONFIG_EXT4DEV_FS_POSIX_ACL=y
CONFIG_EXT4DEV_FS_SECURITY=y
CONFIG_JBD=m
CONFIG_JBD_DEBUG=y
CONFIG_JBD2=m
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_FS_POSIX_ACL=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m
CONFIG_GENERIC_ACL=y

CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y

CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m

CONFIG_ECRYPT_FS=m
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_SUMMARY=y
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_JFFS2_RUBIN=y
CONFIG_JFFS2_CMODE_PRIORITY=y
CONFIG_CRAMFS=m
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3

CONFIG_NFS_FS=m
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_EXPERIMENTAL=y
CONFIG_CODA_FS=m

CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y

CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m

CONFIG_DLM=m
CONFIG_DLM_TCP=y

CONFIG_PROFILING=y
CONFIG_OPROFILE=m
CONFIG_KPROBES=y

CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=16
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_RT_MUTEX_TESTER=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_STACKTRACE=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_FRAME_POINTER=y
CONFIG_RCU_TORTURE_TEST=m
CONFIG_LKDTM=m
CONFIG_DEBUG_RODATA=y
CONFIG_DEBUG_STACKOVERFLOW=y

CONFIG_VSERVER_AUTO_LBACK=y
CONFIG_VSERVER_COWBL=y
CONFIG_VSERVER_PROC_SECURE=y
CONFIG_TAGGING_ID24=y
CONFIG_VSERVER_PRIVACY=y
CONFIG_VSERVER_DEBUG=y
CONFIG_VSERVER_HISTORY=y
CONFIG_VSERVER_HISTORY_SIZE=64
CONFIG_VSERVER_MONITOR=y
CONFIG_VSERVER_MONITOR_SIZE=1024
CONFIG_VSERVER_MONITOR_SYNC=256
CONFIG_VSERVER=y
CONFIG_VSERVER_SECURITY=y

CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
CONFIG_SECURITY=y
CONFIG_SECURITY_CAPABILITIES=y

CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=m
CONFIG_CRYPTO_BLKCIPHER=m
CONFIG_CRYPTO_HASH=m
CONFIG_CRYPTO_MANAGER=m
CONFIG_CRYPTO_HMAC=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_X86_64=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m


CONFIG_BITREVERSE=m
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_PLIST=y
CONFIG_IOMAP_COPY=y


[8.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 47
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 2
cpu MHz         : 2000.000
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt 
lm 3dnowext 3dnow pni lahf_lm
bogomips        : 4031.49
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

[8.3.] Module information (from /proc/modules):

# cat /proc/modules
powernow_k8 11416 0 - Live 0xffffffff883d5000
freq_table 5320 1 powernow_k8, Live 0xffffffff883d2000
processor 27260 1 powernow_k8, Live 0xffffffff883ca000
nfsd 259784 5 - Live 0xffffffff88389000
exportfs 6656 1 nfsd, Live 0xffffffff88386000
lockd 70192 1 nfsd, Live 0xffffffff88373000
nfs_acl 4160 1 nfsd, Live 0xffffffff88370000
sunrpc 178376 7 nfsd,lockd,nfs_acl, Live 0xffffffff88343000
eeprom 8792 0 - Live 0xffffffff8833f000
it87 22944 0 - Live 0xffffffff88338000
hwmon_vid 3328 1 it87, Live 0xffffffff881f7000
i2c_isa 7560 1 it87, Live 0xffffffff88335000
snd_seq_midi 9920 0 - Live 0xffffffff88331000
snd_pcm_oss 46144 0 - Live 0xffffffff88324000
snd_mixer_oss 18248 1 snd_pcm_oss, Live 0xffffffff8831e000
snd_seq_oss 34064 0 - Live 0xffffffff88314000
snd_usb_audio 90320 0 - Live 0xffffffff882fc000
snd_usb_lib 18520 1 snd_usb_audio, Live 0xffffffff882f6000
snd_hwdep 11536 1 snd_usb_audio, Live 0xffffffff882f2000
dm_mod 65008 37 - Live 0xffffffff882e1000
snd_seq_virmidi 8968 0 - Live 0xffffffff882dd000
snd_seq_midi_event 8776 3 snd_seq_midi,snd_seq_oss,snd_seq_virmidi, Live 
0xffffffff882d9000
snd_seq 56360 6 
snd_seq_midi,snd_seq_oss,snd_seq_virmidi,snd_seq_midi_event, Live 
0xffffffff882ca000
pktcdvd 37560 0 - Live 0xffffffff882bf000
lp 15048 0 - Live 0xffffffff882ba000
snd_rtctimer 4448 0 - Live 0xffffffff882b7000
hangcheck_timer 4824 0 - Live 0xffffffff882b4000
nvram 10184 0 - Live 0xffffffff882b0000
softdog 7452 0 - Live 0xffffffff882ad000
uinput 10768 0 - Live 0xffffffff882a9000
eth1394 21344 0 - Live 0xffffffff882a2000
snd_mpu401 10088 0 - Live 0xffffffff8829e000
snd_mpu401_uart 9944 1 snd_mpu401, Live 0xffffffff8829a000
snd_rawmidi 28032 4 
snd_seq_midi,snd_usb_lib,snd_seq_virmidi,snd_mpu401_uart, Live 
0xffffffff88292000
snd_seq_device 9308 4 snd_seq_midi,snd_seq_oss,snd_seq,snd_rawmidi, Live 
0xffffffff8828e000
ohci1394 36520 0 - Live 0xffffffff88284000
ieee1394 109160 2 eth1394,ohci1394, Live 0xffffffff88268000
parport_pc 42856 1 - Live 0xffffffff8825c000
parport 44588 2 lp,parport_pc, Live 0xffffffff88250000
analog 12128 0 - Live 0xffffffff8824c000
gameport 19552 1 analog, Live 0xffffffff88246000
floppy 67176 0 - Live 0xffffffff88234000
rtc 10592 1 snd_rtctimer, Live 0xffffffff88230000
sr_mod 17252 0 - Live 0xffffffff8822a000
cdrom 36840 2 pktcdvd,sr_mod, Live 0xffffffff88220000
radeonfb 116832 0 - Live 0xffffffff88202000
k8temp 7048 0 - Live 0xffffffff881ff000
hwmon 4232 2 it87,k8temp, Live 0xffffffff881fc000
pcspkr 4160 0 - Live 0xffffffff881f9000
usbhid 28992 0 - Live 0xffffffff881ee000
hid 23296 1 usbhid, Live 0xffffffff881e7000
sg 27496 0 - Live 0xffffffff881df000
raid1 25360 1 - Live 0xffffffff881d7000
md_mod 81780 6 raid1, Live 0xffffffff881c2000
snd_intel8x0 37360 1 - Live 0xffffffff881b7000
snd_ac97_codec 111384 1 snd_intel8x0, Live 0xffffffff8819a000
snd_pcm 87728 4 snd_pcm_oss,snd_usb_audio,snd_intel8x0,snd_ac97_codec, 
Live 0xffffffff88183000
snd_timer 26272 3 snd_seq,snd_rtctimer,snd_pcm, Live 0xffffffff8817b000
snd 66024 17 
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_usb_audio,snd_hwdep,snd_seq_virmidi,snd_seq,snd_mpu401,snd_mpu401_uart,snd_rawmidi,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer, 
Live 0xffffffff88169000
soundcore 10080 1 snd, Live 0xffffffff88165000
snd_page_alloc 10896 2 snd_intel8x0,snd_pcm, Live 0xffffffff88161000
ac97_bus 3776 1 snd_ac97_codec, Live 0xffffffff8815f000
marvell 3456 0 - Live 0xffffffff8815d000
libphy 23248 1 marvell, Live 0xffffffff88156000
forcedeth 46476 0 - Live 0xffffffff88149000
usb_storage 45284 0 - Live 0xffffffff8813c000
libusual 18856 1 usb_storage, Live 0xffffffff88136000
ohci_hcd 22220 0 - Live 0xffffffff8812f000
ehci_hcd 34580 0 - Live 0xffffffff88125000
usbcore 150232 8 
snd_usb_audio,snd_usb_lib,usbhid,usb_storage,libusual,ohci_hcd,ehci_hcd, 
Live 0xffffffff880ff000
evdev 11392 1 - Live 0xffffffff880fb000
ext3 145592 18 - Live 0xffffffff880d6000
jbd 77432 1 ext3, Live 0xffffffff880c2000
ext2 75568 2 - Live 0xffffffff880ae000
mbcache 10376 2 ext3,ext2, Live 0xffffffff880aa000
sata_nv 21764 3 - Live 0xffffffff880a3000
pata_amd 15840 0 - Live 0xffffffff8809e000
ata_generic 9732 0 - Live 0xffffffff8809a000
libata 115368 3 sata_nv,pata_amd,ata_generic, Live 0xffffffff8807c000
sd_mod 21952 2 - Live 0xffffffff88075000
scsi_mod 110664 5 sr_mod,sg,usb_storage,libata,sd_mod, Live 
0xffffffff88058000
vga16fb 12824 1 - Live 0xffffffff88053000
vgastate 8640 1 vga16fb, Live 0xffffffff8804f000
fb_ddc 3200 1 radeonfb, Live 0xffffffff8804d000
cfbfillrect 4480 2 radeonfb,vga16fb, Live 0xffffffff8804a000
cfbimgblt 3200 2 radeonfb,vga16fb, Live 0xffffffff88048000
cfbcopyarea 3968 2 radeonfb,vga16fb, Live 0xffffffff88046000
i2c_nforce2 6976 0 - Live 0xffffffff88043000
i2c_algo_bit 8328 1 radeonfb, Live 0xffffffff8803f000
i2c_dev 8968 0 - Live 0xffffffff8803b000
i2c_core 26768 8 
eeprom,it87,i2c_isa,radeonfb,fb_ddc,i2c_nforce2,i2c_algo_bit,i2c_dev, 
Live 0xffffffff88033000
fbcon 43008 77 - Live 0xffffffff88027000
bitblit 6336 1 fbcon, Live 0xffffffff88024000
fbcon_rotate 3456 1 bitblit, Live 0xffffffff88022000
fbcon_cw 6464 1 fbcon_rotate, Live 0xffffffff8801f000
fbcon_ud 6720 1 fbcon_rotate, Live 0xffffffff8801c000
fbcon_ccw 6656 1 fbcon_rotate, Live 0xffffffff88019000
softcursor 2752 4 bitblit,fbcon_cw,fbcon_ud,fbcon_ccw, Live 
0xffffffff88017000
fb 51408 8 
radeonfb,vga16fb,fbcon,bitblit,fbcon_cw,fbcon_ud,fbcon_ccw,softcursor, 
Live 0xffffffff88009000
font 8960 1 fbcon, Live 0xffffffff88005000
crc32 4608 1 fbcon, Live 0xffffffff88002000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

 # cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:06.0
  0170-0177 : libata
01f0-01f7 : 0000:00:06.0
  01f0-01f7 : libata
0290-0297 : it87-isa
0330-0331 : MPU401 UART
0376-0376 : 0000:00:06.0
  0376-0376 : libata
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f2-03f5 : floppy
03f6-03f6 : 0000:00:06.0
  03f6-03f6 : libata
03f7-03f7 : floppy DIR
03f8-03ff : serial
0960-0967 : 0000:00:08.0
  0960-0967 : sata_nv
0970-0977 : 0000:00:07.0
  0970-0977 : sata_nv
09e0-09e7 : 0000:00:08.0
  09e0-09e7 : sata_nv
09f0-09f7 : 0000:00:07.0
  09f0-09f7 : sata_nv
0b60-0b63 : 0000:00:08.0
  0b60-0b63 : sata_nv
0b70-0b73 : 0000:00:07.0
  0b70-0b73 : sata_nv
0be0-0be3 : 0000:00:08.0
  0be0-0be3 : sata_nv
0bf0-0bf3 : 0000:00:07.0
  0bf0-0bf3 : sata_nv
0cf8-0cff : PCI conf1
4000-407f : motherboard
  4000-4003 : ACPI PM1a_EVT_BLK
  4004-4005 : ACPI PM1a_CNT_BLK
  4008-400b : ACPI PM_TMR
  401c-401c : ACPI PM2_CNT_BLK
  4020-4027 : ACPI GPE0_BLK
4080-40ff : motherboard
  4080-40ff : pnp 00:01
4400-447f : motherboard
  4400-447f : pnp 00:01
4480-44ff : motherboard
  44a0-44af : ACPI GPE1_BLK
4800-487f : motherboard
  4800-487f : pnp 00:01
4880-48ff : motherboard
  4880-48ff : pnp 00:01
4c00-4c3f : 0000:00:01.1
  4c00-4c3f : nForce2_smbus
4c40-4c7f : 0000:00:01.1
  4c40-4c7f : nForce2_smbus
a000-afff : PCI Bus #01
  a000-a0ff : 0000:01:00.0
b000-b007 : 0000:00:0a.0
  b000-b007 : forcedeth
c400-c40f : 0000:00:08.0
  c400-c40f : sata_nv
d800-d80f : 0000:00:07.0
  d800-d80f : sata_nv
dc00-dcff : 0000:00:04.0
  dc00-dcff : NVidia CK804
e000-e0ff : 0000:00:04.0
  e000-e0ff : NVidia CK804
e400-e41f : 0000:00:01.1
f000-f00f : 0000:00:06.0
  f000-f00f : libata

[8.5.] PCI information ('lspci -vvv' as root)

 # lspci -vvv
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller 
(rev a3)
        Subsystem: ASUSTeK Computer Inc. Unknown device 815a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=0 UnitCnt=15 MastHost- DefDir- DUL-
                Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- 
<CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- 
LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ 
<CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- 
LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
                Revision ID: 1.03
                Link Frequency 0: 1.0GHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 
500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- 
UIDRD-
                Link Frequency 1: 200MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 
500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- 
SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [e0] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 255
        Region 0: I/O ports at e400 [size=32]
        Region 4: I/O ports at 4c00 [size=64]
        Region 5: I/O ports at 4c40 [size=64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) 
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at d2104000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) 
(prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 
Audio Controller (rev a2)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at e000 [size=256]
        Region 2: Memory at d2103000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a 
[Master SecP PriP])
        Subsystem: Unknown device f043:815a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 0: [virtual] Memory at 000001f0 (32-bit, 
non-prefetchable) [disabled] [size=8]
        Region 1: [virtual] Memory at 000003f0 (type 3, 
non-prefetchable) [disabled] [size=1]
        Region 2: [virtual] Memory at 00000170 (32-bit, 
non-prefetchable) [disabled] [size=8]
        Region 3: [virtual] Memory at 00000370 (type 3, 
non-prefetchable) [disabled] [size=1]
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev f3) (prog-if 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc. Unknown device 815a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 23
        Region 0: I/O ports at 09f0 [size=8]
        Region 1: I/O ports at 0bf0 [size=4]
        Region 2: I/O ports at 0970 [size=8]
        Region 3: I/O ports at 0b70 [size=4]
        Region 4: I/O ports at d800 [size=16]
        Region 5: Memory at d2102000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev f3) (prog-if 85 [Master SecO PriO])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at 09e0 [size=8]
        Region 1: I/O ports at 0be0 [size=4]
        Region 2: I/O ports at 0960 [size=8]
        Region 3: I/O ports at 0b60 [size=4]
        Region 4: I/O ports at c400 [size=16]
        Region 5: Memory at d2101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) 
(prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d2000000-d20fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR+
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at d2100000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at b000 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/1 Enable+
                Address: 00000000fee0100c  Data: 4139
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s <512ns, L1 <4us
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x2, ASPM L0s, Port 3
                Link: Latency L0s <512ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x4
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- 
Surpise-
                Slot: Number 8, PowerLimit 25.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-

00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/1 Enable+
                Address: 00000000fee0100c  Data: 4141
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s <512ns, L1 <4us
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 2
                Link: Latency L0s <512ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x4
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- 
Surpise-
                Slot: Number 4, PowerLimit 10.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/1 Enable+
                Address: 00000000fee0100c  Data: 4149
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s <512ns, L1 <4us
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 1
                Link: Latency L0s <512ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x8
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- 
Surpise-
                Slot: Number 2, PowerLimit 10.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: d0000000-d1ffffff
        Prefetchable memory behind bridge: 00000000c0000000-00000000cfffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/1 Enable+
                Address: 00000000fee0100c  Data: 4151
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s <512ns, L1 <4us
                Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s, Port 0
                Link: Latency L0s <512ns, L1 <4us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x16
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- 
Surpise-
                Slot: Number 1, PowerLimit 75.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd On, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- 
<CRCErr=0
                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc R423 5F57 
[Radeon X800XT (PCIE)] (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Unknown device 0312
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Region 2: Memory at d1000000 (64-bit, non-prefetchable) [size=64K]
        Region 4: I/O ports at a000 [size=256]
        Expansion ROM at d0000000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag+
                Device: Latency L0s <256ns, L1 <4us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, 
Port 0
                Link: Latency L0s <256ns, L1 <2us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x16
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

01:00.1 Display controller: ATI Technologies Inc R423 5F57 [Radeon 
X800XT (PCIE)] (Secondary)
        Subsystem: ATI Technologies Inc Unknown device 0313
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at d1010000 (64-bit, non-prefetchable) 
[disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s <256ns, L1 <4us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, 
Port 0
                Link: Latency L0s <256ns, L1 <2us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x16

05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d2004000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at d2000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+


Here are the radeonfb patches i have applied:

http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v6a.diff and 
some others grabbed from web

To make them easier to identify, i added the files that were modified 
(diff -ruN) at the end of that report.


Thank you for your help

Jj



--------------030303080806070008000502
Content-Type: text/x-patch;
 name="ati_ids.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ati_ids.h.diff"

--- ati_ids.h.orig	2007-03-23 23:07:09.000000000 +0100
+++ ati_ids.h	2007-03-25 21:58:27.000000000 +0200
@@ -31,6 +31,7 @@
 #define PCI_CHIP_RV360_AR               0x4152
 #define PCI_CHIP_RV350_AS               0x4153
 #define PCI_CHIP_RV350_AT               0x4154
+#define PCI_CHIP_RV350_AU 		0x4155
 #define PCI_CHIP_RV350_AV               0x4156
 #define PCI_CHIP_MACH32			0x4158
 #define PCI_CHIP_RS250_4237		0x4237
@@ -71,7 +72,13 @@
 #define PCI_CHIP_R420_JL                0x4A4C
 #define PCI_CHIP_R420_JM                0x4A4D
 #define PCI_CHIP_R420_JN                0x4A4E
+#define PCI_CHIP_R420_JO 		0x4A4F
 #define PCI_CHIP_R420_JP                0x4A50
+#define PCI_CHIP_R420_JT 		0x4A54
+#define PCI_CHIP_R480_KI 		0x4B49
+#define PCI_CHIP_R480_KJ 		0x4B4A
+#define PCI_CHIP_R480_KK                0x4B4B
+#define PCI_CHIP_R480_KL 		0x4B4C
 #define PCI_CHIP_MACH64LB		0x4C42
 #define PCI_CHIP_MACH64LD		0x4C44
 #define PCI_CHIP_RAGE128LE		0x4C45
@@ -182,9 +189,19 @@
 #define PCI_CHIP_R423_UI                0x5549
 #define PCI_CHIP_R423_UJ                0x554A
 #define PCI_CHIP_R423_UK                0x554B
+#define PCI_CHIP_R423_UL 		0x554C
+#define PCI_CHIP_R423_UM 		0x554D
+#define PCI_CHIP_R423_UN 		0x554E
+#define PCI_CHIP_R423_UO 		0x554F
+#define PCI_CHIP_R423_UP 	       	0x5550
 #define PCI_CHIP_R423_UQ                0x5551
 #define PCI_CHIP_R423_UR                0x5552
 #define PCI_CHIP_R423_UT                0x5554
+#define PCI_CHIP_RV410_VJ 		0x564A
+#define PCI_CHIP_RV410_VK 		0x564B
+#define PCI_CHIP_RV410_VO 		0x564F
+#define PCI_CHIP_RV410_VR 		0x5652
+#define PCI_CHIP_RV410_VS 		0x5653
 #define PCI_CHIP_MACH64VT		0x5654
 #define PCI_CHIP_MACH64VU		0x5655
 #define PCI_CHIP_MACH64VV		0x5656
@@ -206,7 +223,22 @@
 #define PCI_CHIP_RV280_5964		0x5964
 #define PCI_CHIP_RV280_5C61		0x5C61
 #define PCI_CHIP_RV280_5C63		0x5C63
+#define PCI_CHIP_R423_5D48		0x5D48
+#define PCI_CHIP_R423_5D49		0x5D49
+#define PCI_CHIP_R423_5D4A		0x5D4A
+#define PCI_CHIP_R480_5D4C		0x5D4C
+#define PCI_CHIP_R480_5D4D		0x5D4D
+#define PCI_CHIP_R480_5D4E		0x5D4E
+#define PCI_CHIP_R480_5D4F		0x5D4F
+#define PCI_CHIP_R480_5D50		0x5D50
+#define PCI_CHIP_R480_5D52		0x5D52
 #define PCI_CHIP_R423_5D57              0x5D57
+#define PCI_CHIP_RV410_5E48		0x5E48
+#define PCI_CHIP_RV410_5E4A		0x5E4A
+#define PCI_CHIP_RV410_5E4B		0x5E4B
+#define PCI_CHIP_RV410_5E4C		0x5E4C
+#define PCI_CHIP_RV410_5E4D		0x5E4D
+#define PCI_CHIP_RV410_5E4F		0x5E4F
+#define PCI_CHIP_R423_5F57              0x5F57
 #define PCI_CHIP_RS350_7834             0x7834
 #define PCI_CHIP_RS350_7835             0x7835
-



--------------030303080806070008000502
Content-Type: text/x-patch;
 name="radeon_accel.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_accel.c.diff"

--- radeon_accel.c.orig	2007-03-21 22:53:31.000000000 +0100
+++ radeon_accel.c	2007-03-25 21:36:19.000000000 +0200
@@ -203,9 +203,7 @@
 	host_path_cntl = INREG(HOST_PATH_CNTL);
 	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
 
-	if (rinfo->family == CHIP_FAMILY_R300 ||
-	    rinfo->family == CHIP_FAMILY_R350 ||
-	    rinfo->family == CHIP_FAMILY_RV350) {
+	if (IS_R300_VARIANT(rinfo)) {
 		u32 tmp;
 
 		OUTREG(RBBM_SOFT_RESET, (rbbm_soft_reset |
@@ -241,9 +239,7 @@
 	INREG(HOST_PATH_CNTL);
 	OUTREG(HOST_PATH_CNTL, host_path_cntl);
 
-	if (rinfo->family != CHIP_FAMILY_R300 ||
-	    rinfo->family != CHIP_FAMILY_R350 ||
-	    rinfo->family != CHIP_FAMILY_RV350)
+	if (IS_R300_VARIANT(rinfo))
 		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
 
 	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
@@ -254,16 +250,15 @@
 {
 	unsigned long temp;
 
-	/* disable 3D engine */
-	OUTREG(RB3D_CNTL, 0);
-
 	radeonfb_engine_reset(rinfo);
 
 	radeon_fifo_wait (1);
-	if ((rinfo->family != CHIP_FAMILY_R300) &&
-	    (rinfo->family != CHIP_FAMILY_R350) &&
-	    (rinfo->family != CHIP_FAMILY_RV350))
+	if (IS_R300_VARIANT(rinfo)) {
+		temp = INREG(RB2D_DSTCACHE_MODE);
+		OUTREG(RB2D_DSTCACHE_MODE, temp | (1<<17)); /* FIXME */
+	} else {
 		OUTREG(RB2D_DSTCACHE_MODE, 0);
+	}
 
 	radeon_fifo_wait (3);
 	/* We re-read MC_FB_LOCATION from card as it can have been



--------------030303080806070008000502
Content-Type: text/x-patch;
 name="radeon_backlight.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_backlight.c.diff"

--- radeon_backlight.c.orig	2007-03-21 22:53:31.000000000 +0100
+++ radeon_backlight.c	2007-03-25 21:36:19.000000000 +0200
@@ -58,7 +58,7 @@
 	u32 lvds_gen_cntl, tmpPixclksCntl;
 	int level;
 
-	if (rinfo->mon1_type != MT_LCD)
+	if (PRIMARY_MONITOR(rinfo) != MT_LCD)
 		return 0;
 
 	/* We turn off the LCD completely instead of just dimming the
@@ -146,7 +146,7 @@
 	struct radeon_bl_privdata *pdata;
 	char name[12];
 
-	if (rinfo->mon1_type != MT_LCD)
+	if (PRIMARY_MONITOR(rinfo) == MT_LCD) {
 		return;
 
 #ifdef CONFIG_PMAC_BACKLIGHT



--------------030303080806070008000502
Content-Type: text/x-patch;
 name="radeon_base.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_base.c.diff"

--- radeon_base.c.orig	2007-03-23 23:09:19.000000000 +0100
+++ radeon_base.c	2007-03-26 13:39:31.000000000 +0200
@@ -3,6 +3,7 @@
  *
  *	framebuffer driver for ATI Radeon chipset video boards
  *
+ *	Copyright 2006	Solomon Peachy <pizza@shaftnet.org>
  *	Copyright 2003	Ben. Herrenschmidt <benh@kernel.crashing.org>
  *	Copyright 2000	Ani Joshi <ajoshi@kernel.crashing.org>
  *
@@ -50,7 +51,7 @@
  */
 
 
-#define RADEON_VERSION	"0.2.0"
+#define RADEON_VERSION	"0.3.0"
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -180,6 +181,7 @@
 	CHIP_DEF(PCI_CHIP_RV360_AR,	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV350_AS,	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV350_AT,	RV350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV350_AU, 	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV350_AV,	RV350,	CHIP_HAS_CRTC2),
 	/* 9800/Pro/FileGL X2 */
 	CHIP_DEF(PCI_CHIP_R350_AH,	R350,	CHIP_HAS_CRTC2),
@@ -190,7 +192,7 @@
 	CHIP_DEF(PCI_CHIP_R350_NI,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R360_NJ,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R350_NK,	R350,	CHIP_HAS_CRTC2),
-	/* Newer stuff */
+	/* X300/X600 */
 	CHIP_DEF(PCI_CHIP_RV380_3E50,	RV380,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV380_3E54,	RV380,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV380_3150,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
@@ -201,6 +203,19 @@
 	CHIP_DEF(PCI_CHIP_RV370_5B65,	RV380,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV370_5460,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_RV370_5464,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	/* X700 */
+	CHIP_DEF(PCI_CHIP_RV410_VJ, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VK, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VO, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VR, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VS, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_5E48,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4A,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4B,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4C,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4D,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4F,	RV410,	CHIP_HAS_CRTC2),
+	/* X800/X850 */
 	CHIP_DEF(PCI_CHIP_R420_JH,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JI,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JJ,	R420,	CHIP_HAS_CRTC2),
@@ -208,7 +223,9 @@
 	CHIP_DEF(PCI_CHIP_R420_JL,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JM,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JN,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R420_JO, 	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JP,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JT, 	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UH,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UI,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UJ,	R420,	CHIP_HAS_CRTC2),
@@ -217,6 +234,25 @@
 	CHIP_DEF(PCI_CHIP_R423_UR,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UT,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_5D57,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_5F57,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UP, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_5D49, 	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R423_5D4A, 	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R423_5D48, 	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R423_UO, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UM, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UN, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UL, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4C, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D50, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4E, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4F, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D52, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4D, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KJ, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KK,    R420,     CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KI, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KL, 	R420,	CHIP_HAS_CRTC2),
 	/* Original Radeon/7200 */
 	CHIP_DEF(PCI_CHIP_RADEON_QD,	RADEON,	0),
 	CHIP_DEF(PCI_CHIP_RADEON_QE,	RADEON,	0),
@@ -259,6 +295,7 @@
 static int default_dynclk = -2;
 static int nomodeset = 0;
 static int ignore_edid = 0;
+static int ignore_conntable = 0;
 static int mirror = 0;
 static int panel_yres = 0;
 static int force_dfp = 0;
@@ -269,6 +306,12 @@
 static int force_sleep;
 static int ignore_devlist;
 
+#ifdef CONFIG_FB_RADEON_DEBUG
+int radeonfb_debug = 1;
+#else
+int radeonfb_debug = 0;
+#endif
+
 /*
  * prototypes
  */
@@ -324,7 +367,7 @@
 	 * to phase out Open Firmware images.
 	 *
 	 * Currently, we only look at the first PCI data, we could iteratre and deal with
-	 * them all, and we should use fb_bios_start relative to start of image and not
+	 * them all, and we should use fp_bios_start relative to start of image and not
 	 * relative start of ROM, but so far, I never found a dual-image ATI card
 	 *
 	 * typedef struct {
@@ -410,7 +453,7 @@
  * Read XTAL (ref clock), SCLK and MCLK from Open Firmware device
  * tree. Hopefully, ATI OF driver is kind enough to fill these
  */
-static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
+static int __devinit radeon_get_pll_info_openfirmware (struct radeonfb_info *rinfo)
 {
 	struct device_node *dp = rinfo->of_node;
 	const u32 *val;
@@ -433,6 +476,7 @@
 	if (val && *val)
 		rinfo->pll.mclk = (*val) / 10;
 
+	RTRACE("Retrieved PLL infos from Open Firmware\n");
        	return 0;
 }
 #endif /* CONFIG_PPC_OF */
@@ -575,10 +619,87 @@
 	return 0;
 }
 
+static int __devinit radeon_get_pll_info_legacy(struct radeonfb_info *rinfo)
+{
+	u16 pll_info_block;
+
+	if (!rinfo->bios_seg)
+		return -EINVAL;
+
+	pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
+	
+	rinfo->pll.sclk		= BIOS_IN16(pll_info_block + 0x08);
+	rinfo->pll.mclk		= BIOS_IN16(pll_info_block + 0x0a);
+	rinfo->pll.ref_clk	= BIOS_IN16(pll_info_block + 0x0e);
+	rinfo->pll.ref_div	= BIOS_IN16(pll_info_block + 0x10);
+	rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
+	rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
+
+	RTRACE("Retrieved PLL infos from Legacy BIOS\n");
+	return 0;
+}
+
+
+static int __devinit radeon_get_pll_info_atom(struct radeonfb_info *rinfo)
+{
+	u16 pll_info_block;
+
+	if (!rinfo->bios_seg)
+		return -EINVAL;
+
+	pll_info_block = BIOS_IN16(rinfo->atom_data_start + 12);
+	
+	rinfo->pll.sclk = BIOS_IN32(pll_info_block + 8);
+	rinfo->pll.mclk = BIOS_IN32(pll_info_block + 12);
+	rinfo->pll.ref_clk = BIOS_IN16(pll_info_block + 82);
+	rinfo->pll.ref_div = 0; /* Have to get it elsewhere */
+	rinfo->pll.ppll_min = BIOS_IN16(pll_info_block + 78);
+	rinfo->pll.ppll_max = BIOS_IN32(pll_info_block + 32);
+
+	RTRACE("Retrieved PLL infos from ATOM BIOS\n");
+	return 0;
+}
+
+static void radeon_detect_bios_type(struct radeonfb_info *rinfo)
+{
+#ifdef CONFIG_PPC_OF
+	  rinfo->is_atom_bios = 0;
+	rinfo->radeon_get_pll_info = radeon_get_pll_info_openfirmware;
+	rinfo->radeon_get_lvds_info = radeon_get_lvds_info_openfirmware;
+	  rinfo->radeon_get_tmds_info = NULL;
+	rinfo->radeon_get_conn_info = radeon_get_conn_info_openfirmware;
+#else
+	  int tmp = rinfo->fp_bios_start + 4;
+	  unsigned char sign[4];
+
+		  sign[0] = BIOS_IN8(tmp);
+		  sign[1] = BIOS_IN8(tmp + 1);
+		  sign[2] = BIOS_IN8(tmp + 2);
+		  sign[3] = BIOS_IN8(tmp + 3);
+
+		  if (!memcmp(sign, "ATOM", 4) || !memcmp(sign, "MOTA", 4)) {
+ 		  	rinfo->is_atom_bios = 1;
+ 
+		  rinfo->atom_data_start = BIOS_IN16(rinfo->fp_bios_start + 32);
+		  rinfo->radeon_get_pll_info = radeon_get_pll_info_atom;
+		  rinfo->radeon_get_lvds_info = radeon_get_lvds_info_atom;
+		  rinfo->radeon_get_conn_info = radeon_get_conn_info_atom;
+		  rinfo->radeon_get_tmds_info = radeon_get_tmds_info_atom;
+	  } else {
+		  rinfo->is_atom_bios = 0;
+		  rinfo->radeon_get_pll_info = radeon_get_pll_info_legacy;
+		  rinfo->radeon_get_lvds_info = radeon_get_lvds_info_legacy;
+		  rinfo->radeon_get_conn_info = radeon_get_conn_info_legacy;
+		  rinfo->radeon_get_tmds_info = radeon_get_tmds_info_legacy;
+	  }
+#endif  /* CONFIG_PPC_OF */
+
+}
+
 /*
  * Retrieve PLL infos by different means (BIOS, Open Firmware, register probing...)
  */
-static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
+static void __devinit radeon_get_pll_info(struct radeonfb_info *rinfo)
 {
 	/*
 	 * In the case nothing works, these are defaults; they are mostly
@@ -630,46 +751,30 @@
 	case PCI_DEVICE_ID_ATI_RADEON_QF:
 	case PCI_DEVICE_ID_ATI_RADEON_QG:
 	default:
-		rinfo->pll.ppll_max = 35000;
-		rinfo->pll.ppll_min = 12000;
+		if (rinfo->family == CHIP_FAMILY_R420) {
+			rinfo->pll.ppll_max = 50000;
+			rinfo->pll.ppll_min = 20000;
+		} else {
+			rinfo->pll.ppll_max = 35000;
+			rinfo->pll.ppll_min = 12000;
+		}
 		rinfo->pll.mclk = 16600;
 		rinfo->pll.sclk = 16600;
 		rinfo->pll.ref_clk = 2700;
 		break;
 	}
-	rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
-
-
-#ifdef CONFIG_PPC_OF
-	/*
-	 * Retrieve PLL infos from Open Firmware first
-	 */
-       	if (!force_measure_pll && radeon_read_xtal_OF(rinfo) == 0) {
-       		printk(KERN_INFO "radeonfb: Retrieved PLL infos from Open Firmware\n");
-		goto found;
-	}
-#endif /* CONFIG_PPC_OF */
 
 	/*
-	 * Check out if we have an X86 which gave us some PLL informations
-	 * and if yes, retrieve them
+	 * If we have a way to retrieve the PLL information, do so.
 	 */
-	if (!force_measure_pll && rinfo->bios_seg) {
-		u16 pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
-
-		rinfo->pll.sclk		= BIOS_IN16(pll_info_block + 0x08);
-		rinfo->pll.mclk		= BIOS_IN16(pll_info_block + 0x0a);
-		rinfo->pll.ref_clk	= BIOS_IN16(pll_info_block + 0x0e);
-		rinfo->pll.ref_div	= BIOS_IN16(pll_info_block + 0x10);
-		rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
-		rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
-
-		printk(KERN_INFO "radeonfb: Retrieved PLL infos from BIOS\n");
-		goto found;
+	if (!force_measure_pll && rinfo->radeon_get_pll_info) {
+		if (!rinfo->radeon_get_pll_info(rinfo)) {
+			goto found;
+		}
 	}
 
 	/*
-	 * We didn't get PLL parameters from either OF or BIOS, we try to
+	 * If we don't get the PLL parameters handed to us, we try to
 	 * probe them
 	 */
 	if (radeon_probe_pll_params(rinfo) == 0) {
@@ -683,6 +788,22 @@
        	printk(KERN_INFO "radeonfb: Used default PLL infos\n");
 
 found:
+
+	/* Check and fix-up the PLL divisor if necessary */
+	if (rinfo->pll.ref_div < 2) {
+		int tmp = INPLL(PPLL_REF_DIV);
+		if (rinfo->family == CHIP_FAMILY_RS300) {
+			rinfo->pll.ref_div = (tmp & R300_PPLL_REF_DIV_ACC_MASK) >> R300_PPLL_REF_DIV_ACC_SHIFT;
+		} else {
+			rinfo->pll.ref_div = tmp & PPLL_REF_DIV_MASK;
+		}
+		
+		/* Sane default */
+		if (rinfo->pll.ref_div < 2) {		
+			rinfo->pll.ref_div = 12;
+		}
+	}		
+
 	/*
 	 * Some methods fail to retrieve SCLK and MCLK values, we apply default
 	 * settings in this case (200Mhz). If that really happne often, we could
@@ -698,7 +819,7 @@
 	       rinfo->pll.ref_div,
 	       rinfo->pll.mclk / 100, rinfo->pll.mclk % 100,
 	       rinfo->pll.sclk / 100, rinfo->pll.sclk % 100);
-	printk("radeonfb: PLL min %d max %d\n", rinfo->pll.ppll_min, rinfo->pll.ppll_max);
+	RTRACE("PLL min %d max %d\n", rinfo->pll.ppll_min, rinfo->pll.ppll_max);
 }
 
 static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
@@ -839,7 +960,7 @@
         if (rinfo->asleep)
         	return 0;
 
-	radeon_fifo_wait(2);
+	radeon_engine_idle();
         OUTREG(CRTC_OFFSET, ((var->yoffset * var->xres_virtual + var->xoffset)
 			     * var->bits_per_pixel / 8) & ~7);
         return 0;
@@ -923,6 +1044,7 @@
         u32 val;
 	u32 tmp_pix_clks;
 	int unblank = 0;
+	int i;
 
 	if (rinfo->lock_blank)
 		return 0;
@@ -952,78 +1074,81 @@
         }
 	OUTREG(CRTC_EXT_CNTL, val);
 
+	for (i = 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+		if (rinfo->heads[i] == -1)
+			continue;
 
-	switch (rinfo->mon1_type) {
-	case MT_DFP:
-		if (unblank)
-			OUTREGP(FP_GEN_CNTL, (FP_FPON | FP_TMDS_EN),
-				~(FP_FPON | FP_TMDS_EN));
-		else {
-			if (mode_switch || blank == FB_BLANK_NORMAL)
-				break;
-			OUTREGP(FP_GEN_CNTL, 0, ~(FP_FPON | FP_TMDS_EN));
-		}
+		switch (rinfo->connectors[rinfo->heads[i]].mon_type) {
+		case MT_DFP:
+			if (unblank)
+				OUTREGP(FP_GEN_CNTL, (FP_FPON | FP_TMDS_EN),
+					~(FP_FPON | FP_TMDS_EN));
+			else {
+				if (mode_switch || blank == FB_BLANK_NORMAL)
+					break;
+				OUTREGP(FP_GEN_CNTL, 0, ~(FP_FPON | FP_TMDS_EN));
+			}
 		break;
-	case MT_LCD:
-		del_timer_sync(&rinfo->lvds_timer);
-		val = INREG(LVDS_GEN_CNTL);
-		if (unblank) {
-			u32 target_val = (val & ~LVDS_DISPLAY_DIS) | LVDS_BLON | LVDS_ON
-				| LVDS_EN | (rinfo->init_state.lvds_gen_cntl
-					     & (LVDS_DIGON | LVDS_BL_MOD_EN));
-			if ((val ^ target_val) == LVDS_DISPLAY_DIS)
-				OUTREG(LVDS_GEN_CNTL, target_val);
-			else if ((val ^ target_val) != 0) {
-				OUTREG(LVDS_GEN_CNTL, target_val
-				       & ~(LVDS_ON | LVDS_BL_MOD_EN));
-				rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
-				rinfo->init_state.lvds_gen_cntl |=
-					target_val & LVDS_STATE_MASK;
-				if (mode_switch) {
-					radeon_msleep(rinfo->panel_info.pwr_delay);
+		case MT_LCD:
+			del_timer_sync(&rinfo->lvds_timer);
+			val = INREG(LVDS_GEN_CNTL);
+			if (unblank) {
+				u32 target_val = (val & ~LVDS_DISPLAY_DIS) | LVDS_BLON | LVDS_ON
+					| LVDS_EN | (rinfo->init_state.lvds_gen_cntl
+						     & (LVDS_DIGON | LVDS_BL_MOD_EN));
+				if ((val ^ target_val) == LVDS_DISPLAY_DIS)
 					OUTREG(LVDS_GEN_CNTL, target_val);
+				else if ((val ^ target_val) != 0) {
+					OUTREG(LVDS_GEN_CNTL, target_val
+					       & ~(LVDS_ON | LVDS_BL_MOD_EN));
+					rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
+					rinfo->init_state.lvds_gen_cntl |=
+						target_val & LVDS_STATE_MASK;
+					if (mode_switch) {
+						radeon_msleep(rinfo->panel_info.pwr_delay);
+						OUTREG(LVDS_GEN_CNTL, target_val);
+					} else {
+						rinfo->pending_lvds_gen_cntl = target_val;
+						mod_timer(&rinfo->lvds_timer,
+							  jiffies +
+							  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
+					}
 				}
-				else {
-					rinfo->pending_lvds_gen_cntl = target_val;
-					mod_timer(&rinfo->lvds_timer,
-					   jiffies +
-					   msecs_to_jiffies(rinfo->panel_info.pwr_delay));
-				}
+			} else {
+				val |= LVDS_DISPLAY_DIS;
+				OUTREG(LVDS_GEN_CNTL, val);
+				
+				/* We don't do a full switch-off on a simple mode switch */
+				if (mode_switch || blank == FB_BLANK_NORMAL)
+					break;
+				
+				/* Asic bug, when turning off LVDS_ON, we have to make sure
+				 * RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
+				 */
+				tmp_pix_clks = INPLL(PIXCLKS_CNTL);
+				if (rinfo->is_mobility || rinfo->is_IGP)
+					OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
+				val &= ~(LVDS_BL_MOD_EN);
+				OUTREG(LVDS_GEN_CNTL, val);
+				udelay(100);
+				val &= ~(LVDS_ON | LVDS_EN);
+				OUTREG(LVDS_GEN_CNTL, val);
+				val &= ~LVDS_DIGON;
+				rinfo->pending_lvds_gen_cntl = val;
+				mod_timer(&rinfo->lvds_timer,
+					  jiffies +
+					  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
+				rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
+				rinfo->init_state.lvds_gen_cntl |= val & LVDS_STATE_MASK;
+				if (rinfo->is_mobility || rinfo->is_IGP)
+					OUTPLL(PIXCLKS_CNTL, tmp_pix_clks);
 			}
-		} else {
-			val |= LVDS_DISPLAY_DIS;
-			OUTREG(LVDS_GEN_CNTL, val);
-
-			/* We don't do a full switch-off on a simple mode switch */
-			if (mode_switch || blank == FB_BLANK_NORMAL)
-				break;
-
-			/* Asic bug, when turning off LVDS_ON, we have to make sure
-			 * RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
-			 */
-			tmp_pix_clks = INPLL(PIXCLKS_CNTL);
-			if (rinfo->is_mobility || rinfo->is_IGP)
-				OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
-			val &= ~(LVDS_BL_MOD_EN);
-			OUTREG(LVDS_GEN_CNTL, val);
-			udelay(100);
-			val &= ~(LVDS_ON | LVDS_EN);
-			OUTREG(LVDS_GEN_CNTL, val);
-			val &= ~LVDS_DIGON;
-			rinfo->pending_lvds_gen_cntl = val;
-			mod_timer(&rinfo->lvds_timer,
-				  jiffies +
-				  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
-			rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
-			rinfo->init_state.lvds_gen_cntl |= val & LVDS_STATE_MASK;
-			if (rinfo->is_mobility || rinfo->is_IGP)
-				OUTPLL(PIXCLKS_CNTL, tmp_pix_clks);
+			break;
+		case MT_CRT:
+			// todo: powerdown DAC
+		default:
+			break;
 		}
-		break;
-	case MT_CRT:
-		// todo: powerdown DAC
-	default:
-		break;
 	}
 
 	/* let fbcon do a soft blank for us */
@@ -1274,10 +1399,7 @@
 	radeon_pll_errata_after_data(rinfo);
 
 	/* Set PPLL ref. div */
-	if (rinfo->family == CHIP_FAMILY_R300 ||
-	    rinfo->family == CHIP_FAMILY_RS300 ||
-	    rinfo->family == CHIP_FAMILY_R350 ||
-	    rinfo->family == CHIP_FAMILY_RV350) {
+	if (IS_R300_VARIANT(rinfo) || (rinfo->family == CHIP_FAMILY_RS300)) {
 		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {
 			/* When restoring console mode, use saved PPLL_REF_DIV
 			 * setting.
@@ -1374,6 +1496,7 @@
 	OUTREG(CRTC_OFFSET_CNTL, 0);
 	OUTREG(CRTC_PITCH, mode->crtc_pitch);
 	OUTREG(SURFACE_CNTL, mode->surface_cntl);
+	OUTREG(DISP_MERGE_CNTL, 0xffff0000);
 
 	radeon_write_pll_regs(rinfo, mode);
 
@@ -1884,7 +2007,7 @@
         info->fix.ywrapstep = 0;
         info->fix.type_aux = 0;
         info->fix.mmio_start = rinfo->mmio_base_phys;
-        info->fix.mmio_len = RADEON_REGSIZE;
+        info->fix.mmio_len = pci_resource_len(rinfo->pdev, 2);
 	info->fix.accel = FB_ACCEL_ATI_RADEON;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
@@ -1988,9 +2111,7 @@
 	u32 tmp;
 
 	/* framebuffer size */
-        if ((rinfo->family == CHIP_FAMILY_RS100) ||
-            (rinfo->family == CHIP_FAMILY_RS200) ||
-            (rinfo->family == CHIP_FAMILY_RS300)) {
+        if (rinfo->is_IGP) {
           u32 tom = INREG(NB_TOM);
           tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
 
@@ -2018,6 +2139,10 @@
 	/* mem size is bits [28:0], mask off the rest */
 	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
 
+	/* Limit memory to 128 megs for now */
+	if (rinfo->video_ram > MAX_VRAM)
+		rinfo->video_ram = MAX_VRAM;
+
 	/*
 	 * Hack to get around some busted production M6's
 	 * reporting no ram
@@ -2102,7 +2227,7 @@
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 
-	return radeon_show_one_edid(buf, off, count, rinfo->mon1_EDID);
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->heads[0]].edid);
 }
 
 
@@ -2113,7 +2238,27 @@
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 
-	return radeon_show_one_edid(buf, off, count, rinfo->mon2_EDID);
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->heads[1]].edid);
+}
+
+static ssize_t radeon_show_edid3(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+        struct fb_info *info = pci_get_drvdata(pdev);
+        struct radeonfb_info *rinfo = info->par;
+
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->heads[2]].edid);
+}
+
+static ssize_t radeon_show_edid4(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+        struct fb_info *info = pci_get_drvdata(pdev);
+        struct radeonfb_info *rinfo = info->par;
+
+	return radeon_show_one_edid(buf, off, count, rinfo->connectors[rinfo->heads[3]].edid);
 }
 
 static struct bin_attribute edid1_attr = {
@@ -2136,6 +2281,25 @@
 	.read	= radeon_show_edid2,
 };
 
+static struct bin_attribute edid3_attr = {
+	.attr   = {
+		.name	= "edid3",
+		.owner	= THIS_MODULE,
+		.mode	= 0444,
+	},
+	.size	= EDID_LENGTH,
+	.read	= radeon_show_edid3,
+};
+
+static struct bin_attribute edid4_attr = {
+	.attr   = {
+		.name	= "edid4",
+		.owner	= THIS_MODULE,
+		.mode	= 0444,
+	},
+	.size	= EDID_LENGTH,
+	.read	= radeon_show_edid4,
+};
 
 static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
@@ -2143,6 +2307,7 @@
 	struct fb_info *info;
 	struct radeonfb_info *rinfo;
 	int ret;
+	int i;
 
 	RTRACE("radeonfb_pci_register BEGIN\n");
 	
@@ -2199,7 +2364,8 @@
 	}
 
 	/* map the regions */
-	rinfo->mmio_base = ioremap(rinfo->mmio_base_phys, RADEON_REGSIZE);
+	rinfo->mmio_base = ioremap(rinfo->mmio_base_phys, 
+				   pci_resource_len(rinfo->pdev, 2));
 	if (!rinfo->mmio_base) {
 		printk(KERN_ERR "radeonfb (%s): cannot map MMIO\n",
 		       pci_name(rinfo->pdev));
@@ -2284,6 +2450,7 @@
 	 * We probably need to make sure this is the primary display,
 	 * but that is difficult without some arch support.
 	 */
+
 #ifdef CONFIG_X86
 	if (rinfo->bios_seg == NULL)
 		radeon_find_mem_vbios(rinfo);
@@ -2295,14 +2462,23 @@
 	if (rinfo->bios_seg == NULL && rinfo->is_mobility)
 		radeon_map_ROM(rinfo, pdev);
 
+	/* Check BIOS Type */
+	radeon_detect_bios_type(rinfo);
+	
 	/* Get informations about the board's PLL */
-	radeon_get_pllinfo(rinfo);
+	radeon_get_pll_info(rinfo);
+
+	/* Get informations about internal TMDS controller if any */
+	radeon_get_tmds_info(rinfo);
 
 #ifdef CONFIG_FB_RADEON_I2C
 	/* Register I2C bus */
 	radeon_create_i2c_busses(rinfo);
 #endif
 
+	/* Get infos about connectors -- need I2C here! */
+	radeon_get_conn_info(rinfo, ignore_conntable);
+
 	/* set all the vital stuff */
 	radeon_set_fbinfo (rinfo);
 
@@ -2313,10 +2489,15 @@
 	radeon_check_modes(rinfo, mode_option);
 
 	/* Register some sysfs stuff (should be done better) */
-	if (rinfo->mon1_EDID)
+	
+	if ((rinfo->heads[0] != -1) && rinfo->connectors[rinfo->heads[0]].edid)
 		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
-	if (rinfo->mon2_EDID)
+	if ((rinfo->heads[1] != -1) && rinfo->connectors[rinfo->heads[1]].edid)
 		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+	if ((rinfo->heads[2] != -1) && rinfo->connectors[rinfo->heads[2]].edid)
+		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid3_attr);
+	if ((rinfo->heads[3] != -1) && rinfo->connectors[rinfo->heads[3]].edid)
+		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid4_attr);
 
 	/* save current mode regs before we switch into the new one
 	 * so we can restore this upon __exit
@@ -2361,10 +2542,12 @@
 err_unmap_fb:
 	iounmap(rinfo->fb_base);
 err_unmap_rom:
-	kfree(rinfo->mon1_EDID);
-	kfree(rinfo->mon2_EDID);
-	if (rinfo->mon1_modedb)
-		fb_destroy_modedb(rinfo->mon1_modedb);
+	for (i = 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+		kfree(rinfo->connectors[i].edid);
+		if (rinfo->connectors[i].modedb)
+			fb_destroy_modedb(rinfo->connectors[i].modedb);
+	}
+
 	fb_dealloc_cmap(&info->cmap);
 #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
@@ -2389,18 +2572,24 @@
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
- 
+
+	int i;
+
         if (!rinfo)
                 return;
 
 	radeonfb_bl_exit(rinfo);
 	radeonfb_pm_exit(rinfo);
 
-	if (rinfo->mon1_EDID)
+	if ((rinfo->heads[0] != -1) && rinfo->connectors[rinfo->heads[0]].edid)
 		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
-	if (rinfo->mon2_EDID)
+	if ((rinfo->heads[1] != -1) && rinfo->connectors[rinfo->heads[1]].edid)
 		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
-
+	if ((rinfo->heads[2] != -1) && rinfo->connectors[rinfo->heads[2]].edid)
+		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid3_attr);
+	if ((rinfo->heads[3] != -1) && rinfo->connectors[rinfo->heads[3]].edid)
+		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid4_attr);
+ 
 #if 0
 	/* restore original state
 	 * 
@@ -2426,10 +2615,11 @@
 	pci_release_region(pdev, 2);
 	pci_release_region(pdev, 0);
 
-	kfree(rinfo->mon1_EDID);
-	kfree(rinfo->mon2_EDID);
-	if (rinfo->mon1_modedb)
-		fb_destroy_modedb(rinfo->mon1_modedb);
+	for (i = 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+		kfree(rinfo->connectors[i].edid);
+		if (rinfo->connectors[i].modedb)
+			fb_destroy_modedb(rinfo->connectors[i].modedb);
+	}
 #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
 #endif        
@@ -2479,12 +2669,18 @@
 			force_measure_pll = 1;
 		} else if (!strncmp(this_opt, "ignore_edid", 11)) {
 			ignore_edid = 1;
+		} else if (!strncmp(this_opt, "ignore_conntable", 16)) {
+			ignore_conntable = 1;
+		} else if (!strncmp( this_opt, "default_dynclk:", 15)) {
+			default_dynclk = simple_strtoul((this_opt+15), NULL, 10);
 #if defined(CONFIG_PM) && defined(CONFIG_X86)
 	 	} else if (!strncmp(this_opt, "force_sleep", 11)) {
 			force_sleep = 1;
 		} else if (!strncmp(this_opt, "ignore_devlist", 14)) {
 			ignore_devlist = 1;
 #endif
+		} else if (!strncmp(this_opt, "debug", 5)) {
+			radeonfb_debug = 1;
 		} else
 			mode_option = this_opt;
 	}
@@ -2528,6 +2724,8 @@
 MODULE_PARM_DESC(force_dfp, "bool: force display to dfp");
 module_param(ignore_edid, bool, 0);
 MODULE_PARM_DESC(ignore_edid, "bool: Ignore EDID data when doing DDC probe");
+module_param(ignore_conntable, bool, 0);
+MODULE_PARM_DESC(ignore_conntable, "bool: Ignore BIOS Connector table");
 module_param(monitor_layout, charp, 0);
 MODULE_PARM_DESC(monitor_layout, "Specify monitor mapping (like XFree86)");
 module_param(force_measure_pll, bool, 0);
@@ -2546,3 +2744,5 @@
 module_param(ignore_devlist, bool, 0);
 MODULE_PARM_DESC(ignore_devlist, "bool: ignore workarounds for bugs in specific laptops");
 #endif
+module_param(radeonfb_debug, int, 0);
+MODULE_PARM_DESC(radeonfb_debug, "Enable full debugging text");



--------------030303080806070008000502
Content-Type: text/x-patch;
 name="radeonfb.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeonfb.h.diff"

--- radeonfb.h.orig	2007-03-21 22:53:31.000000000 +0100
+++ radeonfb.h	2007-03-25 21:36:19.000000000 +0200
@@ -26,6 +26,8 @@
  * Most of the definitions here are adapted right from XFree86 *
  ***************************************************************/
 
+/* Sorry, we have to limit video ram to 128M */
+#define MAX_VRAM		(128*1024*1024)
 
 /*
  * Chip families. Must fit in the low 16 bits of a long word
@@ -47,7 +49,8 @@
 	CHIP_FAMILY_R350,
 	CHIP_FAMILY_RV350,
 	CHIP_FAMILY_RV380,    /* RV370/RV380/M22/M24 */
-	CHIP_FAMILY_R420,     /* R420/R423/M18 */
+	CHIP_FAMILY_RV410,    /* RV410/M26 */
+	CHIP_FAMILY_R420,     /* R420/R423/R480/M18 */
 	CHIP_FAMILY_LAST,
 };
 
@@ -64,6 +67,7 @@
 				((rinfo)->family == CHIP_FAMILY_RV350) || \
 				((rinfo)->family == CHIP_FAMILY_R350)  || \
 				((rinfo)->family == CHIP_FAMILY_RV380) || \
+				((rinfo)->family == CHIP_FAMILY_RV410) || \
 				((rinfo)->family == CHIP_FAMILY_R420))
 
 /*
@@ -86,11 +90,50 @@
 	CHIP_ERRATA_PLL_DELAY		= 0x00000004,
 };
 
+/*
+ * DDC i2c ports
+ */
+enum radeon_ddc_type {
+	ddc_none = -1,
+	ddc_monid = 0,
+	ddc_dvi,
+	ddc_vga,
+	ddc_crt2,
+};
+
+/*
+ * Connector types
+ */
+enum radeon_legacy_conn_type {
+	legacy_conn_none = 0,
+	legacy_conn_proprietary,
+	legacy_conn_crt,
+	legacy_conn_dvi_i,
+	legacy_conn_dvi_d,
+	legacy_conn_ctv,
+	legacy_conn_stv,
+	legacy_conn_unsupported,
+};
+
+enum radeon_conn_type {
+	conn_none = 0,
+	conn_vga,
+	conn_dvi_i,
+	conn_dvi_d,
+	conn_dvi_a,
+	conn_stv,
+	conn_ctv,
+	conn_lvds,
+	conn_digital,
+	conn_unsupported,
+	conn_proprietary,
+};
 
 /*
  * Monitor types
  */
-enum radeon_montype {
+enum radeon_mon_type {
+	MT_UNKNOWN = -1,
 	MT_NONE = 0,
 	MT_CRT,		/* CRT */
 	MT_LCD,		/* LCD */
@@ -100,27 +143,45 @@
 };
 
 /*
- * DDC i2c ports
+ * DAC types
  */
-enum ddc_type {
-	ddc_none,
-	ddc_monid,
-	ddc_dvi,
-	ddc_vga,
-	ddc_crt2,
+enum radeon_dac_type {
+	dac_unknown = -1,
+	dac_primary = 0,
+	dac_tvdac = 1,
 };
 
 /*
- * Connector types
+ * TMDS types
  */
-enum conn_type {
-	conn_none,
-	conn_proprietary,
-	conn_crt,
-	conn_DVI_I,
-	conn_DVI_D,
+enum radeon_tmds_type {
+	tmds_unknown = -1,
+	tmds_internal = 0,
+	tmds_external = 1,
 };
 
+/*
+ * Each connector gets this structure associated with it,
+ * containing infos about the connector wiring and about
+ * whatever has been detected on it
+ */
+struct radeon_connector {
+	enum radeon_conn_type	conn_type;
+	enum radeon_ddc_type	ddc_type;
+	enum radeon_dac_type	dac_type;
+	enum radeon_tmds_type	tmds_type;
+	enum radeon_mon_type	mon_type;
+	u8			*edid;
+	struct fb_videomode	*modedb;
+	unsigned int		modedb_size;
+
+	int head;
+};
+
+/*
+ * Currently, the driver deals with at most 4 connectors
+ */
+#define RADEON_MAX_CONNECTORS	4
 
 /*
  * PLL infos
@@ -128,11 +189,19 @@
 struct pll_info {
 	int ppll_max;
 	int ppll_min;
-	int sclk, mclk;
+	int sclk;
+	int mclk;
 	int ref_div;
 	int ref_clk;
 };
 
+/*
+ * TMDS PLL infos
+ */
+struct radeon_tmds_pll_info {
+	long	freq;
+	u32	value;
+};
 
 /*
  * This structure contains the various registers manipulated by this
@@ -299,6 +368,20 @@
 	void __iomem		*bios_seg;
 	int			fp_bios_start;
 
+	int                     is_atom_bios;
+	int                     atom_data_start;
+	
+	/* BIOS Functions */
+	int                     (*radeon_get_pll_info)(struct radeonfb_info *rinfo);
+	int                     (*radeon_get_lvds_info)(struct radeonfb_info *rinfo);
+	int                     (*radeon_get_conn_info)(struct radeonfb_info *rinfo);
+	int                     (*radeon_get_tmds_info)(struct radeonfb_info *rinfo);
+
+	/* Connector infos */
+	struct radeon_connector		connectors[RADEON_MAX_CONNECTORS];
+	int                     heads[RADEON_MAX_CONNECTORS];  // index into connectors.
+	int                     num_heads;  // number of heads.
+
 	u32			pseudo_palette[17];
 	struct { u8 red, green, blue, pad; }
 				palette[256];
@@ -317,15 +400,8 @@
 	int			has_CRTC2;
 	int			is_mobility;
 	int			is_IGP;
-	int			reversed_DAC;
-	int			reversed_TMDS;
 	struct panel_info	panel_info;
-	int			mon1_type;
-	u8			*mon1_EDID;
-	struct fb_videomode	*mon1_modedb;
-	int			mon1_dbsize;
-	int			mon2_type;
-	u8		        *mon2_EDID;
+	struct radeon_tmds_pll_info	tmds_pll[4];
 
 	u32			dp_gui_master_cntl;
 
@@ -357,24 +433,19 @@
 };
 
 
-#define PRIMARY_MONITOR(rinfo)	(rinfo->mon1_type)
+#define PRIMARY_HEAD(rinfo)      (rinfo->connectors[rinfo->heads[0]])
+#define SECONDARY_HEAD(rinfo)    (rinfo->connectors[rinfo->heads[1]])
 
+#define SECONDARY_HEAD_PRESENT(rinfo) (rinfo->heads[1] != -1)
+
+#define PRIMARY_MONITOR(rinfo)	 (rinfo->connectors[rinfo->heads[0]].mon_type)
+#define SECONDARY_MONITOR(rinfo) ((SECONDARY_HEAD_PRESENT(rinfo) ? (rinfo->connectors[rinfo->heads[1]].mon_type) : MT_NONE))
 
 /*
  * Debugging stuffs
  */
-#ifdef CONFIG_FB_RADEON_DEBUG
-#define DEBUG		1
-#else
-#define DEBUG		0
-#endif
-
-#if DEBUG
-#define RTRACE		printk
-#else
-#define RTRACE		if(0) printk
-#endif
-
+extern int radeonfb_debug;
+#define RTRACE		if(radeonfb_debug) printk
 
 /*
  * IO macros
@@ -597,7 +668,7 @@
 /* I2C Functions */
 extern void radeon_create_i2c_busses(struct radeonfb_info *rinfo);
 extern void radeon_delete_i2c_busses(struct radeonfb_info *rinfo);
-extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
+extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, struct radeon_connector *conn);
 
 /* PM Functions */
 extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
@@ -635,4 +706,18 @@
 static inline void radeonfb_bl_exit(struct radeonfb_info *rinfo) {}
 #endif
 
+/* Bios functions.  Fix this. */
+extern void __devinit radeon_get_conn_info(struct radeonfb_info *rinfo, int ignore_conntable);
+extern void __devinit radeon_get_tmds_info(struct radeonfb_info *rinfo);
+
+extern int __devinit radeon_get_lvds_info_atom(struct radeonfb_info *rinfo);
+extern int __devinit radeon_get_lvds_info_legacy(struct radeonfb_info *rinfo);
+extern int __devinit radeon_get_conn_info_atom(struct radeonfb_info *rinfo);
+extern int __devinit radeon_get_conn_info_legacy(struct radeonfb_info *rinfo);
+extern int __devinit radeon_get_tmds_info_legacy(struct radeonfb_info *rinfo);
+extern int __devinit radeon_get_tmds_info_atom(struct radeonfb_info *rinfo);
+#ifdef CONFIG_PPC_OF
+extern int __devinit radeon_get_lvds_info_openfirmware(struct radeonfb_info *rinfo);
+extern int __devinit radeon_get_conn_info_openfirmware(struct radeonfb_info *rinfo);
+#endif
 #endif /* __RADEONFB_H__ */



--------------030303080806070008000502
Content-Type: text/x-patch;
 name="radeon_i2c.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_i2c.c.diff"

--- radeon_i2c.c.orig	2007-03-21 22:53:31.000000000 +0100
+++ radeon_i2c.c	2007-03-26 14:20:13.000000000 +0200
@@ -136,35 +136,58 @@
 	rinfo->i2c[3].rinfo = NULL;
 }
 
-int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn,
-			       u8 **out_edid)
+int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, struct radeon_connector *conn)
 {
-	u32 reg = rinfo->i2c[conn-1].ddc_reg;
+	int mon_type = MT_NONE;
 	u8 *edid;
 
-	OUTREG(reg, INREG(reg) &
-			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
+	if (!conn)
+		return 1;
 
-	edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
+	if (rinfo->is_mobility && (conn->ddc_type == ddc_none) &&
+		(INREG(LVDS_GEN_CNTL) & (LVDS_ON|LVDS_EN))) {
+			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn->ddc_type);
+			mon_type = MT_LCD;
+			edid = NULL;
+			goto done;
+	}
+
+	if (conn->ddc_type == ddc_none)
+		return 1;
 
-	if (out_edid)
-		*out_edid = edid;
-	if (!edid) {
-		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn);
-		return MT_NONE;
+	edid = fb_ddc_read(&rinfo->i2c[conn->ddc_type].adapter);
+
+        if (!edid) {
+		/* what about the special case where we are a DFP/LVDS, but have a DDC connection
+		 * but no EDID? We should fall back to MT_LCD...?  XXXX
+		 */
+		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn->ddc_type);
+		mon_type = MT_NONE;
+		goto done;
+	}
+	if ((edid[EDID_STRUCT_DISPLAY] & 0x80) && (conn->ddc_type == ddc_dvi)) {
+		RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn->ddc_type);
+		mon_type = MT_DFP;
+		goto done;
 	}
-	if (edid[0x14] & 0x80) {
-		/* Fix detection using BIOS tables */
-		if (rinfo->is_mobility /*&& conn == ddc_dvi*/ &&
-		    (INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
-			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
-			return MT_LCD;
-		} else {
-			RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn);
-			return MT_DFP;
-		}
+ 
+	if (rinfo->is_mobility && 
+		(conn->conn_type == conn_lvds) &&
+		(edid[EDID_STRUCT_DISPLAY] & 0x80) &&  // ie EDID valid and marks us as a DFP... 
+		(INREG(LVDS_GEN_CNTL) & (LVDS_ON|LVDS_EN))) {
+		RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn->ddc_type);
+		mon_type = MT_LCD;
+		goto done;
 	}
-       	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn);
-	return MT_CRT;
+ 
+	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn->ddc_type);
+	mon_type = MT_CRT;
+
+ done:
+	conn->edid = edid;
+	conn->mon_type = mon_type;
+
+	return (mon_type == MT_NONE);
 }
 
+



--------------030303080806070008000502
Content-Type: text/x-patch;
 name="radeon_monitor.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_monitor.c.diff"

--- radeon_monitor.c.orig	2007-03-21 22:53:31.000000000 +0100
+++ radeon_monitor.c	2007-03-26 14:22:37.000000000 +0200
@@ -1,6 +1,29 @@
 #include "radeonfb.h"
 #include "../edid.h"
 
+/*
+ * TMDS PLL configuration table, taken from X.org
+ */
+static const struct radeon_tmds_pll_info default_tmds_pll[CHIP_FAMILY_LAST][4] =
+{
+    {{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_UNKNOW*/
+    {{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_LEGACY*/
+    {{12000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_RADEON*/
+    {{12000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_RV100*/
+    {{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_RS100*/
+    {{15000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_RV200*/
+    {{12000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_RS200*/
+    {{15000, 0xa1b}, {0xffffffff, 0xa3f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_R200*/
+    {{15500, 0x81b}, {0xffffffff, 0x83f}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_RV250*/
+    {{0, 0}, {0, 0}, {0, 0}, {0, 0}},				/*CHIP_FAMILY_RS300*/
+    {{13000, 0x400f4}, {15000, 0x400f7}, {0xffffffff, 0x400f7}, {0, 0}},	/*CHIP_FAMILY_RV280*/
+    {{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R300*/
+    {{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R350*/
+    {{15000, 0xb0155}, {0xffffffff, 0xb01cb}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_RV350*/
+    {{15000, 0xb0155}, {0xffffffff, 0xb01cb}, {0, 0}, {0, 0}},	/*CHIP_FAMILY_RV380*/
+    {{0xffffffff, 0xb01cb}, {0, 0}, {0, 0}, {0, 0}},		/*CHIP_FAMILY_R420*/
+};
+
 static struct fb_var_screeninfo radeonfb_default_var = {
 	.xres		= 640,
 	.yres		= 480,
@@ -23,34 +46,308 @@
 	.vmode		= FB_VMODE_NONINTERLACED
 };
 
-static char *radeon_get_mon_name(int type)
+int __devinit radeon_get_lvds_info_atom(struct radeonfb_info *rinfo)
 {
-	char *pret = NULL;
+	unsigned long tmp;
 
-	switch (type) {
-		case MT_NONE:
-			pret = "no";
-			break;
-		case MT_CRT:
-			pret = "CRT";
-			break;
-		case MT_DFP:
-			pret = "DFP";
-			break;
-		case MT_LCD:
-			pret = "LCD";
-			break;
-		case MT_CTV:
-			pret = "CTV";
-			break;
-		case MT_STV:
-			pret = "STV";
+	if (!rinfo->bios_seg)
+		return -ENODEV;
+
+	tmp = BIOS_IN16(rinfo->atom_data_start + 16);
+	if (!tmp) {
+		RTRACE("No LVDS panel info in ATOM BIOS\n");
+		rinfo->panel_info.pwr_delay = 200;
+		return -ENODEV;
+	}
+	
+	rinfo->panel_info.xres = BIOS_IN16(tmp+6);
+	rinfo->panel_info.yres = BIOS_IN16(tmp+10);
+	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
+	       rinfo->panel_info.xres, rinfo->panel_info.yres);
+	rinfo->panel_info.pwr_delay = BIOS_IN16(tmp+40);
+	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_delay);
+	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <= 0)
+		rinfo->panel_info.pwr_delay = 2000;
+	
+	/* No special divider combinations? */
+	
+	rinfo->panel_info.hblank = BIOS_IN16(tmp+8);
+	rinfo->panel_info.hOver_plus = BIOS_IN16(tmp+14);
+	rinfo->panel_info.hSync_width = BIOS_IN16(tmp+16);
+	rinfo->panel_info.vblank = BIOS_IN16(tmp+12);
+	rinfo->panel_info.vOver_plus = BIOS_IN16(tmp+18);
+	rinfo->panel_info.vSync_width = BIOS_IN16(tmp+20);
+	rinfo->panel_info.clock = BIOS_IN16(tmp+4);
+	
+	/* Assume high active syncs for now until ATI tells me more... maybe we
+	 * can probe register values here ?
+	 */
+	rinfo->panel_info.hAct_high = 1;
+	rinfo->panel_info.vAct_high = 1;
+	/* Mark panel infos valid */
+	rinfo->panel_info.valid = 1;
+	
+	return 0;
+}
+
+int __devinit radeon_get_lvds_info_legacy(struct radeonfb_info *rinfo)
+{
+	unsigned long tmp, tmp0;
+	char stmp[30];
+	int i;
+
+	if (!rinfo->bios_seg)
+		return -ENODEV;
+
+	if (!(tmp = BIOS_IN16(rinfo->fp_bios_start + 0x40))) {
+		RTRACE("No LVDS panel info in Legacy BIOS\n");
+		rinfo->panel_info.pwr_delay = 200;
+		return -ENODEV;
+	}
+	
+	for(i=0; i<24; i++)
+		stmp[i] = BIOS_IN8(tmp+i+1);
+	stmp[24] = 0;
+	printk("radeonfb: panel ID string: %s\n", stmp);
+	rinfo->panel_info.xres = BIOS_IN16(tmp + 25);
+	rinfo->panel_info.yres = BIOS_IN16(tmp + 27);
+	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
+	       rinfo->panel_info.xres, rinfo->panel_info.yres);
+	
+	rinfo->panel_info.pwr_delay = BIOS_IN16(tmp + 44);
+	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_delay);
+	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <= 0)
+		rinfo->panel_info.pwr_delay = 2000;
+	
+	/*
+	 * Some panels only work properly with some divider combinations
+	 */
+	rinfo->panel_info.ref_divider = BIOS_IN16(tmp + 46);
+	rinfo->panel_info.post_divider = BIOS_IN8(tmp + 48);
+	rinfo->panel_info.fbk_divider = BIOS_IN16(tmp + 49);
+	if (rinfo->panel_info.ref_divider != 0 &&
+	    rinfo->panel_info.fbk_divider > 3) {
+		rinfo->panel_info.use_bios_dividers = 1;
+		printk(KERN_INFO "radeondb: BIOS provided dividers will be used\n");
+		RTRACE("ref_divider = %x\n", rinfo->panel_info.ref_divider);
+		RTRACE("post_divider = %x\n", rinfo->panel_info.post_divider);
+		RTRACE("fbk_divider = %x\n", rinfo->panel_info.fbk_divider);
+	}
+	
+	RTRACE("Scanning BIOS table ...\n");
+	for(i=0; i<32; i++) {
+		tmp0 = BIOS_IN16(tmp+64+i*2);
+		if (tmp0 == 0)
 			break;
+		RTRACE(" %d x %d\n", BIOS_IN16(tmp0), BIOS_IN16(tmp0+2));
+		if ((BIOS_IN16(tmp0) == rinfo->panel_info.xres) &&
+		    (BIOS_IN16(tmp0+2) == rinfo->panel_info.yres)) {
+			rinfo->panel_info.hblank = (BIOS_IN16(tmp0+17) - BIOS_IN16(tmp0+19)) * 8;
+			rinfo->panel_info.hOver_plus = ((BIOS_IN16(tmp0+21) -
+							 BIOS_IN16(tmp0+19) -1) * 8) & 0x7fff;
+			rinfo->panel_info.hSync_width = BIOS_IN8(tmp0+23) * 8;
+			rinfo->panel_info.vblank = BIOS_IN16(tmp0+24) - BIOS_IN16(tmp0+26);
+			rinfo->panel_info.vOver_plus = (BIOS_IN16(tmp0+28) & 0x7ff) - BIOS_IN16(tmp0+26);
+			rinfo->panel_info.vSync_width = (BIOS_IN16(tmp0+28) & 0xf800) >> 11;
+			rinfo->panel_info.clock = BIOS_IN16(tmp0+9);
+			/* Assume high active syncs for now until ATI tells me more... maybe we
+			 * can probe register values here ?
+			 */
+			rinfo->panel_info.hAct_high = 1;
+			rinfo->panel_info.vAct_high = 1;
+			/* Mark panel infos valid */
+			rinfo->panel_info.valid = 1;
+			
+			RTRACE("Found panel in BIOS table:\n");
+			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
+			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
+			RTRACE("  hSync_width: %d\n", rinfo->panel_info.hSync_width);
+			RTRACE("  vblank: %d\n", rinfo->panel_info.vblank);
+			RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
+			RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
+			RTRACE("  clock: %d\n", rinfo->panel_info.clock);
+			
+			return 0;
+		}
+	}
+
+	RTRACE("Didn't find panel in BIOS table !\n");
+
+	return -ENODEV;
+}
+
+/*
+ * Get informations about TMDS controllers and their setup at
+ * different operating frequencies
+ */
+void __devinit radeon_get_tmds_info(struct radeonfb_info *rinfo)
+{
+	int i;
+	int family = rinfo->family;
+
+	/* Get default TMDS infos for this chip */
+	for (i=0; i<4; i++) {
+		rinfo->tmds_pll[i].value = default_tmds_pll[family][i].value;
+		rinfo->tmds_pll[i].freq = default_tmds_pll[family][i].freq;
 	}
 
-	return pret;
+	/* Get whatever the firmware provides */
+	if (rinfo->radeon_get_tmds_info) {
+		rinfo->radeon_get_tmds_info(rinfo);
+		// XXX Do we care about the return value?
+	}
 }
 
+int __devinit radeon_get_tmds_info_legacy(struct radeonfb_info *rinfo)
+{
+	int offset, i, n, rev;
+
+	offset = BIOS_IN16(rinfo->fp_bios_start + 0x34);
+	if (offset == 0)
+		return -ENODEV;
+
+	rev = BIOS_IN8(offset);
+	RTRACE("DFP table revision: %d\n", rev);
+
+	switch(rev) {
+	case 3:
+		n = BIOS_IN8(offset + 5) + 1;
+		if (n > 4)
+			n = 4;
+		for (i = 0; i < n; i++) {
+			/* Looks bogus ... but that's what is in X.org */
+			rinfo->tmds_pll[i].value =
+				BIOS_IN32(offset+i*10+0x08);
+			rinfo->tmds_pll[i].freq =
+				BIOS_IN16(offset+i*10+0x10);
+		}
+		return 0;
+
+	/* revision 4 has some problem as it appears in RV280,
+	 * comment it off for now, use default instead
+	 */
+#if 0
+	case 4:
+		stride = 0;
+		n = BIOS_IN8(offset  5) + 1;
+		if (n > 4)
+			n = 4;
+		for (i = 0; i < n; i++) {
+			rinfo->tmds_pll[i].value =
+				BIOS_IN32(tmp+stride+0x08);
+			rinfo->tmds_pll[i].freq =
+				BIOS_IN16(tmp+stride+0x10);
+			if (i == 0)
+				stride += 10;
+			else
+				stride += 6;
+		}
+		return 0;
+#endif
+	}
+	return -ENODEV;
+}
+
+int __devinit radeon_get_tmds_info_atom(struct radeonfb_info *rinfo)
+{
+	int offset, i, maxfreq;
+
+	offset = BIOS_IN16(rinfo->atom_data_start + 18);
+	if (offset == 0)
+		return -ENODEV;
+
+	maxfreq = BIOS_IN16(offset + 4);
+
+	for (i = 0; i < 4; i++) {
+		rinfo->tmds_pll[i].freq = BIOS_IN16(offset+i*6+6);
+		/* This assumes each field in TMDS_PLL has 6 bit as
+		 * in R300/R420
+		 */
+		rinfo->tmds_pll[i].value =
+			((BIOS_IN8(offset+i*6+8) & 0x3f) |
+			 ((BIOS_IN8(offset+i*6+10) & 0x3f)<<6) |
+			 ((BIOS_IN8(offset+i*6+9) & 0xf)<<12) |
+			 ((BIOS_IN8(offset+i*6+11) & 0xf)<<16));
+		RTRACE("TMDS PLL from BIOS: %ld %x\n",
+		       rinfo->tmds_pll[i].freq, rinfo->tmds_pll[i].value);
+
+		if (maxfreq == rinfo->tmds_pll[i].freq) {
+		    rinfo->tmds_pll[i].freq = 0xffffffff;
+		    break;
+		}
+	}
+	return 0;
+}
+
+
+static const char *conn_type_name[] = {
+	"NONE", "VGA", "DVI-I", "DVI-D", "DVI-A", "S-Video",
+	"Composite Video", "Internal Panel", "Digital",
+	"Unsupported", "Proprietary"
+};
+
+static const char *mon_type_name[] = {
+	"None", "CRT", "LVDS Flat panel",
+	"DVI Flat panel", "Composite TV", "S-Video TV"
+};
+
+static void __devinit radeon_fill_conn(struct radeon_connector *conn, int mon_type, int ddc_type, int *found_tmds, int *found_crt) 
+{
+	conn->mon_type = mon_type;
+	conn->ddc_type = ddc_type;
+
+	// XXX what about reversed DAC/TMDS??
+
+	switch(mon_type) {
+	case MT_CRT:
+		conn->conn_type = conn_vga;
+		conn->tmds_type = tmds_unknown;
+		conn->dac_type = (*found_crt) ? dac_tvdac: dac_primary;
+		if (ddc_type == ddc_none)
+			conn->ddc_type = (*found_crt) ? ddc_crt2 : ddc_vga;
+		*found_crt = 1;
+		break;
+	case MT_DFP:
+		conn->conn_type = conn_dvi_i;
+		conn->tmds_type = (*found_tmds) ? tmds_external: tmds_internal;
+		conn->dac_type = dac_unknown;
+		if (ddc_type == ddc_none) conn->ddc_type = ddc_dvi;
+		*found_tmds = 1;
+		break;
+	case MT_LCD:
+		conn->conn_type = conn_lvds;
+		conn->tmds_type = tmds_unknown;
+		conn->dac_type = dac_unknown;
+		if (ddc_type == ddc_none) 
+			conn->ddc_type = ddc_none; //heh
+		break;
+	case MT_CTV:
+		conn->conn_type = conn_ctv;
+		conn->tmds_type = tmds_unknown;
+		conn->dac_type = dac_tvdac;
+		if (ddc_type == ddc_none) 
+			conn->ddc_type = ddc_vga; // XXX ddc_crt2?
+		break;
+	case MT_STV:
+		conn->conn_type = conn_stv;
+		conn->tmds_type = tmds_unknown;
+		conn->dac_type = dac_tvdac;
+		if (ddc_type == ddc_none) 
+			conn->ddc_type = ddc_vga; // XXX ddc_crt2?
+		break;
+	case MT_UNKNOWN:
+	case MT_NONE:
+		conn->conn_type = conn_none;
+		conn->tmds_type = tmds_unknown;
+		conn->mon_type = MT_NONE;
+		conn->ddc_type = ddc_none;
+		conn->dac_type = dac_unknown;
+		break;
+	default:
+		break;
+	}
+	// leaves conn_digital, conn_unsupported, conn_propritetary
+}
 
 #ifdef CONFIG_PPC_OF
 /*
@@ -59,33 +356,40 @@
  * models with broken OF probing by hard-coding known EDIDs for some Mac
  * laptops internal LVDS panel. (XXX: not done yet)
  */
-static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_EDID,
+static int __devinit radeon_parse_montype_prop(struct radeonfb_info *rinfo,
+					       struct device_node *dp,
+					       struct radeon_connector *conn,
 					       int hdno)
 {
-        static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID",
+	static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID",
 				     "EDID1", "EDID2",  NULL };
 	const u8 *pedid = NULL;
 	const u8 *pmt = NULL;
 	u8 *tmp;
-        int i, mt = MT_NONE;  
-	
+	int i;
+
 	RTRACE("analyzing OF properties...\n");
 	pmt = get_property(dp, "display-type", NULL);
 	if (!pmt)
-		return MT_NONE;
+		return -1;
 	RTRACE("display-type: %s\n", pmt);
-	/* OF says "LCD" for DFP as well, we discriminate from the caller of this
-	 * function
-	 */
-	if (!strcmp(pmt, "LCD") || !strcmp(pmt, "DFP"))
-		mt = MT_DFP;
-	else if (!strcmp(pmt, "CRT"))
-		mt = MT_CRT;
-	else {
+	if (!strcmp(pmt, "LCD") || !strcmp(pmt, "DFP")) {
+		/* OF says "LCD" for DFP as well.*/
+		if (rinfo->is_mobility) {
+			conn->mon_type = MT_LCD;
+			/* Maybe check for LVDS_GEN_CNTL here ? I need to check out
+			 * what OF does when booting with lid closed
+			 */
+		} else{
+			conn->mon_type = MT_DFP;
+		}
+	} else if (!strcmp(pmt, "CRT")) {
+		conn->mon_type = MT_CRT;
+	} else {
 		if (strcmp(pmt, "NONE") != 0)
 			printk(KERN_WARNING "radeonfb: Unknown OF display-type: %s\n",
 			       pmt);
-		return MT_NONE;
+		return -1;
 	}
 
 	for (i = 0; propnames[i] != NULL; ++i) {
@@ -102,25 +406,36 @@
 	if (pedid == NULL && dp->parent && (hdno == 0))
 		pedid = get_property(dp->parent, "EDID", NULL);
 	if (pedid == NULL)
-		return mt;
+		return -1;
 
 	tmp = kmemdup(pedid, EDID_LENGTH, GFP_KERNEL);
-	if (!tmp)
-		return mt;
-	*out_EDID = tmp;
-	return mt;
+	conn->edid = tmp;
+
+	{
+		int found_tmds = 0;
+		int found_crt = 0;
+		int ddc_type = ddc_none;
+		// XXX what about reversed DAC/TMDS??
+		radeon_fill_conn(conn, conn->mon_type, ddc_type, &found_crt, &found_tmds);
+	}
+
+	return 0;
 }
 
-static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_no,
-					  u8 **out_EDID)
+/* return a -1 on error */
+static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_no)
+
 {
-        struct device_node *dp;
+	struct radeon_connector *conn;
+	struct device_node *dp;
 
 	RTRACE("radeon_probe_OF_head\n");
 
-        dp = rinfo->of_node;
-        while (dp == NULL)
-		return MT_NONE;
+	conn = &rinfo->connectors[head_no];
+
+	dp = rinfo->of_node;
+	if (dp == NULL)
+		return -1;
 
 	if (rinfo->has_CRTC2) {
 		const char *pname;
@@ -129,116 +444,284 @@
 		dp = dp->child;
 		do {
 			if (!dp)
-				return MT_NONE;
+				return -1;
+
 			pname = get_property(dp, "name", NULL);
-			if (!pname)
-				return MT_NONE;
+			if (!pname) 
+				return -1;
+
 			len = strlen(pname);
 			RTRACE("head: %s (letter: %c, head_no: %d)\n",
 			       pname, pname[len-1], head_no);
 			if (pname[len-1] == 'A' && head_no == 0) {
-				int mt = radeon_parse_montype_prop(dp, out_EDID, 0);
-				/* Maybe check for LVDS_GEN_CNTL here ? I need to check out
-				 * what OF does when booting with lid closed
-				 */
-				if (mt == MT_DFP && rinfo->is_mobility)
-					mt = MT_LCD;
-				return mt;
-			} else if (pname[len-1] == 'B' && head_no == 1)
-				return radeon_parse_montype_prop(dp, out_EDID, 1);
+				return radeon_parse_montype_prop(rinfo, dp, conn, 0);
+			} else if (pname[len-1] == 'B' && head_no == 1) {
+				return radeon_parse_montype_prop(rinfo, dp, conn, 1);
+			}
 			second = 1;
 			dp = dp->sibling;
 		} while(!second);
 	} else {
 		if (head_no > 0)
-			return MT_NONE;
-		return radeon_parse_montype_prop(dp, out_EDID, -1);
+			return -1;
+		return radeon_parse_montype_prop(rinfo, dp, conn, -1);
 	}
-        return MT_NONE;
+	return -1;
 }
 #endif /* CONFIG_PPC_OF */
 
-
-static int __devinit radeon_get_panel_info_BIOS(struct radeonfb_info *rinfo)
+/*
+ * Get informations about the various connectors on this card. This is
+ * the most prone to fail function as various firmwares tend to say
+ * crap or not give any info at all. The Open Firmware version is just
+ * a table of known cards for now for example. We'll probably need some
+ * additional module params to force different settings in case of
+ * misdetection here.
+ *
+ * This doesn _not_ try actual probing of whatever is plugged on those
+ * various connectors. This will be done later. We do store whatever
+ * probing info the firmware gives us though
+ */
+void __devinit radeon_get_conn_info(struct radeonfb_info *rinfo, int ignore_conntable)
 {
-	unsigned long tmp, tmp0;
-	char stmp[30];
 	int i;
 
-	if (!rinfo->bios_seg)
-		return 0;
+	/* Clear table */
+	for (i = 0; i < RADEON_MAX_CONNECTORS; i++) {
+		rinfo->connectors[i].conn_type	= conn_none;
+		rinfo->connectors[i].ddc_type	= ddc_none;
+		rinfo->connectors[i].dac_type	= dac_unknown;
+		rinfo->connectors[i].tmds_type	= tmds_unknown;
+		rinfo->connectors[i].mon_type	= MT_UNKNOWN;
+		rinfo->connectors[i].head       = -1;
+		rinfo->heads[i] = -1;
+	}
+	rinfo->num_heads = 0;
+
+	if (ignore_conntable) {	
+#if defined(CONFIG_FB_RADEON_I2C)
+		struct radeon_connector conn;
+		int idx = 0;
+		int found_tmds = 0;
+		int found_crt = 0;
+
+		// XXX what about reversed DAC/TMDS??
+
+		for (i = 0; i < 4; i++) {
+			conn.ddc_type = i;
+			if (!radeon_probe_i2c_connector(rinfo, &conn)) {
+				radeon_fill_conn(&rinfo->connectors[idx++], conn.mon_type, conn.ddc_type, 
+						 &found_tmds, &found_crt); 
+			}
+		}
 
-	if (!(tmp = BIOS_IN16(rinfo->fp_bios_start + 0x40))) {
-		printk(KERN_ERR "radeonfb: Failed to detect DFP panel info using BIOS\n");
-		rinfo->panel_info.pwr_delay = 200;
-		return 0;
+		/* If we failed to probe something.. */
+		if (idx) 
+			goto found;
+#endif /* CONFIG_FB_RADEON_I2C */
+	} else {
+		/* Try to obtain infos from firmware */
+		if (rinfo->radeon_get_conn_info) {
+			if (!rinfo->radeon_get_conn_info(rinfo)) {
+				goto found;
+			}
+		}
 	}
 
-	for(i=0; i<24; i++)
-		stmp[i] = BIOS_IN8(tmp+i+1);
-	stmp[24] = 0;
-	printk("radeonfb: panel ID string: %s\n", stmp);
-	rinfo->panel_info.xres = BIOS_IN16(tmp + 25);
-	rinfo->panel_info.yres = BIOS_IN16(tmp + 27);
-	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
-		rinfo->panel_info.xres, rinfo->panel_info.yres);
-
-	rinfo->panel_info.pwr_delay = BIOS_IN16(tmp + 44);
-	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_delay);
-	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <= 0)
-		rinfo->panel_info.pwr_delay = 2000;
+	printk(KERN_INFO "radeonfb: No connector infos, using defaults...\n");
 
-	/*
-	 * Some panels only work properly with some divider combinations
+	/* Here, we use defaults that are common enough ... we hope
+	 * For a mobility chip, we assume LVDS is on primary
 	 */
-	rinfo->panel_info.ref_divider = BIOS_IN16(tmp + 46);
-	rinfo->panel_info.post_divider = BIOS_IN8(tmp + 48);
-	rinfo->panel_info.fbk_divider = BIOS_IN16(tmp + 49);
-	if (rinfo->panel_info.ref_divider != 0 &&
-	    rinfo->panel_info.fbk_divider > 3) {
-		rinfo->panel_info.use_bios_dividers = 1;
-		printk(KERN_INFO "radeondb: BIOS provided dividers will be used\n");
-		RTRACE("ref_divider = %x\n", rinfo->panel_info.ref_divider);
-		RTRACE("post_divider = %x\n", rinfo->panel_info.post_divider);
-		RTRACE("fbk_divider = %x\n", rinfo->panel_info.fbk_divider);
+	if (rinfo->is_mobility) {
+		rinfo->connectors[0].conn_type	= conn_lvds;
+		rinfo->connectors[0].ddc_type	= ddc_dvi;
+		rinfo->connectors[0].dac_type	= dac_primary;
+		rinfo->connectors[0].tmds_type	= tmds_unknown;
+		rinfo->connectors[0].mon_type	= MT_UNKNOWN;
+
+		rinfo->connectors[1].conn_type	= conn_dvi_d;
+		rinfo->connectors[1].ddc_type	= ddc_vga;
+		rinfo->connectors[1].dac_type	= dac_primary;
+		rinfo->connectors[1].tmds_type	= tmds_internal;
+		rinfo->connectors[1].mon_type	= MT_UNKNOWN;
+
+		rinfo->connectors[2].conn_type	= conn_stv;
+		rinfo->connectors[2].ddc_type	= ddc_none;
+		rinfo->connectors[2].dac_type	= dac_tvdac;
+		rinfo->connectors[2].tmds_type	= tmds_unknown;
+		rinfo->connectors[2].mon_type	= MT_UNKNOWN;
+	} else {
+		rinfo->connectors[0].conn_type	= conn_dvi_d;
+		rinfo->connectors[0].ddc_type	= ddc_dvi;
+		rinfo->connectors[0].dac_type	= dac_tvdac;
+		rinfo->connectors[0].tmds_type	= tmds_internal;
+		rinfo->connectors[0].mon_type	= MT_UNKNOWN;
+
+		rinfo->connectors[1].conn_type	= conn_vga;
+		rinfo->connectors[1].ddc_type	= ddc_vga;
+		rinfo->connectors[1].dac_type	= dac_primary;
+		rinfo->connectors[1].tmds_type	= tmds_unknown;
+		rinfo->connectors[1].mon_type	= MT_UNKNOWN;
+		
+		if (rinfo->has_CRTC2) {
+			rinfo->connectors[1].conn_type	= conn_vga;
+			rinfo->connectors[1].ddc_type	= ddc_crt2;
+			rinfo->connectors[1].dac_type	= dac_tvdac;
+			rinfo->connectors[1].tmds_type	= tmds_unknown;
+			rinfo->connectors[1].mon_type	= MT_UNKNOWN;
+		}
 	}
-	RTRACE("Scanning BIOS table ...\n");
-	for(i=0; i<32; i++) {
-		tmp0 = BIOS_IN16(tmp+64+i*2);
-		if (tmp0 == 0)
-			break;
-		RTRACE(" %d x %d\n", BIOS_IN16(tmp0), BIOS_IN16(tmp0+2));
-		if ((BIOS_IN16(tmp0) == rinfo->panel_info.xres) &&
-		    (BIOS_IN16(tmp0+2) == rinfo->panel_info.yres)) {
-			rinfo->panel_info.hblank = (BIOS_IN16(tmp0+17) - BIOS_IN16(tmp0+19)) * 8;
-			rinfo->panel_info.hOver_plus = ((BIOS_IN16(tmp0+21) -
-							 BIOS_IN16(tmp0+19) -1) * 8) & 0x7fff;
-			rinfo->panel_info.hSync_width = BIOS_IN8(tmp0+23) * 8;
-			rinfo->panel_info.vblank = BIOS_IN16(tmp0+24) - BIOS_IN16(tmp0+26);
-			rinfo->panel_info.vOver_plus = (BIOS_IN16(tmp0+28) & 0x7ff) - BIOS_IN16(tmp0+26);
-			rinfo->panel_info.vSync_width = (BIOS_IN16(tmp0+28) & 0xf800) >> 11;
-			rinfo->panel_info.clock = BIOS_IN16(tmp0+9);
-			/* Assume high active syncs for now until ATI tells me more... maybe we
-			 * can probe register values here ?
+
+ found:
+	/* Now, we do additional fixups */
+
+	/* RS300 has only one DAC, force TV-DAC on VGA port */
+	if (rinfo->family == CHIP_FAMILY_RS300) {
+		for (i = 0; i < RADEON_MAX_CONNECTORS; i++) {
+			if (rinfo->connectors[i].conn_type == conn_vga)
+				rinfo->connectors[i].dac_type = dac_tvdac;
+			else if (rinfo->connectors[i].dac_type != dac_unknown)
+				rinfo->connectors[i].dac_type = dac_primary;
+		}
+	}
+
+	/* Single head chips all use primary DAC */
+	if (!rinfo->has_CRTC2)
+		rinfo->connectors[0].dac_type = dac_primary;
+
+	return;
+ }
+
+#ifdef CONFIG_PPC_OF
+int __devinit radeon_get_conn_info_openfirmware(struct radeonfb_info *rinfo)
+{
+	int i;
+	int found = 0;
+
+	/* Only two heads for OF! */
+	for(i = 0 ; i < 2 ; i++) {
+		if (!radeon_probe_OF_head(rinfo, i))
+			found = 0;
+	}
+	return found;
+}
+#endif /* CONFIG_PPC_OF */
+
+int __devinit radeon_get_conn_info_atom(struct radeonfb_info *rinfo)
+{
+	int i, j, offset, valids;
+	int ids[RADEON_MAX_CONNECTORS];
+	u16 portinfo, tmp0;
+	int conn_index = 0;
+	int conn_add = 2;
+	int idx = 0;
+	int ddc_type, dac_type, conn_type, tmds_type, port_id;
+	int connector_found = 0;
+	int shared;
+	
+	offset = BIOS_IN16(rinfo->atom_data_start + 22);
+	if (offset == 0)
+		return -ENODEV;
+
+	/* Again, I slightly modified X.org algorithm. I assign "primary" outputs
+	 * to entries 0 and 1, and anything else goes after 2.
+	 *
+	 * Also, I keep an array of all port IDs matching connectors[] array,
+	 * unlike X which limits itself to "crtc"'s
+	 */
+	for (i = 0; i < RADEON_MAX_CONNECTORS; i++)
+		ids[i] = -1;
+
+	valids = BIOS_IN16(offset + 4);
+	for (i = 0; i < 8; i++) {
+		shared = 0;
+		if (!(valids & (1 << i)))
+			continue;
+		portinfo = BIOS_IN16(offset + 6 + i*2);
+
+		conn_type = (portinfo >> 4) & 0xf;
+		dac_type = (portinfo & 0xf) - 1;
+		port_id = (portinfo >> 8) & 0xf;
+		ddc_type = ddc_none;
+
+		if ((tmp0 = BIOS_IN16(rinfo->atom_data_start + 24))) {
+			switch(BIOS_IN16(tmp0 + 4 + (27 * port_id)) * 4) {
+			case GPIO_MONID:
+				ddc_type = ddc_monid;
+				break;
+			case GPIO_DVI_DDC:
+				ddc_type = ddc_dvi;
+				break;
+			case GPIO_VGA_DDC:
+				ddc_type = ddc_vga;
+				break;
+			case GPIO_CRT2_DDC:
+				ddc_type = ddc_crt2;
+				break;
+			default:
+				ddc_type = ddc_none;
+				break;
+			}
+		}
+
+		if (i == 3)
+			tmds_type = tmds_internal;
+		else if (i == 7)
+			tmds_type = tmds_external;
+		else
+			tmds_type = tmds_unknown;
+
+		RTRACE("index %d port %d conn %d dac %d ddc %d tmds %d\n", i, port_id, conn_type, dac_type, ddc_type, tmds_type);
+		
+		/* Ok, now we have the port ID, look for an existing port
+		 * already using this ID
+		 */
+		for (j = 0; j < RADEON_MAX_CONNECTORS; j++) {
+			if (port_id != ids[j])
+				continue;
+			/* This port is shared. Update the values (if needed)
+			 * and probe next connector without creating a new
+			 * connector entry.
 			 */
-			rinfo->panel_info.hAct_high = 1;
-			rinfo->panel_info.vAct_high = 1;
-			/* Mark panel infos valid */
-			rinfo->panel_info.valid = 1;
+			if (tmds_type != tmds_unknown)
+				rinfo->connectors[j].tmds_type = tmds_type;
+			if (rinfo->connectors[j].dac_type == dac_unknown)
+				rinfo->connectors[j].dac_type = dac_type;
+			if (rinfo->connectors[j].ddc_type == ddc_none)
+				rinfo->connectors[j].ddc_type = ddc_type;
 
-			RTRACE("Found panel in BIOS table:\n");
-			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
-			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
-			RTRACE("  hSync_width: %d\n", rinfo->panel_info.hSync_width);
-			RTRACE("  vblank: %d\n", rinfo->panel_info.vblank);
-			RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
-			RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
-			RTRACE("  clock: %d\n", rinfo->panel_info.clock);
-				
-			return 1;
+			shared = 1;
 		}
+
+		if (shared)
+			continue;
+
+		conn_index = (ddc_type == ddc_dvi || conn_index == 1) ? 0 : 1;
+
+		/* if the port is a TV port, or both connectors are already
+		 * assigned, assign it after further in the table
+		 */
+		if (conn_type == conn_ctv || conn_type == conn_stv ||
+		    (rinfo->connectors[0].conn_type != conn_none &&
+		     rinfo->connectors[1].conn_type != conn_none))
+			idx = conn_add++;
+		else
+			idx = conn_index;
+
+		rinfo->connectors[idx].tmds_type = tmds_type;
+		rinfo->connectors[idx].dac_type = dac_type;
+		rinfo->connectors[idx].ddc_type = ddc_type;
+		rinfo->connectors[idx].conn_type = conn_type;
+		ids[idx] = port_id;
+
+		/* increment connector_found for primary connectors only */
+		if (idx < 2)
+			connector_found += (idx + 1);
 	}
-	RTRACE("Didn't find panel in BIOS table !\n");
+
+	if (connector_found == 0)
+		return -ENODEV;
 
 	return 0;
 }
@@ -247,44 +730,167 @@
  * doesn't quite work yet, but it's output is still useful for
  * debugging
  */
-static void __devinit radeon_parse_connector_info(struct radeonfb_info *rinfo)
+int __devinit radeon_get_conn_info_legacy(struct radeonfb_info *rinfo)
 {
-	int offset, chips, connectors, tmp, i, conn, type;
-
-	static char* __conn_type_table[16] = {
-		"NONE", "Proprietary", "CRT", "DVI-I", "DVI-D", "Unknown", "Unknown",
-		"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown",
-		"Unknown", "Unknown", "Unknown"
+	int offset, i, entry, tmp;
+	int ddc_type, dac_type, conn_type, tmds_type;
+	int conn_index = 0;
+	int conn_add = 2;
+	int idx = 0;
+
+	/* Convert legacy to real connector types */
+	const enum radeon_conn_type legacy_conn_to_type[] = {
+		conn_none,
+		conn_proprietary,
+		conn_vga,
+		conn_dvi_i,
+		conn_dvi_d,
+		conn_ctv,
+		conn_stv,
+		conn_unsupported,
 	};
 
-	if (!rinfo->bios_seg)
-		return;
+	/* Some laptops only have one connector (VGA) listed in the connector
+	 * table, we need to add LVDS in as a non-DDC display.
+	 * Note, we can't assume the listed VGA will be filled in PortInfo[0],
+	 * when walking through connector table. connector_found has following
+	 * meaning:
+	 * 0 -- nothing found,
+	 * 1 -- only connectors[0] filled,
+	 * 2 -- only connectors[1] filled,
+	 * 3 -- both are filled.
+	 *
+	 * Note: I modified X.org algorithm to add additional entries if any
+	 * after the second table slot. Those entries do not affect the value
+	 * of connector_found. --BenH.
+	 */
+	int connector_found = 0;
 
 	offset = BIOS_IN16(rinfo->fp_bios_start + 0x50);
-	if (offset == 0) {
-		printk(KERN_WARNING "radeonfb: No connector info table detected\n");
-		return;
-	}
-
-	/* Don't do much more at this point but displaying the data if
-	 * DEBUG is enabled
-	 */
-	chips = BIOS_IN8(offset++) >> 4;
-	RTRACE("%d chips in connector info\n", chips);
-	for (i = 0; i < chips; i++) {
-		tmp = BIOS_IN8(offset++);
-		connectors = tmp & 0x0f;
-		RTRACE(" - chip %d has %d connectors\n", tmp >> 4, connectors);
-		for (conn = 0; ; conn++) {
-			tmp = BIOS_IN16(offset);
-			if (tmp == 0)
-				break;
-			offset += 2;
-			type = (tmp >> 12) & 0x0f;
-			RTRACE("  * connector %d of type %d (%s) : %04x\n",
-			       conn, type, __conn_type_table[type], tmp);
+	if (offset == 0)
+		return -ENODEV;
+
+	for (i = 1; i < 4; i++) {
+		entry = offset + i*2;
+
+		/* End of table */
+		if (!BIOS_IN8(entry) && i > 1)
+			break;
+
+		/* Read table entry, check connector type */
+		tmp = BIOS_IN16(entry);
+		conn_type = (tmp >> 12) & 0xf;
+		if (conn_type == legacy_conn_none)
+			continue;
+		ddc_type = (tmp >> 8) & 0xf;
+		dac_type = (tmp & 0x01) ? dac_tvdac : dac_primary;
+		tmds_type = (tmp & 0x10) ? tmds_external : tmds_internal;
+
+		/* same connector */
+		if (connector_found > 0) {
+			if (rinfo->connectors[conn_index].ddc_type == ddc_type)
+				continue;
 		}
+
+		/* sanity checks */
+		if (ddc_type > ddc_crt2)
+			ddc_type = ddc_none;
+		if (conn_type > legacy_conn_unsupported)
+			conn_type = legacy_conn_unsupported;
+		if (conn_type != legacy_conn_dvi_d &&
+		    conn_type != legacy_conn_dvi_i &&
+		    tmds_type == tmds_internal)
+			tmds_type= tmds_unknown;
+
+		/* convert connector type */
+		conn_type = legacy_conn_to_type[conn_type];
+
+		/* internal DDC_DVI port will get assigned to connector[0], or
+		 * if there is no DDC_DVI (like in some IGPs).
+		 */
+		conn_index = (ddc_type == ddc_dvi || conn_index == 1) ? 0 : 1;
+
+		/* if the port is a TV port, or both connectors are already
+		 * assigned, assign it after further in the table
+		 */
+		if (conn_type == conn_ctv || conn_type == conn_stv ||
+		    (rinfo->connectors[0].conn_type != conn_none &&
+		     rinfo->connectors[1].conn_type))
+			idx = conn_add++;
+		else
+			idx = conn_index;
+
+		/* if table full, exit */
+		if (idx >= RADEON_MAX_CONNECTORS) {
+			printk(KERN_WARNING "radeonfb: Connector table full !\n");
+			break;
+		}
+		rinfo->connectors[idx].conn_type	= conn_type;
+		rinfo->connectors[idx].ddc_type		= ddc_type;
+		rinfo->connectors[idx].dac_type		= dac_type;
+		rinfo->connectors[idx].tmds_type	= tmds_type;
+
+		/* increment connector_found for primary connectors only */
+		if (idx < 2)
+			connector_found += (idx + 1);
+	}
+
+	if (rinfo->is_mobility) {
+	    /* For the cases where only one VGA connector is found,
+	     * we assume LVDS is not listed in the connector table,
+	     * add it in here as the first port.
+	     *
+	     * TODO: Check what's up with laptops that have a DVI output
+	     * and no LVDS entry in the table. I suspect some thinkpads
+	     * may play trick with us here... We may want to check the
+	     * presence of a panel via LVDS_GEN_CNTL to be sure...
+	     */
+	    if ((connector_found < 3) &&
+		(rinfo->connectors[idx].conn_type == conn_vga)) {
+		    if (connector_found == 1) {
+			    memcpy(&rinfo->connectors[1], &rinfo->connectors[0],
+				   sizeof(struct radeon_connector));
+		    }
+
+		    /* Fixme: TV DAC is probably elsewhere ... */
+		    rinfo->connectors[0].dac_type = dac_tvdac;
+		    rinfo->connectors[0].tmds_type = tmds_unknown;
+		    rinfo->connectors[0].ddc_type = ddc_none;
+		    rinfo->connectors[0].conn_type = conn_proprietary;
+
+		    printk(KERN_WARNING "radeonfb: LVDS port is not in connector table, added in.\n");
+		    if (connector_found == 0)
+			    connector_found = 1;
+		    else
+			    connector_found = 3;
+	    }
+
+	    /* Check for LCD DDC info table */
+	    if ((offset = BIOS_IN16(rinfo->fp_bios_start + 0x42))) {
+		    if ((tmp = BIOS_IN16(offset + 0x15))) {
+			    if ((ddc_type = BIOS_IN8(tmp+2) & 0x07)) {
+				    rinfo->connectors[0].ddc_type = ddc_type;
+				    printk(KERN_WARNING "radeonfb: LCD DDC Info Table found, "
+						"forcing primary port to %d\n",
+						ddc_type);
+			    }
+		    }
+	    }
+	} else if (connector_found == 2) {
+		memcpy(&rinfo->connectors[0], &rinfo->connectors[1],
+			sizeof (struct radeon_connector));
+		rinfo->connectors[1].dac_type = dac_unknown;
+		rinfo->connectors[1].tmds_type = tmds_unknown;
+		rinfo->connectors[1].ddc_type = ddc_none;
+		rinfo->connectors[1].conn_type = conn_none;
+		connector_found = 1;
 	}
+
+	if (connector_found == 0)
+		return -ENODEV;
+
+	/* External TMDS Table, not used now */
+	return 0;
 }
 
 
@@ -361,6 +967,51 @@
     return connected ? MT_CRT : MT_NONE;
 }
 
+/* Find if the desired connector and monitor are compatible */
+static int __devinit radeon_conn_monitor_compatible(int mon_type, int conn_type) 
+{
+	switch(mon_type) {
+	case MT_CRT:
+		return ((conn_type == conn_vga) || (conn_type == conn_dvi_a));
+	case MT_DFP:
+		return ((conn_type == conn_dvi_i) || (conn_type == conn_dvi_d));
+	case MT_LCD:
+		return (conn_type == conn_lvds);
+	case MT_CTV:
+		return (conn_type == conn_ctv);
+	case MT_STV:
+		return (conn_type == conn_stv);
+	case MT_UNKNOWN:
+	case MT_NONE:
+	default:
+		return 0;
+	}
+	// leaves conn_digital, conn_unsupported, conn_propritetary
+}
+
+/* Find a suitable connector for this display type */
+static int __devinit radeon_find_connector_for_mon(struct radeonfb_info *rinfo, int mon_type)
+{
+	int i;
+	
+	if (mon_type <= MT_NONE) 
+		return 0;
+	
+	for (i = 0; i < RADEON_MAX_CONNECTORS ; i++) {
+		if (radeon_conn_monitor_compatible(mon_type, rinfo->connectors[i].conn_type) && 
+		    (rinfo->connectors[i].mon_type <= MT_NONE)) {
+			rinfo->connectors[i].mon_type = mon_type;
+			rinfo->connectors[i].head = rinfo->num_heads;
+			rinfo->heads[rinfo->num_heads] = i;
+			rinfo->num_heads++;
+			return 0;
+		}
+	}
+
+	printk(KERN_INFO "radeonfb: couldn't find a connector for monitor %d\n", mon_type);
+	return -1;
+}
+
 /*
  * Parse the "monitor_layout" string if any. This code is mostly
  * copied from XFree's radeon driver
@@ -406,19 +1057,20 @@
 		s1[i] = 0;
 		s2[0] = 0;
 	}
+
 	if (strcmp(s1, "CRT") == 0)
-		rinfo->mon1_type = MT_CRT;
+		radeon_find_connector_for_mon(rinfo, MT_CRT);
 	else if (strcmp(s1, "TMDS") == 0)
-		rinfo->mon1_type = MT_DFP;
+		radeon_find_connector_for_mon(rinfo, MT_DFP);
 	else if (strcmp(s1, "LVDS") == 0)
-		rinfo->mon1_type = MT_LCD;
+		radeon_find_connector_for_mon(rinfo, MT_LCD);
 
 	if (strcmp(s2, "CRT") == 0)
-		rinfo->mon2_type = MT_CRT;
+		radeon_find_connector_for_mon(rinfo, MT_CRT);
 	else if (strcmp(s2, "TMDS") == 0)
-		rinfo->mon2_type = MT_DFP;
+		radeon_find_connector_for_mon(rinfo, MT_DFP);
 	else if (strcmp(s2, "LVDS") == 0)
-		rinfo->mon2_type = MT_LCD;
+		radeon_find_connector_for_mon(rinfo, MT_LCD);
 
 	return 1;
 }
@@ -432,12 +1084,7 @@
 void __devinit radeon_probe_screens(struct radeonfb_info *rinfo,
 				    const char *monitor_layout, int ignore_edid)
 {
-#ifdef CONFIG_FB_RADEON_I2C
-	int ddc_crt2_used = 0;	
-#endif
-	int tmp, i;
-
-	radeon_parse_connector_info(rinfo);
+	int i;
 
 	if (radeon_parse_monitor_layout(rinfo, monitor_layout)) {
 
@@ -448,30 +1095,32 @@
 		 * a layout for each card ?
 		 */
 
-		RTRACE("Using specified monitor layout: %s", monitor_layout);
+		RTRACE("Using specified monitor layout: %s\n", monitor_layout);
 #ifdef CONFIG_FB_RADEON_I2C
 		if (!ignore_edid) {
-			if (rinfo->mon1_type != MT_NONE)
-				if (!radeon_probe_i2c_connector(rinfo, ddc_dvi, &rinfo->mon1_EDID)) {
-					radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon1_EDID);
-					ddc_crt2_used = 1;
+			int mon_type;
+
+			/* If the DDC detection fails, 
+			   we still want to use the user's specified layout! */
+			mon_type = PRIMARY_MONITOR(rinfo);
+
+			if (PRIMARY_MONITOR(rinfo) > MT_NONE)
+				if (radeon_probe_i2c_connector(rinfo, &PRIMARY_HEAD(rinfo)))
+					PRIMARY_MONITOR(rinfo) = mon_type;
+			if (SECONDARY_HEAD_PRESENT(rinfo)) {
+				mon_type = SECONDARY_MONITOR(rinfo);
+				if (SECONDARY_MONITOR(rinfo) > MT_NONE) {
+					if (radeon_probe_i2c_connector(rinfo, &SECONDARY_HEAD(rinfo)))
+						rinfo->connectors[rinfo->heads[1]].mon_type = mon_type;
 				}
-			if (rinfo->mon2_type != MT_NONE)
-				if (!radeon_probe_i2c_connector(rinfo, ddc_vga, &rinfo->mon2_EDID) &&
-				    !ddc_crt2_used)
-					radeon_probe_i2c_connector(rinfo, ddc_crt2, &rinfo->mon2_EDID);
+			}
 		}
 #endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon1_type == MT_NONE) {
-			if (rinfo->mon2_type != MT_NONE) {
-				rinfo->mon1_type = rinfo->mon2_type;
-				rinfo->mon1_EDID = rinfo->mon2_EDID;
-			} else {
-				rinfo->mon1_type = MT_CRT;
-				printk(KERN_INFO "radeonfb: No valid monitor, assuming CRT on first port\n");
-			}
-			rinfo->mon2_type = MT_NONE;
-			rinfo->mon2_EDID = NULL;
+		
+		/* If the user specified a bogus monitor layout... */
+		if (PRIMARY_MONITOR(rinfo) <= MT_NONE) {
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
+			printk(KERN_INFO "radeonfb: No valid monitor, assuming CRT on first port\n");
 		}
 	} else {
 		/*
@@ -480,182 +1129,107 @@
 		
 		RTRACE("Starting monitor auto detection...\n");
 
-#if DEBUG && defined(CONFIG_FB_RADEON_I2C)
-		{
-			u8 *EDIDs[4] = { NULL, NULL, NULL, NULL };
-			int mon_types[4] = {MT_NONE, MT_NONE, MT_NONE, MT_NONE};
-			int i;
-
-			for (i = 0; i < 4; i++)
-				mon_types[i] = radeon_probe_i2c_connector(rinfo,
-									  i+1, &EDIDs[i]);
-		}
-#endif /* DEBUG */
 		/*
 		 * Old single head cards
 		 */
 		if (!rinfo->has_CRTC2) {
-#ifdef CONFIG_PPC_OF
-			if (rinfo->mon1_type == MT_NONE)
-				rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0,
-									&rinfo->mon1_EDID);
-#endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
-			if (rinfo->mon1_type == MT_NONE)
-				rinfo->mon1_type =
-					radeon_probe_i2c_connector(rinfo, ddc_dvi,
-								   &rinfo->mon1_EDID);
-			if (rinfo->mon1_type == MT_NONE)
-				rinfo->mon1_type =
-					radeon_probe_i2c_connector(rinfo, ddc_vga,
-								   &rinfo->mon1_EDID);
-			if (rinfo->mon1_type == MT_NONE)
-				rinfo->mon1_type =
-					radeon_probe_i2c_connector(rinfo, ddc_crt2,
-								   &rinfo->mon1_EDID);	
-#endif /* CONFIG_FB_RADEON_I2C */
-			if (rinfo->mon1_type == MT_NONE)
-				rinfo->mon1_type = MT_CRT;
-			goto bail;
-		}
-
-		/*
-		 * Check for cards with reversed DACs or TMDS controllers using BIOS
-		 */
-		if (rinfo->bios_seg &&
-		    (tmp = BIOS_IN16(rinfo->fp_bios_start + 0x50))) {
-			for (i = 1; i < 4; i++) {
-				unsigned int tmp0;
-
-				if (!BIOS_IN8(tmp + i*2) && i > 1)
+			/* Probe each connector */
+			for(i = 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+				if (PRIMARY_MONITOR(rinfo) > MT_NONE)
+					/* only one head */
 					break;
-				tmp0 = BIOS_IN16(tmp + i*2);
-				if ((!(tmp0 & 0x01)) && (((tmp0 >> 8) & 0x0f) == ddc_dvi)) {
-					rinfo->reversed_DAC = 1;
-					printk(KERN_INFO "radeonfb: Reversed DACs detected\n");
-				}
-				if ((((tmp0 >> 8) & 0x0f) == ddc_dvi) && ((tmp0 >> 4) & 0x01)) {
-					rinfo->reversed_TMDS = 1;
-					printk(KERN_INFO "radeonfb: Reversed TMDS detected\n");
+				if (!radeon_probe_i2c_connector(rinfo, &rinfo->connectors[i])) {
+					rinfo->heads[rinfo->num_heads] = i;
+					rinfo->connectors[i].head = rinfo->num_heads++;
 				}
 			}
-		}
-
-		/*
-		 * Probe primary head (DVI or laptop internal panel)
-		 */
-#ifdef CONFIG_PPC_OF
-		if (rinfo->mon1_type == MT_NONE)
-			rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0,
-								&rinfo->mon1_EDID);
-#endif /* CONFIG_PPC_OF */
-#ifdef CONFIG_FB_RADEON_I2C
-		if (rinfo->mon1_type == MT_NONE)
-			rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_dvi,
-								      &rinfo->mon1_EDID);
-		if (rinfo->mon1_type == MT_NONE) {
-			rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_crt2,
-								      &rinfo->mon1_EDID);
-			if (rinfo->mon1_type != MT_NONE)
-				ddc_crt2_used = 1;
-		}
 #endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon1_type == MT_NONE && rinfo->is_mobility &&
-		    ((rinfo->bios_seg && (INREG(BIOS_4_SCRATCH) & 4))
-		     || (INREG(LVDS_GEN_CNTL) & LVDS_ON))) {
-			rinfo->mon1_type = MT_LCD;
-			printk("Non-DDC laptop panel detected\n");
+			if (PRIMARY_MONITOR(rinfo) <= MT_NONE) {
+				radeon_find_connector_for_mon(rinfo, MT_CRT);
+			}
+			goto bail;
 		}
-		if (rinfo->mon1_type == MT_NONE)
-			rinfo->mon1_type = radeon_crt_is_connected(rinfo, rinfo->reversed_DAC);
 
-		/*
-		 * Probe secondary head (mostly VGA, can be DVI)
-		 */
-#ifdef CONFIG_PPC_OF
-		if (rinfo->mon2_type == MT_NONE)
-			rinfo->mon2_type = radeon_probe_OF_head(rinfo, 1,
-								&rinfo->mon2_EDID);
-#endif /* CONFIG_PPC_OF */
+		/* Probe heads */
 #ifdef CONFIG_FB_RADEON_I2C
-		if (rinfo->mon2_type == MT_NONE)
-			rinfo->mon2_type = radeon_probe_i2c_connector(rinfo, ddc_vga,
-								      &rinfo->mon2_EDID);
-		if (rinfo->mon2_type == MT_NONE && !ddc_crt2_used)
-			rinfo->mon2_type = radeon_probe_i2c_connector(rinfo, ddc_crt2,
-								      &rinfo->mon2_EDID);
+		/* Probe each connector in turn. */
+		for(i = 0 ; i < RADEON_MAX_CONNECTORS ; i++) {
+			if (rinfo->connectors[i].mon_type > MT_NONE)
+				/* Don't probe "detected" stuff again */
+				continue;
+			if (!radeon_probe_i2c_connector(rinfo, &rinfo->connectors[i])) {
+				rinfo->heads[rinfo->num_heads] = i;
+				rinfo->connectors[i].head = rinfo->num_heads++;
+			}
+		}
+	
 #endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon2_type == MT_NONE)
-			rinfo->mon2_type = radeon_crt_is_connected(rinfo, !rinfo->reversed_DAC);
 
-		/*
-		 * If we only detected port 2, we swap them, if none detected,
-		 * assume CRT (maybe fallback to old BIOS_SCRATCH stuff ? or look
-		 * at FP registers ?)
-		 */
-		if (rinfo->mon1_type == MT_NONE) {
-			if (rinfo->mon2_type != MT_NONE) {
-				rinfo->mon1_type = rinfo->mon2_type;
-				rinfo->mon1_EDID = rinfo->mon2_EDID;
-			} else
-				rinfo->mon1_type = MT_CRT;
-			rinfo->mon2_type = MT_NONE;
-			rinfo->mon2_EDID = NULL;
+		/* Mobility chips usually have LCDs... */
+		if ((PRIMARY_MONITOR(rinfo) <= MT_NONE) && 
+		    rinfo->is_mobility &&
+		    ((rinfo->bios_seg && (INREG(BIOS_4_SCRATCH) & 4)) ||
+		     (INREG(LVDS_GEN_CNTL) & (LVDS_EN|LVDS_ON)))) {
+			printk(KERN_INFO "radeonfb: Non-DDC laptop panel detected\n");
+			radeon_find_connector_for_mon(rinfo, MT_LCD);
+			if (rinfo->radeon_get_lvds_info) {
+				rinfo->radeon_get_lvds_info(rinfo);
+			}
 		}
 
-		/*
-		 * Deal with reversed TMDS
-		 */
-		if (rinfo->reversed_TMDS) {
-			/* Always keep internal TMDS as primary head */
-			if (rinfo->mon1_type == MT_DFP || rinfo->mon2_type == MT_DFP) {
-				int tmp_type = rinfo->mon1_type;
-				u8 *tmp_EDID = rinfo->mon1_EDID;
-				rinfo->mon1_type = rinfo->mon2_type;
-				rinfo->mon1_EDID = rinfo->mon2_EDID;
-				rinfo->mon2_type = tmp_type;
-				rinfo->mon2_EDID = tmp_EDID;
-				if (rinfo->mon1_type == MT_CRT || rinfo->mon2_type == MT_CRT)
-					rinfo->reversed_DAC ^= 1;
-			}
+		/* Probe for monitors on the primary and secondary crtc heads */
+		if (PRIMARY_MONITOR(rinfo) <= MT_NONE)
+			radeon_find_connector_for_mon(rinfo, radeon_crt_is_connected(rinfo, 1));
+
+		/* If we still haven't found anything, just force it to be on the CRT.. */
+		if (PRIMARY_MONITOR(rinfo) <= MT_NONE)
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
+
+		/* Always keep internal TMDS as primary head */
+		if (SECONDARY_HEAD_PRESENT(rinfo) && 
+		   (SECONDARY_HEAD(rinfo).tmds_type == tmds_internal) && 
+		   (SECONDARY_MONITOR(rinfo) == MT_DFP)) {
+			int head = rinfo->heads[0];
+			rinfo->heads[0] = rinfo->heads[1];
+			rinfo->heads[1] = head;
 		}
 	}
-	if (ignore_edid) {
-		kfree(rinfo->mon1_EDID);
-		rinfo->mon1_EDID = NULL;
-		kfree(rinfo->mon2_EDID);
-		rinfo->mon2_EDID = NULL;
-	}
-
- bail:
-	printk(KERN_INFO "radeonfb: Monitor 1 type %s found\n",
-	       radeon_get_mon_name(rinfo->mon1_type));
-	if (rinfo->mon1_EDID)
-		printk(KERN_INFO "radeonfb: EDID probed\n");
-	if (!rinfo->has_CRTC2)
-		return;
-	printk(KERN_INFO "radeonfb: Monitor 2 type %s found\n",
-	       radeon_get_mon_name(rinfo->mon2_type));
-	if (rinfo->mon2_EDID)
-		printk(KERN_INFO "radeonfb: EDID probed\n");
+bail:
+
+	/* Dump out the heads we've found so far */
+	for (i = 0; i < RADEON_MAX_CONNECTORS; i++) {
+		if (rinfo->connectors[i].conn_type == conn_none)
+			continue;
+		printk(KERN_INFO " * Connector %d is %s. Head %d, Monitor: %s ", i+1,
+		       conn_type_name[rinfo->connectors[i].conn_type],
+		       rinfo->connectors[i].head,
+		       rinfo->connectors[i].mon_type == MT_UNKNOWN  ?
+		         "Not Probed Yet" : 
+		         mon_type_name[rinfo->connectors[i].mon_type]);
+		if (rinfo->connectors[i].edid) 
+			printk("(EDID probed)\n");
+		else 
+			printk("\n");
+		
+		printk(KERN_INFO "   ddc port: %d, dac: %d, tmds: %d\n",
+		       rinfo->connectors[i].ddc_type,
+		       rinfo->connectors[i].dac_type,
+		       rinfo->connectors[i].tmds_type);
+	}
 }
 
 
-/*
- * This functions applyes any arch/model/machine specific fixups
- * to the panel info. It may eventually alter EDID block as
- * well or whatever is specific to a given model and not probed
- * properly by the default code
- */
-static void radeon_fixup_panel_info(struct radeonfb_info *rinfo)
-{
 #ifdef CONFIG_PPC_OF
+int __devinit radeon_get_lvds_info_openfirmware(struct radeonfb_info *rinfo)
+{
+
 	/*
 	 * LCD Flat panels should use fixed dividers, we enfore that on
 	 * PPC only for now...
 	 */
-	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type == MT_LCD
-	    && rinfo->is_mobility) {
+	if (!rinfo->panel_info.use_bios_dividers && (PRIMARY_MONITOR(rinfo) == MT_LCD) &&
+	    rinfo->is_mobility) {
 		int ppll_div_sel;
 		u32 ppll_divn;
 		ppll_div_sel = INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
@@ -666,15 +1240,16 @@
 		rinfo->panel_info.post_divider = (ppll_divn >> 16) & 0x7;
 		rinfo->panel_info.use_bios_dividers = 1;
 
-		printk(KERN_DEBUG "radeonfb: Using Firmware dividers 0x%08x "
+		printk(KERN_INFO "Using Firmware dividers 0x%08x "
 		       "from PPLL %d\n",
 		       rinfo->panel_info.fbk_divider |
 		       (rinfo->panel_info.post_divider << 16),
 		       ppll_div_sel);
+		return 0;
 	}
-#endif /* CONFIG_PPC_OF */
+	return -ENODEV;
 }
-
+#endif /* CONFIG_PPC_OF */
 
 /*
  * Fill up panel infos from a mode definition, either returned by the EDID
@@ -741,22 +1316,34 @@
 	info->var = radeonfb_default_var;
 	INIT_LIST_HEAD(&info->modelist);
 
-	/*
-	 * First check out what BIOS has to say
-	 */
-	if (rinfo->mon1_type == MT_LCD)
-		radeon_get_panel_info_BIOS(rinfo);
+	/* If we're an LCD and don't have a valid setup... */
+	if ((PRIMARY_MONITOR(rinfo) == MT_LCD) &&
+	    !rinfo->panel_info.valid && 
+	    rinfo->radeon_get_lvds_info) {
+		rinfo->radeon_get_lvds_info(rinfo);
+	}
+
+#if 0
+	/* If we're a mobility and still haven't detected a screen..? */
+	if ((PRIMARY_MONITOR(rinfo) <= MT_NONE) &&
+	    rinfo->is_mobility && 
+	    rinfo->radeon_get_lvds_info) {
+		if (!rinfo->radeon_get_lvds_info(rinfo)) 
+			radeon_find_connector_for_mon(rinfo, MT_LCD);
+	}
+#endif
 
 	/*
 	 * Parse EDID detailed timings and deduce panel infos if any. Right now
 	 * we only deal with first entry returned by parse_EDID, we may do better
 	 * some day...
 	 */
-	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type != MT_CRT
-	    && rinfo->mon1_EDID) {
+	if (!rinfo->panel_info.use_bios_dividers && 
+	    (PRIMARY_MONITOR(rinfo) != MT_CRT) &&
+	    PRIMARY_HEAD(rinfo).edid) {
 		struct fb_var_screeninfo var;
 		RTRACE("Parsing EDID data for panel info\n");
-		if (fb_parse_edid(rinfo->mon1_EDID, &var) == 0) {
+		if (fb_parse_edid(PRIMARY_HEAD(rinfo).edid, &var) == 0) {
 			if (var.xres >= rinfo->panel_info.xres &&
 			    var.yres >= rinfo->panel_info.yres)
 				radeon_var_to_panel_info(rinfo, &var);
@@ -764,15 +1351,10 @@
 	}
 
 	/*
-	 * Do any additional platform/arch fixups to the panel infos
-	 */
-	radeon_fixup_panel_info(rinfo);
-
-	/*
 	 * If we have some valid panel infos, we setup the default mode based on
 	 * those
 	 */
-	if (rinfo->mon1_type != MT_CRT && rinfo->panel_info.valid) {
+	if ((PRIMARY_MONITOR(rinfo) != MT_CRT) && rinfo->panel_info.valid) {
 		struct fb_var_screeninfo *var = &info->var;
 
 		RTRACE("Setting up default mode based on panel info\n");
@@ -803,22 +1385,21 @@
 	/*
 	 * Now build modedb from EDID
 	 */
-	if (rinfo->mon1_EDID) {
-		fb_edid_to_monspecs(rinfo->mon1_EDID, &info->monspecs);
+	if (PRIMARY_HEAD(rinfo).edid) {
+		fb_edid_to_monspecs(PRIMARY_HEAD(rinfo).edid, &info->monspecs);
 		fb_videomode_to_modelist(info->monspecs.modedb,
 					 info->monspecs.modedb_len,
 					 &info->modelist);
-		rinfo->mon1_modedb = info->monspecs.modedb;
-		rinfo->mon1_dbsize = info->monspecs.modedb_len;
+		PRIMARY_HEAD(rinfo).modedb = info->monspecs.modedb;
+		PRIMARY_HEAD(rinfo).modedb_size = info->monspecs.modedb_len;
 	}
-
 	
 	/*
 	 * Finally, if we don't have panel infos we need to figure some (or
 	 * we try to read it from card), we try to pick a default mode
 	 * and create some panel infos. Whatever...
 	 */
-	if (rinfo->mon1_type != MT_CRT && !rinfo->panel_info.valid) {
+	if ((PRIMARY_MONITOR(rinfo) != MT_CRT) && !rinfo->panel_info.valid) {
 		struct fb_videomode	*modedb;
 		int			dbsize;
 		char			modename[32];
@@ -832,21 +1413,22 @@
 		}
 		if (rinfo->panel_info.xres == 0 || rinfo->panel_info.yres == 0) {
 			printk(KERN_WARNING "radeonfb: Can't find panel size, going back to CRT\n");
-			rinfo->mon1_type = MT_CRT;
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
 			goto pickup_default;
 		}
 		printk(KERN_WARNING "radeonfb: Assuming panel size %dx%d\n",
 		       rinfo->panel_info.xres, rinfo->panel_info.yres);
-		modedb = rinfo->mon1_modedb;
-		dbsize = rinfo->mon1_dbsize;
+		modedb = PRIMARY_HEAD(rinfo).modedb;
+		dbsize = PRIMARY_HEAD(rinfo).modedb_size;
 		snprintf(modename, 31, "%dx%d", rinfo->panel_info.xres, rinfo->panel_info.yres);
 		if (fb_find_mode(&info->var, info, modename,
 				 modedb, dbsize, NULL, 8) == 0) {
 			printk(KERN_WARNING "radeonfb: Can't find mode for panel size, going back to CRT\n");
-			rinfo->mon1_type = MT_CRT;
+			radeon_find_connector_for_mon(rinfo, MT_CRT);
 			goto pickup_default;
 		}
 		has_default_mode = 1;
+		radeon_find_connector_for_mon(rinfo, MT_LCD);
 		radeon_var_to_panel_info(rinfo, &info->var);
 	}
 
@@ -946,14 +1528,14 @@
 	memcpy(dest, src, sizeof(struct fb_var_screeninfo));
 
 	/* Check if we have a modedb built from EDID */
-	if (rinfo->mon1_modedb) {
-		db = rinfo->mon1_modedb;
-		dbsize = rinfo->mon1_dbsize;
+	if (PRIMARY_HEAD(rinfo).modedb) {
+		db = PRIMARY_HEAD(rinfo).modedb;
+		dbsize = PRIMARY_HEAD(rinfo).modedb_size;
 		native_db = 1;
 	}
 
 	/* Check if we have a scaler allowing any fancy mode */
-	has_rmx = rinfo->mon1_type == MT_LCD || rinfo->mon1_type == MT_DFP;
+	has_rmx = (PRIMARY_MONITOR(rinfo) == MT_LCD) || (PRIMARY_MONITOR(rinfo) == MT_DFP);
 
 	/* If we have a scaler and are passed FB_ACTIVATE_TEST or
 	 * FB_ACTIVATE_NOW, just do basic checking and return if the
@@ -966,7 +1548,7 @@
 		 * 640x480-60, but I assume userland knows what it's doing here
 		 * (though I may be proven wrong...)
 		 */
-		if (has_rmx == 0 && rinfo->mon1_modedb)
+		if (has_rmx == 0 && PRIMARY_HEAD(rinfo).modedb)
 			if (fb_validate_mode((struct fb_var_screeninfo *)src, rinfo->info))
 				return -EINVAL;
 		return 0;



--------------030303080806070008000502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------030303080806070008000502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------030303080806070008000502--
