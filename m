From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 4/5][RFC] fbdev: Clean up framebuffer
 initialization
Date: Sun, 5 Sep 2004 12:13:38 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0409051206180.28961@waterleaf.sonytel.be>
References: <200409041108.40276.adaplas@hotpop.com>
 <Pine.GSO.4.58.0409051113060.28961@waterleaf.sonytel.be>
 <200409051750.47987.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266513AbUIEKNv@vger.kernel.org>
In-Reply-To: <200409051750.47987.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Thomas Winischhofer <thomas@winischhofer.net>

On Sun, 5 Sep 2004, Antonino A. Daplas wrote:
> On Sunday 05 September 2004 17:16, Geert Uytterhoeven wrote:
> > On Sat, 4 Sep 2004, Antonino A. Daplas wrote:
> > > Currently, the framebuffer system is initialized in a roundabout manner.
> > > First, drivers/char/mem.c calls fbmem_init().  fbmem_init() will then
> > > iterate over an array of individual drivers' xxxfb_init(), then each
> > > driver registers its presence back to fbmem.  During console_init(),
> > > drivers/char/vt.c will call fb_console_init(). fbcon will check for
> > > registered drivers, and if any are present, will call take_over_console()
> > > in drivers/char/vt.c.
> > >
> > > This patch changes the initialization sequence so it proceeds in this
> > > manner: Each driver has its own module_init(). Each driver calls
> > > register_framebuffer() in fbmem.c. fbmem.c will then notify fbcon of the
> > > driver registration.  Upon notification, fbcon calls take_over_console()
> > > in vt.c.
> >
> > My main concern with this change is that it will be no longer possible to
> > change initialization order (and hence choose the primary display for
> > systems with multiple graphics adapters) by specifying `video=xxxfb' on the
> > kernel command line.
>
> I see your point.  But, can we use "fbcon=" setup options to choose which fb
> gets mapped to what console? We already have fbcon=map:<option> so we can
> choose which becomes the primary display. Granted the "fbcon=" setup is
> currently broken, but if fixed, will that be a fair compromise?

Yes, sounds fine.

Just thinking of something else: right now it's possible to disable a fbdev by
saying `video=xxxfb:off'. This can be useful if the fbdev driver doesn't work
with your hardware. After you change, individual fbdev drivers will have to
reimplement this theirselves in their __setup() functions.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
