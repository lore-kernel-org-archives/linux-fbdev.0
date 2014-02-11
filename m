From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Feb 2014 13:12:47 +0000
Subject: Re: [PATCH] video: xilinxfb: Move xilinxfb_platform_data directly to the driver
Message-Id: <52FA21CF.1040809@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ISMwuIjBEdGC4fnl2bQHI8toMbmHQspSP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <af8de8bd8803b319c0f6a02ca5109768e5ef8457.1392101292.git.michal.simek@xilinx.com>
In-Reply-To: <af8de8bd8803b319c0f6a02ca5109768e5ef8457.1392101292.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org

--ISMwuIjBEdGC4fnl2bQHI8toMbmHQspSP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 08:48, Michal Simek wrote:
> No reason to have separate file in header in include/linux folder
> if this is purely driver specific structure.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>=20
> I have this patch in my devel tree for a while and would like
> to hear your opinion. I can't see any reason to have
> xilinxfb_platform_data in header if this is purely OF driver
> used on OF archs.
> ---
>  drivers/video/xilinxfb.c | 15 ++++++++++++++-
>  include/linux/xilinxfb.h | 30 ------------------------------
>  2 files changed, 14 insertions(+), 31 deletions(-)
>  delete mode 100644 include/linux/xilinxfb.h

Thanks. Queued for 3.15.

 Tomi



--ISMwuIjBEdGC4fnl2bQHI8toMbmHQspSP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+iHPAAoJEPo9qoy8lh71Kz0QAIKXcLqRcJsDM77rYnfaZ9h9
2gDAPo2bxtkm9ZZ4L28Bhuxs0kmNlq1XzEbTcbtZiOxIRl0yvR735JDymV3zloGz
7z1N6/U0d/m1ikwQ84HOSo4TC8T0yIiVJEEumMskiAuKTW0SNR2fPEa1vu3OBCf2
Nmv2AtWzU4zGLeUGpJ6z+VVgVnqIeFYMUhUeWywjOTGzMWlXlRHUNQiuhoIWbThV
IRr2Qu0raADfM5knNB1vB4iwf99Qwp/Bo5MM6ayzRD78l74OotOVbpB2NZ7wSD5i
nrTSMtSbl2Jdi0xdSuUiIDZNzwWs/7Q7LS/Wspg9gttG01G8QPFl6s7q5oFBwWE6
TMNFwRJHZ8+lFYNwVxqJJH5B6cFPEtYZ08e2Nq+37/uGQ/FPvWzzKeP6DU0YZwkc
HY0CV7KM6oLcZO5BPlZYZ5ufnF63a7yEZy36Z7PXWKe132Ducmg0hNO/rliESL1G
iMumHvpoGoz82GnAtGxbYaCy0zbrf6CT7I8f55AJL+oPVoijnXNmx+rnx0Rk04eG
usSqW18M4jKzzgYzSjDkN3CTSzv/sD61J5h36btsqeTY5pdeecSSx/g9GotN2sov
vRHHtgfHnkZuXG/W63+sIEq4Qn3uoO3WlLlzaNvM5lApDiH4uEfSoGZtBMfwVrii
AUq0+Cf3HMl9pkE6R3KD
=4zlY
-----END PGP SIGNATURE-----

--ISMwuIjBEdGC4fnl2bQHI8toMbmHQspSP--
