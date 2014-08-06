From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 06 Aug 2014 12:48:23 +0000
Subject: Re: [PATCH] video/fbdev: Always built-in video= cmdline parsing
Message-Id: <20140806124823.GE8727@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407312512-6533-1-git-send-email-daniel.vetter@ffwll.ch>
 <1407318226-23169-1-git-send-email-daniel.vetter@ffwll.ch>
 <CAMuHMdUmy=PLh_z=D9S=oj2dxG74sXC-3_-7V8PCQgNMLz8ngQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUmy=PLh_z=D9S=oj2dxG74sXC-3_-7V8PCQgNMLz8ngQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Plagniol-Villard <plagnioj@jcrosoft.com>

On Wed, Aug 06, 2014 at 12:27:32PM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 6, 2014 at 11:43 AM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > In drm/i915 we want to get at the video= cmdline modes even when we
> > don't have fbdev support enabled, so that users can always override
> > the kernel's initial mode selection.
> >
> > But that gives us a direct depency upon the parsing code in the fbdev
> > subsystem. Since it's so little code just extract these 2 functions
> > and always build them in.
> 
> How much is "so little"? Think memory-constrained systems.
> 
> You can still build it depending on CONFIG_FB or CONFIG_DRM_I915.

I'll do it as an option selected by FB and DRM then.
> 
> > diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
> > index fa306538dac2..891c1f890e03 100644
> > --- a/drivers/video/fbdev/core/Makefile
> > +++ b/drivers/video/fbdev/core/Makefile
> > @@ -1,4 +1,4 @@
> > -obj-y                             += fb_notify.o
> 
> Oh, this is already unconditional. Who are its users?

Welcome in fbdev-land. Not going to fix this, since my dragon-slaying
sword is already broken.

> 
> > +obj-y                             += fb_notify.o fb_cmdline.o
> >  obj-$(CONFIG_FB)                  += fb.o
> >  fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
> >                                       modedb.o fbcvt.o
> > diff --git a/drivers/video/fbdev/core/fb_cmdline.c b/drivers/video/fbdev/core/fb_cmdline.c
> > new file mode 100644
> > index 000000000000..91503a43213e
> > --- /dev/null
> > +++ b/drivers/video/fbdev/core/fb_cmdline.c
> > @@ -0,0 +1,103 @@
> > +/*
> > + *  linux/drivers/video/fb_cmdline.c
> > + *
> > + *  Copyright (C) 2014 Intel Corp
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file COPYING in the main directory of this archive
> > + * for more details.
> > + *
> > + * Authors:
> > + *    Vetter <danie.vetter@ffwll.ch>
> > + */
> 
> The above chunk doesn't sound appropriate for extracting existing code...

Well it all horribly predates git history, so no idea who actually wrote
this. I'll copy over the old header on top.
-Daniel
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
