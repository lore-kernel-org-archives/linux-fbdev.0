From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH][FBCON]: Mode Switch in fbcon_blank()
Date: Sun, 4 Jul 2004 23:47:46 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407042347.46226.adaplas@hotpop.com>
References: <200406301047.57423.adaplas@hotpop.com> <1088564019.1922.12.camel@gaston> <cc3d6r$d5v$1@sea.gmane.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bh9Dr-0000g3-8x
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 08:48:07 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bh9Cr-00029o-LM
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 08:48:07 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 5DFCA66E11E
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  4 Jul 2004 15:03:26 +0000 (UTC)
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
To: Javier Marcet <javier-ml-gmane@marcet.info>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, David Eger <eger@havoc.gtf.org>

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

Jurriaan's problem told me that I'm probably over-engineering the mode switch
code. Perhaps the ugly workaround patch is not necessary.  All that is needed
is to bypass fbcon_resize() and just do a simple set_par().

David, Javier, can you try the patch below?  Reverse the one with the big
HACK ALERT comment first.  If it works for you two, the code just became
simpler.

Tony

Signed-off-by: Antonino A. Daplas <adaplas@pol.net>

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
