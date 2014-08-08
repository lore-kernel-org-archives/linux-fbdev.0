From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 08 Aug 2014 07:09:19 +0000
Subject: Re: [PATCH] Adding a support for Skyworks SKY81452
Message-Id: <20140808070913.GB5387@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LyciRD1jyfeSSjG0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407398738-7582-1-git-send-email-jack.yoo@skyworksinc.com>
 <20140807123439.GC29832@distanz.ch>
In-Reply-To: <20140807123439.GC29832@distanz.ch>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Gyungoh Yoo <gyungoh@gmail.com>, rdunlap@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, jg1.han@samsung.com, cooloney@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, grant.likely@linaro.org, sameo@linux.intel.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, jack.yoo@skyworksinc.com, florian.vaussard@epfl.ch, jason@lakedaemon.net, andrew@lunn.ch, silvio.fricke@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2014 at 02:34:39PM +0200, Tobias Klauser wrote:
> On 2014-08-07 at 10:05:38 +0200, Gyungoh Yoo <gyungoh@gmail.com> wrote:
[...]
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id sky81452_of_match[] =3D {
> > +	{.compatible =3D "sky,sky81452",},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sky81452_of_match);
> > +#endif
>=20
> The #ifdefery here is not needed since you use of_match_ptr below, whcih
> will expand to NULL of CONFIG_OF is not set.

On the contrary, that's exactly why the #ifdef is needed here. If you
don't guard the OF match table here, then of_match_ptr() evaluating to
NULL will cause the table to become unused and the compiler warning
about it.

Thierry

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT5HeZAAoJEN0jrNd/PrOhB9EP/2Hd2EA1+jw5UI/TXC1Qtyrf
J04aSZe68LEZ6qLc3IcZubQPU8b7Les+28+xmgW6YjD2k8V+KN+/q5YgilcuS8xp
qlUhCtxwuCoKZWZ9wvhXw68cZ0n327NU7Ho/XVkWLhN7QeqMK7RMvhv5lG0t8ult
K8Zx1CGQsG/GWzUjoCiMmYmMUc7VrzGPRtiYReQDlQcu5d3BGrp5lcdcezbP2vcz
pMPenD9YUe6lHkZZoEk+uL7auzPDQx/IUk8+p5KqZUWOi55EWh0pXpOhEh6+kfm0
0/92kyBdet2YJACR5vmvCkjQFF5yX0LpM65Bz8ENUX4RTTpFoBz44Qb2sFgDzmV3
hepqYX0x4Hten+4fs8ygrmmLkqsH5KEVoAG+O3555L+tLwpxbi0VMEDtjFYA9sUF
0eUKsJ1ZdkLOoX2fcXbIp0MlE4VU1Wx9bjxvT3+W7FEpegKS0WrTrUeRlONg5nyw
pssEBARWi06EhvwPdrOJ0MICwXu7N5RCYtI6dNK+LOad6Ugne6gPoLV2zDXG1xLf
kqiI7/mEJ+rAddmRaqqm0P47cEjGapFED/eDyMkm3iQnBg9eUw+nCV8qx1sFceHI
3e0VzK0Y7Wys+LHmHWggDii0pFy0kqFyW1FKmLO5M2Ah5uzo0gbi85HVd0n7EDDB
KglYQFEvALBLQrjCguIc
=w9XX
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
