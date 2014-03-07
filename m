From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 07 Mar 2014 12:56:36 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <5319C204.60907@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5JWOeLC4fdU4qw5sRmoXIBHffhDt0KlTB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <20140228162752.GU21483@n2100.arm.linux.org.uk> <5310BDE3.60603@ti.com>
 <20140228165628.GX21483@n2100.arm.linux.org.uk> <53143796.2050309@ti.com>
In-Reply-To: <53143796.2050309@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--5JWOeLC4fdU4qw5sRmoXIBHffhDt0KlTB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/03/14 10:04, Tomi Valkeinen wrote:
> Hi Rob, Pawel, Mark, Ian, Kumar,

Ping,

Any hints on how to continue with this?

> On 28/02/14 18:56, Russell King - ARM Linux wrote:
>> On Fri, Feb 28, 2014 at 06:48:35PM +0200, Tomi Valkeinen wrote:
>>> This is totally unclear to me. How does it become a public standard?
>>> What's the forum for this?
>>
>> Me too.  That's where I'd hope someone on devicetree-discuss will be
>> able to help us work out what's the right approach here. :)
>=20
> The story briefly so far: I've implemented DT support for OMAP display,=

> and created bindings for various (non-OMAP) display components,
> including generic connector bindings for DVI, HDMI and analog-tv.
>=20
> Russell's point was that these connector bindings are very generic, i.e=
=2E
> they are not for any particular chip from a particular vendor, but for
> any connector for DVI, HDMI or analog-tv. And he's worried that maybe w=
e
> shouldn't define such generic bindings without consulting the whole
> device-tree community (i.e including non-linux users).
>=20
> So the question is, is there such a community and a forum to bring up
> this kind of things? If yes, should we bring this up there? If yes, wha=
t
> kind of things in general should be brought into the attention of
> non-linux users?
>=20
> What I wonder here is that while a thing like DVI connector is, of
> course, more generic than, say, "ti,tfp410" encoder chip, but isn't the=

> case still the same: we're defining global bindings for hardware that
> should work for everyone, not only Linux users?
>=20
>  Tomi
>=20
>=20



--5JWOeLC4fdU4qw5sRmoXIBHffhDt0KlTB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTGcIEAAoJEPo9qoy8lh712CwQAKUyobASNnqJYS6bK2FC8dc1
W+VmHqeh1/2IytHTY4WS35dZbQORctATG+X8yfgnK2T62ZTrBrFBopi9GQetQCmW
kTmulOpdkofyEuLBrLkgRYW1y2bJUBmqYggy2/8FXONotdTopTE9hAd2gDe3qmvy
bHIXpZorFheFLultNktYKLOKNv2LCzl/S67LJv7Jfq/2U1k2euYSP14FQuix5UpB
RvH3NgYNJJqw6yMSEeoLtJQfnnq3JBVH73bFvinMX82dnTXXmM4aWZtQUy0efIOJ
ZZX7OQ+qaUWgydHX6hXLvMxLP5q5nQWBRZfqqVzcgukplorEH/29bnAUiukfEGgM
dFU3v7xz/EWBREVLse2xRtEgbeSHorFhOUmF/SIYPZghhWqlBINfnfa5b6GYFt7O
qy7+inUf36BbbsbpprXNNcjKspeEK2NZPL+KuTXm/ZzjRKI7KRlnQktREfekzWx0
GwCERuQXjg/khz4La5bMW9NJBz/P2yt122IV5XX1Y2QNPIgnvkTmG1YQEzr5Q8mO
hO8YXYkOelmg32aKFjASbhp9RFkfOeqdF2ma2r28OBBGkofLvJDR/KmvmHPn1QYi
uoynqya5j0RQOaq+/b0CbSYpV1gIHKxAE0gwPxpe2snmei0apwrOYbXMdyN0JIdG
WkCp3tO/qj3KoN74dKjh
=5I8e
-----END PGP SIGNATURE-----

--5JWOeLC4fdU4qw5sRmoXIBHffhDt0KlTB--
