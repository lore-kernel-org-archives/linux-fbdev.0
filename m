From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Date: Wed, 19 Aug 2015 08:11:39 +0000
Subject: Re: omapdss: Division by zero in kernel
Message-Id: <20150819081139.GB15712@pali>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201507241803.42891@pali>
 <CAHnt0GX6442mtZ=J6CS_60TyTeUu==oROcf4Y=upHGSr71X3EA@mail.gmail.com>
In-Reply-To: <CAHnt0GX6442mtZ=J6CS_60TyTeUu==oROcf4Y=upHGSr71X3EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>, omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

On Tuesday 18 August 2015 07:11:27 Peter Teoh wrote:
> On Fri, Jul 24, 2015 at 9:03 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
> >
> > Hello,
> >
> > when on N900 (real HW or qemu) I run this command
> >
> > / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo 0 > /sys/class/graphics/fb0/size
> >
> > then kernel crash with this error message
> >
> > / # [   29.904113] Division by zero in kernel.
> > ** 3375 printk messages dropped ** [   29.963836] [<c01e0008>] (__aeabi_uidivmod) from [<c022071c>]
> > (cfb_imageblit+0xac/0x464)
> > ** 8426 printk messages dropped ** [   30.111083] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 8380 printk messages dropped ** [   30.258209] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 7813 printk messages dropped ** [   30.400054] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 7666 printk messages dropped ** [   30.538391] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 7687 printk messages dropped ** [   30.676544] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 7960 printk messages dropped ** [   30.819915] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 8317 printk messages dropped ** [   30.966979] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 8590 printk messages dropped ** [   31.122528] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 8885 printk messages dropped ** [   31.287658] [<c0218ed0>] (fbcon_scroll) from [<c025af90>] (scrup+0x60/0x128)
> > ** 9408 printk messages dropped ** [   31.461425] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 9787 printk messages dropped ** [   31.644287] [<c02187e8>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10081 printk messages dropped ** [   31.833984] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10501 printk messages dropped ** [   32.031066] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10816 printk messages dropped ** [   32.233001] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10900 printk messages dropped ** [   32.440490] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10837 printk messages dropped ** [   32.645233] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10837 printk messages dropped ** [   32.848999] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10837 printk messages dropped ** [   33.053833] [<c02187a4>] (fbcon_redraw.isra.12) from [<c0218ed0>]
> > (fbcon_scroll+0x6a0/0xcbc)
> > ** 10838 printk messages dropped ** [   33.258361] [<c0218ed0>] (fbcon_scroll) from [<c025af90>] (scrup+0x60/0x128)
> >
> > I suspect that problem is in omapdss.
> >
> > I do not know if size 0 make sense, but Maemo userspace is calling above
> > commands and on Nokia's 2.6.28 kernel there is no crash or error message.
> >
> > IMHO Division by zero in kernel should not be there even if userspace
> > call "incorrect" command.
> >
> > --
> > Pali Rohár
> > pali.rohar@gmail.com
> 
> 
> 
> Not sure if my analysis is correct.   According to the recent pull
> (4.2.0-rc4+), the code is still vulnerable to this division by zero:
> 
> Inside drivers/video/fbdev/core/cfbimgblt.c:
> 
> void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
> {
>         u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
>         u32 bpl = sizeof(u32), bpp = p->var.bits_per_pixel;
>         u32 width = image->width;
>         u32 dx = image->dx, dy = image->dy;
>         u8 __iomem *dst1;
> 
>         if (p->state != FBINFO_STATE_RUNNING)
>                 return;
> 
>         bitstart = (dy * p->fix.line_length * 8) + (dx * bpp);
>         start_index = bitstart & (32 - 1);
>         pitch_index = (p->fix.line_length & (bpl - 1)) * 8;
> 
>         bitstart /= 8;
>         bitstart &= ~(bpl - 1);
>         dst1 = p->screen_base + bitstart;
> 
>         if (p->fbops->fb_sync)
>                 p->fbops->fb_sync(p);
> 
>         if (image->depth = 1) {
>                 if (p->fix.visual = FB_VISUAL_TRUECOLOR ||
>                     p->fix.visual = FB_VISUAL_DIRECTCOLOR) {
>                         fgcolor = ((u32*)(p->pseudo_palette))[image->fg_color];
>                         bgcolor = ((u32*)(p->pseudo_palette))[image->bg_color];
>                 } else {
>                         fgcolor = image->fg_color;
>                         bgcolor = image->bg_color;
>                 }
> 
>                 if (32 % bpp = 0 && !start_index && !pitch_index &&
>                     ((width & (32/bpp-1)) = 0) &&
>                     bpp >= 8 && bpp <= 32)
>                         fast_imageblit(image, p, dst1, fgcolor, bgcolor);
>                 else
>                         slow_imageblit(image, p, dst1, fgcolor, bgcolor,
>                                         start_index, pitch_index);
>         } else
>                 color_imageblit(image, p, dst1, start_index, pitch_i
> 
> 
> Notice that bpp is not checked for zero, and thus bpp=0 is totally
> feasible?   resulting in 32/bpp crashing the kernel?
> 

Hm... this could really be a problem! But how to patch it? Which branch
should be called (fast_ or slow_ function) if bpp is zero?

And is there some way to force kernel to dump backtrace into dmesg when
division by zero occur?

-- 
Pali Rohár
pali.rohar@gmail.com
