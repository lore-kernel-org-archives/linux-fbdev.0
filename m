From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] nvidiafb: Add flat panel dither support
Date: Tue, 04 Oct 2005 13:50:53 +1000
Message-ID: <1128397854.31063.8.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMdss-0004Em-QQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 20:54:30 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EMdss-0007oE-D8
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 03 Oct 2005 20:54:31 -0700
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
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

nvidiafb didn't fully hook-up the code it borrowed from X for doing flat
panel dithering (this is useful for 6 bits panels). This adds a driver
option to force it, and by default "reads" the current value from the
chip to get the firmware setting. It significantly improves the quality
of images on the iMac G5 I have here (though the X driver doesn't yet
"read" the current value and defaults to 0, so you have to add Option
"FBDither" "true" to your X config file to get that, I'll try to fix
X.org to "read" the default unless specified asap).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/nvidia/nvidia.c
===================================================================
--- linux-work.orig/drivers/video/nvidia/nvidia.c	2005-10-04 13:38:17.000000000 +1000
+++ linux-work/drivers/video/nvidia/nvidia.c	2005-10-04 13:41:26.000000000 +1000
@@ -403,6 +403,7 @@
 
 /* command line data, set in nvidiafb_setup() */
 static int flatpanel __devinitdata = -1;	/* Autodetect later */
+static int fpdither __devinitdata = -1;
 static int forceCRTC __devinitdata = -1;
 static int hwcur __devinitdata = 0;
 static int noaccel __devinitdata = 0;
@@ -1018,10 +1019,19 @@
 	NVTRACE_ENTER();
 
 	NVLockUnlock(par, 1);
-	if (!par->FlatPanel || (info->var.bits_per_pixel != 24) ||
-	    !par->twoHeads)
+	if (!par->FlatPanel || !par->twoHeads)
 		par->FPDither = 0;
 
+	if (par->FPDither < 0) {
+		if ((par->Chipset & 0x0ff0) == 0x0110)
+			par->FPDither = !!(NV_RD32(par->PRAMDAC, 0x0528)
+					   & 0x00010000);
+		else
+			par->FPDither = !!(NV_RD32(par->PRAMDAC, 0x083C) & 1);
+		printk(KERN_INFO PFX "Flat panel dithering %s\n",
+		       par->FPDither ? "enabled" : "disabled");
+	}
+
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 	    FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
@@ -1540,9 +1550,9 @@
 	sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
 
 	par->FlatPanel = flatpanel;
-
 	if (flatpanel == 1)
 		printk(KERN_INFO PFX "flatpanel support enabled\n");
+	par->FPDither = fpdither;
 
 	par->CRTCnumber = forceCRTC;
 	par->FpScale = (!noscale);
@@ -1721,6 +1731,8 @@
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
 #endif
+		} else if (!strncmp(this_opt, "fpdither:", 9)) {
+			fpdither = simple_strtol(this_opt+9, NULL, 0);
 		} else
 			mode_option = this_opt;
 	}
@@ -1767,7 +1779,11 @@
 module_param(flatpanel, int, 0);
 MODULE_PARM_DESC(flatpanel,
 		 "Enables experimental flat panel support for some chipsets. "
-		 "(0 or 1=enabled) (default=0)");
+		 "(0=disabled, 1=enabled, -1=autodetect) (default=-1)");
+module_param(fpdither, int, 0);
+MODULE_PARM_DESC(fpdither,
+		 "Enables dithering of flat panel for 6 bits panels. "
+		 "(0=disabled, 1=enabled, -1=autodetect) (default=-1)");
 module_param(hwcur, int, 0);
 MODULE_PARM_DESC(hwcur,
 		 "Enables hardware cursor implementation. (0 or 1=enabled) "




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
