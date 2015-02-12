From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 12 Feb 2015 16:41:47 +0000
Subject: Re: [PATCH 2/8] fbdev: ssd1307fb: Unify init code and make controller configurable from device tree
Message-Id: <20150212164147.GK2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BPjCafsbA2ap7OrL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-3-git-send-email-niederp@physik.uni-kl.de>
 <20150207104225.GM2079@lukather>
 <20150207155933.4f1d0998@maestro.intranet>
In-Reply-To: <20150207155933.4f1d0998@maestro.intranet>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--BPjCafsbA2ap7OrL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2015 at 03:59:33PM +0100, Thomas Niederpr=FCm wrote:
> Am Sat, 7 Feb 2015 11:42:25 +0100
> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>=20
> > Hi,
> >=20
> > On Fri, Feb 06, 2015 at 11:28:08PM +0100, niederp@physik.uni-kl.de
> > wrote:
> > > From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > >=20
> > > This patches unifies the init code for the ssd130X chips and
> > > adds device tree bindings to describe the hardware configuration
> > > of the used controller. This gets rid of the magic bit values
> > > used in the init code so far.
> > >=20
> > > Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > > ---
> > >  .../devicetree/bindings/video/ssd1307fb.txt        |  11 +
> > >  drivers/video/fbdev/ssd1307fb.c                    | 243
> > > ++++++++++++++------- 2 files changed, 174 insertions(+), 80
> > > deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/video/ssd1307fb.txt
> > > b/Documentation/devicetree/bindings/video/ssd1307fb.txt index
> > > 7a12542..1230f68 100644 ---
> > > a/Documentation/devicetree/bindings/video/ssd1307fb.txt +++
> > > b/Documentation/devicetree/bindings/video/ssd1307fb.txt @@ -15,6
> > > +15,17 @@ Required properties:=20
> > >  Optional properties:
> > >    - reset-active-low: Is the reset gpio is active on physical low?
> > > +  - solomon,segment-remap: Invert the order of data column to
> > > segment mapping
> > > +  - solomon,offset: Map the display start line to one of COM0 -
> > > COM63
> > > +  - solomon,contrast: Set initial contrast of the display
> > > +  - solomon,prechargep1: Set the duration of the precharge period
> > > phase1
> > > +  - solomon,prechargep2: Set the duration of the precharge period
> > > phase2
> > > +  - solomon,com-alt: Enable/disable alternate COM pin configuration
> > > +  - solomon,com-lrremap: Enable/disable left-right remap of COM
> > > pins
> > > +  - solomon,com-invdir: Invert COM scan direction
> > > +  - solomon,vcomh: Set VCOMH regulator voltage
> > > +  - solomon,dclk-div: Set display clock divider
> > > +  - solomon,dclk-frq: Set display clock frequency
> >=20
> > I'm sorry, but this is the wrong approach, for at least two reasons:
> > you broke all existing users of that driver, which is a clear no-go,
>=20
> Unfortunately this is true. The problem is that the SSD130X
> controllers allow for a very versatile wiring of the display to the
> controller.  It's over to the manufacturer of the OLED module
> (disp+controller) to decide how it's actually wired and during
> device initialization the driver has to take care to configure the
> SSD130X controller according to that wiring. If the driver fails to
> do so you will end up having your display showing
> garbage.

How so?

Does it depend on the X, or can it change from one same controller to
another? to what extent?

The 1306 for example seems to not be using these values at all, while
the 1307 does.

> Unfortunately the current sate of the initialization code of the
> ssd1307fb driver is not very flexible in that respect. Taking a look
> at the initialization code for the ssd1306 shows that it was written
> with one very special display module in mind. Most of the magic bit
> values set there are non-default values according to the
> datasheet. The result is that the driver works with that one
> particular display module but many other (differently wired) display
> modules using a ssd1306 controller won't work without changing the
> hardcoded magic bit values.
>=20
> My idea here was to set all configuration to the default values (as
> given in the datasheet) unless it is overwritten by DT. Of course,
> without a change in DT, this breaks the driver for all existing users.
> The only alternative would be to set the current values as default.
> Somehow this feels wrong to me as these values look arbitrary when you
> don't know what exact display module they were set for. But if you
> insist, I will change the default values.

Unfortunately, the DT bindings are to be considered an ABI, and we
should support booting with older DTs (not that I personally care
about it, but that's another issue). So we really don't have much
choice here.

Moreover, that issue left aside, modifying bindings like this without
fixing up the in-tree users is considered quite rude :)

> > and the DT itself should not contain any direct mapping of the
> > registers.
> >=20
>=20
> I think I don't get what you mean here. Is it because I do no sanity
> checks of the numbers set in DT? I was just looking for a way to hand
> over the information about the wiring of display to the driver. How
> would you propose to solve this?

What I meant was that replicating direct registers value is usually a
recipe for a later failure, especially if we can have the information
under a generic and easy to understand manner.

For example, replacing the solomon,dclk-div and solomon,dclk-frq
properties by a clock-frequency property in Hz, and computing the
divider and that register in your driver is usually better, also
because it allows to have different requirements / algorithms to
compute that if some other chip needs it.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--BPjCafsbA2ap7OrL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU3NfLAAoJEBx+YmzsjxAg+i0P/i6dxhlBb6wcE+Cmf0CLM+lx
wfnxUiGE/sof3kOeYXWiNKvy99IDJf0HRkhl/NfbAvM8H3UcEeJrECuAKqO5o6vs
7AW9ODtBG6QXnAP6dPh7a0o2pxTQts0Yaj2/DwHVgxv/L9S8IFNplxFMtTEPX5oX
Kck3aRuWaVZdD/UEd3MpwGuCZQLzAf4xRc/F/gu2j+rNFnQ8rr7DyVOs6HP10gIr
HsUHoaUPiH1bmYN2gJ4QZQO40NzScwhm29O3GFEQMAYhQKFlDrHgiAsWJ00OH60J
GOluuhYRbeQmpFFR+hggw9HFvg5jyk+ekfvuGlXFVaN9LQyPmdgnUfhOn9mEv97j
UBPYca4Btf30wpulYGZsm5uPWT8lHeq+wgjGPWHKcjIiDqGjTJ4Ucyabzu7PO/mB
Lx+PzWS/PxMA9PsNfQLuA7ClqgbIUGVvDac3IkeQGeNWEBSs7yUzBkxCit6WRhGP
Cgl80bQ/ROqMNz/nyBPJhCvSxQ3NLT6VtqkGZ4xzYkxDfESi0e2/GTubUOJD54i9
hrm681beXUORqYFnqcrFaheoX6QbFJ86ZFsV0d0DsOFFGTB9Af0ct+d2TZJ4NKEk
tXmHFs7mNmVkHchsQTgkoZfwQX/Jk0EWhY95iemCer64qJegexTlHDCfu+LQ1spQ
yQrF2LNQgwQYiFtD4kT6
=GKm1
-----END PGP SIGNATURE-----

--BPjCafsbA2ap7OrL--
