From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fb rotation 2.6.x
Date: Wed, 16 Mar 2005 07:47:20 +0800
Message-ID: <200503160747.20530.adaplas@hotpop.com>
References: <20050315085827.56051.qmail@web53603.mail.yahoo.com> <200503160450.48352.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBLn8-0005Ar-OE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 15:49:38 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DBLn8-0002Nz-4f
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Mar 2005 15:49:38 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 0FF8F14B25A9
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Mar 2005 23:49:04 +0000 (UTC)
In-Reply-To: <200503160450.48352.adaplas@hotpop.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Komal Shah <komal_shah802003@yahoo.com>

On Wednesday 16 March 2005 04:50, Antonino A. Daplas wrote:
> On Tuesday 15 March 2005 16:58, Komal Shah wrote:
>
> Sometimes people use multiple fbdevs mapped to different consoles, so a
> set_par() is called for each fb_info mapped for each console.
>
> I guess I can add an "already_initialized" flag so fbcon doesn't do
> multiple set_pars().
>

>
> What fields do you use in var that is important for rotation? Is it
> var->rotate? If that is the case, just add those fields in struct display
> in fbcon.h, and update the functions display_to_var() and var_to_display()
> in fbcon.c to also include the said fields.

Try the attached patch.  It adds var->rotate to the set of parameters saved
by fbcon.  The patch also includes minimizing the number of set_pars done
during init.  Let me know if there are still set_pars that escaped.

BTW, the patch is against my tree, but it should apply reasonably well to
any recent 2.6 kernel + a few rejects which you can easily apply by hand.

Tony

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-11-21 22:54:54 +08:00
+++ b/drivers/video/console/fbcon.c	2005-03-16 07:39:24 +08:00
@@ -599,9 +599,10 @@
 
 	ops->currcon = fg_console;
 
-	if (info->fbops->fb_set_par)
+	if (info->fbops->fb_set_par && !(ops->flags & FBCON_FLAGS_INIT))
 		info->fbops->fb_set_par(info);
 
+	ops->flags |= FBCON_FLAGS_INIT;
 	ops->graphics = 0;
 
 	if (vc)
@@ -703,6 +704,7 @@
 	disp->green = var->green;
 	disp->blue = var->blue;
 	disp->transp = var->transp;
+	disp->rotate = var->rotate;
 	disp->mode = fb_match_mode(var, &info->modelist);
 	if (disp->mode == NULL)
 		/* This should not happen */
@@ -726,6 +728,7 @@
 	var->green = disp->green;
 	var->blue = disp->blue;
 	var->transp = disp->transp;
+	var->rotate = disp->rotate;
 }
 
 static const char *fbcon_startup(void)
@@ -898,6 +901,7 @@
 static void fbcon_init(struct vc_data *vc, int init)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops;
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
 	struct display *t, *p = &fb_display[vc->vc_num];
@@ -948,6 +952,8 @@
 	new_cols = info->var.xres / vc->vc_font.width;
 	new_rows = info->var.yres / vc->vc_font.height;
 	vc_resize(vc, new_cols, new_rows);
+
+	ops = info->fbcon_par;
 	/*
 	 * We must always set the mode. The mode of the previous console
 	 * driver could be in the same resolution but we are using different
@@ -955,10 +961,14 @@
 	 *
 	 * We need to do it in fbcon_init() to prevent screen corruption.
 	 */
-	if (CON_IS_VISIBLE(vc) && info->fbops->fb_set_par)
-		info->fbops->fb_set_par(info);
+	if (CON_IS_VISIBLE(vc)) {
+		if (info->fbops->fb_set_par && 
+		    !(ops->flags & FBCON_FLAGS_INIT))
+			info->fbops->fb_set_par(info);
+		ops->flags |= FBCON_FLAGS_INIT;
+	}
 
-	((struct fbcon_ops *) info->fbcon_par)->graphics = 0;
+	ops->graphics = 0;
 
 	if ((cap & FBINFO_HWACCEL_COPYAREA) &&
 	    !(cap & FBINFO_HWACCEL_DISABLED))
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2004-11-21 22:26:19 +08:00
+++ b/drivers/video/console/fbcon.h	2005-03-16 07:39:24 +08:00
@@ -18,6 +18,8 @@
 
 #include <asm/io.h>
 
+#define FBCON_FLAGS_INIT 1
+
    /*
     *    This is the interface between the low-level console driver and the
     *    low-level frame buffer device
@@ -41,6 +43,7 @@
     u32 grayscale;
     u32 nonstd;
     u32 accel_flags;
+    u32 rotate;
     struct fb_bitfield red;
     struct fb_bitfield green;
     struct fb_bitfield blue;
@@ -68,6 +71,7 @@
 	int    cursor_reset;
 	int    blank_state;
 	int    graphics;
+	int    flags;
 	char  *cursor_data;
 };
     /*




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
