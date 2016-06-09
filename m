From: Mark Brown <broonie@kernel.org>
Date: Thu, 09 Jun 2016 15:57:46 +0000
Subject: Re: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
Message-Id: <20160609155746.GZ7510@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OCeUrMLoh2ht7f6S"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
 <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
 <20160609102925.GS7510@sirena.org.uk>
 <CAJZ5v0hiyyOhU7AjOEjFHjTKhT+pqWZheUG77c6u2HV9dNQ0Gg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hiyyOhU7AjOEjFHjTKhT+pqWZheUG77c6u2HV9dNQ0Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--OCeUrMLoh2ht7f6S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 09, 2016 at 02:50:26PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 9, 2016 at 12:29 PM, Mark Brown <broonie@kernel.org> wrote:

> > The external interface shouldn't be DT specific, the Intel people are
> > busy importing all of DT into ACPI

> Well, not really.

> If you are referring to the pinctrl proposal discussed recently, that
> was a proposal from one group at Intel and AFAICS it has been
> abandoned.

Well, it was that, it was the device properties stuff in general and the
overlays stuff - plus just the fact that with the Minnowboard style use
case people have and the desire to use ACPI it seems like that's going
to be something you need.

--OCeUrMLoh2ht7f6S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWZH5AAoJECTWi3JdVIfQvS4H/i9Q+NK3qFJ20x5n4tnU3Kqb
R5CadVol9AxuB5DmzVxduAAdc4YGDBs+cxJXQVJ0kjNNETE0V/5g6AhHf1frJe5c
yctigVuTXIeHXHQOS1NfpmjVKQwIFMJ5xvHy+XRAcAeNlmkKEGR+Ayma3sFk3XY7
MfUWd7652D2mejDNXLp6V3UhgfDX8u5qMuYazGor98EVDaiidh4k1AqK7LyfMQQm
5f8El3h6+LOCHyxPBF+hopBJwoKg1FLoYiXzBWAzbXajTmpBkQdXLa0QaoKYu/2j
vzrTjqjb2zvvbvQbEnDz4ZjXcrfK2Aa2qjfrohDSp+hO4uqtnU1URD/19EfObuA=
=tIVl
-----END PGP SIGNATURE-----

--OCeUrMLoh2ht7f6S--
