From: Antonino Daplas <adaplas@pol.net>
Subject: Re: clipping
Date: 11 Jan 2003 13:12:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042261610.932.143.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301102030310.30522-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XE6u-0004Xg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 21:23:08 -0800
In-Reply-To: <Pine.LNX.4.44.0301102030310.30522-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-01-11 at 04:31, James Simmons wrote:
> 
> > > > Except for the geek value, why would it be cleaner to draw half of a character
> > > > near the border?
> > > 
> > > This is one of the reasons why I moved from fbset to setting the console 
> > > resolution via the console layer. You can't end up with half characters. 
> > > Via fbset you could but fbcon had extra code to prevent such foolishness. 
> > > But it still looked silly to have half line on the bottom of the screen 
> > > that nothing ever drawed in.
> > 
> > What else can you do? My notebook has a fixed LCD of 1024x768. With the 12x22
> > font, I have a text console of 85x34, using only 1020x748 pixels. Shrinking the
> > resolution to 1020x748 is not an option.
> 
> Ug. I guess we handle it the best way we can. Also we can try BenH 
> suggesting of incorpating scaling. 
> 

Or we can modify fbcon_resize() so it just checks if the resulting
resolution is enough to accomodate the console window size...

static int fbcon_resize(struct vc_data *vc, unsigned int width, 
			unsigned int height)
{
	struct display *p = &fb_display[vc->vc_num];
	struct fb_info *info = p->fb_info;
	struct fb_var_screeninfo var = info->var;
	int err, x, y;

	var.xres = x = width * vc->vc_font.width;
	var.yres = y = height * vc->vc_font.height;
	var.activate = FB_ACTIVATE_TEST;
	err = fb_set_var(&var, info);
	if (err || var.xres < x || var.yres < y)
		return -EINVAL;

	var.activate = FB_ACTIVATE_NOW;
	err = fb_set_var(&var, info);
	p->vrows = info->var.yres_virtual/vc->vc_font.height;
	return err; 
}

...which implies that we also have to modify accel_clear_margins() so it
clears more than just a fraction of a character's width and height...

void accel_clear_margins(struct vc_data *vc, struct display *p,
				int bottom_only)
{
	struct fb_info *info = p->fb_info;
	unsigned int cw = vc->vc_font.width;
	unsigned int ch = vc->vc_font.height;
	unsigned int rw = info->var.xres - vc->vc_cols * cw;
	unsigned int bh = info->var.yres - vc->vc_rows * ch;
	unsigned int rs = info->var.xres - rw;
	unsigned int bs = info->var.yres - bh;
	struct fb_fillrect region;

	region.color = attr_bgcol_ec(p, vc);
	region.rop = ROP_COPY;

	if (rw & !bottom_only) {
		region.dx = info->var.xoffset + rs;
		region.dy = 0;
		region.width = rw;
		region.height = info->var.yres_virtual;
		info->fbops->fb_fillrect(info, &region);
	}

	if (bh) {
		region.dx = info->var.xoffset;
		region.dy = info->var.yoffset + bs;
		region.width = rs;
		region.height = bh;
		info->fbops->fb_fillrect(info, &region);
	}	
}	

... which exposed a bug in vc_resize() in vt.c.  In vc_resize(), the
global variables:

	video_num_lines;
	video_num_columns;
	video_size_row;
	screenbuf_size;

are modified before calling consw->con_resize() which, if it returns
with an error, are left with invalid numbers. So attached is a patch.

It behaves correctly now.  When the resulting resolution is bigger than
the console window size, it's left with a small window at the upper left
corner.  So stty must be called so rows and cols are enough but no
bigger than the supported resolution.

This works pretty well if panning is disabled.  With panning, I get a
cursor "dissynchronous" with the display and where the virtual screen is
randomly placed anywhere within the display window.

We might need to fix for scrolling + panning here.

Tony

diff -Naur linux-2.5.54/drivers/char/vt.c linux/drivers/char/vt.c
--- linux-2.5.54/drivers/char/vt.c	2003-01-11 04:47:02.000000000 +0000
+++ linux/drivers/char/vt.c	2003-01-11 04:47:49.000000000 +0000
@@ -732,24 +732,24 @@
 	if (new_cols == video_num_columns && new_rows == video_num_lines)
 		return 0;
 
-	newscreen = (unsigned short *) kmalloc(new_screen_size, GFP_USER);
-	if (!newscreen)
-		return -ENOMEM;
-
 	old_rows = video_num_lines;
 	old_cols = video_num_columns;
 	old_row_size = video_size_row;
 	old_screen_size = screenbuf_size;
 
+	err = resize_screen(currcons, new_cols, new_rows);
+	if (err) 
+		return err;
+
+	newscreen = (unsigned short *) kmalloc(new_screen_size, GFP_USER);
+	if (!newscreen)
+		return -ENOMEM;
+
 	video_num_lines = new_rows;
 	video_num_columns = new_cols;
 	video_size_row = new_row_size;
 	screenbuf_size = new_screen_size;
 
-	err = resize_screen(currcons, new_cols, new_rows);
-	if (err)
-		return err;
-
 	rlth = min(old_row_size, new_row_size);
 	rrem = new_row_size - rlth;
 	old_origin = origin;





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
