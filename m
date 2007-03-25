From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: nvidiafb, monitor A & B and CRTC 0 & 1
Date: Sun, 25 Mar 2007 06:01:53 -0700
Message-ID: <460672C1.3080303@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010701020004010908000002"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HVSMG-0005UD-Dr for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Mar 2007 06:02:04 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HVSMF-0005YT-CH
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Mar 2007 06:02:04 -0700
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
To: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010701020004010908000002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   how much are you sure that monitor A i2c should use ddc_base 0x3E, 
and monitor B base 0x36 ?  Yesterday I connected TV (using HDMI cable) 
to my box, and ... it came up in 720x480 resolution, and fbset allowed 
me to go only up to 1920x540.  Which was quite surprising as when 
nvidiafb gets loaded second output stays in whatever mode it was before 
(720x400, text), displaying garbage, and only primary output does something.

After I added some debugging printks I've found that code became a bit 
confused because it believed that primary monitor is 1920x540, but later 
it found in CRTC0's registers that panel size is 1920x1200 (Windows also 
agree that 1920x1200 is primary monitor, and 1920x1080i secondary one).

When I applied attached patch then my monitor became as happy as it was 
before I connected HDMI cable to secondary output.
					Thanks,
						Petr

[just in case]
Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>

Before patch:

ACPI: PCI Interrupt Link [APC8] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC8] -> GSI 16 (level, 
low) -> IRQ 16
nvidiafb: Device ID: 10de0295
nvidiafb: CRTC0 analog not found
nvidiafb: CRTC1 analog not found
edid: 1920 x 540, 13468
nvidiafb: EDID found from BUS1
edid: 1920 x 1200, 6493
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 0 is currently programmed for DFP
nvidiafb: Using DFP on CRTC 0
nvidiafb: Panel size is 1920 x 1200
nvidiafb: Panel is TMDS
nvidiafb: MTRR set to ON
nvidiafb: Flat panel dithering disabled
Console: switching to colour frame buffer device 90x30
nvidiafb: PCI nVidia NV29 framebuffer (64MB @ 0xE0000000)

After patch:

ACPI: PCI Interrupt Link [APC8] enabled at IRQ 16
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC8] -> GSI 16 (level, 
low) -> IRQ 16
nvidiafb: Device ID: 10de0295
nvidiafb: CRTC0 analog not found
nvidiafb: CRTC1 analog not found
edid: 1920 x 1200, 6493
nvidiafb: EDID found from BUS1
edid: 1920 x 540, 13468
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 0 is currently programmed for DFP
nvidiafb: Using DFP on CRTC 0
nvidiafb: Panel size is 1920 x 1200
nvidiafb: Panel is TMDS
nvidiafb: MTRR set to ON
nvidiafb: Flat panel dithering disabled
Console: switching to colour frame buffer device 240x75
nvidiafb: PCI nVidia NV29 framebuffer (64MB @ 0xE0000000)

Monitor:
	# EDID version 1 revision 3
Section "Monitor"
	# Block type: 2:0 3:fc
	Identifier "FPD2485W"
	VendorName "GWY"
	ModelName "FPD2485W"
	# Block type: 2:0 3:fc
	# Block type: 2:0 3:fd
	HorizSync 30-83
	VertRefresh 56-76
	# Max dot clock (video bandwidth) 160 MHz
	# Block type: 2:0 3:ff
	# DPMS capabilities: Active off:yes  Suspend:no  Standby:no

	Mode 	"1920x1200"	# vfreq 59.950Hz, hfreq 74.038kHz
		DotClock	154.000000
		HTimings	1920 1968 2000 2080
		VTimings	1200 1203 1209 1235
		Flags	"-HSync" "+VSync"
	EndMode
	# Block type: 2:0 3:fc
	# Block type: 2:0 3:fd
	# Block type: 2:0 3:ff
EndSection

TV:
	# EDID version 1 revision 3
Section "Monitor"
	# Block type: 2:0 3:fc
	Identifier "LT-40FN97"
	VendorName "JVC"
	ModelName "LT-40FN97"
	# Block type: 2:0 3:fc
	# Block type: 2:0 3:fd
	HorizSync 15-46
	VertRefresh 59-61
	# Max dot clock (video bandwidth) 80 MHz
	# DPMS capabilities: Active off:yes  Suspend:no  Standby:no

	Mode 	"1920x540"	# vfreq 60.053Hz, hfreq 33.750kHz
		DotClock	74.250000
		HTimings	1920 2008 2052 2200
		VTimings	540 542 547 562
		Flags	"Interlace" "+HSync" "+VSync"
	EndMode
	Mode 	"720x480"	# vfreq 59.940Hz, hfreq 31.469kHz
		DotClock	27.000000
		HTimings	720 736 798 858
		VTimings	480 489 495 525
		Flags	"-HSync" "-VSync"
	EndMode
	# Block type: 2:0 3:fc
	# Block type: 2:0 3:fd
EndSection

--------------010701020004010908000002
Content-Type: text/x-patch;
 name="nvidia-swap-mona-monb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nvidia-swap-mona-monb.diff"

diff -uN -r linux-2.6.21-rc4-f33b.dist/drivers/video/nvidia/nv_i2c.c linux-2.6.21-rc4-f33b/drivers/video/nvidia/nv_i2c.c
--- linux-2.6.21-rc4-f33b.dist/drivers/video/nvidia/nv_i2c.c	2007-03-24 03:46:16.000000000 -0700
+++ linux-2.6.21-rc4-f33b/drivers/video/nvidia/nv_i2c.c	2007-03-25 04:52:09.000000000 -0700
@@ -133,10 +133,10 @@
 	par->chan[1].par = par;
 	par->chan[2].par = par;
 
-	par->chan[0].ddc_base = 0x3e;
+	par->chan[0].ddc_base = 0x36;
 	nvidia_setup_i2c_bus(&par->chan[0], "nvidia #0");
 
-	par->chan[1].ddc_base = 0x36;
+	par->chan[1].ddc_base = 0x3e;
 	nvidia_setup_i2c_bus(&par->chan[1], "nvidia #1");
 
 	par->chan[2].ddc_base = 0x50;

--------------010701020004010908000002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------010701020004010908000002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------010701020004010908000002--
