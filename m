From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 14:58:14 +0000
Subject: Re: [PATCH RFC 0/9] omapdrm/omapfb/omapdss split
Message-Id: <56699306.4070101@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gIoo5M64R7mkfLJhevtW0s60nwPMKaRuS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
 <CAF6AEGsCi_-YwQHYjfO_ao7Fg8QmQ=Gka1rG+OgkNqNaRsA5vw@mail.gmail.com>
In-Reply-To: <CAF6AEGsCi_-YwQHYjfO_ao7Fg8QmQ=Gka1rG+OgkNqNaRsA5vw@mail.gmail.com>
To: Rob Clark <robdclark@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

--gIoo5M64R7mkfLJhevtW0s60nwPMKaRuS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 10/12/15 16:53, Rob Clark wrote:

> It would be nice to see omapdrm eventually using the panel framework,
> etc.  But I think copy/paste to decouple omapdrm from omapfb/vout as
> the first step makes sense.

Yes, long term plans include getting rid of the omap specific
panel/encoder drivers. But I can't do that as long as omapfb/vout is
there, preventing any bigger refactorings.

 Tomi


--gIoo5M64R7mkfLJhevtW0s60nwPMKaRuS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWaZMGAAoJEPo9qoy8lh71vLUQAJDwPHxS68plroXrM3+kwRn7
64pMQMHVhokN3KW39aX5Zc7PuInuq8WrEpcV/4S9MDvRyToVXhERo/Fa4mLO+TD6
xJ9m1DVkBogUMX0KP69lHQIzxOJ2qwSVNWsrKbmv124TbSFwJc/mNASjwkQ04Wp3
Dmol/PgGIRTUctRTBDLZ2PYZRPnlJsigdSLPyZ19EA6Ad5DhsG6KKcmEfUzWzwcq
2OvQd8Z8uu1UgASVG+ShvYyYHkX7B88M2OPCagKtMnPoe4uNd+xhALr1d1qzoCmc
ANf7kyA5slpv6/RXGXP6P86oZvYdxqkIWrI2JKm56ZonTvUfBaDwEmIKNbKYjwqT
5F73eYXdY4vgG1Rv0ane3DcvxnKUklQ/ZsPNPetarM3gUYq8k5xMIdf83ilSQ9mq
rU6hY+X7c5EXiORjAx9Ql7aTOBKsYup3SNcp8zMSq7BsQ52fhZyTZ3WKFN4NGNTg
cZNGsfrdEDmTn8WzVmrmECwyIBY6NXZX4yUnAz8HM/LZUzeQo4Qeqq8ojVFE30CO
I4jUPxf1tFVtU4tK8FvHUjmQMfl/jUEPDm2mjMi+NxlTO+VR7rtLLFISLxFmboBp
h0fHgjXV5WeAWdnHXwatPL3uRmLJ4Ohou1A3rD/9dO99coqfwgMCu90WfKj/j21h
E3XgyA/KhZXccIXNdnjB
=v1fB
-----END PGP SIGNATURE-----

--gIoo5M64R7mkfLJhevtW0s60nwPMKaRuS--
