From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Feb 2014 11:40:36 +0000
Subject: Re: [PATCH 1/1] video: s6e8ax0: Use devm_* APIs
Message-Id: <52FE00B4.8010003@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="h6or0l5e61W72VviTQiWG6EKHpUO9II41"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392198779-5203-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1392198779-5203-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--h6or0l5e61W72VviTQiWG6EKHpUO9II41
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 11:52, Sachin Kamat wrote:
> devm_* APIs make the cleanup paths simpler.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/exynos/s6e8ax0.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Thanks, queued for 3.15.

 Tomi



--h6or0l5e61W72VviTQiWG6EKHpUO9II41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS/gC3AAoJEPo9qoy8lh71e9AP/2MpueWmZKBiOglPvc/bw64z
+aXa32VN7sIkTQLHyq3+SHXHV1dwJ8VotnA/j/yRVpx3e7jI2L3wFMgWXmU+VyAi
sAUJ2r4WdVMXghBA+1WoOTFO+/I+DvsSfKKeldVXx82kNHExyr1FIqFPAxmB7a2N
p4RO/pzrSGzTpB4kNcy0n6jDwnIOiiGXA0ift0s+OSrLZYlEaM1k6lnCIr6w1WWI
GJChzhw2QS5cQaRRP7LyHUShCddj7dDdptt/kF0jwCBv78xjNNFvn7iViGyg412p
XCbw8PavPXayZgsTUF4oHsIHtUN797tD9g53WSkp5Xp4EMXlW/CU11RWgDWtoRQ0
PFhiAFXaz0Fa8kDsKngai6TwNN1+pZ8ufo2y8tJxsDYXO4+0WNE3N8tVrFa4BGpf
EC3cx14tw+rc3oe1cnH2uJ6k4iFUPItOVI1UchGd5qtfoqxmC+dTHzgC7ahJdSjz
NxnIN6LZa6Z65eEfvcaWjzMVJ3aHCXNAvILhF6hlZPvl9N/CWJLQVl5i5OKrU4AN
JBDXyZF75V67PnJot7D6NMNV2ssucvPWII3uDO8tNqnKcnCASml0yITOsCLjMKNZ
8vkkz3S2RbAncU9l9mpa4TAOChlifbzGBluOCQ7AreK1qAbZsan3BnGCA3wB8BSd
mJB7JSVtZw1v9uge+MeV
=GCPD
-----END PGP SIGNATURE-----

--h6or0l5e61W72VviTQiWG6EKHpUO9II41--
