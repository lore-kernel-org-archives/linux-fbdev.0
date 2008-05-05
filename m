From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 5/8] tridentfb: move global flat panel
 variable into structure
Date: Mon, 5 May 2008 18:56:24 +0200
Message-ID: <20080505185624.86de282d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt3zM-0007gC-2m for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:56:32 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt3zL-0006Df-64
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:56:32 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@pol.net, akpm@linux-foundation.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch moves flat panel indicator into tridentfb_par
structure and removes related global variables and macros.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-02 13:32:08.000000000 +0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-02 13:35:57.000000000 +0200
@@ -30,6 +30,7 @@ struct tridentfb_par {
 	void __iomem *io_virt;	/* iospace virtual memory address */
 	u32 pseudo_pal[16];
 	int chip_id;
+	int flatpanel;
 };
 
 static unsigned char eng_oper;	/* engine operation... */
@@ -43,24 +44,22 @@ static struct fb_fix_screeninfo tridentf
 	.accel = FB_ACCEL_NONE,
 };
 
-static int displaytype;
-
 /* defaults which are normally overriden by user values */
 
 /* video mode */
 static char *mode_option __devinitdata = "640x480";
-static int bpp = 8;
+static int bpp __devinitdata = 8;
 
-static int noaccel;
+static int noaccel __devinitdata;
 
 static int center;
 static int stretch;
 
-static int fp;
-static int crt;
+static int fp __devinitdata;
+static int crt __devinitdata;
 
-static int memsize;
-static int memdiff;
+static int memsize __devinitdata;
+static int memdiff __devinitdata;
 static int nativex;
 
 module_param(mode_option, charp, 0);
@@ -75,7 +74,9 @@ module_param(memsize, int, 0);
 module_param(memdiff, int, 0);
 module_param(nativex, int, 0);
 module_param(fp, int, 0);
+MODULE_PARM_DESC(fp, "Define if flatpanel is connected");
 module_param(crt, int, 0);
+MODULE_PARM_DESC(crt, "Define if CRT is connected");
 
 static int is3Dchip(int id)
 {
@@ -728,15 +729,15 @@ static void set_number_of_lines(struct t
 
 /*
  * If we see that FP is active we assume we have one.
- * Otherwise we have a CRT display.User can override.
+ * Otherwise we have a CRT display. User can override.
  */
-static unsigned int __devinit get_displaytype(struct tridentfb_par *par)
+static int __devinit is_flatpanel(struct tridentfb_par *par)
 {
 	if (fp)
-		return DISPLAY_FP;
+		return 1;
 	if (crt || !iscyber(par->chip_id))
-		return DISPLAY_CRT;
-	return (read3CE(par, FPConfig) & 0x10) ? DISPLAY_FP : DISPLAY_CRT;
+		return 0;
+	return (read3CE(par, FPConfig) & 0x10) ? 1 : 0;
 }
 
 /* Try detecting the video memory size */
@@ -824,6 +825,7 @@ static unsigned int __devinit get_memsiz
 static int tridentfb_check_var(struct fb_var_screeninfo *var,
 			       struct fb_info *info)
 {
+	struct tridentfb_par *par = info->par;
 	int bpp = var->bits_per_pixel;
 	debug("enter\n");
 
@@ -831,7 +833,7 @@ static int tridentfb_check_var(struct fb
 	if (bpp == 24)
 		bpp = var->bits_per_pixel = 32;
 	/* check whether resolution fits on panel and in memory */
-	if (flatpanel && nativex && var->xres > nativex)
+	if (par->flatpanel && nativex && var->xres > nativex)
 		return -EINVAL;
 	if (var->xres * var->yres_virtual * bpp / 8 > info->fix.smem_len)
 		return -EINVAL;
@@ -928,7 +930,7 @@ static int tridentfb_set_par(struct fb_i
 	crtc_unlock(par);
 	write3CE(par, CyberControl, 8);
 
-	if (flatpanel && var->xres < nativex) {
+	if (par->flatpanel && var->xres < nativex) {
 		/*
 		 * on flat panels with native size larger
 		 * than requested resolution decide whether
@@ -1097,7 +1099,7 @@ static int tridentfb_set_par(struct fb_i
 	t_outb(par, tmp, 0x3C6);
 	t_inb(par, 0x3C8);
 
-	if (flatpanel)
+	if (par->flatpanel)
 		set_number_of_lines(par, info->var.yres);
 	set_lwidth(par, info->var.xres * bpp / (4 * 16));
 	info->fix.visual = (bpp == 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
@@ -1153,7 +1155,7 @@ static int tridentfb_blank(int blank_mod
 	struct tridentfb_par *par = info->par;
 
 	debug("enter\n");
-	if (flatpanel)
+	if (par->flatpanel)
 		return 0;
 	t_outb(par, 0x04, 0x83C8); /* Read DPMS Control */
 	PMCont = t_inb(par, 0x83C6) & 0xFC;
@@ -1322,9 +1324,9 @@ static int __devinit trident_pci_probe(s
 	}
 
 	output("%s board found\n", pci_name(dev));
-	displaytype = get_displaytype(default_par);
+	default_par->flatpanel = is_flatpanel(default_par);
 
-	if (flatpanel)
+	if (default_par->flatpanel)
 		nativex = get_nativex(default_par);
 
 	info->fix = tridentfb_fix;
@@ -1441,9 +1443,9 @@ static int __init tridentfb_setup(char *
 		if (!strncmp(opt, "noaccel", 7))
 			noaccel = 1;
 		else if (!strncmp(opt, "fp", 2))
-			displaytype = DISPLAY_FP;
+			fp = 1;
 		else if (!strncmp(opt, "crt", 3))
-			displaytype = DISPLAY_CRT;
+			fp = 0;
 		else if (!strncmp(opt, "bpp=", 4))
 			bpp = simple_strtoul(opt + 4, NULL, 0);
 		else if (!strncmp(opt, "center", 6))
diff -urp linux-old/include/video/trident.h linux-pc/include/video/trident.h
--- linux-old/include/video/trident.h	2008-05-02 11:42:34.000000000 +0200
+++ linux-pc/include/video/trident.h	2008-05-02 13:32:16.000000000 +0200
@@ -63,12 +63,6 @@
 #define LCD_CENTER	1
 #define LCD_BIOS	2
 
-/* display types */
-#define DISPLAY_CRT	0
-#define DISPLAY_FP	1
-
-#define flatpanel (displaytype == DISPLAY_FP)
-
 /* General Registers */
 #define SPR	0x1F		/* Software Programming Register (videoram) */
 

----------------------------------------------------------------------
Andrzej Piaseczny w roli kucharza? Zobacz!
http://link.interia.pl/f1dcb


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
