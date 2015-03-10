From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Mar 2015 14:55:56 +0000
Subject: Re: [PATCH] video: treat signal like timeout as failure
Message-Id: <54FF05FC.5030704@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="O5Nstm1xbuNH7KtoLsMbv4cXILT8rtm4S"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
 <54FEE70D.3010307@ti.com> <20150310125116.GA26020@opentech.at>
 <20150310141511.GL8656@n2100.arm.linux.org.uk>
 <20150310143928.GA19501@opentech.at>
 <20150310144640.GM8656@n2100.arm.linux.org.uk>
In-Reply-To: <20150310144640.GM8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--O5Nstm1xbuNH7KtoLsMbv4cXILT8rtm4S
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/03/15 16:46, Russell King - ARM Linux wrote:

> In which case, let me propose that the exynos fbdev driver needs to be
> moved to drivers/staging, and stay there until this stuff gets fixed.
> drivers/staging is supposed to be for stuff which isn't up to the mark,=

> and which is potentially unstable.  And that's what this driver exactly=

> is.

There is drivers/gpu/drm/exynos/ which is getting a lot of updates. So...=


I'd propose removing the exynos fbdev driver if the exynos drm driver
offers the same functionality. I don't know if that's the case. Does the
drm driver support all the devices the fbdev supports?

Also, I'm not sure if and how we can remove drivers. If exynos fbdev
driver is dropped, that would perhaps break boards that have exynos
fbdev in their .dts file. And if the drm driver doesn't offer the exact
same /dev/fbX interface, it would break the userspace.

So I don't know if that's possible. But that's what I'd like to do,
eventually, for all the fbdev drivers. Implement drm driver, remove the
fbdev one.

 Tomi



--O5Nstm1xbuNH7KtoLsMbv4cXILT8rtm4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/wX8AAoJEPo9qoy8lh71BnsP/3LhHbyPPa6i8RJjF6tajpn3
PBXjBl27YUx+RNc+wo42MDN+mIkIfMoa7YTY0LsfO4lbhGBEWIkfMUoayKrdriJK
09DLGQdxo+27eP6QbYlfCW40ZkeF+hUWQfA4LD96fvXqDUfrHPsYg35cWZ33TgU+
Zr7N70+qi3jLfMd3dCM/YXh5jqu9UlQEu2Qd7k+ygP8UOAK/2/ECkfdjoHRc8KmV
waFLUH+cwmTMFIKTLEMMmaRopoqj+z+G9PQu0hrG+EzPZ87aHHUxecd6aFvZdKo+
uMkKcBCX2CeIW9VOB3Gzd5CvkgEzovwVCa+5fiwYi8uOe/LO9xloTAfYjXjbcGB1
xjGypuJIeTdbvvos/dSqFe/SB028sqgGSBLm9F0bumBlVkuJh2DbCstYnp5ovP0o
qa8kt/xD7mNlyjMdREZs9bZhzd2S8jzctduNKnfj5ctqsA+yjZm+6O2MzSkbEbPu
c/FzXr3UUg0JPA2zOC3aiMNRBo/tDtuBxD61AaQW8PgzF9sc2WJdDqjs7Ip1qzUv
UyXQyS8ZCQZuK3wlVL8lA0bCuvvf/sIAzOLCzT6kebqg0y/ubO7eMt9OTlNMkDwo
k/vslo9Wc1d9k/8qXbUjgff7dBZaJzsOZ21pmuyJ+IKZXfu7jWYVpXkzXgZdosCJ
Geruz5nDXCq+lk3dpXF+
=HlEO
-----END PGP SIGNATURE-----

--O5Nstm1xbuNH7KtoLsMbv4cXILT8rtm4S--
