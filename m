From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GeForce 5200 on rivafb
Date: Sun, 12 Dec 2004 02:00:56 -0800
Message-ID: <7vpt1fu97r.fsf@assigned-by-dhcp.cox.net>
References: <200412120511.31725.adaplas@hotpop.com>
	<7vd5xgmevm.fsf@assigned-by-dhcp.cox.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cdf16-0000hF-KR
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 17:28:48 -0800
Received: from fed1rmmtao02.cox.net ([68.230.241.37])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cdf14-0001N3-9B
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 17:28:48 -0800
In-Reply-To: <7vd5xgmevm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 11 Dec 2004 18:25:49 -0800")
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

--=-=-=

>>>>> "AAD" == Antonino A Daplas <adaplas@hotpop.com> writes:

AAD> 1. Change this line in drivers/video/fbmon.c
>>> 
AAD> #undef DEBUG
AAD> to 
AAD> #define DEBUG
>>> 
>>> Will do, but I have one question.  The last time I tried
>>> turning debugging on on rivafb-i2c it was very unpleasant;

AAD> No :-), this is not for nvidiafb but for the EDID parser, and it will give
AAD> you a very descriptive parsing of the EDID block.

The attached is what I got in the kernel boot log.  Again,
AFAICT the display is an analog CRT but one of the decoded lines
say "Digital Display Input".  Anyway I'll disable the i2c stuff
in the meantime as you recommended.

Thanks.


--=-=-=
Content-Disposition: attachment; filename=kernel-log-debug
Content-Description: nvidiafb EDID detection log

Dec 12 01:30:53 siamese kernel: klogd 1.4.1#16, log source = /proc/kmsg started.
Dec 12 01:30:53 siamese kernel: Inspecting /boot/System.map-2.6.10-rc3-siam-c5ccf2
Dec 12 01:30:53 siamese kernel: Loaded 24983 symbols from /boot/System.map-2.6.10-rc3-siam-c5ccf2.
Dec 12 01:30:53 siamese kernel: Symbols match kernel version 2.6.10.
Dec 12 01:30:53 siamese kernel: No module symbols loaded - kernel modules not enabled. 
Dec 12 01:30:53 siamese kernel: Linux version 2.6.10-rc3-siam-c5ccf2 (junio@siamese) (gcc version 3.3.4 (Debian 1:3.3.4-13)) #1 Sat Dec 11 19:21:37 PST 2004
Dec 12 01:30:53 siamese kernel: BIOS-provided physical RAM map:
Dec 12 01:30:53 siamese kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec 12 01:30:53 siamese kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Dec 12 01:30:53 siamese kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Dec 12 01:30:53 siamese kernel:  BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
Dec 12 01:30:53 siamese kernel:  BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
Dec 12 01:30:53 siamese kernel:  BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
Dec 12 01:30:53 siamese kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Dec 12 01:30:53 siamese kernel: 767MB LOWMEM available.
Dec 12 01:30:54 siamese kernel: DMI 2.3 present.
Dec 12 01:30:54 siamese kernel: Built 1 zonelists
Dec 12 01:30:54 siamese kernel: Kernel command line: BOOT_IMAGE=2610rc3siam+ ro root=900
Dec 12 01:30:54 siamese kernel: Local APIC disabled by BIOS -- you can enable it with "lapic"
Dec 12 01:30:54 siamese kernel: Initializing CPU#0
Dec 12 01:30:54 siamese kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Dec 12 01:30:54 siamese kernel: Detected 750.116 MHz processor.
Dec 12 01:30:54 siamese kernel: Using tsc for high-res timesource
Dec 12 01:30:54 siamese kernel: Console: colour VGA+ 80x25
Dec 12 01:30:54 siamese kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Dec 12 01:30:54 siamese kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Dec 12 01:30:54 siamese kernel: Memory: 775944k/786368k available (1749k kernel code, 9932k reserved, 563k data, 412k init, 0k highmem)
Dec 12 01:30:54 siamese kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dec 12 01:30:54 siamese kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Dec 12 01:30:54 siamese kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Dec 12 01:30:54 siamese kernel: CPU: L2 Cache: 64K (64 bytes/line)
Dec 12 01:30:54 siamese kernel: Intel machine check architecture supported.
Dec 12 01:30:54 siamese kernel: Intel machine check reporting enabled on CPU#0.
Dec 12 01:30:54 siamese kernel: CPU: AMD Duron(tm) Processor stepping 01
Dec 12 01:30:54 siamese kernel: Enabling fast FPU save and restore... done.
Dec 12 01:30:54 siamese kernel: Checking 'hlt' instruction... OK.
Dec 12 01:30:54 siamese kernel: NET: Registered protocol family 16
Dec 12 01:30:54 siamese kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb2d0, last bus=1
Dec 12 01:30:54 siamese kernel: PCI: Using configuration type 1
Dec 12 01:30:54 siamese kernel: mtrr: v2.0 (20020519)
Dec 12 01:30:54 siamese kernel: PCI: Probing PCI hardware
Dec 12 01:30:54 siamese kernel: PCI: Probing PCI hardware (bus 00)
Dec 12 01:30:54 siamese kernel: Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
Dec 12 01:30:54 siamese kernel: PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
Dec 12 01:30:54 siamese kernel: Machine check exception polling timer started.
Dec 12 01:30:54 siamese kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Dec 12 01:30:54 siamese kernel: Initializing Cryptographic API
Dec 12 01:30:54 siamese kernel: Applying VIA southbridge workaround.
Dec 12 01:30:54 siamese kernel: PCI: Disabling Via external APIC routing
Dec 12 01:30:54 siamese kernel: nvidiafb: nVidia device/chipset 10DE0110
Dec 12 01:30:54 siamese kernel: nvidiafb: nVidia Corporation NV11 [GeForce2 MX/MX 400]
Dec 12 01:30:54 siamese kernel: nvidiafb: EDID found from BUS1
Dec 12 01:30:54 siamese kernel: ========================================
Dec 12 01:30:54 siamese kernel: Display Information (EDID)
Dec 12 01:30:54 siamese kernel: ========================================
Dec 12 01:30:54 siamese kernel:    EDID Version 1.2
Dec 12 01:30:54 siamese kernel:    Manufacturer: VSC
Dec 12 01:30:54 siamese kernel:    Model: 5a44
Dec 12 01:30:54 siamese kernel:    Serial#: 2694881440
Dec 12 01:30:54 siamese kernel:    Year: 2150 Week 14
Dec 12 01:30:54 siamese kernel:    Serial Number: DZ01401434
Dec 12 01:30:54 siamese kernel:    Monitor Name: PF775
Dec 12 01:30:54 siamese kernel:    Display Characteristics:
Dec 12 01:30:54 siamese kernel:       Monitor Operating Limits: From EDID
Dec 12 01:30:54 siamese kernel:            H: 30-97KHz V: 50-180Hz DCLK: 200MHz
Dec 12 01:30:54 siamese kernel:       Digital Display Input
Dec 12 01:30:54 siamese kernel:       Sync: 
Dec 12 01:30:54 siamese kernel:       Max H-size in cm: 160
Dec 12 01:30:54 siamese kernel:       Max V-size in cm: 160
Dec 12 01:30:54 siamese kernel:       Gamma: 2.60
Dec 12 01:30:54 siamese kernel:       DPMS: Active yes, Suspend yes, Standby yes
Dec 12 01:30:54 siamese kernel:       RGB Color Display
Dec 12 01:30:54 siamese kernel:       Chroma
Dec 12 01:30:54 siamese kernel:          RedX:     0.627 RedY:     0.342
Dec 12 01:30:54 siamese kernel:          GreenX:   0.289 GreenY:   0.605
Dec 12 01:30:54 siamese kernel:          BlueX:    0.150 BlueY:    0.070
Dec 12 01:30:54 siamese kernel:          WhiteX:   0.283 WhiteY:   0.298
Dec 12 01:30:54 siamese kernel:       First DETAILED Timing is preferred
Dec 12 01:30:54 siamese kernel:       Display is GTF capable
Dec 12 01:30:54 siamese kernel:    Supported VESA Modes
Dec 12 01:30:54 siamese kernel:       720x400@70Hz
Dec 12 01:30:54 siamese kernel:       640x480@60Hz
Dec 12 01:30:54 siamese kernel:       800x600@72Hz
Dec 12 01:30:54 siamese kernel:       800x600@75Hz
Dec 12 01:30:54 siamese kernel:       832x624@75Hz
Dec 12 01:30:54 siamese kernel:       1024x768@87Hz Interlaced
Dec 12 01:30:54 siamese kernel:       1024x768@60Hz
Dec 12 01:30:54 siamese kernel:       1024x768@70Hz
Dec 12 01:30:54 siamese kernel:       1024x768@75Hz
Dec 12 01:30:54 siamese kernel:       1280x1024@75Hz
Dec 12 01:30:54 siamese kernel:       1152x870@75Hz
Dec 12 01:30:54 siamese kernel:       Manufacturer's mask: 0
Dec 12 01:30:54 siamese kernel:    Standard Timings
Dec 12 01:30:54 siamese kernel:       640x480@85Hz
Dec 12 01:30:54 siamese kernel:       800x600@85Hz
Dec 12 01:30:54 siamese kernel:       1528x1146@75Hz
Dec 12 01:30:54 siamese kernel:       1280x960@60Hz
Dec 12 01:30:54 siamese kernel:       1280x960@85Hz
Dec 12 01:30:54 siamese kernel:       1280x1024@85Hz
Dec 12 01:30:54 siamese kernel:       1528x1222@60Hz
Dec 12 01:30:54 siamese kernel:       1600x1200@75Hz
Dec 12 01:30:54 siamese kernel:    Detailed Timings
Dec 12 01:30:54 siamese kernel:       94 MHz 1024 1072 1168 1376 768 769 772 808 +HSync +VSync
Dec 12 01:30:54 siamese kernel: 
Dec 12 01:30:54 siamese kernel: ========================================
Dec 12 01:30:54 siamese kernel: nvidiafb: Unable to detect which CRTCNumber...
Dec 12 01:30:54 siamese kernel: ...Defaulting to CRTCNumber 1
Dec 12 01:30:54 siamese kernel: nvidiafb: Using DFP on CRTC 1
Dec 12 01:30:54 siamese kernel: Panel size is 1 x 1
Dec 12 01:30:54 siamese kernel: nvidiafb: MTRR set to ON
Dec 12 01:30:54 siamese kernel: Real Time Clock Driver v1.12
Dec 12 01:30:54 siamese kernel: Linux agpgart interface v0.100 (c) Dave Jones
Dec 12 01:30:54 siamese kernel: agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
Dec 12 01:30:54 siamese kernel: agpgart: Maximum main memory to use for agp memory: 690M
Dec 12 01:30:54 siamese kernel: agpgart: AGP aperture is 128M @ 0xd0000000

--=-=-=--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
