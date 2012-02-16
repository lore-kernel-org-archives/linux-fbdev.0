From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 16 Feb 2012 08:22:16 +0000
Subject: Re: [PATCH v2] OMAPDSS: HACK: Ensure DSS clock domain gets out of idle when HDMI is enabled
Message-Id: <1329380536.1951.26.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-MHddRiR3joeUlP8cq8H9"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1328854552-30714-1-git-send-email-archit@ti.com>
	 <1329220678.1845.68.camel@deskari> <4F3A5A5D.4020906@ti.com>
	 <1329225311.1845.109.camel@deskari> <4F3A61EF.4030803@ti.com>
	 <4F3A809E.3070508@ti.com> <4F3B9E8F.1020002@ti.com> <4F3BA6A2.60604@ti.com>
	 <1329310317.1892.60.camel@deskari> <4F3BAD41.1020102@ti.com>
	 <87fweb98bs.fsf@ti.com>
In-Reply-To: <87fweb98bs.fsf@ti.com>
To: Kevin Hilman <khilman@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org


--=-MHddRiR3joeUlP8cq8H9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-15 at 11:59 -0800, Kevin Hilman wrote:
> "Cousson, Benoit" <b-cousson@ti.com> writes:

> > Kevin,
> >
> > Do we still need to set the dev.parent to omap_device_parent?
>=20
> Nope.
>=20
> > I guess the default &platform_bus parent is good enough and
> > potentially the DSS children should be able to overwrite that.
>=20
> Yes, now that we use PM domains, we don't need it.  I just sent a patch
> to remove omap_device_parent.

But it's still not possible to create a custom parent-child hierarchy
with omap_devices. Or can I change the parent of a platform_device after
it has been created? (doesn't sound very clean even if I can)

 Tomi


--=-MHddRiR3joeUlP8cq8H9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPPLy3AAoJEPo9qoy8lh71vDgP/0JGgMhxR45p+rfjnJkMgdIF
rZLLIpJ6igsqXcAUbsWzR7JyrNDsJ1GazoI9Q1z7AarGPTkMxcyzO2Gf/LMkCx2+
G9Lq5+txd7I1D2OyW0NpXOWd14uuD2YsZ2aYVtAQYMTPMWtLL3Hd0DMVtWguHYpM
ZWEmEn94yNSyMaTcHNo8Wh9ZTX7HpqBI+f8Wr9ehBz+1FUtgZf+CDMmx77oyWj8n
7JJpaP/4YPGONO2Hetl8jaRiphReSmRPH1XZBGO4jyc54ugKDc5fnB9ts/NzZ+nl
hnSKOVMEVrfBqQEcouwJ4vg867kbs5uQG7+qPU8j/FRDvf/MuR/km0qjdOpy38FO
q0EfOMtPpUyyzrzNfDpjCxv1zs3s58T/tiCS9hj1VKjPxnW9+N+2T/FFJOkO+Adi
R9qXgvEw8cCwS3G+zUiIkYkCdP8UWpL7VglDxactRYBF74Y3K6q6zx9gHs5Tym3L
wuQCSwQy8WvBCowCQQ2cRpfIHfx6B+dryXbvArL9nOqwapjdGFXjjj14LRqFCxWQ
Jcug7JU+EHg5ciotJMXEUy0CV616K/6CsVR9PJf3DgAo0cIU6uWfjdEb5SupvL5j
hD36JExVVIQ0+1FZpaQIDvBFZb5jON/PV7b58O6E4I3iyNicSWom8f4qRTZcfdbm
jtYnRLqMQdSOh0blruq1
=bCMb
-----END PGP SIGNATURE-----

--=-MHddRiR3joeUlP8cq8H9--

