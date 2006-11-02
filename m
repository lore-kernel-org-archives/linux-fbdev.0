From: akpm@osdl.org
Subject: [patch 08/25] constify and annotate
	__read_mostly in vgacon.c and fbmem.c
Date: Wed, 01 Nov 2006 21:50:22 -0800
Message-ID: <200611020550.kA25oMAL002303@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVUP-0007gE-8J for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:45 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVUO-0000IC-Rg
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:45 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, deller@gmx.de

From: Helge Deller <deller@gmx.de>

- annotate some variables from vgacon.c and fbmem.c as __read_mostly
- move the mask[] array in fb_set_logo_truepalette() into the .rodata section

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/console/vgacon.c |   30 +++++++++++++++---------------
 drivers/video/fbmem.c          |   14 +++++++-------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff -puN drivers/video/console/vgacon.c~constify-and-annotate-__read_mostly drivers/video/console/vgacon.c
--- a/drivers/video/console/vgacon.c~constify-and-annotate-__read_mostly
+++ a/drivers/video/console/vgacon.c
@@ -93,27 +93,27 @@ static void vgacon_invert_region(struct 
 static unsigned long vgacon_uni_pagedir[2];
 
 /* Description of the hardware situation */
-static unsigned long	vga_vram_base;		/* Base of video memory */
-static unsigned long	vga_vram_end;		/* End of video memory */
-static int		vga_vram_size;		/* Size of video memory */
-static u16		vga_video_port_reg;	/* Video register select port */
-static u16		vga_video_port_val;	/* Video register value port */
-static unsigned int	vga_video_num_columns;	/* Number of text columns */
-static unsigned int	vga_video_num_lines;	/* Number of text lines */
-static int		vga_can_do_color = 0;	/* Do we support colors? */
-static unsigned int	vga_default_font_height;/* Height of default screen font */
-static unsigned char	vga_video_type;		/* Card type */
-static unsigned char	vga_hardscroll_enabled;
-static unsigned char	vga_hardscroll_user_enable = 1;
+static int		vga_init_done		__read_mostly;
+static unsigned long	vga_vram_base		__read_mostly;	/* Base of video memory */
+static unsigned long	vga_vram_end		__read_mostly;	/* End of video memory */
+static unsigned int	vga_vram_size		__read_mostly;	/* Size of video memory */
+static u16		vga_video_port_reg	__read_mostly;	/* Video register select port */
+static u16		vga_video_port_val	__read_mostly;	/* Video register value port */
+static unsigned int	vga_video_num_columns;			/* Number of text columns */
+static unsigned int	vga_video_num_lines;			/* Number of text lines */
+static int		vga_can_do_color	__read_mostly;	/* Do we support colors? */
+static unsigned int	vga_default_font_height __read_mostly;	/* Height of default screen font */
+static unsigned char	vga_video_type		__read_mostly;	/* Card type */
+static unsigned char	vga_hardscroll_enabled	__read_mostly;
+static unsigned char	vga_hardscroll_user_enable __read_mostly = 1;
 static unsigned char	vga_font_is_default = 1;
 static int		vga_vesa_blanked;
 static int 		vga_palette_blanked;
 static int 		vga_is_gfx;
 static int 		vga_512_chars;
 static int 		vga_video_font_height;
-static int 		vga_scan_lines;
-static unsigned int 	vga_rolled_over = 0;
-static int              vga_init_done;
+static int 		vga_scan_lines		__read_mostly;
+static unsigned int 	vga_rolled_over;
 
 static int __init no_scroll(char *str)
 {
diff -puN drivers/video/fbmem.c~constify-and-annotate-__read_mostly drivers/video/fbmem.c
--- a/drivers/video/fbmem.c~constify-and-annotate-__read_mostly
+++ a/drivers/video/fbmem.c
@@ -52,8 +52,8 @@
 
 #define FBPIXMAPSIZE	(1024 * 8)
 
-struct fb_info *registered_fb[FB_MAX];
-int num_registered_fb;
+struct fb_info *registered_fb[FB_MAX] __read_mostly;
+int num_registered_fb __read_mostly;
 
 /*
  * Helpers
@@ -202,7 +202,7 @@ static void  fb_set_logo_truepalette(str
 					    const struct linux_logo *logo,
 					    u32 *palette)
 {
-	unsigned char mask[9] = { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
+	static const unsigned char mask[] = { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
 	unsigned char redmask, greenmask, bluemask;
 	int redshift, greenshift, blueshift;
 	int i;
@@ -317,7 +317,7 @@ static struct logo_data {
 	int needs_truepalette;
 	int needs_cmapreset;
 	const struct linux_logo *logo;
-} fb_logo;
+} fb_logo __read_mostly;
 
 static void fb_rotate_logo_ud(const u8 *in, u8 *out, u32 width, u32 height)
 {
@@ -1253,7 +1253,7 @@ fb_release(struct inode *inode, struct f
 	return 0;
 }
 
-static struct file_operations fb_fops = {
+static const struct file_operations fb_fops = {
 	.owner =	THIS_MODULE,
 	.read =		fb_read,
 	.write =	fb_write,
@@ -1459,8 +1459,8 @@ int fb_new_modelist(struct fb_info *info
 	return err;
 }
 
-static char *video_options[FB_MAX];
-static int ofonly;
+static char *video_options[FB_MAX] __read_mostly;
+static int ofonly __read_mostly;
 
 extern const char *global_mode_option;
 
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
