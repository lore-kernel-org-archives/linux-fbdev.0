From: David Vrabel <dvrabel@arcom.com>
Subject: Re: [patch] (Preliminary) Geode framebuffer driver.
Date: Tue, 15 Feb 2005 14:15:03 +0000
Message-ID: <421203E7.4030903@arcom.com>
References: <420C92F0.1090409@arcom.com> <200502120438.27671.adaplas@gawab.com> <4211D969.6070106@arcom.com> <200502152138.24361.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D13Ty-0006PJ-BL
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 06:15:18 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D13Tv-0002fl-Ol
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 06:15:18 -0800
In-Reply-To: <200502152138.24361.adaplas@hotpop.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Note that this driver requires the FB_CFB_xxx and FB_SOFT_CURSOR kbuild
option patches I posted earlier today.

It's also:

Signed-off-by: David Vrabel <dvrabel@arcom.com>

Thanks for looking this over.

> A few minor comments:
> 
> +        /* Clear the frame buffer of garbage. */
> +        memset(info->screen_base, 0, info->fix.smem_len);
> 
> Is the above really necessary?

Yes. Otherwise the screen will show garbage until whatever application
you're using gets around to clearing the screen. (An embedded system
won't necessarily have fbcon.)

> And if it is, memset_io is preferred.

Done.

> +	info->screen_base = (unsigned char *)ioremap(info->fix.smem_start, info->fix.smem_len);
> 
> You also do not need the (unsigned char *) part. (sparse will complain.)

Done.

I think I got that from skeletonfb.c (which is looking a bit out of date).

> No need to resend the patch, just let me know what changes you want, if any.

I've also fixed a warning and corrected some whitespace.

Here's a diff of these changes.

Index: linux-2.6-i386/drivers/video/geode/geodefb.h
===================================================================
--- linux-2.6-i386.orig/drivers/video/geode/geodefb.h	2005-02-15
10:33:59.000000000 +0000
+++ linux-2.6-i386/drivers/video/geode/geodefb.h	2005-02-15
13:49:54.782318435 +0000
@@ -22,7 +22,7 @@
 struct geode_vid_ops {
 	void (*set_dclk)(struct fb_info *);
 	void (*configure_display)(struct fb_info *);
-	int  (*blank_display)(const struct fb_info *, int blank_mode);
+	int  (*blank_display)(struct fb_info *, int blank_mode);
 };

 struct geodefb_par {
Index: linux-2.6-i386/drivers/video/geode/gx1fb_core.c
===================================================================
--- linux-2.6-i386.orig/drivers/video/geode/gx1fb_core.c	2005-02-15
10:33:59.000000000 +0000
+++ linux-2.6-i386/drivers/video/geode/gx1fb_core.c	2005-02-15
13:53:56.244807541 +0000
@@ -139,7 +139,7 @@
 	return 0;
 }

-static int gx1fb_blank(int blank_mode, const struct fb_info *info)
+static int gx1fb_blank(int blank_mode, struct fb_info *info)
 {
 	struct geodefb_par *par = info->par;

@@ -174,7 +174,7 @@
 	if ((fb_len = gx1_frame_buffer_size()) < 0)
 		return -ENOMEM;
 	info->fix.smem_len = fb_len;
-	info->screen_base = (unsigned char *)ioremap(info->fix.smem_start,
info->fix.smem_len);
+	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
 	if (!info->screen_base)
 		return -ENOMEM;

@@ -269,7 +269,7 @@
 int __init gx1fb_init(void)
 {
 	struct fb_info *info;
-        struct geodefb_par *par;
+	struct geodefb_par *par;
 	int ret;

 #ifndef MODULE
@@ -300,8 +300,8 @@
 		goto err;
 	}

-        /* Clear the frame buffer of garbage. */
-        memset(info->screen_base, 0, info->fix.smem_len);
+	/* Clear the frame buffer of garbage. */
+	memset_io(info->screen_base, 0, info->fix.smem_len);

 	gx1fb_check_var(&info->var, info);
 	gx1fb_set_par(info);
@@ -315,7 +315,7 @@

   err:
 	if (info->screen_base)
-		iounmap((void __iomem *)info->screen_base);
+		iounmap(info->screen_base);
 	if (par->vid_regs)
 		iounmap(par->vid_regs);
 	if (par->dc_regs)
@@ -330,7 +330,7 @@
 static void __exit gx1fb_cleanup(void)
 {
 	struct fb_info *info = gx1fb_info;
-        struct geodefb_par *par = gx1fb_info->par;
+	struct geodefb_par *par = gx1fb_info->par;

 	unregister_framebuffer(info);

Index: linux-2.6-i386/drivers/video/geode/video_cs5530.c
===================================================================
--- linux-2.6-i386.orig/drivers/video/geode/video_cs5530.c	2005-02-15
10:33:59.000000000 +0000
+++ linux-2.6-i386/drivers/video/geode/video_cs5530.c	2005-02-15
13:50:10.660522983 +0000
@@ -135,7 +135,7 @@
 	writel(dcfg, par->vid_regs + CS5530_DISPLAY_CONFIG);
 }

-static int cs5530_blank_display(const struct fb_info *info, int blank_mode)
+static int cs5530_blank_display(struct fb_info *info, int blank_mode)
 {
 	struct geodefb_par *par = info->par;
 	u32 dcfg;


-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
