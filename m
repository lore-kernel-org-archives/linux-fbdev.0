From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 23 May 2014 14:10:35 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <537F56DB.1050709@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cOFulN8HU9T6gu8Ttb8kFb3PHkXALJBOM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--cOFulN8HU9T6gu8Ttb8kFb3PHkXALJBOM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 23/05/14 16:13, Alexander Shiyan wrote:

>> Would it be possible to add the new driver along the old driver, and u=
se
>> the new driver only for the boards you have, and for boards for which
>> it's clear the the old driver is not working? This could be merged for=
 3.16.
>=20
> At this time yes, we can. But since I plan to add multiplatform support=

> for this SOC, this seems not possible.
> I can try to make multiplatform support optional, then it could be done=
=2E..

Hmm, why is that not possible with multiplatform support? What do you
mean with multiplatform support here?

While the drivers would handle the same device, if they have different
names then they are different device drivers from Linux's perspective.
Why can't one board use the old driver, and an other board use the new
driver?

> If there will be two drivers, I will do the following: remove the non-D=
T
> support (for new driver) and will create a patch for 3.16 (this patch w=
ill
> no affect to arm-soc).

There would be no one using the driver in 3.16, then, right?

> After that, I will do optional multiplatform support for this CPU and m=
ove
> the boards, which do not use FB.
> After this architecture will be ready to add DT support, and after all =
boards
> will be converted, I'll remove the old version of the driver.
>=20
> OK?

I'm a bit unclear what the multiplatform stuff means here, but yes,
generally sounds ok.

But I don't want to make this more difficult for you than it needs to.
As I said, I'm fine with the current patches, if we skip 3.16 and get
them to linux-next right after the merge window. If nobody would use the
new driver in 3.16 anyway (in your proposal above), would this be the
easiest way?

 Tomi



--cOFulN8HU9T6gu8Ttb8kFb3PHkXALJBOM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTf1bbAAoJEPo9qoy8lh71UnwP/0UO/lc7elyFBCnkxR9h6RPs
8GkM2N5jB0yY8QEL0VUC4fW0cOjZ0Y7nc2tHMtHj2q2246wHrDnmaMBhuupIsQaD
hlgXfLLOts9XGz4nLraQiXBaqxDJVXnaZP8RdakTgTRzNXZkRCN3ACIEsmZaNmuI
QzSOkyOhO0eW8KpuFPUzpynr57eFcv8AhV8ffHqyFwxkm7K6ZW4BSCnnkqt3ZCIO
SItN7JLzmVxvRaWusTbQ+XjFA4PqihntZaFqY3wIfOYsk6JY+ZdQPWMwgaH8EqiQ
CM9uFXfJBG8gGrjhsDSGheORJtWp2pIdxCwU46dv/kmm+Mb99Nm2PUQteMF3zc8y
XYUiBR9qOP8tXVjlSm6uQckRY5qb/w2yPtm32ng3bqxVAFt0r5WOnwr/0JisgKug
llMXrDB4aRaxt7OGxXRiIcVdx7E+xOFHjA2dt/fqSZ9ZWiBeHVWy3rbDGbYRVZbe
FEjtodXKHQaFR2MtjLAIpmXyQtiVAJvBjtIr5eGn2X7xaQskmw4UkykQk+lqt6VW
l5EXYhmP7vrGZlPNH65Rzj1V2oKFx/J6Ym4A+XokC6MimahQMFcw3E1B6AduGxj/
lKWaxCLqNzn7dbfDwDTaRcD6ku5XWcoX+6zm80/+CeAZC2mojKWg4FE5rGFHEBwL
JfvW+V6KPt/Hc4bRgWdT
=5lFy
-----END PGP SIGNATURE-----

--cOFulN8HU9T6gu8Ttb8kFb3PHkXALJBOM--
