From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 29 Feb 2016 16:55:39 +0000
Subject: Re: [PATCH v2] video: exynos: fix modular build
Message-Id: <56D4780B.2070406@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MA4GIcc7Jmt9IeIvJEQSJ4JrcdTPXUepr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456490307-823812-1-git-send-email-arnd@arndb.de>
 <56D46DFD.6090706@ti.com> <6291541.7IMAnfX0g2@wuerfel>
In-Reply-To: <6291541.7IMAnfX0g2@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--MA4GIcc7Jmt9IeIvJEQSJ4JrcdTPXUepr
Content-Type: multipart/mixed; boundary="rCePVtLQ8HwS7T1JunCAhQuVsxGL6Fe8M"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Paul Bolle <pebolle@tiscali.nl>, linux-samsung-soc@vger.kernel.org,
 Donghwa Lee <dh09.lee@samsung.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-kernel@vger.kernel.org,
 Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Message-ID: <56D4780B.2070406@ti.com>
Subject: Re: [PATCH v2] video: exynos: fix modular build
References: <1456490307-823812-1-git-send-email-arnd@arndb.de>
 <56D46DFD.6090706@ti.com> <6291541.7IMAnfX0g2@wuerfel>
In-Reply-To: <6291541.7IMAnfX0g2@wuerfel>

--rCePVtLQ8HwS7T1JunCAhQuVsxGL6Fe8M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/02/16 18:39, Arnd Bergmann wrote:
> On Monday 29 February 2016 18:12:45 Tomi Valkeinen wrote:
>> Hi,
>>
>> On 26/02/16 14:38, Arnd Bergmann wrote:
>>> The s6e8ax0 driver has a dependency on BACKLIGHT_CLASS_DEVICE,
>>> which can be configured as a loadable module, so we have to
>>> make the driver a tristate symbol as well, to avoid this error:
>>>
>>> drivers/built-in.o: In function `s6e8ax0_probe':
>>> :(.text+0x23a48): undefined reference to `devm_backlight_device_regis=
ter'
>>
>> If a 'bool' Kconfig option depends on BACKLIGHT_CLASS_DEVICE, shouldn'=
t
>> the Kconfig dependency take care of having BACKLIGHT_CLASS_DEVICE as
>> built-in?
>=20
> No, that's not how Kconfig interprets it. There are many bool option
> that depend on tristate options but can be enabled if the dependency
> is built-in.
>=20
> Take this one for example:
>=20
> config FIRMWARE_EDID
>        bool "Enable firmware EDID"
>        depends on FB
>=20
> We clearly want to be able to turn this on even for FB=3Dm.

Right.

>>> This also means we get another error from a missing export, which
>>> this fixes as well:
>>>
>>> ERROR: "exynos_mipi_dsi_register_lcd_driver" [drivers/video/fbdev/exy=
nos/s6e8ax0.ko] undefined!
>>>
>>> The drivers are all written to be loadable modules already,
>>> except the Kconfig options for that are missing, which makes
>>> the patch really easy.
>>
>> Looks and sound fine, except doesn't this tell that the drivers have
>> never been tested as modules? Did you or someone else actually test th=
ese?
>=20
> No, this is not runtime tested. Generally there is very little that
> can go wrong here though.
>=20
> An alternative would be to change the dependency to
>=20
> 	depends on BACKLIGHT_CLASS_DEVICE=3Dy
>=20
> which doesn't allow the driver to be turned on for the =3Dm case.
> However, no other framebuffer driver does this.

No, I think it's clearly better to make them tristate. I think all
drivers should be buildable as modules. It just makes me a bit
uncomfortable to enable code that has never been ran.

>>> diff --git a/drivers/video/fbdev/exynos/Makefile b/drivers/video/fbde=
v/exynos/Makefile
>>> index b5b1bd228abb..02d8dc522fea 100644
>>> --- a/drivers/video/fbdev/exynos/Makefile
>>> +++ b/drivers/video/fbdev/exynos/Makefile
>>> @@ -2,6 +2,8 @@
>>>  # Makefile for the exynos video drivers.
>>>  #
>>> =20
>>> -obj-$(CONFIG_EXYNOS_MIPI_DSI)		+=3D exynos_mipi_dsi.o exynos_mipi_ds=
i_common.o \
>>> -				     	exynos_mipi_dsi_lowlevel.o
>>> +obj-$(CONFIG_EXYNOS_MIPI_DSI)		+=3D exynos-mipi-dsi-mod.o
>>> +
>>> +exynos-mipi-dsi-mod-objs		+=3D exynos_mipi_dsi.o exynos_mipi_dsi_com=
mon.o \
>>> +					   exynos_mipi_dsi_lowlevel.o
>>
>> Hmm, why is this makefile change needed?
>=20
> The original Makefile would link each file into a separate module, but =
that
> cannot work, because they reference symbols from each other that are no=
t
> exported to other modules.
>=20
> With my change, all the files get linked into a single module.

Yes, of course.

Thanks, I'll queue this up for 4.6.

 Tomi


--rCePVtLQ8HwS7T1JunCAhQuVsxGL6Fe8M--

--MA4GIcc7Jmt9IeIvJEQSJ4JrcdTPXUepr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1HgLAAoJEPo9qoy8lh71WBsQAJKrvmYgqKKC8obILSxEIbCv
CsJb8kFoYreRMYd6U9kAk8Wqsv45c696vNErrvu0rvUn9mDy0lbOszYZILjeWxz/
WAdkZDFxDIp3yc/4bSj5GNTeSYqjTXXC5bnwddDx+ALHK5/ubmRg0jyRRAFeVKn+
YB9bVJQI+uGZO7P+buB5b8WfRjV3RAdLL3Rfd0N7A58drycSQRi/u2lauQSSxMk2
e/A9pIG/BePcFESvWKHRmrQkKOvOidiTmPhJXr5A80Q9LrK5m9tpMVRMpXKZLVm8
rtuDId6x2XUa8oRdVwVxjvR4dunOjeeCMnWx3IIFwjoGkm2eJEEjUZnLXRnDpNRL
Wgm1kYtCxH6p8uYINQzu1iMZQJG14o7wCSe5LoCPhJ3ms8GnlD+ajFp7B7SN9v1K
Hx4t5w+mgGP5lCN/3PFF/B2UDsTZP8QOkBA954XAuXTfs7MB5KrRK3MU3p9zE+pU
YlmO+UOoaJRUBst7pEPX+7YqO1dicLpqpzAmC0nDx94eZUzSFzyEeRuR1JBJW4W0
yTnOd3vjSvpRLo1rzFAW0dvBh6hgoNOaSpUUx5Ql0IdHjKB7o6wzHel/xwMD2tLw
Q4yjeoTlkk5m5FVCIMlcXtc0bDp6FLtBiSnjt/T2GHJsrqlUC33TxBlyHKMqFSZl
QXFUrrEo2hvi/tAbj+Oe
=DBVl
-----END PGP SIGNATURE-----

--MA4GIcc7Jmt9IeIvJEQSJ4JrcdTPXUepr--
