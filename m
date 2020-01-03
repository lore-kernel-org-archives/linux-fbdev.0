From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 11:38:42 +0000
Subject: Re: [PATCH 2/3] video: fbdev: mmp: add COMPILE_TEST support
Message-Id: <21153de6-885a-b52f-e051-0d6070daf2e9@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190627140744eucas1p1eb91c6c21ae36105f38dbf5e42259a7c@eucas1p1.samsung.com>
 <d21a19ea-8c18-80df-ae79-76de7c5ee67c@samsung.com>
 <28d91688-6df2-9207-7d88-34d024baf727@samsung.com>
In-Reply-To: <28d91688-6df2-9207-7d88-34d024baf727@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 8/20/19 11:56 AM, Andrzej Hajda wrote:
> On 27.06.2019 16:07, Bartlomiej Zolnierkiewicz wrote:
>> Add COMPILE_TEST support to mmp display subsystem for better compile
>> testing coverage.
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
>>  drivers/video/fbdev/mmp/Kconfig    |    2 +-
>>  drivers/video/fbdev/mmp/hw/Kconfig |    3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> Index: b/drivers/video/fbdev/mmp/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>> --- a/drivers/video/fbdev/mmp/Kconfig
>> +++ b/drivers/video/fbdev/mmp/Kconfig
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  menuconfig MMP_DISP
>>  	tristate "Marvell MMP Display Subsystem support"
>> -	depends on CPU_PXA910 || CPU_MMP2
>> +	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
>>  	help
>>  	  Marvell Display Subsystem support.
>> =20
>> Index: b/drivers/video/fbdev/mmp/hw/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D>> --- a/drivers/video/fbdev/mmp/hw/Kconfig
>> +++ b/drivers/video/fbdev/mmp/hw/Kconfig
>> @@ -1,7 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  config MMP_DISP_CONTROLLER
>>  	bool "mmp display controller hw support"
>> -	depends on CPU_PXA910 || CPU_MMP2
>> +	depends on HAVE_CLK && HAS_IOMEM
>> +	depends on CPU_PXA910 || CPU_MMP2 || COMPILE_TEST
>>  	help
>>  		Marvell MMP display hw controller support
>>  		this controller is used on Marvell PXA910 and
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
