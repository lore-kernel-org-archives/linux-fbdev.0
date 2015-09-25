From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 25 Sep 2015 13:09:46 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <5605479A.2020903@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="89ICnEldGUdMNpSivaiw58Ume9O67G8sB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <560524E7.4020707@gmail.com>
In-Reply-To: <560524E7.4020707@gmail.com>
To: Kamil Lulko <kamil.lulko@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

--89ICnEldGUdMNpSivaiw58Ume9O67G8sB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/09/15 13:41, Kamil Lulko wrote:
> Hi,
>=20
>> fbdev is (more or less) maintained, but it's a deprecated framework. A=
ll
>> new Linux display drivers should be done on DRM.
>=20
> What about no-mmu platforms? DRM has a big fat MMU dependency in the
> kconfig, is there a way to write DRM driver for such devices?

I guess not.

Then again, I don't see why DRM would have a hard dependency to MMU, if
the work is done to make DRM work optionally without MMU. How much work
that is, I have no idea.

 Tom


--89ICnEldGUdMNpSivaiw58Ume9O67G8sB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWBUeaAAoJEPo9qoy8lh71zKMP/0blbnwo2dtvCVnHugfGxO7Z
n/XhJivWll/dinwq8Nfz1UhrqFAcAGLaWpQE+fuhWtUwLz/g9IX0nq5GgHYdni4l
NXuNfw6UU9UblO0NxRUm1s7AesMOulLBDpo67L+O4ifidov+tHe6a2eC++ZvLe1k
SSnuysNx3gdv9Z32pP9iUB1EwfKrbqv+mDdBrJsvu+jnX797nCqhtGgT/AUvu+oH
m2rrWR4IdMTJfJAftrGGHtV5DaJlhXdMnMyMkMAnh7WxTGkrAIhbYdZvZ/MJ0lMr
oLXCKbZOv9P2xsvPvrA/Zv6701lX4cH+MHqUqvInykyvDcKOdAIp5yvspby1NW/v
FD40UnwPbsVtA/QSC1g4u79o90qdZS8FCC+dZ8tU7tawatT08bO4MgFhosUmPQ1G
XVFeP7GkIKohTLTKApPj6vLF998ZDdVV6NsiAJ1zdlHs32xVgMx/A5qq6cRCJN84
7mye/Ax8gnqmab/y2QXWcnlD3+6dGSc6Nxf9pi8Nh4kF9DzMkkcZy3RCHl/Zv5r7
Z0dg691bRpA1q3CdroyPfBOmO2Pk72a4HslMU5P9MbFNB7YTcQ7mAIxCOz7xYtV8
sZgUMA/53Qclj7uVMhjqLr5IUmf9dHT6yKwT0meovwX1Tz70GEwVX37aYi8TC3NT
+KGGn1wsrY4VfGtsYiQf
=FNQX
-----END PGP SIGNATURE-----

--89ICnEldGUdMNpSivaiw58Ume9O67G8sB--
