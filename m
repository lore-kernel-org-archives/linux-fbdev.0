From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 24 Jan 2011 20:43:17 +0000
Subject: Re: [PATCH 3/4] drivers/video/bf537-lq035.c: Add missing IS_ERR test
Message-Id: <201101241543.19543.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4542647.ktSb8pjErU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1295898922-18822-1-git-send-email-julia@diku.dk> <1295898922-18822-4-git-send-email-julia@diku.dk>
In-Reply-To: <1295898922-18822-4-git-send-email-julia@diku.dk>
To: Julia Lawall <julia@diku.dk>
Cc: Paul Mundt <lethal@linux-sh.org>, kernel-janitors@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--nextPart4542647.ktSb8pjErU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday, January 24, 2011 14:55:21 Julia Lawall wrote:
> lcd_device_register may return ERR_PTR, so a check is added for this value
> before the dereference.  All of the other changes reorganize the error
> handling code in this function to avoid duplicating all of it in the added
> case.
>=20
> In the original code, in one case, the global variable fb_buffer was set =
to
> NULL in error code that appears after this variable is initialized.  This
> is done now in all error handling code that has this property.

Acked-by: Mike Frysinger <vapier@gentoo.org>
=2Dmike

--nextPart4542647.ktSb8pjErU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJNPeRnAAoJEEFjO5/oN/WB218P/02NaQe+P9RR8qyHQKItMfCm
7ZGjjfuLTgTc9+1w4ijcDKdJQMuq1KzeiG033+LhNA8LdJ3jpmc4gVuslwbjYl1y
CGKAeLsUIfuAn/s5A/4iMzBsREXWadlX5Ze8T6zDQKBrr2UJMqFfhualSlt9W7Ho
1UEt6kXEKINf5lbD8LHXQV2zIlR0tp8qJ/4xLbCacs8G4gMc6GaYxHiDlAxvk8WY
qMZI05QPr1ykMFTX/T2OEc6fnZAHlZ+VbuR2YUb+UC0TEClbbV7J4sVh7wgbGpoX
YPLF7bLkVYxVfVyAMii4REaZiXx3bFi8iPNde9AgeDFoo7HmF/DcLy0qaWIOKj9F
/jp/0ELj4HW8LfszeGezvMIGsMiGbkkt2rMe5j5NOBNcFRxDyZP5YB8zUnMBj7Xv
Ut75erzf1wg5QGUf6FihzYt8LoKmlvIoM6oMT1YrDjAQeG5ubi2KtSyqEIRza0KL
sEoiu/ZH7rMZ3zjeWytRbCt5W0fspcx4tU3rVyvsAVEVT3n3cYu5T945XsLKE7xw
0azDC6lRIfLSLBoXZURNHi+hz0WxiMn8viyYvS5buoJoV0NR4DPRmjiwinD2bT8P
Oe/FJxB2eGTGkAu1WbP0ie43QerKytmpORZz0QFcE6e0CSVTPbBYozicXUfnG7oM
fWB4/xpyTFWclTw36WTj
=JU5K
-----END PGP SIGNATURE-----

--nextPart4542647.ktSb8pjErU--
