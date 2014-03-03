From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 03 Mar 2014 08:04:38 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <53143796.2050309@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mLdtcipUaru7vkkgJkGglhP09QM6T3nLr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <20140228162752.GU21483@n2100.arm.linux.org.uk> <5310BDE3.60603@ti.com>
 <20140228165628.GX21483@n2100.arm.linux.org.uk>
In-Reply-To: <20140228165628.GX21483@n2100.arm.linux.org.uk>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--mLdtcipUaru7vkkgJkGglhP09QM6T3nLr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Rob, Pawel, Mark, Ian, Kumar,

On 28/02/14 18:56, Russell King - ARM Linux wrote:
> On Fri, Feb 28, 2014 at 06:48:35PM +0200, Tomi Valkeinen wrote:
>> This is totally unclear to me. How does it become a public standard?
>> What's the forum for this?
>=20
> Me too.  That's where I'd hope someone on devicetree-discuss will be
> able to help us work out what's the right approach here. :)

The story briefly so far: I've implemented DT support for OMAP display,
and created bindings for various (non-OMAP) display components,
including generic connector bindings for DVI, HDMI and analog-tv.

Russell's point was that these connector bindings are very generic, i.e.
they are not for any particular chip from a particular vendor, but for
any connector for DVI, HDMI or analog-tv. And he's worried that maybe we
shouldn't define such generic bindings without consulting the whole
device-tree community (i.e including non-linux users).

So the question is, is there such a community and a forum to bring up
this kind of things? If yes, should we bring this up there? If yes, what
kind of things in general should be brought into the attention of
non-linux users?

What I wonder here is that while a thing like DVI connector is, of
course, more generic than, say, "ti,tfp410" encoder chip, but isn't the
case still the same: we're defining global bindings for hardware that
should work for everyone, not only Linux users?

 Tomi



--mLdtcipUaru7vkkgJkGglhP09QM6T3nLr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTFDeWAAoJEPo9qoy8lh71i38QAIix94EUjiYHPVzRVIjjWcYQ
b2heqft8UTQHFkpEjj5hUc/Neie7Ub2sUqt/tjzqpS81Z+O4+qbDmnnvfaY6Ww81
Vm8wAmno4NiHfX6oSGEtHRajrMEAg+taMoSFwfQLQQUTj8YYXWsG+UWs1UeT8wbM
vbX0HXlR4RINxG9foo0zO1lthIOKfmL1a1XVWxEsm7lHG6UsNcCM3QmX0m3IpJ3V
KUv2XSPOqOtvPRUdYUxzwBjWn51T4ANAl5j+6B8Y2vszocplBJRJ2NRKbP2SkiZf
Qhy3b6svhk3DOVMCq7jMbB0hwJqMKdbg/u9NyPv0e7o42TxsRqe1KVCECjHOp1zH
i2TvgbeCyqCojNAxw2GttMBIPEa067xxK7yz9iL/iw7GkFVZd8iffAZ9OtK91hzV
RVEhVGo5vYNicduAnjdk1hwVKvB+p0HQ+UWs8A015TpbARVNh8mRQoLvdO0Nle1J
P9jIAMKamnmXtLzALMDY6mVXjk6xrSjvFN4yhBe9Ep1LXARvSTwYJe6kzl5mxhpN
BwXxS8Xw6zeVDtu3aXWC5rQcEV96q2rKry0qnQZ2F6AoWkjgPLSG1VVLkuQHed8z
TNfwJE0Va/skJga1BD5sm9MWVaasRqc8YRj4Kz79QjkAt1MSVjLKrijSfEkBAoSf
IXOlJp5t+6d3gQk0tgu8
=sdgg
-----END PGP SIGNATURE-----

--mLdtcipUaru7vkkgJkGglhP09QM6T3nLr--
