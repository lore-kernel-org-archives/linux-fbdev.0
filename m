From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] fbcon scrolling + initialisation oddity
Date: 20 Jan 2003 09:29:38 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1043026112.988.4.camel@localhost.localdomain>
References: <20030119200340.A13758@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030119200340.A13758@flint.arm.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Mon, 2003-01-20 at 04:03, Russell King wrote:
> 1. YWRAP scrolling.
> 
> There appears to be something weird going on with fbcon scrolling in 2.5.59
> when using YWRAP.  The best example is what happens when scrolling a large
> file (say, /etc/termcap) in less.
> 
> While scrolling down in the file, the screen scrolls correctly for the
> most part.  At some point, the screen stops scrolling and the last line
> which normally displays the less prompt character ":" is replaced by
> the next line of text.  Continuing to scroll down produces no visible
> changes.
> 
> Once enough scrolling has occurred, suddenly the screen jumps and we get
> the proper text displayed.
> 
> Also, if you scroll line by line until the ":" is replaced by text as
> above, scrolling back up one line replaces the ":" and scrolling upwards
> scrolls the screen up correctly.
> 
> As an additional behaviour point, if you scroll down until the ":" just
> disappears and then some extra lines, hit 'q' to exit less, followed by
> ^L, most of the screen is cleared, except for the very top few lines.
> I haven't checked, but I suspect the number of lines left at the top of
> the screen is equal to the number of lines we're off the bottom of the
> screen.
> 

fb_pan_display() does not test for YWRAP.  Can you try this?

Tony

diff -Naur linux-2.5.59/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.59/drivers/video/fbmem.c	2003-01-20 01:10:12.000000000 +0000
+++ linux/drivers/video/fbmem.c	2003-01-20 01:14:27.000000000 +0000
@@ -724,11 +724,15 @@
 {
         int xoffset = var->xoffset;
         int yoffset = var->yoffset;
+	int ybottom = var->yoffset;
         int err;
 
+	if (!(var->vmode & FB_VMODE_YWRAP))
+		ybottom += info->var.yres;
+
         if (xoffset < 0 || yoffset < 0 || !info->fbops->fb_pan_display ||
             xoffset + info->var.xres > info->var.xres_virtual ||
-            yoffset + info->var.yres > info->var.yres_virtual)
+            ybottom > info->var.yres_virtual)
                 return -EINVAL;
 	if ((err = info->fbops->fb_pan_display(var, info)))
 		return err;
