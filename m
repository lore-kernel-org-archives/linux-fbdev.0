From: Javier Villavicencio <jvillavicencio@arnet.com.ar>
Subject: Missing radeonfb_setup
Date: Tue, 28 Oct 2003 18:55:59 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031028185559.384201ff.jvillavicencio@arnet.com.ar>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__28_Oct_2003_18:55:59_-0300_083a5230"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEbpz-0006Fr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 13:57:15 -0800
Received: from smtp1.arnet.com.ar ([200.45.191.6])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AEbp1-0005lA-7a
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Oct 2003 13:56:15 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--Multipart_Tue__28_Oct_2003_18:55:59_-0300_083a5230
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Simple patch to the new radeon fb driver to make it set modes/resolutions,
and take the other parameters.
Extracted some code from the matroxfb driver. Added radeonfb_setup function.

Also, with the new fbdev driver and with or without this little fix, tested in -test8 and
-test9 I cannot get my console framebuffer back when I switch from X, system working ok,
but the console is distorted. I have a Radeon 9600 Pro.

Salu2.

Javier Villavicencio.



--Multipart_Tue__28_Oct_2003_18:55:59_-0300_083a5230
Content-Type: text/x-diff;
 name="radeonfb_setup.diff"
Content-Disposition: attachment;
 filename="radeonfb_setup.diff"
Content-Transfer-Encoding: 7bit

diff -urN linux.radeonfb/drivers/video/aty/radeon_base.c linux-2.6.0-test9/drivers/video/aty/radeon_base.c
--- linux.radeonfb/drivers/video/aty/radeon_base.c	2003-10-27 06:23:11.799945343 -0300
+++ linux-2.6.0-test9/drivers/video/aty/radeon_base.c	2003-10-27 06:04:24.973721058 -0300
@@ -236,8 +236,8 @@
  * globals
  */
         
-static char *mode_option;
-static char *monitor_layout;
+static char mode_option[64]; 		/* "radeonfb:mode_option:xxxxx" or "radeonfb:xxxxx" */
+static char monitor_layout[64];		/* "radeonfb:mode_layout:xxxxx" */
 static int noaccel = 0;
 static int nomodeset = 0;
 static int ignore_edid = 0;
@@ -2367,6 +2367,40 @@
 #endif /* CONFIG_PM */
 };
 
+int __init radeonfb_setup (char *options) {
+	char *this_opt;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt) continue;
+
+		printk("radeonfb_setup: option %s\n", this_opt);
+		
+		if (!strncmp(this_opt, "noaccel:", 8))
+			noaccel = simple_strtoul(this_opt+8, NULL, 0);
+		else if (!strncmp(this_opt, "nomodeset:", 10))
+			nomodeset = simple_strtoul(this_opt+10, NULL, 0);
+		else if (!strncmp(this_opt, "panel_yres:", 11))
+			panel_yres = simple_strtoul(this_opt+11, NULL, 0);
+		else if (!strncmp(this_opt, "force_dfp:", 9))
+		        force_dfp = simple_strtoul(this_opt+9, NULL, 0);
+		else if (!strncmp(this_opt, "ignore_edid:", 11))
+			ignore_edid = simple_strtoul(this_opt+11, NULL, 0);
+		else if (!strncmp(this_opt, "force_measure_pll:", 17))
+			force_measure_pll = simple_strtoul(this_opt+17, NULL, 0);
+		else if (!strncmp(this_opt, "nomtrr:", 7))
+			nomtrr = simple_strtoul(this_opt+7, NULL, 0);
+		else if (!strncmp(this_opt, "monitor_layout:", 15))
+			strlcpy(monitor_layout, this_opt+15, sizeof(monitor_layout));
+		else if (!strncmp(this_opt, "mode_option:", 12))
+			strlcpy(mode_option, this_opt+12, sizeof(mode_option));
+                else 
+			strlcpy(mode_option, this_opt, sizeof(mode_option));
+	}
+	return 0;
+}
 
 int __init radeonfb_init (void)
 {
@@ -2406,6 +2440,6 @@
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
 #endif
 module_param(panel_yres, int, 0);
-MODULE_PARM_DESC(force_dfp, "int: set panel yres");
+MODULE_PARM_DESC(panel_yres, "int: set panel yres");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
diff -urN linux.radeonfb/drivers/video/aty/radeon_monitor.c linux-2.6.0-test9/drivers/video/aty/radeon_monitor.c
--- linux.radeonfb/drivers/video/aty/radeon_monitor.c	2003-10-27 06:23:11.804944612 -0300
+++ linux-2.6.0-test9/drivers/video/aty/radeon_monitor.c	2003-10-27 06:15:41.079084942 -0300
@@ -7,10 +7,22 @@
 #endif /* CONFIG_PPC_OF */
 
 static struct fb_var_screeninfo radeonfb_default_var = {
-        640, 480, 640, 480, 0, 0, 8, 0,
-        {0, 6, 0}, {0, 6, 0}, {0, 6, 0}, {0, 0, 0},
-        0, 0, -1, -1, 0, 39721, 40, 24, 32, 11, 96, 2,
-        0, FB_VMODE_NONINTERLACED
+        640,480,640,480,/* W,H, W, H (virtual) load xres,xres_virtual*/
+        0,0,            /* virtual -> visible no offset */
+        8,              /* depth -> load bits_per_pixel */
+        0,              /* greyscale ? */
+        {0,0,0},        /* R */
+        {0,0,0},        /* G */
+        {0,0,0},        /* B */
+        {0,0,0},        /* transparency */
+        0,              /* standard pixel format */
+        FB_ACTIVATE_NOW,
+        -1,-1,
+        FB_ACCELF_TEXT, /* accel flags */
+        39721L,48L,16L,33L,10L,
+        96L,2L,~0,      /* No sync info */
+        FB_VMODE_NONINTERLACED,
+        0, {0,0,0,0,0}
 };
 
 static char *radeon_get_mon_name(int type)
@@ -288,7 +300,7 @@
  * Parse the "monitor_layout" string if any. This code is mostly
  * copied from XFree's radeon driver
  */
-static int __devinit radeon_parse_monitor_layout(struct radeonfb_info *rinfo, const char *monitor_layout)
+static int __devinit radeon_parse_monitor_layout(struct radeonfb_info *rinfo, const char monitor_layout[64])
 {
 	char s1[5], s2[5];
 	int i = 0, second = 0;
@@ -348,7 +360,7 @@
  * driver
  */
 void __devinit radeon_probe_screens(struct radeonfb_info *rinfo,
-				    const char *monitor_layout, int ignore_edid)
+				    const char monitor_layout[64], int ignore_edid)
 {
 	int ddc_crt2_used = 0;
 	int tmp, i;
@@ -584,7 +596,7 @@
  * Build the modedb for head 1 (head 2 will come later), check panel infos
  * from either BIOS or EDID, and pick up the default mode
  */
-void __devinit radeon_check_modes(struct radeonfb_info *rinfo, const char *mode_option)
+void __devinit radeon_check_modes(struct radeonfb_info *rinfo, const char mode_option[64])
 {
 	int has_default_mode = 0;
 
@@ -698,11 +710,12 @@
 		struct fb_videomode default_mode;
 		if (has_default_mode)
 			radeon_var_to_videomode(&default_mode, &rinfo->info.var);
-		else
-			radeon_var_to_videomode(&default_mode, &radeonfb_default_var);
-		if (fb_find_mode(&rinfo->info.var, &rinfo->info, mode_option,
-				 rinfo->mon1_modedb, rinfo->mon1_dbsize, &default_mode, 8) == 0)
+		else {
+			printk("radeonfb: mode_option %s \n", mode_option);
+			fb_find_mode(&radeonfb_default_var, &rinfo->info, mode_option[0]?mode_option:NULL, 
+				     rinfo->mon1_modedb, rinfo->mon1_dbsize, &default_mode, 8);
 			rinfo->info.var = radeonfb_default_var;
+			radeon_var_to_videomode(&default_mode, &radeonfb_default_var);
+		}
 	}
-
 }


--Multipart_Tue__28_Oct_2003_18:55:59_-0300_083a5230--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
