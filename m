From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Fix 8bpp RGB fields length
Date: Mon, 30 Mar 2009 00:18:19 +0300
Message-ID: <20090329211819.GX10127@sci.fi>
References: <20090301215556.8631c63c.krzysztof.h1@poczta.fm>
	<20090302130202.GA6298@sci.fi>
	<20090302180239.f6e67497.krzysztof.h1@poczta.fm>
	<5d9b736f0903291214r7e8cb250l432307d80deb5a35@mail.gmail.com>
	<10f740e80903291226m68689d51vf8b52a2e3beb9cf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1Lo2Op-00030V-RZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Mar 2009 21:18:35 +0000
Received: from smtp6.welho.com ([213.243.153.40])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lo2Of-0004oq-Mp for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Mar 2009 21:18:30 +0000
Content-Disposition: inline
In-Reply-To: <10f740e80903291226m68689d51vf8b52a2e3beb9cf2@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Michal Januszewski <michalj@gmail.com>

On Sun, Mar 29, 2009 at 09:26:02PM +0200, Geert Uytterhoeven wrote:
> On Sun, Mar 29, 2009 at 21:14, Michal Januszewski <michalj@gmail.com> wro=
te:
> > On Mon, Mar 2, 2009 at 19:02, Krzysztof Helt <krzysztof.h1@poczta.fm> w=
rote:
> > A slight omission in the fbdev API I suppose since the LUT entries are
> >>> nearly always 3*8bits wide. VGA being the exception.
> >>
> >> If offsets of all RGB components are the same the length field says
> >> how lone the pallete index is. It does not say anything how long
> >> the LUT entries are. This is the same misunderstanding as done
> >> inside the driver.
> >
> > Where is this meaning of the length field defined? =A0While I agree
> > that interpreting it as the length of the palette seems to make
> > more sense (considering the current FB API), there are several
> > places in the fbdev code contradicting this interpretation
> > (comments in skeletonfb.c, vfb.c, code in vga16fb.c, ..).
> =

> Originally it was the width of the color component in the DAC, i.e. 6
> for VGA with 18 bit color palettes.
> Later is was redefined to be the width of the bitfield in the pixel
> data, for consistency with
> other visuals (pseudocolor is directcolor where the R, G, B, and A
> bitfields overlap),
> and to handle hardware where the number of palette entries is not 1 << bpp
> (e.g. 64 colors in 8 bpp packed pixels).
> =

> That's why vfb.c has an (obsolete) comment:
> =

>          * Pseudocolor:
>          *    uses offset =3D 0 && length =3D RAMDAC register width.
>          *    var->{color}.offset is 0
>          *    var->{color}.length contains widht of DAC
> =

> while the (newer) skeletonfb mentions both:
> =

>      * Pseudocolor:
>      *    var->{color}.offset is 0
>      *    var->{color}.length contains width of DAC or the number of uniq=
ue
>      *                        colors available (color depth)
> =

> vga16fb.c is also an old driver.
> =

> > IMO, if we're going to fix uvesafb, we should also fix all the
> > other drivers and documentation along with it.
> =

> Yep.

The comment explaining fb_bitfield in linux/fb.h seems to need some
fixing too ie. remove the big-endian comment as I think everyone just
assumes the fb_bitfield values are in the device's native endianness.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
