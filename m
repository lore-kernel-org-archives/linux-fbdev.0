From: Bodo Eggert <7eggert@gmx.de>
Subject: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
Date: Fri, 5 Aug 2005 00:03:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0noS-0002tx-0b
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Aug 2005 15:03:40 -0700
Received: from mail-in-01.arcor-online.net ([151.189.21.41])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E0noR-0002BX-Df
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Aug 2005 15:03:40 -0700
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net


My CRT is out of sync after radeonfb from 2.6.13-rc5 is initialized. 
2.6.12 does not show this behaviour.

dmesg from both systems, trimmed down:

2.6.13-rc5:

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: e8000000-e9ffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
...
Applying VIA southbridge workaround.
radeonfb_pci_register BEGIN
radeonfb (0000:01:00.0): Found 131072k of DDR 128 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
hStart = 694, hEnd = 757, hTotal = 795
vStart = 402, vEnd = 408, vTotal = 418
h_total_disp = 0x590062	   hsync_strt_wid = 0x8702c0
v_total_disp = 0x18f01a1	   vsync_strt_wid = 0x860191
pixclock = 85925
freq = 1163
freq = 1666, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 26656
ref_div = 12, ref_clk = 2700, output_freq = 26656
post div = 0x5
fb_div = 0x76
ppll_div_3 = 0x50076
Console: switching to colour frame buffer device 90x25
radeonfb (0000:01:00.0): ATI Radeon AS 
radeonfb_pci_register END
PCI: Enabling device 0000:00:09.0 (0000 -> 0003)
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:0d.0
fb: 3Dfx Banshee memory = 16384K
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:0d.0
[drm] Initialized tdfx 1.0.0 20010216 on minor 0: 
[drm] Initialized radeon 1.16.0 20050311 on minor 1: 

2.6.12:

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
...
Applying VIA southbridge workaround.
radeonfb_pci_register BEGIN
radeonfb (0000:01:00.0): Found 131072k of DDR 128 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
hStart = 737, hEnd = 808, hTotal = 896
vStart = 401, vEnd = 404, vTotal = 417
h_total_disp = 0x59006f	   hsync_strt_wid = 0x8802eb
v_total_disp = 0x18f01a0	   vsync_strt_wid = 0x830190
pixclock = 38210
freq = 2617
freq = 2617, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 20936
ref_div = 12, ref_clk = 2700, output_freq = 20936
post div = 0x3
fb_div = 0x5d
ppll_div_3 = 0x3005d
Console: switching to colour frame buffer device 90x25
radeonfb (0000:01:00.0): ATI Radeon AS 
radeonfb_pci_register END
...
fb: 3Dfx Banshee memory = 16384K
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:0d.0
[drm] Initialized tdfx 1.0.0 20010216 on minor 0: 
[drm] Initialized radeon 1.16.0 20050311 on minor 1: 
-- 
Top 100 things you don't want the sysadmin to say:
10. I don't care what he says, I'm _NOT_ having it on _my_ network


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
