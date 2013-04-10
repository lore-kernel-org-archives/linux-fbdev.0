From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Apr 2013 10:00:15 +0000
Subject: Re: How to manage OMAP display drivers in the future
Message-Id: <5165382F.8050401@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig8B2ACB057839B90EC8DC96FD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <51403F91.7070401@iki.fi>
In-Reply-To: <51403F91.7070401@iki.fi>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

--------------enig8B2ACB057839B90EC8DC96FD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On 2013-03-13 10:57, Tomi Valkeinen wrote:
> Hi Dave,
>=20
> I'm writing this mail to get some ideas how we should manage OMAP's
> display drivers in the future.
>=20
> As a short intro, we have the following players around:
>=20
> omapdss - omapdss handles the DSS (display subsystem) hardware. omapdss=

> doesn't do any buffer management or expose any userspace API (except a
> few sysfs files), so it doesn't do anything by itself.
> (drivers/video/omap2/dss/)
>=20
> panel drivers - Drivers for various panel models. The panel drivers use=

> omapdss API to manage the video bus. (drivers/video/omap2/displays/)
>=20
> omapfb - Framebuffer driver, uses omapdss to handle the HW.
> (drivers/video/omap2/omapfb/)
>=20
> omap_vout - V4L2 driver for showing video, uses omapdss to handle the
> HW. (drivers/media/platform/omap/)
>=20
> omapdrm - DRM driver, uses omapdss to handle the HW.
> (drivers/gpu/drm/omapdrm/)
>=20
> omapdss and the panel drivers form the lowest level layer. omapfb and
> omap_vout can be used at the same time, but omapdrm must be used alone,=

> without omapfb or omap_vout.
>=20
> omapfb and omap_vout are not much developed anymore, even though they
> are still commonly used. Most of the development happens in omapdss,
> panel drivers and omapdrm.
>=20
> So that's what we have now. In the distant future I see omapfb and
> omap_vout disappear totally, the panel drivers would be made generic
> using Common Display Framework, and omapdss and omapdrm would more or
> less be merged together. However, all that is still far away, and we
> need some plan to go forward for now.
>=20
> Most pressing question is how to get OMAP display patches merged. It
> seems that there's not really an fbdev maintainer for the time being,
> and fbdev tree has been the route for omapdss, panels and omapfb in the=

> past. Now that omapdrm is the new main driver for omap display, fbdev
> would be somewhat wrong in any case.
>=20
> Dave, how would you feel about merging changes to all the above
> components through DRM tree? Merging all the above together would be th=
e
> easiest way, as the changes may have dependencies to each other.
>=20
> As I said, most of the development should be in omapdss, panels and
> omapdrm. There would be an occasional fix for omapfb and omap_vout, or
> small changes when omapdss changes require changes elsewhere.

Ping. Do you have any thoughts of the above?

We have a few patches for omapdrm for 3.10 that depend on omapdss
patches. I'm currently acting as a fbdev maintainer (well, more like
somebody who collects the fbdev patches that are quite surely ok), so I
can take the problematic omapdrm patches via fbdev tree with the omapdss
patches, if that's ok for you. And send the other omapdrm patches to be
merged via drm tree.

Or, I could take all the omapdrm patches via fbdev tree, if that's
better. There aren't too many of them for 3.10.

 Tomi



--------------enig8B2ACB057839B90EC8DC96FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRZTgvAAoJEPo9qoy8lh71SLEP/Av8EQ+LCSrSBcFVDprbypim
+RezcDKsgjvxfLfWAN6HNfs1Igb2aq1exCLDZa5SRnFsm1SOyLd086WY0OAvKbQd
E6ackExu/YSbB1xVarV1XU+Jx5cZxwVBF+bOT/Zxted3wL0iXE8wrSnik0sCmRFc
yx7l6aKb/TZv/JbuLqrlgnCBlvq0Iju2RMPRNhQ+1u1+yYTN/IFWET2hw1UKGQPq
IZY2NsAArq6/wXwbooAHDH6MVzVzW5ajE9ynXPLXxenbzpzwvvSm1JvjPB3PVY3f
ue10OdXzDsqezH2+3Vem13vu4ciKpAgO336MiOJgwhAFrOttxpZXVkz3GE7lzptm
MA0I/E55KNSIXIwKbqDaMhLg5JYap9lsWKv80b388vqFvMD36Yoxb8VqzRvKJY+G
dyleuPhupFf+a+hiwp5rDNKWFcnFQwGQhxigaG0nz969YViqauhUn0+36spphSse
HkJVh5SJOVEmwOH/mXlOC7oP+V5IKdc5Y0vBJewR0UiX20xK3roPxO1GVFUcv4VN
W0wKshTt6Hv5psL6GKRNTy6Jjljs3Ye3rOxvXMvrEqeDqzclfdpWwxg2RCH5uFcc
tnrVexsj0dFgn71PXucSVgiV5nAlm+5jriU1je8LFtFpovPD8lg+5ovognX0u1FW
Z98QeIus0fnl3eXy9hYu
=cvwT
-----END PGP SIGNATURE-----

--------------enig8B2ACB057839B90EC8DC96FD--
