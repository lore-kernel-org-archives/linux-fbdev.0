From: Guido Guenther <agx@sigxcpu.org>
Subject: Re: [Patch] rivafb: rix crashes on ppc
Date: Thu, 28 Oct 2004 00:53:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041027225341.GA3453@bogon.ms20.nix>
References: <20041027220122.GA3578@bogon.ms20.nix>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMwgD-0001TI-9U
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Oct 2004 15:54:09 -0700
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CMwgB-00066w-Ej
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Oct 2004 15:54:09 -0700
Content-Disposition: inline
In-Reply-To: <20041027220122.GA3578@bogon.ms20.nix>
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
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org

On Thu, Oct 28, 2004 at 12:01:22AM +0200, Guido Guenther wrote:
> Hi,
> the attached patch against 2.6.9 for rivafb:
>  - fixes crashes when changing video modes/switching away from X on ppc
>  - fixes random crashes when scrolling in e.g. vi
>  - improves on the NV30 support
>  - reintroduces noaccel (not perfect but helps a lot for debugging)
>  - converts MODULE_PARM to module_param
>  - cleans up some printks, FB_ACCELF_TEXT cruft
> Most of this is taken from either XFree86 4.3 or BenH's 2.4 ppc tree. 
> Please apply,
I shouldn't be sending out patches late, the HWACCEL_DISABLED logic was
reversed, fixed here.
 -- Guido

Signed-off-by: Guido Guenter <agx@sigxcpu.org>

diff -u linux-2.6.9.orig/drivers/video/riva/fbdev.c linux-2.6.9/drivers/video/riva/fbdev.c
--- linux-2.6.9.orig/drivers/video/riva/fbdev.c	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6.9/drivers/video/riva/fbdev.c	2004-10-28 00:43:57.905334920 +0200
@@ -205,6 +207,7 @@
 /* command line data, set in rivafb_setup() */
 static int flatpanel __initdata = -1; /* Autodetect later */
 static int forceCRTC __initdata = -1;
+static int noaccel   __initdata = 0;
 #ifdef CONFIG_MTRR
 static int nomtrr __initdata = 0;
 #endif
@@ -231,7 +234,6 @@
 	.activate	= FB_ACTIVATE_NOW,
 	.height		= -1,
 	.width		= -1,
-	.accel_flags	= FB_ACCELF_TEXT,
 	.pixclock	= 39721,
 	.left_margin	= 40,
 	.right_margin	= 24,
@@ -1008,8 +1010,6 @@
 			par->state.flags |= VGA_SAVE_CMAP;
 		save_vga(&par->state);
 #endif
-		riva_common_setup(par);
-		RivaGetConfig(&par->riva, par->Chipset);
 		/* vgaHWunlock() + riva unlock (0x7F) */
 		CRTCout(par, 0x11, 0xFF);
 		par->riva.LockUnlock(&par->riva, 0);
@@ -1157,14 +1157,12 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 
 	NVTRACE_ENTER();
-	riva_common_setup(par);
-	RivaGetConfig(&par->riva, par->Chipset);
 	/* vgaHWunlock() + riva unlock (0x7F) */
 	CRTCout(par, 0x11, 0xFF);
 	par->riva.LockUnlock(&par->riva, 0);
-
 	riva_load_video_mode(info);
-	riva_setup_accel(info);
+	if(!(info->flags & FBINFO_HWACCEL_DISABLED))
+		riva_setup_accel(info);
 	
 	memset_io(par->riva.CURSOR, 0, MAX_CURS * MAX_CURS * 2);
 	info->fix.line_length = (info->var.xres_virtual * (info->var.bits_per_pixel >> 3));
@@ -1670,6 +1668,13 @@
 		    | FBINFO_HWACCEL_FILLRECT
 		    | FBINFO_HWACCEL_IMAGEBLIT
 	            | FBINFO_MISC_MODESWITCHLATE;
+
+	/* Accel seems to not work properly on NV30 yet...*/
+	if ((par->riva.Architecture == NV_ARCH_30) || noaccel) {
+	    	printk(KERN_DEBUG PFX "disabling acceleration\n");
+  		info->flags |= FBINFO_HWACCEL_DISABLED;
+	}
+
 	info->var = rivafb_default_var;
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
@@ -1711,13 +1716,14 @@
 			pedid = (unsigned char *)
 				get_property(dp, propnames[i], NULL);
 			if (pedid != NULL) {
-		par->EDID = pedid;
-		return 1;
+				par->EDID = pedid;
+				NVTRACE("LCD found.\n");
+				return 1;
 			}
 		}
 	}
 	NVTRACE_LEAVE();
-		return 0;
+	return 0;
 }
 #endif /* CONFIG_PPC_OF */
 
@@ -1732,7 +1738,7 @@
 	for (i = par->bus; i >= 1; i--) {
 		riva_probe_i2c_connector(par, i, &par->EDID);
 		if (par->EDID) {
-			printk("rivafb: Found EDID Block from BUS %i\n", i);
+			printk(PFX "Found EDID Block from BUS %i\n", i);
 			break;
 		}
 	}
@@ -1771,7 +1777,6 @@
 		var->bits_per_pixel = 8;
 		riva_update_var(var, &modedb);
 	}
-	var->accel_flags |= FB_ACCELF_TEXT;
 	NVTRACE_LEAVE();
 }
 
@@ -1781,10 +1786,10 @@
 	NVTRACE_ENTER();
 #ifdef CONFIG_PPC_OF
 	if (!riva_get_EDID_OF(info, pdev))
-		printk("rivafb: could not retrieve EDID from OF\n");
+		printk(PFX "could not retrieve EDID from OF\n");
 #elif CONFIG_FB_RIVA_I2C
 	if (!riva_get_EDID_i2c(info))
-		printk("rivafb: could not retrieve EDID from DDC/I2C\n");
+		printk(PFX "could not retrieve EDID from DDC/I2C\n");
 #endif
 	NVTRACE_LEAVE();
 }
@@ -1946,7 +1951,6 @@
 			printk(KERN_ERR PFX "cannot ioremap PRAMIN region\n");
 			goto err_out_free_nv3_pramin;
 		}
-		rivafb_fix.accel = FB_ACCEL_NV3;
 		break;
 	case NV_ARCH_04:
 	case NV_ARCH_10:
@@ -1954,14 +1958,13 @@
 	case NV_ARCH_30:
 		default_par->riva.PCRTC0 = (unsigned *)(default_par->ctrl_base + 0x00600000);
 		default_par->riva.PRAMIN = (unsigned *)(default_par->ctrl_base + 0x00710000);
-		rivafb_fix.accel = FB_ACCEL_NV4;
 		break;
 	}
-
 	riva_common_setup(default_par);
 
 	if (default_par->riva.Architecture == NV_ARCH_03) {
-		default_par->riva.PCRTC = default_par->riva.PCRTC0 = default_par->riva.PGRAPH;
+		default_par->riva.PCRTC = default_par->riva.PCRTC0
+		                        = default_par->riva.PGRAPH;
 	}
 
 	rivafb_fix.smem_len = riva_get_memlen(default_par) * 1024;
@@ -2115,6 +2119,8 @@
 #endif
 		} else if (!strncmp(this_opt, "strictmode", 10)) {
 			strictmode = 1;
+		} else if (!strncmp(this_opt, "noaccel", 7)) {
+			noaccel = 1;
 		} else
 			mode_option = this_opt;
 	}
@@ -2163,19 +2169,20 @@
 }
 
 module_exit(rivafb_exit);
+#endif /* MODULE */
 
-MODULE_PARM(flatpanel, "i");
+module_param(noaccel, bool, 0);
+MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
+module_param(flatpanel, int, -1);
 MODULE_PARM_DESC(flatpanel, "Enables experimental flat panel support for some chipsets. (0 or 1=enabled) (default=0)");
-MODULE_PARM(forceCRTC, "i");
+module_param(forceCRTC, int, -1);
 MODULE_PARM_DESC(forceCRTC, "Forces usage of a particular CRTC in case autodetection fails. (0 or 1) (default=autodetect)");
-
 #ifdef CONFIG_MTRR
-MODULE_PARM(nomtrr, "i");
+module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) (default=0)");
 #endif
-MODULE_PARM(strictmode, "i");
+module_param(strictmode, bool, 0);
 MODULE_PARM_DESC(strictmode, "Only use video modes from EDID");
-#endif /* MODULE */
 
 MODULE_AUTHOR("Ani Joshi, maintainer");
 MODULE_DESCRIPTION("Framebuffer driver for nVidia Riva 128, TNT, TNT2, and the GeForce series");
diff -u linux-2.6.9.orig/drivers/video/riva/nv_driver.c linux-2.6.9/drivers/video/riva/nv_driver.c
--- linux-2.6.9.orig/drivers/video/riva/nv_driver.c	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6.9/drivers/video/riva/nv_driver.c	2004-10-27 19:42:09.000000000 +0200
@@ -104,12 +104,33 @@
 riva_is_second(struct riva_par *par)
 {
 	if (par->FlatPanel == 1) {
-		switch(par->Chipset) {
-		case NV_CHIP_GEFORCE4_440_GO:
-		case NV_CHIP_GEFORCE4_440_GO_M64:
-		case NV_CHIP_GEFORCE4_420_GO:
-		case NV_CHIP_GEFORCE4_420_GO_M32:
-		case NV_CHIP_QUADRO4_500_GOGL:
+		switch(par->Chipset & 0xffff) {
+		case 0x0174:
+		case 0x0175:
+		case 0x0176:
+		case 0x0177:
+		case 0x0179:
+		case 0x017C:
+		case 0x017D:
+		case 0x0186:
+		case 0x0187:
+		/* this might not be a good default for the chips below */
+		case 0x0286:
+		case 0x028C:
+		case 0x0316:
+		case 0x0317:
+		case 0x031A:
+		case 0x031B:
+		case 0x031C:
+		case 0x031D:
+		case 0x031E:
+		case 0x031F:
+		case 0x0324:
+		case 0x0325:
+		case 0x0328:
+		case 0x0329:
+		case 0x032C:
+		case 0x032D:
 			par->SecondCRTC = TRUE;
 			break;
 		default:
@@ -308,13 +329,33 @@
 	par->riva.IO = (MISCin(par) & 0x01) ? 0x3D0 : 0x3B0;
 	
 	if (par->FlatPanel == -1) {
-		switch (par->Chipset) {
-		case NV_CHIP_GEFORCE4_440_GO:
-		case NV_CHIP_GEFORCE4_440_GO_M64:
-		case NV_CHIP_GEFORCE4_420_GO:
-		case NV_CHIP_GEFORCE4_420_GO_M32:
-		case NV_CHIP_QUADRO4_500_GOGL:
-		case NV_CHIP_GEFORCE2_GO:
+		switch (par->Chipset & 0xffff) {
+		case 0x0112:   /* known laptop chips */
+		case 0x0174:
+		case 0x0175:
+		case 0x0176:
+		case 0x0177:
+		case 0x0179:
+		case 0x017C:
+		case 0x017D:
+		case 0x0186:
+		case 0x0187:
+		case 0x0286:
+		case 0x028C:
+		case 0x0316:
+		case 0x0317:
+		case 0x031A:
+		case 0x031B:
+		case 0x031C:
+		case 0x031D:
+		case 0x031E:
+		case 0x031F:
+		case 0x0324:
+		case 0x0325:
+		case 0x0328:
+		case 0x0329:
+		case 0x032C:
+		case 0x032D:
 			printk(KERN_INFO PFX 
 				"On a laptop.  Assuming Digital Flat Panel\n");
 			par->FlatPanel = 1;
@@ -339,6 +380,11 @@
 	case 0x01F0:
 	case 0x0250:
 	case 0x0280:
+	case 0x0300:
+	case 0x0310:
+	case 0x0320:
+	case 0x0330:
+	case 0x0340:
 		riva_is_second(par);
 		break;
 	default:
@@ -362,5 +408,7 @@
 		par->FlatPanel = 0;
 	}
 	par->riva.flatPanel = (par->FlatPanel > 0) ? TRUE : FALSE;
+
+	RivaGetConfig(&par->riva, par->Chipset);
 }
 
diff -u linux-2.6.9.orig/drivers/video/riva/riva_hw.c linux-2.6.9/drivers/video/riva/riva_hw.c
--- linux-2.6.9.orig/drivers/video/riva/riva_hw.c	2004-10-18 23:55:36.000000000 +0200
+++ linux-2.6.9/drivers/video/riva/riva_hw.c	2004-10-28 00:44:49.696461472 +0200
@@ -1536,13 +1536,13 @@
             chip->PMC[0x00001588/4] = 0;
 
             chip->PFB[0x00000240/4] = 0;
-            chip->PFB[0x00000244/4] = 0;
-            chip->PFB[0x00000248/4] = 0;
-            chip->PFB[0x0000024C/4] = 0;
             chip->PFB[0x00000250/4] = 0;
-            chip->PFB[0x00000254/4] = 0;
-            chip->PFB[0x00000258/4] = 0;
-            chip->PFB[0x0000025C/4] = 0;
+            chip->PFB[0x00000260/4] = 0;
+            chip->PFB[0x00000270/4] = 0;
+            chip->PFB[0x00000280/4] = 0;
+            chip->PFB[0x00000290/4] = 0;
+            chip->PFB[0x000002A0/4] = 0;
+            chip->PFB[0x000002B0/4] = 0;
 
             chip->PGRAPH[0x00000B00/4] = chip->PFB[0x00000240/4];
             chip->PGRAPH[0x00000B04/4] = chip->PFB[0x00000244/4];
@@ -2067,7 +2067,8 @@
 
 #ifdef __BIG_ENDIAN
     /* turn on big endian register access */
-    chip->PMC[0x00000004/4] = 0x01000001;
+    if(!(chip->PMC[0x00000004/4] & 0x01000001))
+    	chip->PMC[0x00000004/4] = 0x01000001;
 #endif
 
     /*
@@ -2128,6 +2129,11 @@
     case 0x01F0:
     case 0x0250:
     case 0x0280:
+    case 0x0300:
+    case 0x0310:
+    case 0x0320:
+    case 0x0330:
+    case 0x0340:
        if(chip->PEXTDEV[0x0000/4] & (1 << 22))
            chip->CrystalFreqKHz = 27000;
        break;
@@ -2159,6 +2165,11 @@
     case 0x01F0:
     case 0x0250:
     case 0x0280:
+    case 0x0300:
+    case 0x0310:
+    case 0x0320:
+    case 0x0330:
+    case 0x0340:
         chip->twoHeads = TRUE;
         break;
     default:
diff -u linux-2.6.9.orig/drivers/video/riva/riva_hw.h linux-2.6.9/drivers/video/riva/riva_hw.h
--- linux-2.6.9.orig/drivers/video/riva/riva_hw.h	2004-10-18 23:55:21.000000000 +0200
+++ linux-2.6.9/drivers/video/riva/riva_hw.h	2004-10-26 09:44:15.000000000 +0200
@@ -541,8 +541,10 @@
 
 #define RIVA_FIFO_FREE(hwinst,hwptr,cnt)                            \
 {                                                                   \
-    while ((hwinst).FifoFreeCount < (cnt))                          \
+    while ((hwinst).FifoFreeCount < (cnt)) {                        \
+	mb();mb();						    \
         (hwinst).FifoFreeCount = (hwinst).hwptr->FifoFree >> 2;     \
+    }								    \
     (hwinst).FifoFreeCount -= (cnt);                                \
 }
 #endif /* __RIVA_HW_H__ */


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
