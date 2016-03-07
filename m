From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Mar 2016 18:40:45 +0000
Subject: Re: [PATCH 4/5] Subject: goldfish: 32 bit framebuffer support
Message-Id: <56DDCB2D.3010801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KXs2sNk4tUS2KP94trj1Dwnu2JakdFmXM"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--KXs2sNk4tUS2KP94trj1Dwnu2JakdFmXM
Content-Type: multipart/mixed; boundary="h9MFGdDah8J48d68LVQMmDvo4NcsegxU8"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Alan <alan@linux.intel.com>, linux-fbdev@vger.kernel.org,
 plagnioj@jcrosoft.com
Message-ID: <56DDCB2D.3010801@ti.com>
Subject: Re: [PATCH 4/5] Subject: goldfish: 32 bit framebuffer support
References: <20160226183940.2731.42083.stgit@localhost.localdomain>
 <20160226184219.2731.30360.stgit@localhost.localdomain>
In-Reply-To: <20160226184219.2731.30360.stgit@localhost.localdomain>

--h9MFGdDah8J48d68LVQMmDvo4NcsegxU8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/02/16 20:42, Alan wrote:
> From: bohu <bohu@google.com>
>=20
> Add support for display formats and allow the use of both 16-bit and
> 32-bit framebuffers in the emulator.
>=20
> Signed-off-by: Bo Hu <bohu@google.com>
> Signed-off-by: Jin Qian <jinqian@android.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>  drivers/video/fbdev/goldfishfb.c |   88 ++++++++++++++++++++++++++++++=
++------
>  1 file changed, 74 insertions(+), 14 deletions(-)

Lots of the added lines in this patch just end up removed in the next one=
=2E..

I guess these patches were just taken from some google tree and dumped
to fbdev. I'd appreciate if someone would go through them first before
sending.

 Tomi


--h9MFGdDah8J48d68LVQMmDvo4NcsegxU8--

--KXs2sNk4tUS2KP94trj1Dwnu2JakdFmXM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW3cstAAoJEPo9qoy8lh71cYgP/1q41TA+dg0EZxVU71h9m6u0
GFjqzte6mlGF9EtUmZvJ+yy53AG9S5W9P77VBtz/rkNeBFoGJZkg3WPBZdSAEk8E
x9uKGZx9ZIhQAsqA8FIBYj7q1y3mRwWoQ4wT0wQfxt12VHs7sUUJREssguqXoNAQ
FlOhoV+XOjGQOEHMytAq1hVdcuUv2pvOe6FV2v0hdOdVZ0H2owPPpDix4XgJxunG
EZXAEFOzeiLiPtMZIg7PEpIj7SjRujs/4qA6BfDSR++BeVOW6FtC9HdeOz+V3enX
BWJVNmEpkIaqA/1lwqYq2SzgXjyfjY//IfjLv5pMCjFaur6fAw5PowbSXDAzM8sH
/Ug2xHlXHggZUW8wvGI5qYDMRr5OtzpdCiFQhDsEY7BZysi4ZweOTGOUgpFexyka
cFG25b2YE28OyoI1BTeuBwPmGu0f9Q7RKTBM4Xup1Yx3XqZ8j1xF/FhPW3otyst4
nM3hgItqBUgDD3B6II+9OMSqjbS26c9Nn/NlVgOv/RIHB9tYktkpUIrpMzl8u03R
DJygtABzg/aywfRr4Ubkn/8B1X/drgwhDzMzD5K4S1tWjTg/gUEiZpAk+q0woQsu
8tTueB7gUEdYDqTe/d87x9k3u5IYh/25lg6dZdD5LGAUbnVpUT9wP4Hidke1RSpd
P9kcq0cSWahAHWX/5AAH
=sdUt
-----END PGP SIGNATURE-----

--KXs2sNk4tUS2KP94trj1Dwnu2JakdFmXM--
