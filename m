From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] g364fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:53:46 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915195346.GM16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzQd-0004pZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:54:31 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzQc-0005Eh-J7
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:54:30 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,
this patch converts driver/video/g364fb to framebuffer_alloc:

======== drivers/video/g364fb.c 1.24 ========
D 1.24 03/09/11 23:40:23+02:00 kronos@kronoz.cjb.net 27 26 17/11/256
P drivers/video/g364fb.c
C - switch to framebuffer_alloc
C - compilation fixes
------------------------------------------------

===== drivers/video/g364fb.c 1.23 vs 1.24 =====
--- 1.23/drivers/video/g364fb.c	Tue May  6 04:41:32 2003
+++ 1.24/drivers/video/g364fb.c	Thu Sep 11 23:40:23 2003
@@ -72,7 +72,7 @@
 #define MON_ID_REG 	0xe4100000	/* unused */
 #define RESET_REG 	0xe4180000	/* Write only */
 
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 
 static struct fb_fix_screeninfo fb_fix __initdata = {
 	.id 		= "G364 8plane",
@@ -127,7 +127,7 @@
 
 int g364fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-
+	int i;
 	/* Turn the cursor off before we start changing it. */
 	*(unsigned int *) CTLA_REG |= CURS_TOGGLE;
 
@@ -233,6 +233,10 @@
 {
 	int mem, i, j;
 
+	fb_info = framebuffer_alloc(0, NULL);
+	if (!fb_info)
+		return -ENOMEM;
+
 	/* TBD: G364 detection */
 
 	/* get the resolution set by ARC console */
@@ -243,24 +247,26 @@
 	    (*((volatile unsigned int *) VDISPLAY_REG) & 0x00ffffff) / 2;
 	*(volatile unsigned int *) CTLA_REG |= ENABLE_VTG;
 
-	fb_var.xres_virtual = fbvar.xres;
-	fb_fix.line_length = (xres / 8) * fb_var.bits_per_pixel;
+	fb_var.xres_virtual = fb_var.xres;
+	fb_fix.line_length = (fb_var.xres / 8) * fb_var.bits_per_pixel;
 	fb_fix.smem_start = 0x40000000;	/* physical address */
 	/* get size of video memory; this is special for the JAZZ hardware */
 	mem = (r4030_read_reg32(JAZZ_R4030_CONFIG) >> 8) & 3;
 	fb_fix.smem_len = (1 << (mem * 2)) * 512 * 1024;
 	fb_var.yres_virtual = fb_fix.smem_len / fb_var.xres;
 
-	fb_info.fbops = &g364fb_ops;
-	fb_info.screen_base = (char *) G364_MEM_BASE;	/* virtual kernel address */
-	fb_info.var = fb_var;
-	fb_info.fix = fb_fix;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info->fbops = &g364fb_ops;
+	fb_info->screen_base = (char *) G364_MEM_BASE;	/* virtual kernel address */
+	fb_info->var = fb_var;
+	fb_info->fix = fb_fix;
+	fb_info->flags = FBINFO_FLAG_DEFAULT;
 
-	fb_alloc_cmap(&fb_info.cmap, 255, 0);
+	fb_alloc_cmap(&fb_info->cmap, 255, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(fb_info) < 0) {
+		kfree(fb_info);
 		return -EINVAL;
+	}
 	return 0;
 }
 


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"La teoria e` quando sappiamo come funzionano le cose ma non funzionano.
 La pratica e` quando le cose funzionano ma non sappiamo perche`.
 Abbiamo unito la teoria e la pratica: le cose non funzionano piu` e non
 sappiamo il perche`." -- A. Einstein


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
