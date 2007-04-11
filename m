From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
Subject: Re: radeonfb doesn't work with an ati X800 pcie
 card
Date: Wed, 11 Apr 2007 14:17:59 +0200
Message-ID: <461CD1F7.40004@gmx.net>
References: <46093D22.3090401@gmx.net> <461BD18E.5020706@gmx.net>
Reply-To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010008000506000806010108"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HbbmC-0008CX-Vs for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 05:18:24 -0700
Received: from ip-62-241-114-101.evc.net ([62.241.114.101]
	helo=snowman.cryosphere.shacknet.nu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HbbmB-0007kW-EX
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 05:18:16 -0700
In-Reply-To: <461BD18E.5020706@gmx.net>
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
To: Jimmy.Jazz@gmx.net
Cc: kofboy@163.com, kronos.it@gmail.com, linux-fbdev-devel@lists.sourceforge.net, pizza@shaftnet.org, benh@kernel.crashing.org

This is a multi-part message in MIME format.
--------------010008000506000806010108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

i sent it without care and i forgot to add some diff files you will have 
to apply to radeonfb.h, ati_ids.h and radeon_base.c with both 
radeon_accel.c and radeon_monitor.c patches. Otherwise, you won't be 
able to compile the kernel anymore. Sorry for the inconvenient.

Thank you all of you who contributed to these patches, the initiator of 
the radeonfb driver and of course the Xorg team who made ATI cards 
compatible with the xorg server.

Jj

--------------010008000506000806010108
Content-Type: text/x-patch;
 name="ati_ids.h.2.6.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ati_ids.h.2.6.20.diff"

--- drivers/video/aty/ati_ids.h	2007-04-08 11:41:52.000000000 +0200
+++ drivers/video/aty/ati_ids.h	2007-04-05 12:26:00.000000000 +0200
@@ -209,4 +209,4 @@
 #define PCI_CHIP_R423_5D57              0x5D57
 #define PCI_CHIP_RS350_7834             0x7834
 #define PCI_CHIP_RS350_7835             0x7835
-
+#define PCI_CHIP_RS480_5955             0x5955

--------------010008000506000806010108
Content-Type: text/x-patch;
 name="radeon_accel.c.2.6.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_accel.c.2.6.20.diff"

--- drivers/video/aty/radeon_accel.c	2007-04-08 11:41:52.000000000 +0200
+++ drivers/video/aty/radeon_accel.c	2007-04-08 13:57:39.000000000 +0200
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

--------------010008000506000806010108
Content-Type: text/x-patch;
 name="radeon_base.c.2.6.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_base.c.2.6.20.diff"

--- drivers/video/aty/radeon_base.c	2007-04-08 11:41:52.000000000 +0200
+++ drivers/video/aty/radeon_base.c	2007-04-06 00:36:15.000000000 +0200
@@ -100,6 +100,8 @@
 	{ PCI_VENDOR_ID_ATI, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (flags) | (CHIP_FAMILY_##family) }
 
 static struct pci_device_id radeonfb_pci_table[] = {
+        /* Radeon Xpress 200m */
+	CHIP_DEF(PCI_CHIP_RS480_5955,   RS480,  CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
 	/* Mobility M6 */
 	CHIP_DEF(PCI_CHIP_RADEON_LY, 	RV100,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_RADEON_LZ,	RV100,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
@@ -268,6 +270,11 @@
 #endif
 static int force_sleep;
 static int ignore_devlist;
+#ifdef CONFIG_PMAC_BACKLIGHT
+static int backlight = 1;
+#else
+static int backlight = 0;
+#endif
 
 /*
  * prototypes
@@ -575,6 +582,32 @@
 	return 0;
 }
 
+static void radeon_detect_bios_type(struct radeonfb_info *rinfo)
+{
+#ifndef CONFIG_PPC_OF
+          int offset = rinfo->fp_bios_start + 4;
+          unsigned char sign[4];
+
+                  sign[0] = BIOS_IN8(offset);
+                  sign[1] = BIOS_IN8(offset + 1);
+                  sign[2] = BIOS_IN8(offset + 2);
+                  sign[3] = BIOS_IN8(offset + 3);
+
+          if (!memcmp(sign, "ATOM", 4) || !memcmp(sign, "MOTA", 4)) {
+                rinfo->is_atom_bios = 1;
+                rinfo->atom_data_start = BIOS_IN16(rinfo->fp_bios_start + 32);
+
+       		printk(KERN_INFO "radeonfb: ATOM BIOS signature found\n");
+
+		return;
+          } 
+#endif  /* NOT CONFIG_PPC_OF */
+
+          rinfo->is_atom_bios = 0;
+
+	  return;
+}
+
 /*
  * Retrieve PLL infos by different means (BIOS, Open Firmware, register probing...)
  */
@@ -651,20 +684,38 @@
 #endif /* CONFIG_PPC_OF */
 
 	/*
-	 * Check out if we have an X86 which gave us some PLL informations
+	 * Check out if we have an ATOM BIOS which gave us some PLL informations
 	 * and if yes, retrieve them
 	 */
+
 	if (!force_measure_pll && rinfo->bios_seg) {
-		u16 pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
+        	u16 pll_info_block;
 
-		rinfo->pll.sclk		= BIOS_IN16(pll_info_block + 0x08);
-		rinfo->pll.mclk		= BIOS_IN16(pll_info_block + 0x0a);
-		rinfo->pll.ref_clk	= BIOS_IN16(pll_info_block + 0x0e);
-		rinfo->pll.ref_div	= BIOS_IN16(pll_info_block + 0x10);
-		rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
-		rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
+		if(rinfo->is_atom_bios) {
+        		pll_info_block = BIOS_IN16(rinfo->atom_data_start + 12);
 
+        		rinfo->pll.sclk = BIOS_IN32(pll_info_block + 8);
+        		rinfo->pll.mclk = BIOS_IN32(pll_info_block + 12);
+        		rinfo->pll.ref_clk = BIOS_IN16(pll_info_block + 82);
+        		rinfo->pll.ref_div = 0; /* Have to get it elsewhere */
+        		rinfo->pll.ppll_min = BIOS_IN16(pll_info_block + 78);
+        		rinfo->pll.ppll_max = BIOS_IN32(pll_info_block + 32);
+		} else {
+	/*
+	 * Check out if we have an X86 which gave us some PLL informations
+	 * and if yes, retrieve them
+	 */
+			pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
+
+			rinfo->pll.sclk		= BIOS_IN16(pll_info_block + 0x08);
+			rinfo->pll.mclk		= BIOS_IN16(pll_info_block + 0x0a);
+			rinfo->pll.ref_clk	= BIOS_IN16(pll_info_block + 0x0e);
+			rinfo->pll.ref_div	= BIOS_IN16(pll_info_block + 0x10);
+			rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
+			rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
+		}
 		printk(KERN_INFO "radeonfb: Retrieved PLL infos from BIOS\n");
+
 		goto found;
 	}
 
@@ -680,18 +731,38 @@
 	/*
 	 * Fall back to already-set defaults...
 	 */
-       	printk(KERN_INFO "radeonfb: Used default PLL infos\n");
+       	printk(KERN_INFO "radeonfb: Fall back to default PLL infos\n");
 
 found:
+       /* Check and fix-up the PLL divisor if necessary */
+        if (rinfo->pll.ref_div < 2) {
+                int tmp = INPLL(PPLL_REF_DIV);
+                if (rinfo->family == CHIP_FAMILY_RS300) {
+                        rinfo->pll.ref_div = (tmp & R300_PPLL_REF_DIV_ACC_MASK) >> R300_PPLL_REF_DIV_ACC_SHIFT;
+                } else {
+                        rinfo->pll.ref_div = tmp & PPLL_REF_DIV_MASK;
+                }
+
+                /* Sane default */
+                if (rinfo->pll.ref_div < 2) {
+       			printk(KERN_INFO "radeonfb: Set a sane default PLL divisor\n");
+                        rinfo->pll.ref_div = 12;
+                }
+        }
+
 	/*
 	 * Some methods fail to retrieve SCLK and MCLK values, we apply default
-	 * settings in this case (200Mhz). If that really happne often, we could
+	 * settings in this case (200Mhz). If that really happen often, we could
 	 * fetch from registers instead...
 	 */
-	if (rinfo->pll.mclk == 0)
+	if (rinfo->pll.mclk == 0) {
+       		printk(KERN_INFO "radeonfb: Set a sane default MCLK value\n");
 		rinfo->pll.mclk = 20000;
-	if (rinfo->pll.sclk == 0)
+	}
+	if (rinfo->pll.mclk == 0) {
+       		printk(KERN_INFO "radeonfb: Set a sane default SCLK value\n");
 		rinfo->pll.sclk = 20000;
+	}
 
 	printk("radeonfb: Reference=%d.%02d MHz (RefDiv=%d) Memory=%d.%02d Mhz, System=%d.%02d MHz\n",
 	       rinfo->pll.ref_clk / 100, rinfo->pll.ref_clk % 100,
@@ -1026,8 +1097,7 @@
 		break;
 	}
 
-	/* let fbcon do a soft blank for us */
-	return (blank == FB_BLANK_NORMAL) ? -EINVAL : 0;
+	return 0;
 }
 
 static int radeonfb_blank (int blank, struct fb_info *info)
@@ -1990,7 +2060,8 @@
 	/* framebuffer size */
         if ((rinfo->family == CHIP_FAMILY_RS100) ||
             (rinfo->family == CHIP_FAMILY_RS200) ||
-            (rinfo->family == CHIP_FAMILY_RS300)) {
+            (rinfo->family == CHIP_FAMILY_RS300) ||
+	    (rinfo->family == CHIP_FAMILY_RS480) ) {
           u32 tom = INREG(NB_TOM);
           tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
 
@@ -2295,6 +2366,9 @@
 	if (rinfo->bios_seg == NULL && rinfo->is_mobility)
 		radeon_map_ROM(rinfo, pdev);
 
+        /* Check BIOS Type */
+        radeon_detect_bios_type(rinfo);
+
 	/* Get informations about the board's PLL */
 	radeon_get_pllinfo(rinfo);
 
@@ -2349,7 +2423,8 @@
 						 MTRR_TYPE_WRCOMB, 1);
 #endif
 
-	radeonfb_bl_init(rinfo);
+	if (backlight)
+		radeonfb_bl_init(rinfo);
 
 	printk ("radeonfb (%s): %s\n", pci_name(rinfo->pdev), rinfo->name);
 
@@ -2393,7 +2468,6 @@
         if (!rinfo)
                 return;
 
-	radeonfb_bl_exit(rinfo);
 	radeonfb_pm_exit(rinfo);
 
 	if (rinfo->mon1_EDID)
@@ -2420,6 +2494,8 @@
 
         unregister_framebuffer(info);
 
+        radeonfb_bl_exit(rinfo);
+
         iounmap(rinfo->mmio_base);
         iounmap(rinfo->fb_base);
  
@@ -2469,6 +2545,8 @@
 			force_dfp = 1;
 		} else if (!strncmp(this_opt, "panel_yres:", 11)) {
 			panel_yres = simple_strtoul((this_opt+11), NULL, 0);
+		} else if (!strncmp(this_opt, "backlight:", 10)) {
+			backlight = simple_strtoul(this_opt+10, NULL, 0);
 #ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;

--------------010008000506000806010108
Content-Type: text/x-patch;
 name="radeon_monitor.c.2.6.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon_monitor.c.2.6.20.diff"

--- drivers/video/aty/radeon_monitor.c	2007-04-08 11:41:52.000000000 +0200
+++ drivers/video/aty/radeon_monitor.c	2007-04-08 14:59:09.000000000 +0200
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

--------------010008000506000806010108
Content-Type: text/x-patch;
 name="radeonfb.h.2.6.20.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeonfb.h.2.6.20.diff"

--- drivers/video/aty/radeonfb.h	2007-04-08 11:41:52.000000000 +0200
+++ drivers/video/aty/radeonfb.h	2007-04-06 00:30:45.000000000 +0200
@@ -48,6 +48,7 @@
 	CHIP_FAMILY_RV350,
 	CHIP_FAMILY_RV380,    /* RV370/RV380/M22/M24 */
 	CHIP_FAMILY_R420,     /* R420/R423/M18 */
+	CHIP_FAMILY_RS480,
 	CHIP_FAMILY_LAST,
 };
 
@@ -64,7 +65,8 @@
 				((rinfo)->family == CHIP_FAMILY_RV350) || \
 				((rinfo)->family == CHIP_FAMILY_R350)  || \
 				((rinfo)->family == CHIP_FAMILY_RV380) || \
-				((rinfo)->family == CHIP_FAMILY_R420))
+				((rinfo)->family == CHIP_FAMILY_R420)  || \
+		                ((rinfo)->family == CHIP_FAMILY_RS480) )
 
 /*
  * Chip flags
@@ -299,6 +301,9 @@
 	void __iomem		*bios_seg;
 	int			fp_bios_start;
 
+	int			is_atom_bios;
+        int                     atom_data_start;
+
 	u32			pseudo_palette[17];
 	struct { u8 red, green, blue, pad; }
 				palette[256];

--------------010008000506000806010108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------010008000506000806010108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------010008000506000806010108--
