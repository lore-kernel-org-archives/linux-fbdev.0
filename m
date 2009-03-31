From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: fix color component field length documentation
Date: Tue, 31 Mar 2009 09:18:09 +0200
Message-ID: <10f740e80903310018v7e12de88m696f07e40dc617e3@mail.gmail.com>
References: <20090330220007.GC6540@spock.one.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754442AbZCaHSY@vger.kernel.org>
In-Reply-To: <20090330220007.GC6540@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: spock@gentoo.org
Cc: linux-kernel@vger.kernel.org, Krzysztof Helt <krzysztof.h1@poczta.fm>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, linux-fbdev-devel@lists.sourceforge.net

On Tue, Mar 31, 2009 at 00:00, Michal Januszewski <spock@gentoo.org> wr=
ote:
> The documentation about the meaning of the color component bitfield l=
engths
> in pseudocolor modes is inconsistent. =C2=A0Fix it, so that it indica=
tes the
> correct interpretation everywhere, i.e. that the 1 << length is the n=
umber
> of palette entries.
>
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
> Cc: Ville Syrj=C3=A4l=C3=A4 <syrjala@sci.fi>
> Cc: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Except for this:

> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -172,8 +172,11 @@ struct fb_fix_screeninfo {
> =C2=A0/* Interpretation of offset for color fields: All offsets are f=
rom the right,
> =C2=A0* inside a "pixel" value, which is exactly 'bits_per_pixel' wid=
e (means: you
> =C2=A0* can use the offset as right argument to <<). A pixel afterwar=
ds is a bit
> - * stream and is written to video memory as that unmodified. This im=
plies
> - * big-endian byte order if bits_per_pixel is greater than 8.
> + * stream and is written to video memory as that unmodified.
> + *
> + * For pseudocolor, offset is always 0 and length, which should be t=
he same
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is not correct. Offset can be non-zero, e.g. for a 8 bpp frame buf=
fer with
64 palette entries, where the palette index is stored in the upper 6 bi=
ts of the
8-bit pixel value, offset would be 2, and length would be 6.
Not that I've seen that (so far)...

> + * for all color components, indicates the number of available palet=
te entries
> + * (i.e. # of entries =3D 1 << length).
> =C2=A0*/
> =C2=A0struct fb_bitfield {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 offset; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* beginning of bitfield =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*/
>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
