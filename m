From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 24 Oct 2015 07:09:45 +0000
Subject: Re: [PATCH v4 4/4] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
Message-Id: <20151024070945.GP10947@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="i1d8offQF8oqidLm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445572241-13259-1-git-send-email-wens@csie.org>
 <1445572241-13259-5-git-send-email-wens@csie.org>
 <20151023145309.GA1885@excalibur.cnev.de>
 <CAGb2v67HO5isvUxG09traLUBrBp-0Bea9cXn_O0oqBCTYtfN=w@mail.gmail.com>
 <CAGb2v64xESxh0Dzsh9GijYZADbB-SM99ZVtu=9FGB2Gfz2-Z6Q@mail.gmail.com>
In-Reply-To: <CAGb2v64xESxh0Dzsh9GijYZADbB-SM99ZVtu=9FGB2Gfz2-Z6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--i1d8offQF8oqidLm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 23, 2015 at 11:56:35PM +0800, Chen-Yu Tsai wrote:
> >> as described in
> >> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> >> here, as the display is in portrait mode while the touchscreen is
> >> in landscape mode and needs to have the x and y axes swapped to
> >> work in the same coordinate system as the display.
> >>
> >> Regarding the driver side: the goodix driver in kernel 4.3
> >> doesn't yet support this property, but patches to add support for
> >> it are on the linux-input list and should hopefully make it into
> >> kernel 4.4.
> >
> > The DTS is already in Maxime's tree, and in sunxi-next. Feel free to
> > send a follow-up patch adding them. I was waiting for those patches
> > to be merged.
>=20
> Sorry, spoke too soon. Maxime hasn't pushed it out yet. Could you send
> a patch adding touchscreen-swapped-x-y for Maxime to squash in?

I did the last DT pull request for 4.4 yesterday, so I won't squash
any patches.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--i1d8offQF8oqidLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKy65AAoJEBx+YmzsjxAgyCIP/2o9Q7JxdVllytw0GoFF0TIP
YtdanIUQwcJARGOxdg63TKBMtaxPNMv3jbPalblMSFw4F4dVC6DMlnQXWDnOIZ67
GsS+Dkqmk0b/BTBoNTxGh8H6On1ty4fw+LUiw57njcsmZV2NACZSrEqICTCw5JXL
JnxdpNshd6YFkcxywdcrfaa/ocwCt71ah2ro+gJkpQ0PgyfOQVKZinYf6pRAIvED
M/3ptTTnlU4DOGG6fiDBTzJX7Z3KmTdYt+/bG92Oozp/uQYg/kl/5BJOjRrCKxHg
qm14ShQll580TYHcknED/JwerXy35Iw4Ix9j1ZZQXWPY9+ejb0lhXZgCjVqz2Weh
d+Gk5AClv3V2J0lbBWcQ4wyqRzykU5cJulYawznJOwVUppZp0VSVIhs5FxfmU0YW
8Z0rbYn/pUCO5Gg3Buz72zRTrvrIGDE/V1JR35vtzziIaNn2BybjrrQ9tjq7ZuyE
Y2ROIQIBDKKqXUJIvBF7PsJCiRe+c0n9WKWeVxADQKcOUDrzWhHdf0utldEBQHl7
4VBA7VO5GCEsJ33yuM6fhMc3VHJCCg8M5E/wLo7t6A7FxStDX6i2sP/ZG5DN3kZd
7dxdovMR7ZNEXwZvLT4+y+PLXXov2QwM5IIIvrAAF3xbFeV6PLUC8OJ3ALphhIGt
Fsr8uuQ/Zo+/01Mgslh7
=61SF
-----END PGP SIGNATURE-----

--i1d8offQF8oqidLm--
