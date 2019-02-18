From: Finn Thain <fthain@telegraphics.com.au>
Date: Mon, 18 Feb 2019 22:37:29 +0000
Subject: Re: [RFC] video/macfb: Wire up inverse option
Message-Id: <alpine.LNX.2.21.1902190905020.14@nippy.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdWVERvgpC0uTSg9A70b3k6p=zD5BQY=Est6Tb-18x3EGA@mail.gmail.com>
In-Reply-To: <CAMuHMdWVERvgpC0uTSg9A70b3k6p=zD5BQY=Est6Tb-18x3EGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, 18 Feb 2019, Geert Uytterhoeven wrote:

> >
> > I did some more investigation. When I tested macfb in qemu, I found 
> > that dafb_setpalette() is actually being called.
> >
> > And with this patch to add the missing call to fb_invert_cmaps(), the 
> > dafb_setpalette() parameters change accordingly. So I'll submit this 
> > patch again with signed-off-by.
> >
> > (The problem remains that dafb_setpalette() doesn't seem to have the 
> > desired effect on the hardware, but that's a separate issue.)
> 
> Could it be the hardware CLUT pointer is out of sync? Given lastreg is 
> initialized to -1, if the first write is to regno 0, the code will 
> assume the CLUT pointer is pointing to the right register.
> 
> Initializing lastreg to e.g. -2 would fix that.
> 

Well, Stan found that the 'inverse' option didn't work on his LC III, 
which involves v8_brazil_setpalette() and not dafb_setpalette(). The bug 
you found only affects the latter function. I will send a patch for the 
bug though it doesn't seem to help on qemu (quadra 800). On qemu I was 
able to get 'inverse' to work by switching to 2 bpp. So there seems to be 
some other driver issue at work here that I'll have to look into.

> > On some powerbooks with greyscale LCD panels, the the black background 
> > is actually white, due to the backlight, and the white text is opaque 
> > black. This may or may not be optimal, depending on conditions etc. so 
> > I prefer not to remove macfb's 'inverse' option.
> 
> You can always use a higher layer to configure that, e.g. "setterm 
> --inversescreen on".  Won't help for the initial kernel log, though.
> 
> Originally (before git history), the inverse parameter also affected 
> display.inverse.  While this field still exists (see fbcon.h), there is 
> no code left that uses it.
> 
> The last user was removed in full-history-linux commit 25e5e3c795bcf408 
> ("[PATCH] fbdev: support for bold attribute for monochrome 
> framebuffers").
> 
> Probably reviving that, and getting rid of the fb_invert_cmaps() calls, 
> is the best solution, as display.inverse does not affect other frame 
> buffers.
> 

Maybe. It seems like an enhancement, or at best a theoretical bug. Can I 
leave that one in your hands?

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
