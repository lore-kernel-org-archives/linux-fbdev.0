From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 13 Aug 2017 13:34:45 +0000
Subject: Re: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
Message-Id: <20170813133445.vqbfelwshvrififp@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x7iu3k54wogfx4rq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-3-wsa@the-dreams.de>
 <20170523071819.4zpdef7ofzz3moil@dell>
In-Reply-To: <20170523071819.4zpdef7ofzz3moil@dell>
To: linux-arm-kernel@lists.infradead.org


--x7iu3k54wogfx4rq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 08:18:19AM +0100, Lee Jones wrote:
> On Mon, 22 May 2017, Wolfram Sang wrote:
>=20
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> >=20
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
> >  arch/arm/mach-omap1/board-h2.c          | 2 +-
> >  arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
> >  arch/arm/mach-omap1/board-h3.c          | 2 +-
> >  arch/arm/mach-omap1/board-osk.c         | 2 +-
> >  arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
> >  arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
>=20
> >  drivers/mfd/tps65010.c                  | 2 +-
>=20
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Same here: ok for 4.14 or something needed?


--x7iu3k54wogfx4rq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmQVXUACgkQFA3kzBSg
Kbb82A/8CWo5vCRGkKENB8LF59ZtbSiHZ+oAa+LsTkUcagwRNzUTCEr7OMvOh+70
NFUc1G2mA45kzj9zLkpequWxb7RwOo45fv282ORORVThw7ZQYVlX1fujHjxvkVKV
RYzQFQv3AcO8cp2CXq+ajRpBNbKNr9PeORq5EnJFdJmfrUeuSurxbRIBFWqULBMY
K5K12DRQDjFMRKEtLj0ob/6vmm4P0TUF2rhmHQtIvpzdao1+RKIjeb7RKf81Qnqd
CFRHxCE6pEolJzbnxk9bJqY01nYsDwD0Z3Vq/dU78c1YHvSbQwsvc2VM5QZIjhic
/Uk1NrjBsVc2CoWGa4EYCvDVG+Co+JJuBHZRRVtKsB+/tKLDginU1+Ebb93HpvWe
PmlZPmUa+QQPVcYfBAwCkqzJ/MJZriWpBUVLAI43bcJeV1OYBt2E0Qn9Mwd38Hcq
DsGavA7Gr6mxZh6WiJUbhXgAAUno3ZyJ4zO/vXRNHcL7wW1UOTVNq2M8YSOdIeOu
F5fJL9gT4dY7VT+evobejFIqYSQ2GWZpYUzGLRDT5s7SVjyaGzUDLUNx0tQDnb/t
EWbo9tu+0svV6vAz7Qm53vnjK5QR/PdGpmgsmBy7tL4yLxiqt3uz9DDHHoRVpaFP
Jx5vvOk62RXKv7eeCRC2Iv7Ncm9sEdAX/loqAb3noUwrGsPo6dk=
=p1dJ
-----END PGP SIGNATURE-----

--x7iu3k54wogfx4rq--
