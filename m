From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: 2.6.7mm5: switching from X to fbdev gives wrong vertical frequency
Date: Sun, 4 Jul 2004 23:47:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407042347.53584.adaplas@hotpop.com>
References: <20040704133625.GA30035@middle.of.nowhere>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bh9Ds-0000gU-P8
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 08:48:08 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bh9Ct-0005S4-WC
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 08:48:08 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id 8D551FDF570
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  4 Jul 2004 15:27:13 +0000 (UTC)
In-Reply-To: <20040704133625.GA30035@middle.of.nowhere>
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
To: Jurriaan <thunder7@xs4all.nl>, linux-fbdev-devel@lists.sourceforge.net

On Sunday 04 July 2004 21:36, Jurriaan wrote:
> I boot my kernel like this:
>
> kernel /boot/vmlinuz-267mm5 root=/dev/md3 video=radeonfb:1600x1200-16@85
> softrepeat=1
>
> and that works fine in 2.6.7-mm5 with Davids 16bpp copyarea fix.
>
> XFree also works fine (latest debian version:)
>
> xfree86-common 4.3.0.dfsg.1-5 X Window System (XFree86) infrastructure
> xserver-xfree8 4.3.0.dfsg.1-5 the XFree86 X server
>
> In 2.6.7 both worked fine, and I could switch from X to fb and back
> without any problem. Now, when I switch from X to fb, my 85 Hz refresh
> is changed to 60. That looks really awful.
>

Can you try this patch?

Tony

diff -Naur linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c linux-2.6.7-mm5/drivers/video/console/fbcon.c
--- linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c	2004-07-04 23:34:29.873322872 +0800
+++ linux-2.6.7-mm5/drivers/video/console/fbcon.c	2004-07-04 23:36:18.169859296 +0800
@@ -1679,8 +1679,7 @@
 	var.yres = height * fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
-	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh) ||
-	    (info->flags & FBINFO_MISC_MODESWITCH)) {
+	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) {
 		char mode[40];
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
@@ -1695,12 +1694,9 @@
 			return -EINVAL;
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		if (CON_IS_VISIBLE(vc)) {
-			var.activate = FB_ACTIVATE_NOW |
-				(info->flags & FBINFO_MISC_MODESWITCH) ?
-				FB_ACTIVATE_FORCE : 0;
+			var.activate = FB_ACTIVATE_NOW;
 			fb_set_var(info, &var);
 		}
-		info->flags &= ~FBINFO_MISC_MODESWITCH;
 	}
 	updatescrollmode(p, info, vc);
 	return 0;
@@ -1752,6 +1748,13 @@
 	}
 
  	fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+
+	if (info->flags & FBINFO_MISC_MODESWITCH &&
+		info->fbops->fb_set_par) {
+		info->fbops->fb_set_par(info);
+	}
+	info->flags &= ~FBINFO_MISC_MODESWITCH;
+
 	switch (p->scrollmode) {
 	case SCROLL_WRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
