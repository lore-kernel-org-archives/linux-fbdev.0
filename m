From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Nov 2013 14:35:34 +0000
Subject: Re: [PATCH] video: exynos_mipi_dsim: Remove unused variable
Message-Id: <5294B1B6.1070606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pjjoPl5ov60xplEBGnw9KW8P4HutX4Acw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384463364-28864-1-git-send-email-olof@lixom.net> <CAK9yfHw7poMXWgRYBojzWsdoTxCMRf24YjdbxBhw=gohPrtwmA@mail.gmail.com>
In-Reply-To: <CAK9yfHw7poMXWgRYBojzWsdoTxCMRf24YjdbxBhw=gohPrtwmA@mail.gmail.com>
To: Sachin Kamat <sachin.kamat@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I <kishon@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>

--pjjoPl5ov60xplEBGnw9KW8P4HutX4Acw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-15 04:52, Sachin Kamat wrote:
> + Tomi
>=20
> Hi Olof,
>=20
> On 15 November 2013 02:39, Olof Johansson <olof@lixom.net> wrote:
>> commit 7e0be9f9f7cba3356f75b86737dbe3a005da067e ('video: exynos_mipi_d=
sim:
>> Use the generic PHY driver') resulted in a warning about an unused
>> variable:
>>
>> drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning: unused variabl=
e
>>     'pdev' [-Wunused-variable]
>>
>> It is indeed unused; remove it.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>=20
> I had already sent a similar patch to fix this issue [1] which is
> reviewed by Kishon.
> But the patch that caused the warning was in Greg's tree at that time
> and he wanted
> the follow up patch to go through the video tree. I have pinged Tomi ye=
sterday
> regarding this (now that his tree as well as the original patches are m=
erged).
>=20
> [1] http://www.spinics.net/lists/linux-fbdev/msg12755.html
>=20

The one from Olof seems to have been merged, so I'll drop the one from
Sachin in my tree.

 Tomi



--pjjoPl5ov60xplEBGnw9KW8P4HutX4Acw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlLG2AAoJEPo9qoy8lh71rM4P/ibWprz5prdzVoU6ehI4+9/B
/lMMcBN2eDbzBg8E0kmezhhjj7M8+YmlxVIpLqTC68edRgFtdJRsY9yPf0XE3YmS
XCKkWuPAEDAJOSWXrvnENQnS1/2QAs0tcc5xzNp/7/NH40VGwFPRRBaBIocByXH+
3CbCtfsIcGgVeQBIZoKrrbXRLPlC2QdjYzAg0sgNLrpS0x8eYA3vAp0fZOSqxHYe
ADTXtsIasFNfhipVhlV9col+R62X5AVqFpotmQJO3Su/KvoqQlSk+M/WdF/8NQg4
fH2hdn9PhlAf8FSFx60iRHxBZns79gbRFEJcZkYtq1F1QM1Ggx5yydrnovU3kVDf
FBd32ERaVQbKX7DwROLmqc4CuHdqdOeElWvg4d/sCgPakxWJ9A6smaGlJaxq4hja
zt4sB+WjYncPBhWfM2FFqxuHq4XktstVnyKlYlXt9bmzatBhdfhg0U42WgQ9vclC
Chv/cbbROTPGLbL/khZxtl0GExcu5O+FWJxJHzMu5dEQ3zZf4bGvtIHy1mLEM7i9
pe/Ev+PuHg19g6fyDfIYlgLcSOx4GvOAqgEa+V/sSOMhbPJoUu4HKh4v8gB1dmcX
3D0z3wg1TPfNATcBZ2msYVU3scH0e/ZFECt/QIGTvNZ60U0i45V1UFFRZ07jXCo5
HoRPDVfCWTtJ44iB7N5x
=ae0/
-----END PGP SIGNATURE-----

--pjjoPl5ov60xplEBGnw9KW8P4HutX4Acw--
