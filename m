From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 07:15:23 +0000
Subject: Re: [PATCH] video: exynos: Ensure definitions match prototypes
Message-Id: <5220468B.2090304@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JH6O745Mwki3Q2iOFiXmTnIkUsoIr4dKp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372764414-9102-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1372764414-9102-1-git-send-email-broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jingoo Han <jg1.han@samsung.com>, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

--JH6O745Mwki3Q2iOFiXmTnIkUsoIr4dKp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/07/13 14:26, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>=20
> Ensure that the definitions of functions match the prototypes used by
> other modules by including the header with the prototypes in the files
> with the definitions.
>=20
> Signed-off-by: Mark Brown <broonie@linaro.org>

Thanks, queued this for 3.12.

 Tomi



--JH6O745Mwki3Q2iOFiXmTnIkUsoIr4dKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIEaLAAoJEPo9qoy8lh71R80P/A16bQ1Fz8jG/kZZb260p3Bj
1IrBKr2WyqY8CNvDfHPE87lHf1TIjU8p/kyPx1ZIlMouL4Mrn9lIjFBFvgD71Rzc
A/vRC4rzbFFxACNt0aeCtiYYiGLANZDxYGoXdm5/DLX5Kz2dyJCfHJi0yL1IWWf9
joN2hO7KWUp/zvw7sAHIHHIoGDxLNTMScGFKzMl+GT1aYZvy7p/giVnxB1PeE7OI
mlS3FGm23wTbe0lhM2vtKx2KRmFj4RR77b7K1s22uqDy8QjDEnMdxI51lY6yENfq
hjuOJcR4RhBs+XPfWLTlvVvf1H+QHiBvyBL5Nt0OSS5Iw1bVmx54Hir+MSuSjlXb
OX9aLWCcqsn+QbeWiosz2RxAfazruwcBGHQsqMVejXZM2Wznx7oG5iRvbIAUqB8U
nOlMc01as2nkePdurLL/kg9tRIlcHlz4q3BjKF4HmKxlmvgjmO+cQIQL4oMmDWA7
RyAgNs/m5ZXKdIfQYWo9uC1Nj6qX1fOWPN1x73Diizos0tRTTpFlN3mlIAer4MqY
Vk3Z3zsYBK5lFuOin2e+FUAC0ZQskgZBSqmO7jmuFpRL37Nj4Wbcmh0v2oGUOHeI
fzJqhrOPVodu4779feeDrgh/4va7CP59YJiE0owDkY7PG3hgPlODpGpHwblG6IEv
zczAyW0wK9zhe1TzN16p
=1h7W
-----END PGP SIGNATURE-----

--JH6O745Mwki3Q2iOFiXmTnIkUsoIr4dKp--
