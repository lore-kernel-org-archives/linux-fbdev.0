From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] [BK fbdev updates]
Date: 03 Nov 2002 16:40:00 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1036312836.615.15.camel@daplas>
References: <Pine.LNX.4.33.0211011524270.11313-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0211011524270.11313-100000@maxwell.earthlink.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-11-02 at 07:29, James Simmons wrote:
> 
> > James,
> >
> > I tried the patch, and it does produce a cleaner and smaller driver.
> > Overall, I like it. Some observations:
> >
> > 1. Without the fb_set_var() hook, switching from X messes up the
> > console.  I would guess this will be addressed by the console?
> 
> fbcon_switch has to be rewritten. I'm going threw the process of cleaning
> up the upper fbcon layer. Its such a mess. Yuck!!!
> 
> > 2. Console panning/wrapping does not work.  updatevar includes a check
> > "if (con == info->currcon)", and my guess is info->currcon is obsoleted
> > so the check always fails.
> 
> It worked before. Strange. Do you mean for you console panning doesn't
> work on the visiable VC or a non visible VC?
> 

Adding update_var to fbcon_switch fixes #1 and #2 for me.  Attached is a
diff.

Also, using fbset to change video modes corrupts the console.  Looking
at the code, the flow of control is from the console to fbdev only?  Is
this correct?  I agree with this, it's saner.

Tony

diff -Naur linux/drivers/video/console/fbcon.c linux-2.5.45-fbdev/drivers/video/console/fbcon.c
--- linux/drivers/video/console/fbcon.c	Sun Nov  3 08:19:32 2002
+++ linux-2.5.45-fbdev/drivers/video/console/fbcon.c	Sun Nov  3 08:18:56 2002
@@ -1604,8 +1604,6 @@
     scrollback_max = 0;
     scrollback_current = 0;
 
-    update_var(unit, info);
-
     if (p->dispsw->clear_margins && vt_cons[unit]->vc_mode == KD_TEXT)
 	p->dispsw->clear_margins(conp, p, 0);
     if (logo_shown == -2) {
   
