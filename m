From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [PATCH] matroxfb: Add support for mapping CRTC<->outputs at boot time
Date: Sun, 23 May 2004 14:03:08 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040523120308.GB11373@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRrhE-0000UH-4t
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 05:03:16 -0700
Received: from vana.vc.cvut.cz ([147.32.240.58] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BRrhC-0000p9-2b
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 05:03:14 -0700
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
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Andrew,
  some people expressed interest in having possibility to set CRTC <-> outputs mapping
at boot time, without having to use 'matroxset' later after kernel boots.

  This patch adds option 'video=matroxfb:outputs:XYZ', where X sets which CRTC will connect
to primary output, Y sets secondary output and Z sets DVI output.

  In addition to that I also added missing memset() into maven, which was broken since
i2c was kobjectified.

  I have no idea what you'll do with 'Signed-off-by' line below, but just in case, this
patch was written entirely by me, and I'm not aware about any other IP or patents pending
on it.
					Thanks,
						Petr Vandrovec


Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>





diff -urdN linux/drivers/video/matrox/matroxfb_DAC1064.c linux/drivers/video/matrox/matroxfb_DAC1064.c
--- linux/drivers/video/matrox/matroxfb_DAC1064.c	2004-05-22 18:38:19.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_DAC1064.c	2004-05-23 13:04:23.000000000 +0200
@@ -660,7 +660,7 @@
 	ACCESS_FBINFO(features.accel.has_cacheflush) = 1;
 
 	ACCESS_FBINFO(outputs[0]).output = &m1064;
-	ACCESS_FBINFO(outputs[0]).src = MATROXFB_SRC_CRTC1;
+	ACCESS_FBINFO(outputs[0]).src = ACCESS_FBINFO(outputs[0]).default_src;
 	ACCESS_FBINFO(outputs[0]).data = MINFO;
 	ACCESS_FBINFO(outputs[0]).mode = MATROXFB_OUTPUT_MODE_MONITOR;
 
@@ -859,7 +859,7 @@
 	{
 		ACCESS_FBINFO(outputs[0]).output = &m1064;
 	}
-	ACCESS_FBINFO(outputs[0]).src = MATROXFB_SRC_CRTC1;
+	ACCESS_FBINFO(outputs[0]).src = ACCESS_FBINFO(outputs[0]).default_src;
 	ACCESS_FBINFO(outputs[0]).data = MINFO;
 	ACCESS_FBINFO(outputs[0]).mode = MATROXFB_OUTPUT_MODE_MONITOR;
 
diff -urdN linux/drivers/video/matrox/matroxfb_Ti3026.c linux/drivers/video/matrox/matroxfb_Ti3026.c
--- linux/drivers/video/matrox/matroxfb_Ti3026.c	2004-05-22 18:38:01.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_Ti3026.c	2004-05-23 13:03:08.000000000 +0200
@@ -692,7 +692,7 @@
 
 	ACCESS_FBINFO(outputs[0]).data = MINFO;
 	ACCESS_FBINFO(outputs[0]).output = &ti3026_output;
-	ACCESS_FBINFO(outputs[0]).src = MATROXFB_SRC_CRTC1;
+	ACCESS_FBINFO(outputs[0]).src = ACCESS_FBINFO(outputs[0]).default_src;
 	ACCESS_FBINFO(outputs[0]).mode = MATROXFB_OUTPUT_MODE_MONITOR;
 
 	if (ACCESS_FBINFO(devflags.noinit))
diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	2004-05-22 18:38:28.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_base.c	2004-05-23 13:08:04.000000000 +0200
@@ -1272,6 +1272,7 @@
 static int dfp;				/* "matrox:dfp */
 static int dfp_type = -1;		/* "matrox:dfp:xxx */
 static int memtype = -1;		/* "matrox:memtype:xxx" */
+static char outputs[8];			/* "matrox:outputs:xxx" */
 
 #ifndef MODULE
 static char videomode[64];		/* "matrox:mode:xxxxx" or "matrox:xxxxx" */
@@ -1537,6 +1538,39 @@
 
 static int hotplug = 0;
 
+static void setDefaultOutputs(WPMINFO2) {
+	unsigned int i;
+	const char* ptr;
+
+	ACCESS_FBINFO(outputs[0]).default_src = MATROXFB_SRC_CRTC1;
+	if (ACCESS_FBINFO(devflags.g450dac)) {
+		ACCESS_FBINFO(outputs[1]).default_src = MATROXFB_SRC_CRTC1;
+		ACCESS_FBINFO(outputs[2]).default_src = MATROXFB_SRC_CRTC1;
+	} else if (dfp) {
+		ACCESS_FBINFO(outputs[2]).default_src = MATROXFB_SRC_CRTC1;
+	}
+	ptr = outputs;
+	for (i = 0; i < MATROXFB_MAX_OUTPUTS; i++) {
+		char c = *ptr++;
+		
+		if (c == 0) {
+			break;
+		}
+		if (c == '0') {
+			ACCESS_FBINFO(outputs[i]).default_src = MATROXFB_SRC_NONE;
+		} else if (c == '1') {
+			ACCESS_FBINFO(outputs[i]).default_src = MATROXFB_SRC_CRTC1;
+		} else if (c == '2' && ACCESS_FBINFO(devflags.crtc2)) {
+			ACCESS_FBINFO(outputs[i]).default_src = MATROXFB_SRC_CRTC2;
+		} else {
+			printk(KERN_ERR "matroxfb: Unknown outputs setting\n");
+			break;
+		}
+	}
+	/* Nullify this option for subsequent adapters */
+	outputs[0] = 0;
+}
+
 static int initMatrox2(WPMINFO struct board* b){
 	unsigned long ctrlptr_phys = 0;
 	unsigned long video_base_phys = 0;
@@ -1577,20 +1611,18 @@
 	ACCESS_FBINFO(devflags.crtc2) = (b->flags & DEVF_CRTC2) != 0;
 	ACCESS_FBINFO(devflags.maven_capable) = (b->flags & DEVF_MAVEN_CAPABLE) != 0;
 	ACCESS_FBINFO(devflags.dualhead) = (b->flags & DEVF_DUALHEAD) != 0;
+	ACCESS_FBINFO(devflags.dfp_type) = dfp_type;
+	ACCESS_FBINFO(devflags.g450dac) = (b->flags & DEVF_G450DAC) != 0;
+	ACCESS_FBINFO(devflags.textstep) = ACCESS_FBINFO(devflags.vgastep) * ACCESS_FBINFO(devflags.textmode);
+	ACCESS_FBINFO(devflags.textvram) = 65536 / ACCESS_FBINFO(devflags.textmode);
+	setDefaultOutputs(PMINFO2);
 	if (b->flags & DEVF_PANELLINK_CAPABLE) {
 		ACCESS_FBINFO(outputs[2]).data = MINFO;
 		ACCESS_FBINFO(outputs[2]).output = &panellink_output;
-		if (dfp)
-			ACCESS_FBINFO(outputs[2]).src = MATROXFB_SRC_CRTC1;
-		else
-			ACCESS_FBINFO(outputs[2]).src = MATROXFB_SRC_NONE;
+		ACCESS_FBINFO(outputs[2]).src = ACCESS_FBINFO(outputs[2]).default_src;
 		ACCESS_FBINFO(outputs[2]).mode = MATROXFB_OUTPUT_MODE_MONITOR;
 		ACCESS_FBINFO(devflags.panellink) = 1;
 	}
-	ACCESS_FBINFO(devflags.dfp_type) = dfp_type;
-	ACCESS_FBINFO(devflags.g450dac) = (b->flags & DEVF_G450DAC) != 0;
-	ACCESS_FBINFO(devflags.textstep) = ACCESS_FBINFO(devflags.vgastep) * ACCESS_FBINFO(devflags.textmode);
-	ACCESS_FBINFO(devflags.textvram) = 65536 / ACCESS_FBINFO(devflags.textmode);
 
 	if (ACCESS_FBINFO(capable.cross4MB) < 0)
 		ACCESS_FBINFO(capable.cross4MB) = b->flags & DEVF_CROSS4MB;
@@ -1813,6 +1845,13 @@
 							to yres_virtual * xres_virtual < 2^32 */
 	}
 	matroxfb_init_fix(PMINFO2);
+	/* Normalize values (namely yres_virtual) */
+	matroxfb_check_var(&vesafb_defined, &ACCESS_FBINFO(fbcon));
+	/* And put it into "current" var. Do NOT program hardware yet, or we'll not take over
+	 * vgacon correctly. fbcon_startup will call fb_set_par for us, WITHOUT check_var,
+	 * and unfortunately it will do it BEFORE vgacon contents is saved, so it won't work
+	 * anyway. But we at least tried... */
+	ACCESS_FBINFO(fbcon.var) = vesafb_defined;
 	err = -EINVAL;
 
 	printk(KERN_INFO "matroxfb: %dx%dx%dbpp (virtual: %dx%d)\n",
@@ -1834,6 +1873,9 @@
 		 * until someone tells me what is proper thing to do */
 		printk(KERN_INFO "fb%d: initializing hardware\n",
 			ACCESS_FBINFO(fbcon.node));
+		/* We have to use FB_ACTIVATE_FORCE, as we had to put vesafb_defined to the fbcon.var
+		 * already before, so register_framebuffer works correctly. */
+		vesafb_defined.activate |= FB_ACTIVATE_FORCE;
 		fb_set_var(&ACCESS_FBINFO(fbcon), &vesafb_defined);
 	}
 	return 0;
@@ -2012,7 +2054,7 @@
 	init_waitqueue_head(&ACCESS_FBINFO(crtc1.vsync.wait));
 	init_waitqueue_head(&ACCESS_FBINFO(crtc2.vsync.wait));
 	ACCESS_FBINFO(crtc1.panpos) = -1;
-
+	
 	err = initMatrox2(PMINFO b);
 	if (!err) {
 #ifndef CONFIG_FB_MATROX_MULTIHEAD
@@ -2288,6 +2330,8 @@
 			mem = simple_strtoul(this_opt+4, NULL, 0);
 		else if (!strncmp(this_opt, "mode:", 5))
 			strlcpy(videomode, this_opt+5, sizeof(videomode));
+		else if (!strncmp(this_opt, "outputs:", 8))
+			strlcpy(outputs, this_opt+8, sizeof(outputs));
 		else if (!strncmp(this_opt, "dfp:", 4)) {
 			dfp_type = simple_strtoul(this_opt+4, NULL, 0);
 			dfp = 1;
@@ -2463,6 +2507,8 @@
 MODULE_PARM_DESC(dfp, "Specifies whether to use digital flat panel interface of G200/G400 (0 or 1) (default=0)");
 MODULE_PARM(dfp_type, "i");
 MODULE_PARM_DESC(dfp_type, "Specifies DFP interface type (0 to 255) (default=read from hardware)");
+MODULE_PARM(outputs, "c8");
+MODULE_PARM_DESC(outputs, "Specifies which CRTC is mapped to which output (string of up to three letters, consisting of 0 (disabled), 1 (CRTC1), 2 (CRTC2)) (default=111 for Gx50, 101 for G200/G400 with DFP, and 100 for all other devices)");
 #ifdef CONFIG_PPC_PMAC
 MODULE_PARM(vmode, "i");
 MODULE_PARM_DESC(vmode, "Specify the vmode mode number that should be used (640x480 default)");
diff -urdN linux/drivers/video/matrox/matroxfb_base.h linux/drivers/video/matrox/matroxfb_base.h
--- linux/drivers/video/matrox/matroxfb_base.h	2004-05-22 18:38:21.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_base.h	2004-05-22 19:15:15.000000000 +0200
@@ -479,6 +479,7 @@
 	struct matrox_altout*	output;
 	void*			data;
 	unsigned int		mode;
+	unsigned int		default_src;
 			      } outputs[MATROXFB_MAX_OUTPUTS];
 
 #define MATROXFB_MAX_FB_DRIVERS		5
diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	2004-05-22 18:38:33.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	2004-05-23 13:05:47.000000000 +0200
@@ -628,15 +628,6 @@
 	m2info->mmio.vbase = ACCESS_FBINFO(mmio.vbase);
 	m2info->mmio.len = ACCESS_FBINFO(mmio.len);
 
-	/*
-	 *  If we have unused output, connect CRTC2 to it...
-	 */
-	if (ACCESS_FBINFO(outputs[1]).output &&
-	    ACCESS_FBINFO(outputs[1]).src == MATROXFB_SRC_NONE &&
-	    ACCESS_FBINFO(outputs[2]).src == MATROXFB_SRC_NONE) {
-		ACCESS_FBINFO(outputs[1]).src = MATROXFB_SRC_CRTC2;
-	}
-
 	matroxfb_dh_init_fix(m2info);
 	if (register_framebuffer(&m2info->fbcon)) {
 		return -ENXIO;
diff -urdN linux/drivers/video/matrox/matroxfb_g450.c linux/drivers/video/matrox/matroxfb_g450.c
--- linux/drivers/video/matrox/matroxfb_g450.c	2004-05-22 18:38:33.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_g450.c	2004-05-22 20:05:43.000000000 +0200
@@ -591,11 +591,11 @@
 	if (ACCESS_FBINFO(devflags.g450dac)) {
 		down_write(&ACCESS_FBINFO(altout.lock));
 		tvo_fill_defaults(PMINFO2);
-		ACCESS_FBINFO(outputs[1]).src = MATROXFB_SRC_CRTC1;
+		ACCESS_FBINFO(outputs[1]).src = ACCESS_FBINFO(outputs[1]).default_src;
 		ACCESS_FBINFO(outputs[1]).data = MINFO;
 		ACCESS_FBINFO(outputs[1]).output = &matroxfb_g450_altout;
 		ACCESS_FBINFO(outputs[1]).mode = MATROXFB_OUTPUT_MODE_MONITOR;
-		ACCESS_FBINFO(outputs[2]).src = MATROXFB_SRC_CRTC1;
+		ACCESS_FBINFO(outputs[2]).src = ACCESS_FBINFO(outputs[2]).default_src;
 		ACCESS_FBINFO(outputs[2]).data = MINFO;
 		ACCESS_FBINFO(outputs[2]).output = &matroxfb_g450_dvi;
 		ACCESS_FBINFO(outputs[2]).mode = MATROXFB_OUTPUT_MODE_MONITOR;
diff -urdN linux/drivers/video/matrox/matroxfb_maven.c linux/drivers/video/matrox/matroxfb_maven.c
--- linux/drivers/video/matrox/matroxfb_maven.c	2004-05-22 18:37:59.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_maven.c	2004-05-22 20:05:04.000000000 +0200
@@ -1188,7 +1188,7 @@
 	md->client = clnt;
 	down_write(&ACCESS_FBINFO(altout.lock));
 	ACCESS_FBINFO(outputs[1]).output = &maven_altout;
-	ACCESS_FBINFO(outputs[1]).src = MATROXFB_SRC_NONE;
+	ACCESS_FBINFO(outputs[1]).src = ACCESS_FBINFO(outputs[1]).default_src;
 	ACCESS_FBINFO(outputs[1]).data = md;
 	ACCESS_FBINFO(outputs[1]).mode = MATROXFB_OUTPUT_MODE_MONITOR;
 	up_write(&ACCESS_FBINFO(altout.lock));
@@ -1249,6 +1249,7 @@
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(new_client, 0, sizeof(*new_client) + sizeof(*data));
 	data = (struct maven_data*)(new_client + 1);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
