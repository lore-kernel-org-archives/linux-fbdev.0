From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 18 Mar 2014 06:41:55 +0000
Subject: Re: [PATCH 5/9] Doc/DT: Add DT binding documentation for MIPI DPI Panel
Message-Id: <5327EAB3.8080405@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IiEVc4tMT8q1jBQnUrSuMGVbheetlKngH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-6-git-send-email-tomi.valkeinen@ti.com>
 <3721050.m43feCICLQ@avalon>
In-Reply-To: <3721050.m43feCICLQ@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--IiEVc4tMT8q1jBQnUrSuMGVbheetlKngH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/03/14 16:19, Laurent Pinchart wrote:

>> +Generic MIPI DPI Panel
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Required properties:
>> +- compatible: "panel-dpi"
>> +
>> +Optional properties:
>> +- label: a symbolic name for the panel
>> +- gpios: panel enable gpio and backlight enable gpio
>=20
> While integrated in the panel module, the backlight is a separate piece=
 of=20
> hardware, which could be controlled through other means (I2C for instan=
ce).=20
> Wouldn't it be better to add an explicit DT node for the backlight devi=
ce and=20
> reference that node from the panel node ?

Yes, I agree, but do we have the infrastructure or bindings for that?

Ah, I see we now do have a gpio-backlight driver, but it doesn't have DT
bindings.

 Tomi



--IiEVc4tMT8q1jBQnUrSuMGVbheetlKngH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJ+qzAAoJEPo9qoy8lh71R/0P/3N5qpEut3bGbyfPGd4xtjj9
E13b+bc89sbDTXUevxWaR2rgrqwi+Lt/isCczm5R3af5wHsAFSKC2sTKEz+AtlAu
TeilEjRmYmhiVewwU8tM/tWToUu6Qkcke3c6Z6DpDjphqQVPJX5/KoA8TLkUGNoY
TeDbktiG/sWHnTAvhp4x7nuEPuAv2xO3Zu9QlYIui7dAo/v2sDElfdtf0IChR3oX
r1oXFxYpMom9Oc74yh8LHGzCxEYfc+SRo9nwqIOgXVN673xRensFUbkIh4b0w0wA
irSuI2LbwsMvtMVt38TX2+WV/oJKeU/Av5Ge9i02rjC9GOx/ClpujznUSGhJFbaU
mLeknL9BJrY55wUCmFv/aG2zud4W4ICvwgcU/jELNx2s4wOfO30IzAnX14dK1Tuc
K+ER5A7gfVaSrSNRgVZuQ4kax3sNJtSi+j9VHgFWHq8m2+vk3rD9J8QeMTC0lGkp
OMmaexE5MrjYaD1R5Xk13XdG1YSs9hN8Xda42OQyMo5dVcTFyqbaJym7HAAUbegi
vqpbc0S63BEK4TGTrhU9fH7VtT2XR51QNIK3gfTjVLtqgzs1QeVWZmQ6hGjh6hN3
TuLZ8Pu152UwbJ8nRYBDIwxWI2jYrpD0W9VJMKPB6+84x5I+zAyxHpsvQduhiYtu
FSEFWEeeUAUJvrot/J/g
=ACUE
-----END PGP SIGNATURE-----

--IiEVc4tMT8q1jBQnUrSuMGVbheetlKngH--
