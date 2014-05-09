From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 May 2014 10:18:56 +0000
Subject: Re: some divide by zero bugs in >fb_check_var() functions
Message-Id: <536CAB90.5010900@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9cALjThbF6DH3rRtvDtP1bjgcwxaRP9OE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140124223503.GA4251@elgon.mountain>
In-Reply-To: <20140124223503.GA4251@elgon.mountain>
To: linux-fbdev@vger.kernel.org

--9cALjThbF6DH3rRtvDtP1bjgcwxaRP9OE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/05/14 18:48, Geert Uytterhoeven wrote:
> On Tue, Jan 28, 2014 at 10:28 PM, Kees Cook <keescook@chromium.org> wro=
te:
>> Is it ever valid to have pixclock, xres_virtual, or bits_per_pixel be
>> zero? Seems like it'd be trivial to check for those in fb_set_var()?
>=20
> pixclock could be zero for some special fixed type of display that does=
n't
> have timings. Hmm, you could use 1 for that. Are there any in-tree user=
s?

I have no idea if we have such drivers. But in that case I would rather
use pixel clock of 0 than 1. It's usually much easier to notice uses of
non-valid value if it's 0 than 1.

But maybe that'd warrant a new flag somewhere, to mark the fb as having
no timings.

> Anyway, the checker reported issues with specific drivers, not with the=
 core,
> right?

Yes, but the issue seemed to be so common that it'd be nice if the core
would check it.

But looking at the longer list sent by Dan, it looks to me that there
are also lots of cases where it must be the driver doing the checks.

 Tomi



--9cALjThbF6DH3rRtvDtP1bjgcwxaRP9OE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbKuQAAoJEPo9qoy8lh71q0MQAJvWooKjQnZp4Q3ONmS5YXeZ
ylh9FOHYg+XnngCbU+LdJ9+YLp7rewomlnczwQHKLSuOxXdONJ6bq3n3Yc9kkJRk
Fsf+0eERfmHRjUam+8N7EMI1h4IFysorHriVnLM6fzfd6qG++vtgR+F624ix18Js
j+vRlp4W2kGVuYeu/X/Uxbva+2aPLxoCud8yms/WwqEWmPAQxT8L2zKHGOZKm+7g
jV3U5TsQDx2XnORUgQlpR6QUqK/DdJqts3a020ZZeAmaw7gzdoDISqiw64negw6P
Rb5+5tSUa0/CgyjFe2dNhM47Yb2oYiR3eNyv8X/OGmlhQkwrUEe7veaZCS0VRJM1
xiPx9rKYlO7BiBrGKAKfx63nQD8dcsWSwG/KQ0bb+ygahw4EE4KlNjxR/PSvAMY9
VA6rZPO7BtlCLAeu4fozAm/yXILguMpXacjLIJEgkUpKuBQEKLlHs0fGz9I+rMh1
YeVkIiHlLGGd5EmWS3n4fQueyDaHu40tci1+A5Ewid7edaiJPQk1V4+NnROKg67t
tttgHzB0MzydT3iVcC4yzwcxFtWtYRiKaco4ZXu1NV+/ANgZYUZaqZk58RHEGsHc
/o2gv46QsAyH0rKI0b+i4jLJ8efsR93KEebihH4rPp2OKsG0R4/kIiq8cpCboMjF
QS3maEwzq4nOVcAAvwn7
=DFdY
-----END PGP SIGNATURE-----

--9cALjThbF6DH3rRtvDtP1bjgcwxaRP9OE--
