From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Nov 2013 08:41:56 +0000
Subject: Re: [PATCH] RFC: framebuffer: provide generic get_fb_unmapped_area
Message-Id: <CAMuHMdWJy_0GXSr=2cL9=NtiAadvkq47WPdEt-hfkWwqeW5m1Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384772231-20993-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAMuHMdWtrSnTHNN-7GtMWAG9gZ0HJ3ZgVZt6Cfc=q=e-5Sr-Qw@mail.gmail.com>
 <20131118185959.GE19318@pengutronix.de>
In-Reply-To: <20131118185959.GE19318@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 18, 2013 at 7:59 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>> > +unsigned long fb_get_unmapped_area(struct file *filp, unsigned long o=
rig_addr,
>> > +               unsigned long len, unsigned long pgoff, unsigned long =
flags)
>> > +{
>> > +       struct fb_info * const info =3D filp->private_data;
>> > +       unsigned long screen_size =3D info->screen_size ?: info->fix.s=
mem_len;
>>
>> Why restrict this to screen_size? Fbtest will map the whole frame buffer=
 memory.
> For me screen_size is zero. The logic to determine the size is copied
> from fb_read.

fb_read() only allows reading the visible screen, not the full frame
buffer memory.
fb_mmap() does allow mapping the full frame buffer memory (and the optional
MMIO registers, but you can't easily do that the same way on nommu, as it's
a discontiguous mapping).
So please use PAGE_ALIGN(info->fix.smem_len) as the limit.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
