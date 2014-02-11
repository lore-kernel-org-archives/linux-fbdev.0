From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Feb 2014 14:06:15 +0000
Subject: Re: [RFC PATCH] video: Use fb_sys_write rather than open-coding in drivers
Message-Id: <52FA2E57.3010300@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QVPrfwc3wawPJcD5Q9EiX5Fg3JejxVlQt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <523BF40B.1090002@gmail.com>
In-Reply-To: <523BF40B.1090002@gmail.com>
To: Ryan Mallon <rmallon@gmail.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--QVPrfwc3wawPJcD5Q9EiX5Fg3JejxVlQt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/09/13 10:06, Ryan Mallon wrote:
> Several video drivers open code the fb_write write function with code
> which is very similar to fb_sys_write. Replace the open code versions
> with calls to fb_sys_write. An fb_sync callback is added to each of
> the drivers.
>    =20
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> ---

Doesn't this change the behavior so that fb_write does no longer update
the display, but fb_sync does? I don't think fb_sync is even meant to
update the display, it's meant to wait for an update to finish. Then
again, I'm not sure about that, all I see in fb.h is "wait for blit
idle, optional"

 Tomi



--QVPrfwc3wawPJcD5Q9EiX5Fg3JejxVlQt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+i5YAAoJEPo9qoy8lh71MFQP/inA/g1qn2yD1hZsjbQEMKKs
JgjBZYmvzuzsRxLHQ5vTVj+fS2H9LX8l0zL6TdFfk6k1VFBXsOCfa1Otn9FftJoD
pNuKI1ePMnim5b3VG8hGs1AA12JToVqiSAq2Tx1A/XBZ3Xeg3ZGFwCqyzWOBTuU0
9thg8xdzfWETfn7NKn8pjnZsKhX+CwLPo5waZj6id3Qlx4xg0HgYvW2hXplQzIFJ
WP3w3b+0CK5kEeh+pNFkuOcWm9+CzzvjEOjgVGcqolCLB3bRZtdLtI7ewR7iGVVd
l8GpHc4yEfC0mkrhYOQkdJzlo+NwXzW8J6q3EehsYK/rK36W/vJeg/Oh9VVoNczn
lJ1LEgXRYDnNHOpm/JXO6y3Z9Y/vK3qxVF5u92LX03sBKvzK81wNdgNVNFmWeAKk
YPUNDfDUTkoT6ahmDaqn3sZvBOCTklNAEDW7k0wyyFwWFcDxdyTLpF5WMsbS37u8
rnHR5NKYJ0l3q0fpc91NhfWRnYYPE44kz2h+lMUq1rp6BbnJyiAkuJU/Y/HcZcnO
GJIAfEkG6wtTV+8RJgJAJAfoN2vFPkcLU34wzncYxllUGk/NMtJvS6zKnCTXWZYK
yeqAPeCNg2mI2KhWtN/AkqfV33L3vbVHbU8cljWY8kewDkXQbJ3cacIuU/vCnCg2
SU9ttgqhoTK8hEKjs79R
=5wgk
-----END PGP SIGNATURE-----

--QVPrfwc3wawPJcD5Q9EiX5Fg3JejxVlQt--
