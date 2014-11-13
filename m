From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 13 Nov 2014 16:47:49 +0000
Subject: Re: [PATCH 6/7] ARM: dts: sun6i: Add EHCI support for the M9 board
Message-Id: <20141113164749.GN20972@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cs5saTBZh7UZl2eX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415871109-28332-1-git-send-email-hdegoede@redhat.com>
 <1415871109-28332-6-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415871109-28332-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--cs5saTBZh7UZl2eX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 10:31:48AM +0100, Hans de Goede wrote:
> The Mele M9 / A1000G quad uses both usb-ports, one goes to an internal
> usb wifi card, the other to a build-in usb-hub, so neither need their
> OHCI companion controller to be enabled since the are always connected at
> USB-2 speeds.
>=20
> The controller which is attached to the wifi also does not need a vbus
> regulator.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, with a newline before the pinctrl node.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--cs5saTBZh7UZl2eX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZOC1AAoJEBx+YmzsjxAg0QcP/3L3tkQAujtzQQIbJ6J2sqxp
nRsAP51nwoT1TJypJ2Dyf4imVhigzmyfbd3cxteWaYNhDwbswsP2l/rEacEugg9l
be+xpcM2h4nQpp62PfI92Nx+4LXRcSxehUVUgz4UQVvjA/x6d441d0Fe8f0xt2Zw
Hv1i3rRkvWYQPJ9XI7aln9y2kTggSxfBkOn8Sc/M9OJ8pIgfrJMrGMsNjr5PjOCo
7fBV0M4Cr3j/kntF3dHXKVmLYOoyb68lrkwoexeQ15sxxk7VDi1xqG14Ejzfitff
BOAf2N12G2vS5VIFWpTwq/F3wlNNal8NQ6Ip9U+aJRPSlmBm3HPMOqKzLsoX8oya
EeCpeGoiJIaMs9W3c2LiBbm8BuHMkXl28A1pB6hkYVlcR6qSgRJxlwOXK6maVFbH
gxHL5KU63ettXACxX/17bM0BZ2F69fI13fFtGaWAboFZ579sO+4JHMX+/t1kkK+X
tX6XhoW8NpqSbntJ1bJ5WiLMrBajoJVa3lPtAKd6Z3OJqr+xpsHc2v2nNbHvJZnw
vOI6NScjrUWHaX/k2dOfPsiQCLZIsSz7+4mnPT4HiJlDCup06eZqV9wCPPGlAfZf
w85+3T8d9BJso28JsAB9pvv38CwWN+5kPw2ufETS6kh3e6w7WbgaefWaEEJXnOLz
CWWBvIHO8qNE4O9/f2VR
=XfBL
-----END PGP SIGNATURE-----

--cs5saTBZh7UZl2eX--
