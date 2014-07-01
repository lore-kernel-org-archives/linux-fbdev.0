From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Jul 2014 06:15:45 +0000
Subject: Re: [PATCH] video: fbdev: s3c2410fb: Move to clk_prepare_enable/clk_disable_unprepare
Message-Id: <53B25211.1000600@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mctXk8pti7WENTOOJllMHBrcUmLWsAkVJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404155672-3158-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1404155672-3158-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org

--mctXk8pti7WENTOOJllMHBrcUmLWsAkVJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/06/14 22:14, Vasily Khoruzhick wrote:
> Use clk_prepare_enable/clk_disable_unprepare to make the driver
> work properly with common clock framework.
>=20
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/video/fbdev/s3c2410fb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Thanks, queued for 3.17.

 Tomi



--mctXk8pti7WENTOOJllMHBrcUmLWsAkVJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTslIRAAoJEPo9qoy8lh71OYgQAKx5SF2BKlLiro2jbPcJgQhM
wNlmeieuhMEjomTj0oyQFBidxs0CLZt4aO75FqqIFZwwwA/Bum2xbtBCoDwCiJ/8
TIZKjOXDndOGoNpaMAHO2LxpC1no+7te92uM0SoXD741nxBnHLJzZ0eGFNiPpjqu
pZiXDCqgaWT8/ej+OF9+9wecfN0wiKkpFLijCrUHmMJuVukqBEBnJg1W7t5td5Da
GrYfEkK8CckMqkmwyCJ1QpKmJzAdPRuiig84cfyabQAAo8z4FwTsjvCMLz/g5tge
AxRN+1eGMTjuF4Jrx442jlMFZtwKSBx86DnNvKa41Co/1PcJKYO1DgxbRqzBUF+T
c7iAoCA9PoNvxUtAT2KSRSaUiDK8GD7fktpv9jw7C1nh6oZ83Qrfb0UP991Qibx/
hAmaTwTo6q4XFPTIK24dj3fetHJpRrJBkqFNRWUV3xxVY67hHm8sW9ynzMfTiMcT
l/NxHPlWbCcMXmkOhE87x0se79r65aa0mCghN/Gwv1AGjHGiXsD8JlVPmAF+Z2ao
08+cbVz6DccRXVulQ/mLEGzSzVlzc0qFWVfzTzRo99z7GmOicrqSuVBqScnMxVNv
JiVQkJcn6TzJgjJWgR7+V1A9W7gDt9kJ8hT00X7PT8ELMGd27168sX/hwHIWtmOu
v/FvncjGQR582FiGnAyc
=yAIT
-----END PGP SIGNATURE-----

--mctXk8pti7WENTOOJllMHBrcUmLWsAkVJ--
