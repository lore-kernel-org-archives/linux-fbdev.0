From: Antonino Daplas <adaplas@pol.net>
Subject: fbcon_show_logo using imageblit
Date: 07 May 2002 21:25:42 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1020777134.734.3.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1754yv-0004mg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 May 2002 06:26:17 -0700
Received: from [205.136.61.71] (cwc71.compass.com.ph [205.136.61.71])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id VAA74249
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 7 May 2002 21:26:12 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I was trying to test the imageblit function to draw images, and while
doing that, I thought maybe I can use the fbcon_show_logo function for
testing.  I copied fbcon_show_logo as fbcon_show_logo_accel and slightly
modified the code so it uses imageblit instead. I only included
truecolor and psuedocolor at 8bpp since I don't have the hardware to
test other formats.

The code is probably suboptimal, but I would like to know if the
concept/format for using imageblit is correct. It does work on testing
though.

I included a diff for 2.5.13 + fbdev_fixs.diff (James Simmons).

Tony

--- fbcon.c.orig	Tue May  7 20:53:04 2002
+++ fbcon.c	Tue May  7 21:04:20 2002
@@ -215,6 +215,9 @@
 			    int height, int width, u_int y_break);
 
 static int fbcon_show_logo(void);
+#ifdef CONFIG_FBCON_ACCEL
+static int fbcon_show_logo_accel(void);
+#endif
 
 #ifdef CONFIG_MAC
 /*
@@ -1541,6 +1544,9 @@
 	p->dispsw->clear_margins(conp, p, 0);
     if (logo_shown == -2) {
 	logo_shown = fg_console;
+#ifdef CONFIG_FBCON_ACCEL
+	if (!(fbcon_show_logo_accel()))
+#endif
 	fbcon_show_logo(); /* This is protected above by initmem_freed */
 	update_region(fg_console,
 		      conp->vc_origin + conp->vc_size_row * conp->vc_top,
@@ -2447,6 +2453,143 @@
 
     return done ? (LOGO_H + fontheight(p) - 1) / fontheight(p) : 0 ;
 }
+
+#ifdef CONFIG_FBCON_ACCEL
+static int __init fbcon_show_logo_accel( void )
+{
+	struct display *p = &fb_display[fg_console]; /* draw to vt in foreground */
+	struct fb_image image;
+	int depth = p->var.bits_per_pixel;
+	unsigned char *logo;
+	unsigned char *dst, *src = 0, *data, *dat;
+	int i, j, n, x1, y1, x = 0;
+	int logo_depth, done = 0;
+	
+	if (!(p->fb_info->fbops->fb_imageblit))
+		return 0;
+	dat = (u8 *) (vmalloc(LOGO_W * LOGO_H * ((depth + 7) >> 3)));
+	if (dat == NULL) 
+		return 0;
+	data = dat;
+	/*
+	 * Set colors if visual is PSEUDOCOLOR and we have enough colors, or for
+	 * DIRECTCOLOR
+	 * We don't have to set the colors for the 16-color logo, since that logo
+	 * uses the standard VGA text console palette
+	 */
+	if ((p->visual == FB_VISUAL_PSEUDOCOLOR && depth >= 8) ||
+	    (p->visual == FB_VISUAL_DIRECTCOLOR && depth >= 24))
+		for (i = 0; i < LINUX_LOGO_COLORS; i += n) {
+			n = LINUX_LOGO_COLORS - i;
+			if (n > 16)
+				/* palette_cmap provides space for only 16 colors at once */
+				n = 16;
+			palette_cmap.start = 32 + i;
+			palette_cmap.len   = n;
+			for( j = 0; j < n; ++j ) {
+				palette_cmap.red[j]   = (linux_logo_red[i+j] << 8) |
+					linux_logo_red[i+j];
+				palette_cmap.green[j] = (linux_logo_green[i+j] << 8) |
+					linux_logo_green[i+j];
+				palette_cmap.blue[j]  = (linux_logo_blue[i+j] << 8) |
+					linux_logo_blue[i+j];
+			}
+			p->fb_info->fbops->fb_set_cmap(&palette_cmap, 1, fg_console,
+						       p->fb_info);
+		}
+	
+	if (depth >= 8) {
+		logo = linux_logo;
+		logo_depth = 8;
+	}
+	else if (depth >= 4) {
+		logo = linux_logo16;
+		logo_depth = 4;
+	}
+	else {
+		logo = linux_logo_bw;
+		logo_depth = 1;
+	}
+	
+	if (p->fb_info->fbops->fb_rasterimg)
+		p->fb_info->fbops->fb_rasterimg(p->fb_info, 1);
+	
+#if defined(CONFIG_FBCON_CFB16) || defined(CONFIG_FBCON_CFB24) || \
+    defined(CONFIG_FBCON_CFB32) || defined(CONFIG_FB_SBUS)
+	if ((depth % 8 == 0) && (p->visual == FB_VISUAL_TRUECOLOR)) {
+	    /* Modes without color mapping, needs special data transformation... */
+		unsigned int val;		/* max. depth 32! */
+		int bdepth = depth/8;
+		unsigned char redmask, greenmask, bluemask;
+		int redshift, greenshift, blueshift;
+		unsigned char mask[9] = { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
+		
+		/* Bug: Doesn't obey msb_right ... (who needs that?) */
+		redmask   = mask[p->var.red.length   < 8 ? p->var.red.length   : 8];
+		greenmask = mask[p->var.green.length < 8 ? p->var.green.length : 8];
+		bluemask  = mask[p->var.blue.length  < 8 ? p->var.blue.length  : 8];
+		redshift   = p->var.red.offset   - (8-p->var.red.length);
+		greenshift = p->var.green.offset - (8-p->var.green.length);
+		blueshift  = p->var.blue.offset  - (8-p->var.blue.length);
+		
+		src = logo;
+		for( y1 = 0; y1 < LOGO_H; y1++ ) {
+			dst = data + y1*LOGO_W*bdepth;
+			for( x1 = 0; x1 < LOGO_W; x1++, src++ ) {
+				val = safe_shift((linux_logo_red[*src-32]   & redmask), redshift) |
+					safe_shift((linux_logo_green[*src-32] & greenmask), greenshift) |
+					safe_shift((linux_logo_blue[*src-32]  & bluemask), blueshift);
+				if (bdepth == 4 && !((long)dst & 3)) {
+					/* Some cards require 32bit access */
+					fb_writel (val, dst);
+					dst += 4;
+				} else if (bdepth == 2 && !((long)dst & 1)) {
+					/* others require 16bit access */
+					fb_writew (val,dst);
+					dst +=2;
+				} else {
+#ifdef __LITTLE_ENDIAN
+					for( i = 0; i < bdepth; ++i )
+#else
+					for( i = bdepth-1; i >= 0; --i )
+#endif
+						fb_writeb (val >> (i*8), dst++);
+				}
+			}
+		}
+		done = 1;
+	}
+#endif
+#if defined(CONFIG_FBCON_CFB8) || defined(CONFIG_FB_SBUS)
+	if (depth == 8 && p->type == FB_TYPE_PACKED_PIXELS) {
+		/* depth 8 or more, packed, with color registers */
+		data = logo;
+		done = 1;
+	}
+#endif
+	if (done) {
+		image.dy = 0;
+		image.height = LOGO_H;
+		image.width = LOGO_W;
+		image.depth = depth;
+		image.data = data;
+		for (x = 0; x < smp_num_cpus * (LOGO_W + 8) &&
+			     x < p->var.xres - (LOGO_W + 8); x += (LOGO_W + 8)) {
+			image.dx = x;
+			p->fb_info->fbops->fb_imageblit(p->fb_info, &image);
+		}
+	}
+	vfree(dat);
+	
+	if (p->fb_info->fbops->fb_rasterimg)
+		p->fb_info->fbops->fb_rasterimg(p->fb_info, 0);
+	
+    /* Modes not yet supported: packed pixels with depth != 8 (does such a
+     * thing exist in reality?) */
+	
+	return done ? (LOGO_H + fontheight(p) - 1) / fontheight(p) : 0 ;
+}
+#endif
 
 /*
  *  The console `switch' structure for the frame buffer based console





_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
