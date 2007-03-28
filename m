From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Subject: Re: radeonfb doesn't work with an ati X800 pcie
 card
Date: Thu, 29 Mar 2007 00:03:19 +0200
Message-ID: <460AE627.2010806@gmx.net>
References: <46093D22.3090401@gmx.net>
Reply-To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWgEq-0007Mp-AW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 15:03:28 -0700
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]
	helo=snowman.cryosphere.shacknet.nu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWgEp-0007uM-GJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 15:03:28 -0700
In-Reply-To: <46093D22.3090401@gmx.net>
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
To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net

I made some more tests and without forcing the monitor type. I get some 
odd results and quite the opposite of what i was expecting.
Ignoring the connectors table is not a great idea.

The monitor, a dvi flat panel wide screen (1680x1050), is connected to 
the first video card connector with a dvi cable. Instead, the radeonfb 
driver sees a CRT connected to a vga connector. Heeelp !


# insmod 
/lib/modules/2.6.20-vs2.3.0.11-gentoo/kernel/drivers/video/aty/radeonfb.ko 
ignore_devlist=0 force_measure_pll=1 ignore_conntable=1 nomodeset=0 
noaccel=0 radeonfb_debug=1 default_dynclk=0 ignore_edid=0


[11734.058425] radeonfb_pci_register BEGIN
[11734.058579] radeonfb (0000:01:00.0): Found 262144k of DDR 256 bits 
wide videoram
[11734.058769] radeonfb (0000:01:00.0): mapped 16384k videoram
[11734.058820] radeonfb: Found Intel x86 BIOS ROM Image
[11734.062077] radeonfb: Retrieved PLL infos from registers
[11734.062122] radeonfb: Reference=27.00 MHz (RefDiv=2) Memory=499.50 
Mhz, System=499.50 MHz
[11734.062210] PLL min 20000 max 50000
[11734.062249] TMDS PLL from BIOS: 16500 b011c
[11735.758767] radeonfb: I2C (port 0) ... found CRT display
[11735.837068] i2c_adapter i2c-3: unable to read EDID block.
[11735.957946] i2c_adapter i2c-3: unable to read EDID block.
[11736.078881] i2c_adapter i2c-3: unable to read EDID block.
[11736.121572] radeonfb: I2C (port 1) ... not found
[11736.199817] i2c_adapter i2c-4: unable to read EDID block.
[11736.320754] i2c_adapter i2c-4: unable to read EDID block.
[11736.441703] i2c_adapter i2c-4: unable to read EDID block.
[11736.484388] radeonfb: I2C (port 2) ... not found
[11736.691277] radeonfb: I2C (port 3) ... not found
[11736.691479] Starting monitor auto detection...
[11736.692528] radeonfb: couldn't find a connector for monitor 1
[11736.692613] radeonfb: couldn't find a connector for monitor 1
[11736.692655]  * Connector 1 is VGA. Head -1, Monitor: CRT
[11736.692803]    ddc port: 0, dac: 1, tmds: -1
[11736.692845] Parsing EDID data for panel info
[11736.692926] Guessing panel info...
[11736.692965] radeonfb: Assuming panel size 1680x1050
[11736.693042] modedb fb_find_mode: Trying specified video mode 
(ignoring refresh rate) 1680x1050
[11736.693090] modedb fb_try_mode: Trying mode noname 1680x1050-8@60
[11736.693176] radeonfb: couldn't find a connector for monitor 2
[11736.760147] radeonfb: Dynamic Clock Power Management disabled
[11736.760973] radeonfb (0000:01:00.0): ATI Radeon ]W
[11736.761075] radeonfb_pci_register END


when i don't ignore the connectors table, the dvi connector is well 
defined but the monitor is not.

# insmod 
/lib/modules/2.6.20-vs2.3.0.11-gentoo/kernel/drivers/video/aty/radeonfb.ko 
ignore_devlist=0 force_measure_pll=1 ignore_conntable=0 nomodeset=0 
noaccel=0 radeonfb_debug=1 default_dynclk=0 ignore_edid=0

[14370.011807] radeonfb_pci_register BEGIN
[14370.012069] radeonfb (0000:01:00.0): Found 262144k of DDR 256 bits 
wide videoram
[14370.012149] radeonfb (0000:01:00.0): mapped 16384k videoram
[14370.012243] radeonfb: Found Intel x86 BIOS ROM Image
[14370.027648] radeonfb: Retrieved PLL infos from registers
[14370.027734] radeonfb: Reference=27.00 MHz (RefDiv=2) Memory=499.50 
Mhz, System=499.50 MHz
[14370.027781] PLL min 20000 max 50000
[14370.027859] TMDS PLL from BIOS: 16500 b011c
[14371.560068] index 0 port 1 conn 1 dac 0 ddc 1 tmds -1
[14371.560283] index 2 port 0 conn 5 dac 1 ddc 2 tmds -1
[14371.560326] index 3 port 2 conn 2 dac -1 ddc 0 tmds 0
[14371.560404] index 4 port 2 conn 2 dac 1 ddc 0 tmds -1
[14371.560447] Starting monitor auto detection...
[14371.789081] radeonfb: I2C (port 0) ... found CRT display
[14371.868083] i2c_adapter i2c-4: unable to read EDID block.
[14371.989259] i2c_adapter i2c-4: unable to read EDID block.
[14372.110229] i2c_adapter i2c-4: unable to read EDID block.
[14372.152887] radeonfb: I2C (port 2) ... not found
[14372.152944]  * Connector 1 is DVI-I. Head 0, Monitor: CRT (EDID probed)
[14372.153050]    ddc port: 0, dac: 0, tmds: 0
[14372.153088]  * Connector 3 is S-Video. Head -1, Monitor: None
[14372.153187]    ddc port: 2, dac: 0, tmds: -1
[14372.219847] radeonfb: Dynamic Clock Power Management disabled
[14372.222167] radeonfb (0000:01:00.0): ATI Radeon ]W
[14372.222289] radeonfb_pci_register END


I can't believe i'm the only one who isn' able to use an "old" x800 pcie 
card connected to a dvi flat panel. Get rid of the boring 640x480 
resolution dictatorship and have a nice splash screen, that my moto ;)

If someone has any clues, he is very welcome.

Jj

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
