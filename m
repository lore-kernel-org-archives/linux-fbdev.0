From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Subject: Re: radeonfb doesn't work with an ati X800 pcie
 card
Date: Tue, 10 Apr 2007 20:03:58 +0200
Message-ID: <461BD18E.5020706@gmx.net>
References: <46093D22.3090401@gmx.net>
Reply-To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090502040301080209030405"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HbKhS-0001T9-OO for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Apr 2007 11:04:15 -0700
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]
	helo=snowman.cryosphere.shacknet.nu)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HbKhR-0000L2-Ka
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Apr 2007 11:04:14 -0700
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
Cc: kofboy@163.com

This is a multi-part message in MIME format.
--------------090502040301080209030405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

good news folks, it works great now and only with 2 tiny patches :)

i finally find out what was wrong with my PCIE X800 XT ATI genuine
graphic card. It is quite easy and obvious if you know what the devs
really meant with dcc_monid. In my case that was more appropriate then
ddc_dvi or ddc_vga . Also dcc_monid was the solution and i finally get
something on my screen. Indeed, i needed to modify radeonfb_monitor.c
and have included some more controls to make the auto detection less
restrictive. The 1680x1050 flat panel is now recognized at its native
resolution without forcing the video output to TMDS.

But as usual there is an under achievement somewhere. Xorg stopped
working and let the patch unusable :(
Also, you need to patch radeon_accel.c as well to make dri work again.
Otherwise fifos just timed out and dri didn't initialize.

(**) RADEON(0): RADEONSaveScreen(2)
(**) RADEON(0): FIFO timed out: 1 entries, stat=0x88026101
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 59 entries, stat=0x8802613b
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 17 entries, stat=0x88026111
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 3 entries, stat=0x88026103
(EE) RADEON(0): FIFO timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): FIFO timed out: 59 entries, stat=0x8802613b
(EE) RADEON(0): FIFO timed out, resetting engine...

And last but not least, you are now able to switch to the console and
Xorg back and forth :)

PS:Kofboy suggested me to change the cable for a DVI-D one. Some cables
are DVI-I(24+5) and include a VGA and a DVI-D port, other only
DVI-D(24+1). I don't have an extra cable and i'm short of money :) so i
don't have tried it. It works for kofboy. So give it a try.

I guess that will help other card owners and not only ATI X800 or X700
family one and work without itches.

Jj



--------------090502040301080209030405
Content-Type: text/plain;
 name="radeon_accel.c.2.6.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_accel.c.2.6.20.diff"

--- radeon_accel.c	2007-04-08 11:41:52.000000000 +0200
+++ radeon_accel.c	2007-04-08 13:57:39.000000000 +0200
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

--------------090502040301080209030405
Content-Type: text/plain;
 name="radeon_monitor.c.2.6.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_monitor.c.2.6.20.diff"

--- radeon_monitor.c	2007-04-08 11:41:52.000000000 +0200
+++ radeon_monitor.c	2007-04-08 14:59:09.000000000 +0200
@@ -480,17 +480,6 @@
 		
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
@@ -530,11 +519,11 @@
 				if (!BIOS_IN8(tmp + i*2) && i > 1)
 					break;
 				tmp0 = BIOS_IN16(tmp + i*2);
-				if ((!(tmp0 & 0x01)) && (((tmp0 >> 8) & 0x0f) == ddc_dvi)) {
+				if ((!(tmp0 & 0x01)) && ((((tmp0 >> 8) & 0x0f) == ddc_dvi) || (((tmp0 >> 8) & 0x0f) == ddc_monid))) {
 					rinfo->reversed_DAC = 1;
 					printk(KERN_INFO "radeonfb: Reversed DACs detected\n");
 				}
-				if ((((tmp0 >> 8) & 0x0f) == ddc_dvi) && ((tmp0 >> 4) & 0x01)) {
+				if ((((tmp0 >> 8) & 0x0f) == ddc_dvi || (((tmp0 >> 8) & 0x0f) == ddc_monid)) && ((tmp0 >> 4) & 0x01)) {
 					rinfo->reversed_TMDS = 1;
 					printk(KERN_INFO "radeonfb: Reversed TMDS detected\n");
 				}
@@ -544,6 +533,7 @@
 		/*
 		 * Probe primary head (DVI or laptop internal panel)
 		 */
+		printk(KERN_INFO "radeonfb: Probe primary head\n");
 #ifdef CONFIG_PPC_OF
 		if (rinfo->mon1_type == MT_NONE)
 			rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0,
@@ -551,6 +541,9 @@
 #endif /* CONFIG_PPC_OF */
 #ifdef CONFIG_FB_RADEON_I2C
 		if (rinfo->mon1_type == MT_NONE)
+			rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_monid,
+								      &rinfo->mon1_EDID);
+		if (rinfo->mon1_type == MT_NONE)
 			rinfo->mon1_type = radeon_probe_i2c_connector(rinfo, ddc_dvi,
 								      &rinfo->mon1_EDID);
 		if (rinfo->mon1_type == MT_NONE) {
@@ -572,6 +565,7 @@
 		/*
 		 * Probe secondary head (mostly VGA, can be DVI)
 		 */
+		printk(KERN_INFO "radeonfb: Probe secondary head\n");
 #ifdef CONFIG_PPC_OF
 		if (rinfo->mon2_type == MT_NONE)
 			rinfo->mon2_type = radeon_probe_OF_head(rinfo, 1,
@@ -642,7 +636,7 @@
 
 
 /*
- * This functions applyes any arch/model/machine specific fixups
+ * This functions applies any arch/model/machine specific fixups
  * to the panel info. It may eventually alter EDID block as
  * well or whatever is specific to a given model and not probed
  * properly by the default code

--------------090502040301080209030405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------090502040301080209030405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------090502040301080209030405--
