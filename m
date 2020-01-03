From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 11:38:15 +0000
Subject: Re: [PATCH 1/3] video: fbdev: mmp: remove duplicated MMP_DISP dependency
Message-Id: <633e4795-b914-e5ff-7121-7339a936e8ba@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190627140704eucas1p10f9aca669beb24f5359a0e86f2b6d0ba@eucas1p1.samsung.com>
 <eb28587c-4f8f-f044-1b8b-317a8d7967aa@samsung.com>
 <0534f6bf-cd94-5416-2d4a-5fc9721aa7ed@samsung.com>
In-Reply-To: <0534f6bf-cd94-5416-2d4a-5fc9721aa7ed@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 8/20/19 11:55 AM, Andrzej Hajda wrote:
> On 27.06.2019 16:07, Bartlomiej Zolnierkiewicz wrote:
>> This dependency is already present in higher level Kconfig file
>> (drivers/video/fbdev/mmp/Kconfig).
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>=20
>=20
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, I've queued the patch for v5.6.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> =C2=A0--
> Regards
> Andrzej
>=20
>=20
>> ---
>>  drivers/video/fbdev/mmp/fb/Kconfig |    4 ----
>>  drivers/video/fbdev/mmp/hw/Kconfig |    4 ----
>>  2 files changed, 8 deletions(-)
>>
>> Index: b/drivers/video/fbdev/mmp/fb/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>> --- a/drivers/video/fbdev/mmp/fb/Kconfig
>> +++ b/drivers/video/fbdev/mmp/fb/Kconfig
>> @@ -1,6 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> -if MMP_DISP
>> -
>>  config MMP_FB
>>  	tristate "fb driver for Marvell MMP Display Subsystem"
>>  	depends on FB
>> @@ -10,5 +8,3 @@ config MMP_FB
>>  	default y
>>  	help
>>  		fb driver for Marvell MMP Display Subsystem
>> -
>> -endif
>> Index: b/drivers/video/fbdev/mmp/hw/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>> --- a/drivers/video/fbdev/mmp/hw/Kconfig
>> +++ b/drivers/video/fbdev/mmp/hw/Kconfig
>> @@ -1,6 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>> -if MMP_DISP
>> -
>>  config MMP_DISP_CONTROLLER
>>  	bool "mmp display controller hw support"
>>  	depends on CPU_PXA910 || CPU_MMP2
>> @@ -16,5 +14,3 @@ config MMP_DISP_SPI
>>  	help
>>  		Marvell MMP display hw controller spi port support
>>  		will register as a spi master for panel usage
>> -
>> -endif
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
