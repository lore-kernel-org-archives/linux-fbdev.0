From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [BK fbdev updates]
Date: Fri, 1 Nov 2002 15:29:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0211011524270.11313-100000@maxwell.earthlink.net>
References: <1036178902.572.33.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1036178902.572.33.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> James,
>
> I tried the patch, and it does produce a cleaner and smaller driver.
> Overall, I like it. Some observations:
>
> 1. Without the fb_set_var() hook, switching from X messes up the
> console.  I would guess this will be addressed by the console?

fbcon_switch has to be rewritten. I'm going threw the process of cleaning
up the upper fbcon layer. Its such a mess. Yuck!!!

> 2. Console panning/wrapping does not work.  updatevar includes a check
> "if (con == info->currcon)", and my guess is info->currcon is obsoleted
> so the check always fails.

It worked before. Strange. Do you mean for you console panning doesn't
work on the visiable VC or a non visible VC?

> 3. fbdev can be loaded without taking over the console.  After running
> an fb-based application, exiting fbdev messes up the vga console
> (actually hangs the system).  Should the fbdev driver provide the
> capability to restore the VGA state then, ie at info->fb_release?

Yes!!! Of course there is the issue is the framebuffer that actual one
used for vgacon or is it independent, thinking multihead here.

> 4. The initial font loaded is 8x8. It seems that 8x16 fonts are limited
> for the SGI console console only.  Any reason why?

I have no idea why that is. You can select a differnt font.

> 5.  The cfb_* drawing functions still behave erratically, especially in
> emacs.  Geert has made some versions that work correctly for me.  This
> was discussed in a thread sometimes ago.

Where are the patchs. I like to incorporate them into BK.

> Attached is a diff that will allow the logo to be drawn at 8-bpp
> pseudocolor:

Applied.
