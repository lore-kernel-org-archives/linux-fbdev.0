From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 12:44:06 +0000
Subject: Re: outcome of DRM/KMS DT bindings session
Message-Id: <53108496.8000602@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S8dvDLHgQjCsfSUok8buXDBfe2RQgsoOa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPM=9twObPRhPavm9xD+7=JDPEVD+K_WFJxMGG=f5eXR12PvLw@mail.gmail.com>	<20131030120229.GF24559@pengutronix.de>
	<CAPM=9ty7+A=YjSbRLxmo9mXSQSkZsZngBvTsryZ8+tHppEMPyw@mail.gmail.com>
In-Reply-To: <CAPM=9ty7+A=YjSbRLxmo9mXSQSkZsZngBvTsryZ8+tHppEMPyw@mail.gmail.com>
To: Dave Airlie <airlied@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: ksummit-2013-discuss@lists.linuxfoundation.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>

--S8dvDLHgQjCsfSUok8buXDBfe2RQgsoOa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

A bit old thread, but I noticed this only now.

On 01/11/13 02:10, Dave Airlie wrote:

> But why? why should we have separate drivers for each component of a
> tightly coupled SoC?
>=20
> it makes no sense, having a driver node per every block in the chip
> isn't an advantage, it complicates
> things for no advantage at all. If we don't have hotplug hw removing
> one device shouldn't be possible
> this idea that removing a sub-driver should teardown the drm is crazy a=
s well.

It depends. The SoC's components may be independent as Mark noted, and
having separate device/driver may even be more or less required by the
arch code. I think this is so on OMAP.

In any case, I don't see any reason to require DRM developers to do it
in one way or another. One big driver may work best on one SoC, multiple
small drivers may work best on the other.

The thing is, we anyway need to support multiple devices/drivers, in
cases where we have, say, external i2c controlled encoder, or panels
that need explicit configuration.

So we can't just escape the init time problems by requiring a single big
DRM driver. And if we have the solution for the panels and external
encoders, I don't see why it would be any different for SoC internal
components.

The video pipeline is often composed of multiple video components, and
whether they reside on the SoC, or on the board, it doesn't really make
any difference.

 Tomi



--S8dvDLHgQjCsfSUok8buXDBfe2RQgsoOa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTEISWAAoJEPo9qoy8lh7164AQAKVJBHmL67WexloHCEJegg8P
qb+Xvq8ZrbWIUxQWbSjQ5HKMTKuT+JTc/1S18uMb+XKgKUYX2/UPWwehB2ZjiXkz
F+114DV+qdn9wWHx5CpAkaSwUG7ZmciCgqw4f7oLGk1S/2x9OLQ7J74Ay0OMC/FP
x8EbCxC04cWSRIsZ+YsQEUKC4QwsQYn5UFGTvCVhfonRWdqJfnJ8Yi0iTmvZ0F1P
Ah6YnvhDdg/XpsMOBAbmoblrQAK07AvuDekCqQrhF0NcoinpJs3HIiGpDtjIXgzs
s3+/Clgl0XvB4gx3/qGZVkksiMgAgdev5GEdw8F+YZILgeM9Ri1hnV7DiIMi6B11
F1V8PeFO+Q9R54DZyN9KuYepCeCXf4IQ0jHEea9240GeVhTknbP13hFiLTC+aD83
P4ffzRBnjty5P/+NpAG/SGLZvOv4UyKKQhcHX2N4GgoW5QAAtnhHFdpCy4RYkzdb
uFEALjilahUjIQUOa5WGL9jHKDflxmH/zfOzB5+1guVSnSHClWbL9QHbVS8yeY/R
ydbGlfQ62PN/nGTGxlCDUxEtsbPASzdw1o2gbBL0s5U7TVCH3SJE057rQVr3PfD3
84Wg5We0o5UgtAo86ybj+O322LMI8tEbx3mLj2RmjkXkhQA0BGZN/7TRunkLJDnP
nFwDjxZoqdmIvHN+k8OG
=vDR1
-----END PGP SIGNATURE-----

--S8dvDLHgQjCsfSUok8buXDBfe2RQgsoOa--
