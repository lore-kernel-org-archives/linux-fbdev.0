From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] imacfb: Add Intel-based Macintosh
	Framebuffer Support
Date: Sun, 25 Jun 2006 03:37:51 -0700
Message-ID: <20060625033751.45081f05.akpm@osdl.org>
References: <449E603B.5030809@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuS05-0001xR-Ab for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:37:57 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FuS04-0002kv-Sc
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 03:37:57 -0700
In-Reply-To: <449E603B.5030809@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sun, 25 Jun 2006 18:06:51 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> This patch adds a new framebuffer driver for the Intel Based macs.
> This framebuffer is needed when booting from EFI to get something
> out the box.

A few fixlets below.

This driver looks like it'll leak lots of things when the module is unloaded.




From: Andrew Morton <akpm@osdl.org>

- coding style tweaks

- remove unneeded initialisation of statics

Cc: Edgar Hucek <hostmaster@ed-soft.at>
Cc: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/imacfb.c |   72 ++++++++++++++++++++-------------------
 video/Makefile         |    0 
 2 files changed, 37 insertions(+), 35 deletions(-)

diff -puN drivers/video/imacfb.c~imacfb-add-intel-based-macintosh-framebuffer-support-tidy drivers/video/imacfb.c
--- a/drivers/video/imacfb.c~imacfb-add-intel-based-macintosh-framebuffer-support-tidy
+++ a/drivers/video/imacfb.c
@@ -51,10 +51,10 @@ static struct fb_fix_screeninfo imacfb_f
 	.visual			= FB_VISUAL_TRUECOLOR,
 };
 
-static int inverse		= 0;
+static int inverse;
 static int model		= M_NEW;
-static int manual_height	= 0;
-static int manual_width		= 0;
+static int manual_height;
+static int manual_width;
 
 #define	DEFAULT_FB_MEM	1024*1024*16
 
@@ -105,7 +105,7 @@ static int __init imacfb_setup(char *opt
 		if (!*this_opt) continue;
 
 		if (!strcmp(this_opt, "inverse"))
-			inverse=1;
+			inverse = 1;
 		else if (!strcmp(this_opt, "i17"))
 			model = M_I17;
 		else if (!strcmp(this_opt, "i20"))
@@ -142,32 +142,32 @@ static int __init imacfb_probe(struct pl
 	screen_info.rsvd_size = 8;
 	screen_info.rsvd_pos = 24;
 
-	switch(model) {
-		case M_I17:
-			screen_info.lfb_width = 1440;
-			screen_info.lfb_height = 900;
-			screen_info.lfb_linelength = 1472 * 4;
-			screen_info.lfb_base = 0x80010000;
-			break;
-		case M_NEW:
-		case M_I20:
-			screen_info.lfb_width = 1680;
-			screen_info.lfb_height = 1050;
-			screen_info.lfb_linelength = 1728 * 4;
-			screen_info.lfb_base = 0x80010000;
-			break;
-		case M_MINI:
-			screen_info.lfb_width = 1024;
-			screen_info.lfb_height = 768;
-			screen_info.lfb_linelength = 2048 * 4;
-			screen_info.lfb_base = 0x80000000;
-			break;
-		case M_MACBOOK:
-			screen_info.lfb_width = 1280;
-			screen_info.lfb_height = 800;
-			screen_info.lfb_linelength = 2048 * 4;
-			screen_info.lfb_base = 0x80000000;
-			break;
+	switch (model) {
+	case M_I17:
+		screen_info.lfb_width = 1440;
+		screen_info.lfb_height = 900;
+		screen_info.lfb_linelength = 1472 * 4;
+		screen_info.lfb_base = 0x80010000;
+		break;
+	case M_NEW:
+	case M_I20:
+		screen_info.lfb_width = 1680;
+		screen_info.lfb_height = 1050;
+		screen_info.lfb_linelength = 1728 * 4;
+		screen_info.lfb_base = 0x80010000;
+		break;
+	case M_MINI:
+		screen_info.lfb_width = 1024;
+		screen_info.lfb_height = 768;
+		screen_info.lfb_linelength = 2048 * 4;
+		screen_info.lfb_base = 0x80000000;
+		break;
+	case M_MACBOOK:
+		screen_info.lfb_width = 1280;
+		screen_info.lfb_height = 800;
+		screen_info.lfb_linelength = 2048 * 4;
+		screen_info.lfb_base = 0x80000000;
+		break;
  	}
 
 	/* if the user wants to manually specify height/width,
@@ -229,8 +229,8 @@ static int __init imacfb_probe(struct pl
 
 	info->screen_base = ioremap(imacfb_fix.smem_start, imacfb_fix.smem_len);
 	if (!info->screen_base) {
-		printk(KERN_ERR
-		       "imacfb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
+		printk(KERN_ERR "imacfb: abort, cannot ioremap video memory "
+				"0x%x @ 0x%lx\n",
 			imacfb_fix.smem_len, imacfb_fix.smem_start);
 		err = -EIO;
 		goto err_unmap;
@@ -241,11 +241,13 @@ static int __init imacfb_probe(struct pl
 	       imacfb_fix.smem_start, info->screen_base,
 	       size_remap/1024, size_total/1024);
 	printk(KERN_INFO "imacfb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
-	       imacfb_defined.xres, imacfb_defined.yres, imacfb_defined.bits_per_pixel,
-	       imacfb_fix.line_length, screen_info.pages);
+	       imacfb_defined.xres, imacfb_defined.yres,
+	       imacfb_defined.bits_per_pixel, imacfb_fix.line_length,
+	       screen_info.pages);
 
 	imacfb_defined.xres_virtual = imacfb_defined.xres;
-	imacfb_defined.yres_virtual = imacfb_fix.smem_len / imacfb_fix.line_length;
+	imacfb_defined.yres_virtual = imacfb_fix.smem_len /
+					imacfb_fix.line_length;
 	printk(KERN_INFO "imacfb: scrolling: redraw\n");
 	imacfb_defined.yres_virtual = imacfb_defined.yres;
 
diff -puN drivers/video/Kconfig~imacfb-add-intel-based-macintosh-framebuffer-support-tidy drivers/video/Kconfig
diff -puN drivers/video/Makefile~imacfb-add-intel-based-macintosh-framebuffer-support-tidy drivers/video/Makefile
_


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
