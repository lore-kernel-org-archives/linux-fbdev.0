From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/5] fbdev: PPC crash and other fixes for rivafb
Date: Sat, 4 Sep 2004 11:07:04 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409041107.04266.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3QyO-0003mv-07
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Sep 2004 20:12:16 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C3QyM-0004wA-Up
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Sep 2004 20:12:15 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 09BE88C53
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  4 Sep 2004 03:12:04 +0000 (UTC)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

1. Fixed rivafb crashing in PPC.  rivafb in PPC requires full, instead of
partial, hardware initialization in rivafb_set_par().

2. Added untested support for NV_ARCH_30 chipsets.  

3. From Guido Guenther <agx@sigxcpu.org>
	 here's another short patch fixing the cursor colors on big endian.

5. From Guido Guenther <agx@sigxcpu.org>
	trivial: strictmode is a MODULE_PARAM, even if CONFIG_MTRR is not set:

Signed-off-by: Guido Guenther <agx@sigxcpu.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbdev.c      |   13 ++++++++++---
 nv_driver.c  |    2 ++
 riva_hw.c    |    5 +++++
 rivafb-i2c.c |   35 +++++++++++++++++++++++++----------
 4 files changed, 42 insertions(+), 13 deletions(-)

diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/riva/fbdev.c linux-2.6.9-rc1-mm3/drivers/video/riva/fbdev.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/riva/fbdev.c	2004-09-04 04:26:37.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/riva/fbdev.c	2004-09-04 10:06:41.729829568 +0800
@@ -441,6 +441,8 @@ static void rivafb_load_cursor_image(str
 	int i, j, k = 0;
 	u32 b, tmp;
 	u32 *data = (u32 *)data8;
+	bg = le16_to_cpu(bg);
+	fg = le16_to_cpu(fg);
 
 	for (i = 0; i < h; i++) {
 		b = *data++;
@@ -1155,6 +1157,12 @@ static int rivafb_set_par(struct fb_info
 	struct riva_par *par = (struct riva_par *) info->par;
 
 	NVTRACE_ENTER();
+	riva_common_setup(par);
+	RivaGetConfig(&par->riva, par->Chipset);
+	/* vgaHWunlock() + riva unlock (0x7F) */
+	CRTCout(par, 0x11, 0xFF);
+	par->riva.LockUnlock(&par->riva, 0);
+
 	riva_load_video_mode(info);
 	riva_setup_accel(info);
 	
@@ -1939,15 +1947,14 @@ static int __devinit rivafb_probe(struct
 			goto err_out_free_nv3_pramin;
 		}
 		rivafb_fix.accel = FB_ACCEL_NV3;
-		default_par->bus = 1;
 		break;
 	case NV_ARCH_04:
 	case NV_ARCH_10:
 	case NV_ARCH_20:
+	case NV_ARCH_30:
 		default_par->riva.PCRTC0 = (unsigned *)(default_par->ctrl_base + 0x00600000);
 		default_par->riva.PRAMIN = (unsigned *)(default_par->ctrl_base + 0x00710000);
 		rivafb_fix.accel = FB_ACCEL_NV4;
-		default_par->bus = 2;
 		break;
 	}
 
@@ -2157,9 +2164,9 @@ MODULE_PARM_DESC(forceCRTC, "Forces usag
 #ifdef CONFIG_MTRR
 MODULE_PARM(nomtrr, "i");
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) (default=0)");
+#endif
 MODULE_PARM(strictmode, "i");
 MODULE_PARM_DESC(strictmode, "Only use video modes from EDID");
-#endif
 #endif /* MODULE */
 
 MODULE_AUTHOR("Ani Joshi, maintainer");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/riva/nv_driver.c linux-2.6.9-rc1-mm3/drivers/video/riva/nv_driver.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/riva/nv_driver.c	2004-05-10 10:33:10.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/riva/nv_driver.c	2004-09-04 10:06:41.733828960 +0800
@@ -205,6 +205,7 @@ unsigned long riva_get_memlen(struct riv
 		break;
 	case NV_ARCH_10:
 	case NV_ARCH_20:
+	case NV_ARCH_30:
 		if(chipset == NV_CHIP_IGEFORCE2) {
 
 			dev = pci_find_slot(0, 1);
@@ -274,6 +275,7 @@ unsigned long riva_get_maxdclk(struct ri
 	case NV_ARCH_04:
 	case NV_ARCH_10:
 	case NV_ARCH_20:
+	case NV_ARCH_30:
 		switch ((chip->PFB[0x00000000/4] >> 3) & 0x00000003) {
 		case 3:
 			dclk = 800000;
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/riva/rivafb-i2c.c linux-2.6.9-rc1-mm3/drivers/video/riva/rivafb-i2c.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/riva/rivafb-i2c.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/riva/rivafb-i2c.c	2004-09-04 10:06:41.736828504 +0800
@@ -131,19 +131,34 @@ void riva_create_i2c_busses(struct riva_
 	par->chan[1].par	= par;
 	par->chan[2].par        = par;
 
-	switch (par->riva.Architecture) {
-#if 0		/* no support yet for other nVidia chipsets */
+	par->bus = 0;
+
+	switch ((par->pdev->device >> 4) & 0xff) {
+	case 0x17:
+	case 0x18:
+	case 0x25:
+	case 0x28:
+	case 0x30:
+	case 0x31:
+	case 0x32:
+	case 0x33:
+	case 0x34:
 		par->chan[2].ddc_base   = 0x50;
-		riva_setup_i2c_bus(&par->chan[2], "BUS2");
-#endif
-	case NV_ARCH_10:
-	case NV_ARCH_20:
-	case NV_ARCH_04:
+		par->bus++;
+		riva_setup_i2c_bus(&par->chan[2], "BUS3");
+	case 0x04:
+	case 0x05:
+	case 0x10:
+	case 0x11:
+	case 0x15:
+	case 0x20:
 		par->chan[1].ddc_base	= 0x36;
-		riva_setup_i2c_bus(&par->chan[1], "BUS1");
-	case NV_ARCH_03:
+		par->bus++;
+		riva_setup_i2c_bus(&par->chan[1], "BUS2");
+	case 0x03:
 		par->chan[0].ddc_base	= 0x3e;
-		riva_setup_i2c_bus(&par->chan[0], "BUS0");
+		par->bus++;
+		riva_setup_i2c_bus(&par->chan[0], "BUS1");
 	}
 }
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/riva/riva_hw.c linux-2.6.9-rc1-mm3/drivers/video/riva/riva_hw.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/riva/riva_hw.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/riva/riva_hw.c	2004-09-04 10:06:41.742827592 +0800
@@ -1274,6 +1274,7 @@ static void CalcStateExt
             break;
         case NV_ARCH_10:
         case NV_ARCH_20:
+        case NV_ARCH_30:
             if((chip->Chipset == NV_CHIP_IGEFORCE2) ||
                (chip->Chipset == NV_CHIP_0x01F0))
             {
@@ -1350,6 +1351,7 @@ static void UpdateFifoState
             break;
         case NV_ARCH_10:
         case NV_ARCH_20:
+        case NV_ARCH_30:
             /*
              * Initialize state for the RivaTriangle3D05 routines.
              */
@@ -1459,6 +1461,7 @@ static void LoadStateExt
             break;
         case NV_ARCH_10:
         case NV_ARCH_20:
+        case NV_ARCH_30:
             if(chip->twoHeads) {
                VGA_WR08(chip->PCIO, 0x03D4, 0x44);
                VGA_WR08(chip->PCIO, 0x03D5, state->crtcOwner);
@@ -1755,6 +1758,7 @@ static void UnloadStateExt
             break;
         case NV_ARCH_10:
         case NV_ARCH_20:
+        case NV_ARCH_30:
             state->offset0  = chip->PGRAPH[0x00000640/4];
             state->offset1  = chip->PGRAPH[0x00000644/4];
             state->offset2  = chip->PGRAPH[0x00000648/4];
@@ -2185,6 +2189,7 @@ int RivaGetConfig
             break;
         case NV_ARCH_10:
         case NV_ARCH_20:
+        case NV_ARCH_30:
             nv10GetConfig(chip, chipset);
             break;
         default:




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
