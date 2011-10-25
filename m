From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Oct 2011 11:15:41 +0000
Subject: Re: fb_setcolreg(), CNVT_TOHW() and chan_to_field()
Message-Id: <CAMuHMdXEnRu_v8cs6UkuNmjk9-p1UgNxWSkQcj_2N5D=PUNsWA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111025073349.GB6027@debian>
In-Reply-To: <20111025073349.GB6027@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Tue, Oct 25, 2011 at 09:34, Rabin Vincent <rabin@rab.in> wrote:
> I'm trying to figure out the best way to implement fb_setcolreg() for
> FB_VISUAL_TRUECOLOR.

FB_VISUAL_TRUECOLOR implies the colormap is read-only.
Perhaps you meant FB_VISUAL_DIRECTCOLOR?

> 14 or so drivers copy/paste the CNVT_TOHW from skeletonfb.c:
>
>  #define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
>  ...
>  red = CNVT_TOHW(red, info->var.red.length);
>
> Another 18 or so drivers copy/paste a chan_to_field() function which has
> a straightforward shift:
>
>  static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
>  {
>        chan &= 0xffff;
>        chan >>= 16 - bf->length;
>        return chan << bf->offset;
>  }
>  ...
>  val = chan_to_field(red, &info->var.red);
>
> Both methods return similar values, except that with CNVT_TOHW() the
> extreme values seem to have a smaller range than the other values, while
> with the chan_to_field() shift all the values have an equal range.
>
> What's the reason behind choosing one over the other?  Could/should a
> common function be provided for all the drivers to use?

The idea is to use the full dynamic range of the 16-bit values. I.e. 'all ones'
in the hardware-specific value should map to 'all ones' in the 16-bit expanded
value. So the macros are preferred.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
