From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH][FBCON]: Mode Switch in fbcon_blank()
Date: Fri, 2 Jul 2004 23:37:20 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407022337.20156.adaplas@hotpop.com>
References: <200406301047.57423.adaplas@hotpop.com> <1088564019.1922.12.camel@gaston> <cc3d6r$d5v$1@sea.gmane.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgQ5p-0005Sv-MO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 08:36:49 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BgQ5p-0006Zz-4K
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Jul 2004 08:36:49 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id CCEA7FD7CCF
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  2 Jul 2004 15:18:02 +0000 (UTC)
In-Reply-To: <cc3d6r$d5v$1@sea.gmane.org>
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
To: Javier Marcet <javier-ml-gmane@marcet.info>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Friday 02 July 2004 18:25, Javier Marcet wrote:
> Benjamin Herrenschmidt wrote:
> >> As we've discussed in another thread, below is a diff that will do a
> >> set_par() as late as possible when there is KD_TEXT<->KD_GRAPHICS
> >> switch.  The set_par() will be forced in fbcon_resize() instead.
> >>
> >> Not sure if this has repercussions with the other drivers, but this
> >> patch fixed the X nv driver hanging when switching to the console. (I
> >> believe the crash is actually caused by an early set_par() -- while in
> >> fbcon_blank. Removing the set_par in fbcon_blank fixed the hang but
> >> caused cursor sprite and display corruption).
> >
> > Well... I don't know. It seem to work, so it's probably an acceptable
> > workaround, but I'd like to find out what's wrong with doing it in blank
> > precisely (that is what is the bug in XFree or in the kernel VT), since
> > it's shared by many X drivers, I don't suppose it's a bug in them.
>
> This was included in 2.6.7-mm5 -that's how I noticed it- and I had to
> revert it.
>
> I use radeonfb and when switching from X to console my two monitors will
> go out of sync. The VT is actually there since I can type on it, but I
> can't see anything on neither of my two monitors :(

Grr, I was a little tentative about this patch, hoping against hope that it
will work for all drivers, but you've proven me wrong.  Anyway, we now have
at least 2 drivers that requires reinitialization at different stages, radeonfb
requires it at fbcon_blank() and rivafb at fbcon_switch().  And I really don't
know how to fix it except to look closely at X (and I dread looking at X's code...)
and the VT code (ditto).

Can you try the patch below?  It works for the rivafb, hopefully it works for yours.

Andrew,

This patch is ugly as sin but I can't find a good solution without hacking X or
the vt system.  I've included a big fat comment describing the ugliness.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

Ugly workaround.  When switching from KD_GRAPHICS to KD_TEXT, the 
event is captured at fbcon_blank() allowing fbcon to reinitialize the hardware.
However, some hardware requires the reinitialization to be done immediately,
others require it to be done later.  Others may need it to be done immediately
and later, this is the worst case. 

diff -Naur linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c linux-2.6.7-mm5/drivers/video/console/fbcon.c
--- linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c	2004-07-02 15:09:02.132667752 +0000
+++ linux-2.6.7-mm5/drivers/video/console/fbcon.c	2004-07-02 15:12:29.935076984 +0000
@@ -1802,8 +1802,31 @@
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 
-	if (mode_switch)
-		info->flags |= FBINFO_MISC_MODESWITCH;
+	if (mode_switch) {
+		struct fb_var_screeninfo var = info->var;
+
+/* 
+ * HACK ALERT: Some hardware will require reinitializion at this stage,
+ *             others will require it to be done as late as possible.
+ *             For now, we differentiate this with the 
+ *             FBINFO_MISC_MODESWITCHLATE bitflag.  Worst case will be
+ *             hardware that requires it here and another one later.
+ *             A definitive solution may require fixing X or the VT
+ *             system.
+ */
+		if (info->flags & FBINFO_MISC_MODESWITCHLATE)
+			info->flags |= FBINFO_MISC_MODESWITCH;
+
+		if (blank) {
+		    fbcon_cursor(vc, CM_ERASE);
+		    return 0;
+		}
+
+		if (!(info->flags & FBINFO_MISC_MODESWITCHLATE)) {
+			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
+			fb_set_var(info, &var);
+		}
+	}
 
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 
diff -Naur linux-2.6.7-mm5-orig/drivers/video/riva/fbdev.c linux-2.6.7-mm5/drivers/video/riva/fbdev.c
--- linux-2.6.7-mm5-orig/drivers/video/riva/fbdev.c	2004-07-02 15:08:39.130164664 +0000
+++ linux-2.6.7-mm5/drivers/video/riva/fbdev.c	2004-07-02 15:12:27.322474160 +0000
@@ -1681,7 +1681,8 @@
 		    | FBINFO_HWACCEL_YPAN
 		    | FBINFO_HWACCEL_COPYAREA
 		    | FBINFO_HWACCEL_FILLRECT
-		    | FBINFO_HWACCEL_IMAGEBLIT;
+		    | FBINFO_HWACCEL_IMAGEBLIT
+	            | FBINFO_MISC_MODESWITCHLATE;
 	info->var = rivafb_default_var;
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
diff -Naur linux-2.6.7-mm5-orig/include/linux/fb.h linux-2.6.7-mm5/include/linux/fb.h
--- linux-2.6.7-mm5-orig/include/linux/fb.h	2004-07-02 15:09:17.062398088 +0000
+++ linux-2.6.7-mm5/include/linux/fb.h	2004-07-02 15:12:31.318866616 +0000
@@ -533,6 +533,7 @@
 #define FBINFO_MISC_MODECHANGEUSER     0x10000 /* mode change request
 						  from userspace */
 #define FBINFO_MISC_MODESWITCH         0x20000 /* mode switch */
+#define FBINFO_MISC_MODESWITCHLATE     0x40000 /* init hardware later */
 
 struct fb_info {
 	int node;
 




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
