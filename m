From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2.4.29-pre1] radeonfb: don't try to ioreamp the entire
 VRAM [was: Re: [Linux-fbdev-devel] why does radeonfb work fine in 2.6, but
 not in 2.4.29-pre1?]
Date: Thu, 2 Dec 2004 16:39:25 +0100 (MET)
Message-ID: <Pine.GSO.4.61.0412021634540.11183@waterleaf.sonytel.be>
References: <20041128184606.GA2537@middle.of.nowhere>
 <20041201161455.GA14817@dreamland.darkstar.lan>
 <Pine.GSO.4.61.0412011724010.26820@waterleaf.sonytel.be>
 <20041201203711.GA21008@dreamland.darkstar.lan>
 <Pine.GSO.4.61.0412012221420.2595@waterleaf.sonytel.be>
 <20041202152801.GA8868@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261648AbULBPjt@vger.kernel.org>
In-Reply-To: <20041202152801.GA8868@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thu, 2 Dec 2004, Kronos wrote:
> Il Wed, Dec 01, 2004 at 10:25:38PM +0100, Geert Uytterhoeven ha scritto: 
> > On Wed, 1 Dec 2004, Kronos wrote:
> > > Il Wed, Dec 01, 2004 at 05:25:52PM +0100, Geert Uytterhoeven ha scritto: 
> > > > > Make fb layer aware of the difference between the ioremap()'ed VRAM and
> > > > > total available VRAM.
> > > > > smem_len in struct fb_fix_screeninfo still contains the amount of
> > > > > physical VRAM (reported to userspace via FBIOGET_FSCREENINFO ioctl) and
> > > > > the new field mapped_vram contains the amount of VRAM actually
> > > > > ioremap()'ed by drivers (used in read/write/mmap operations).
> > > > > Since there was unused padding at the end of struct fb_fix_screeninfo
> > > > > binary compatibility with userspace utilities is retained.
> > > > > If mapped_vram is not set it's assumed that the entire framebuffer is
> > > > > mapped, thus other drivers are unaffected by this patch.
> > > > > 
> > > > > The patch has been tested by Jurriaan <thunder7@xs4all.nl>.
> > > > > 
> > > > > Signed-off-by: Luca Tettamanti <kronos@people.it>
> > > > > 
> > > > > --- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
> > > > > +++ b/include/linux/fb.h	2004-11-30 18:33:00.000000000 +0100
> > > > > @@ -126,7 +126,8 @@
> > > > >  					/* (physical address) */
> > > > >  	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
> > > > >  	__u32 accel;			/* Type of acceleration available */
> > > > > -	__u16 reserved[3];		/* Reserved for future compatibility */
> > > > > +	__u32 mapped_vram;		/* Amount of ioremap()'ed VRAM */
> > > > > +	__u16 reserved[1];		/* Reserved for future compatibility */
> > > > >  };
> > > > 
> > > > I don't really like this patch. mapped_vram doesn't matter for user space at
> > > > all, so it does not belong to fb_fix_screeninfo.
> > > 
> > > Hmm, it looked sensible to me since it's the max amount of data that
> > > userspace can read (or write) from /dev/fb%d.
> > 
> > That's not really a user space limitation, but a kernel `bug'.
> > 
> > I.e. it could be solved in the kernel if larger ioremap()s would be allowed, or
> > if some sliding window mapping would be used. User space shouldn't need to know
> > about this.
> 
> I see you point, but users see that their video board does not work if
> the system has 1GB (or more) of RAM and they aren't happy.
> With current VM split (ie. 1GB/3GB) and with that much RAM there's no
> space left to map the entire FB. And AFAIK VM hacking in 2.4 is not
> doable (not that I would be able to do it ;)
> 
> > > Putting mapped_vram in fb_info would be acceptable?
> > 
> > That would make sure this stays in-kernel, but my other reasoning stays the
> > same: it's some kind of kernel bug.
> 
> What about this one:
> 
> 
> Make fb layer aware of the difference between the ioremap()'ed VRAM and
> total available VRAM.
> smem_len in struct fb_fix_screeninfo contains the amount of physical
> VRAM (reported to userspace via FBIOGET_FSCREENINFO ioctl) while the new
> field mapped_vram in struct fb_info contains the amount of VRAM actually
> ioremap()'ed by drivers (used in read/write/mmap operations).
> If mapped_vram is not set it's assumed that the entire framebuffer is
> mapped, thus other drivers are unaffected by this patch.

Looks OK at first sight.

> --- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
> +++ b/include/linux/fb.h	2004-12-02 14:20:50.000000000 +0100
> @@ -323,6 +323,7 @@
>     struct fb_cmap cmap;                 /* Current cmap */
>     struct fb_ops *fbops;
>     char *screen_base;                   /* Virtual address */
> +   unsigned int mapped_vram;		/* ioremap()'ed VRAM */

But perhaps you want to make this unsigned long? I don't think it'll take long
before we'll see graphics cards with 4 GiB or more memory, and it would be good
if 64-bit platforms could take advantage of them.

Oh no, we already have __u32 smem_len in struct fb_fix_screeninfo :-(
So you can forget my comment about 64-bit above...

Hence, you best make it `u32' (this is kernel internal) for consistency.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
