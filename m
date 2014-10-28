From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 28 Oct 2014 10:52:53 +0000
Subject: Re: [PATCH 3/5] fbdev: sa1100fb: make use of device clock
Message-Id: <544F7585.8030708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GFuLUKe2xBN6uh9fAkVoq3JPWmsb9vERE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1414147047-12892-1-git-send-email-dbaryshkov@gmail.com>
 <1414147047-12892-4-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1414147047-12892-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org

--GFuLUKe2xBN6uh9fAkVoq3JPWmsb9vERE
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 24/10/14 13:37, Dmitry Eremin-Solenikov wrote:
> Use per-device clock (instead of calling cpufreq_get(0), which can
> return 0 if no cpu frequency driver is selected) to program timings.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/video/fbdev/sa1100fb.c | 24 +++++++++++++++++-------
>  drivers/video/fbdev/sa1100fb.h |  1 +
>  2 files changed, 18 insertions(+), 7 deletions(-)

I presume this has to be merged with the rest of the patches, so:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--GFuLUKe2xBN6uh9fAkVoq3JPWmsb9vERE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUT3WFAAoJEPo9qoy8lh71uCoP/jKVENbK5W3oxInd/hxf1gyU
Yr6tCFMDDghacBWiovGLwbpK2RDZKtpe2Y/0THAbeGcLXDTDT4FdMIoIwpnQBJ4q
3qz35+/wjq5COqm1xf7kX2VeF7fkeZINEq5xZO1mIbCPOgT0bKkcelLQLOHJ9RtV
eaAjzYaaavnNMINstMyU+/k0Ra1W9yqkheeJ6Siz4dyH3LeGtBeBUBYHxJXxiZoz
Pd79TyRMvw4sONBd4WnLocHRplLpWNnL0uJtw/3T1OddKrk9WdUDzWbhNKaPu7VD
2yptK2VhLlUvQR7JtQthLwGBzHbUYoFfuclpsHDLYAXSDP0Pf3Pga/aiFUCUW2y/
gUs3weG1jzshi1SUycMD+XqjFQjORiYTQgTnBYSapGqiUb+/9IpAsQpUegX84khz
thp0N2kqODRQ6BYr1GtOfH3hArleKoMk8eNHwglwj3FDG+khsF3uqg8gJXOkEa5e
M9adzngqllPknWxpkSx0/m0vwyA+QV2oWwubleXVAxBrv7m5LZ+3eGY722f9ayZV
GZgB7p9iya36KbkxrQUw/tdnrEuJDRYiU7ssoAyVjTByys5i0Mezs9pg7z7E+0VN
IdXTcjsjkZiu7t0F1axEaywNNiFuDUHl4mT2xmnEDqiB7HIz39k4AjgZ02ck2eWW
3o+ajjpJMvHSU2msvlzh
=wip4
-----END PGP SIGNATURE-----

--GFuLUKe2xBN6uh9fAkVoq3JPWmsb9vERE--
