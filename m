From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 19 Mar 2013 11:56:45 +0000
Subject: Re: How to manage OMAP display drivers in the future
Message-Id: <5148527D.1080102@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigB51FC82F41A50B44C795D5AB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <51403F91.7070401@iki.fi>
	<CAF6AEGs_6kLU=OR-mX9kvr=_t9-z4+StobksaW+MfcnhEu2XvA@mail.gmail.com>
In-Reply-To: <CAF6AEGs_6kLU=OR-mX9kvr=_t9-z4+StobksaW+MfcnhEu2XvA@mail.gmail.com>
To: Rob Clark <robdclark@gmail.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

--------------enigB51FC82F41A50B44C795D5AB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-18 22:46, Rob Clark wrote:
> On Wed, Mar 13, 2013 at 4:57 AM, Tomi Valkeinen <tomba@iki.fi> wrote:
>> Hi Dave,
>>
>> I'm writing this mail to get some ideas how we should manage OMAP's
>> display drivers in the future.
>>
>> As a short intro, we have the following players around:
>>
>> omapdss - omapdss handles the DSS (display subsystem) hardware. omapds=
s
>> doesn't do any buffer management or expose any userspace API (except a=

>> few sysfs files), so it doesn't do anything by itself.
>> (drivers/video/omap2/dss/)
>>
>> panel drivers - Drivers for various panel models. The panel drivers us=
e
>> omapdss API to manage the video bus. (drivers/video/omap2/displays/)
>>
>> omapfb - Framebuffer driver, uses omapdss to handle the HW.
>> (drivers/video/omap2/omapfb/)
>>
>> omap_vout - V4L2 driver for showing video, uses omapdss to handle the
>> HW. (drivers/media/platform/omap/)
>>
>> omapdrm - DRM driver, uses omapdss to handle the HW.
>> (drivers/gpu/drm/omapdrm/)
>>
>> omapdss and the panel drivers form the lowest level layer. omapfb and
>> omap_vout can be used at the same time, but omapdrm must be used alone=
,
>> without omapfb or omap_vout.
>>
>> omapfb and omap_vout are not much developed anymore, even though they
>> are still commonly used. Most of the development happens in omapdss,
>> panel drivers and omapdrm.
>=20
> I'd guess if changes in omapfb or omap_vout are mainly just updates
> resulting from omapdss changes, maybe merging it all via drm tree
> would make most sense..
>=20
> Although I tend to think life would be easier w/ some copy/paste.. Ie.
> just move a copy of omapdss into omapdrm directory and start
> refactoring.. Offhand I think at least in the hdmi code, I think we
> could jettison the big timings table, and avi-infoframe stuff and use
> drm helpers.  Probably other places where we could get rid of code
> that duplicates stuff that drm does (or could) provide helpers for..

I've been playing with that idea, but copying omapdss is not so
straightforward either. The panel drivers, headers, kconfig options,
board file code related to dss... It could easily create a rather
confusing mess.

I'm hoping that CDF in some form would realize soon, and then copying
omapdss would be at least somewhwat easier, as there's no need to drag
the panel drivers along.

 Tomi



--------------enigB51FC82F41A50B44C795D5AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRSFKAAAoJEPo9qoy8lh71KJ0P/iL/DyIxZxZdL7hJ7hm2jqk1
uNeMVYnub+GAXtN1mAAx39H+N/98MOLlydYH9Pcz/BI9ASmu9Cgbs+8zEb8S5c1V
w66uS4scFC6oCBWh/V2Bwz5Pg1xogeC8O9S3Vu82NOIIQ3KNMRiSzi+H7K63G/Vz
2g7F5464zje3cvNf2xqnHpxXt24hueUY+/QPvCwogEhCJwNH+209b5u4MV4yDE+w
VLEN7eGLKPTLWHyAdSrZfxD3ynMghWWAd3bZT6x2TZ/n1BluembsISU7RjDfs4Ca
3HDL+y6O6BrpyFpq+UlJ0GiwFj/0dmKdXQsIV9aF+4SnuBCbItwsZA35EirJlcx/
ZYxpDBLwRJ63atQHpLThv4bGVV4SCUsn1Y3EDVet/j31/adp+f+DeCIG4Idq1yqy
nmqP9x0cLV963kCs+TYTefS31kZYVhk0Q02X2oc4aAqB07WHVf9osVev5PztLAoP
iYDiGx2VA1ihzUzVunKpZo2FhLEhwB+uI0Dq85u/8fCv9AJc1BH6tmIb+rRCiQdo
7IbPZrpf/umq6hcYAAiES7Yyx4X+9BKZ8dNlc4z0oW6lfmyu4Ic2hoSglSKIECQ2
kBTc3YVWIGDDi8D9mvS3dhr0XiEa/mw7II9jvjKR5939rxXw7TrsTH0oW8mSwuoA
JxJFq8CDll3BI6hWqR7D
=BWkW
-----END PGP SIGNATURE-----

--------------enigB51FC82F41A50B44C795D5AB--
