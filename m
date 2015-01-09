From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
Date: Fri, 09 Jan 2015 22:23:18 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <20150109222318.GA4891@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
To: linux-fbdev@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 02:58:16PM +0100, Geert Uytterhoeven wrote:
> Hi Maxime,
>=20
> On Fri, Jan 9, 2015 at 12:03 PM, maxime.ripard@free-electrons.com
> <maxime.ripard@free-electrons.com> wrote:
> >> > can fbtest
> >> > (https://git.kernel.org/cgit/linux/kernel/git/geert/fbtest.git/)
> >> > be used to to draw something ?
> >> >
> >> how do I set pixels of it ? Please if you can point me to some stuff t=
hat would be helpful.
> >
> > Last time I tried, fbtest didn't support monochrome display.
>=20
> Really?
>=20
> On ARAnyM:
>=20
> atari:~# fbset -i
>=20
> mode "640x480-60"
>     # D: 25.176 MHz, H: 31.470 kHz, V: 59.943 Hz
>     geometry 640 480 640 972 1
>     timings 39720 42 18 31 11 100 3
>     rgba 1/0,1/0,1/0,0/0
> endmode
>=20
> Frame buffer device information:
>     Name        : Atari Builtin
>     Address     : 0x67a000
>     Size        : 311296
>     Type        : PACKED PIXELS
>     Visual      : PSEUDOCOLOR
>     XPanStep    : 32
>     YPanStep    : 1
>     YWrapStep   : 0
>     LineLength  : 80
>     Accelerator : Atari Blitter
> atari:~# ./m68k-linux-gnu-fbtest
> Using drawops planar (monochrome and (interleaved) bitplanes)
> Available visuals:
>   Monochrome
>   Grayscale 2
>   Pseudocolor 2
> Using visops pseudocolor
> Running all tests
> test001: PASSED
> test002: PASSED
> test004: PASSED
> test005: PASSED
> test006: PASSED
> test009: PASSED
> test011: PASSED
> Benchmarking... 10x10 squares: 17.25 Mpixels/s
> Benchmarking... 20x20 squares: 40.96 Mpixels/s
> Benchmarking... 50x50 squares: 102.41 Mpixels/s
> Benchmarking... 100x100 squares: 195.06 Mpixels/s
> Benchmarking... 200x200 squares: 348.61 Mpixels/s
> Benchmarking... 500x500 squares: 742.07 Mpixels/s
> test012: PASSED
> Benchmarking... triangles of max size 10: 139444.38 triangles/s
> Benchmarking... triangles of max size 20: 107443.29 triangles/s
> Benchmarking... triangles of max size 50: 71237.96 triangles/s
> Benchmarking... triangles of max size 100: 40962.10 triangles/s
> Benchmarking... triangles of max size 200: 23407.09 triangles/s
> Benchmarking... triangles of max size 500: 9102.64 triangles/s
> test013: PASSED
> atari:~#
>=20
> And the result did look good ;-)

Ah, good to know :)

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUsFTWAAoJEBx+YmzsjxAgjZMQAL4C4nFqVK6Dg6CnmsA0GS2r
z/S4Dp7slpScNPccfzH6T1ElqdsU4sH1HoRPNN93+fpVzCgEHpOFf0WZwSeBMC/X
LCJX3j1TRhMDfKu5P9a9YcAIA3qoqLU9nDZg1kSQDvxQcDQo4SHgZznRhYbiaMaB
zL4QJcHqHQ9GFnkxgKiBIFykH/FPQhtQd8o5sLCNHjD6eweOXtgTo2Ted3yc6pJO
Ql84l4mnTbo3glAzRuHaWUbv1sFUqaREotwxDNZGLpGM5WsmW6cAl7a3ayYGutau
3PV2TeXq1T+l8n0zDAm8u8ROl1hAcU2nn1PfxP4gEHzHI1JUEHPmv0V49VyS6C7/
dsKINnhu+t/ZE+Z4nwj0hoJUr2NfqXTTj49du/v6LfUtSKSGZ10iuCIHDlfbSgqV
ht25xEF3egekdraZn4JsDVEBcN/lVpN8x1wp4HK0MvKbzfeEfHO+CGUcZx413dUL
g1yt/ll72kLCO5U5G08VJpYnJqcs4pEdkr8W85KMByo9nchWPjAsSzSJpW52BLWc
ZMfb7mApIXAduVHu3EpUGAxNVwZ+WQSxpuTHo4EJP74tHL/0i0bOzWuTsSRvjlel
GPM77UBz6zLoFMbYjtVm7+wbn0msZikoCNkPyXrl2DwPKOCwBLsSbPoaFHBNmDih
2nn7nAXBovQ7XoCiUOpi
=QXLo
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
