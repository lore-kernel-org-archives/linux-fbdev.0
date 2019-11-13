From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 13 Nov 2019 15:41:04 +0000
Subject: Re: [PATCH v4 1/3] drm/udl: Replace fbdev code with generic emulation
Message-Id: <c2d1d12d-d90e-f6f6-9608-9955e63a8bec@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MUZ0CICzXdQU7zjQFtQ8TsMo9EZyBJIyT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191113115233.18483-1-tzimmermann@suse.de>
 <20191113115233.18483-2-tzimmermann@suse.de>
 <7c9289a6-1a4e-e0d3-ce9e-3f5d6305da69@tronnes.org>
In-Reply-To: <7c9289a6-1a4e-e0d3-ce9e-3f5d6305da69@tronnes.org>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MUZ0CICzXdQU7zjQFtQ8TsMo9EZyBJIyT
Content-Type: multipart/mixed; boundary="1IOtx37RiYQz9L8B57LSRFxdKmUon48jm";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com,
 sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com,
 kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <c2d1d12d-d90e-f6f6-9608-9955e63a8bec@suse.de>
Subject: Re: [PATCH v4 1/3] drm/udl: Replace fbdev code with generic emulation
References: <20191113115233.18483-1-tzimmermann@suse.de>
 <20191113115233.18483-2-tzimmermann@suse.de>
 <7c9289a6-1a4e-e0d3-ce9e-3f5d6305da69@tronnes.org>
In-Reply-To: <7c9289a6-1a4e-e0d3-ce9e-3f5d6305da69@tronnes.org>

--1IOtx37RiYQz9L8B57LSRFxdKmUon48jm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 13.11.19 um 16:26 schrieb Noralf Tr=C3=B8nnes:
>=20
>=20
> Den 13.11.2019 12.52, skrev Thomas Zimmermann:
>> The udl driver can use the generic fbdev implementation. Convert it.
>>
>> v4:
>> 	* hardcode console bpp to 16
>> v3:
>> 	* remove module parameter fb_bpp in favor of fbdev's video
>> 	* call drm_fbdev_generic_setup() directly; remove udl_fbdev_init()
>> 	* use default for struct drm_mode_config_funcs.output_poll_changed
>> 	* use default for struct drm_driver.lastclose
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>=20
>> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_=
main.c
>> index 4e854e017390..3be0c0cec49e 100644
>> --- a/drivers/gpu/drm/udl/udl_main.c
>> +++ b/drivers/gpu/drm/udl/udl_main.c
>> @@ -9,6 +9,7 @@
>>   */
>> =20
>>  #include <drm/drm.h>
>> +#include <drm/drm_fb_helper.h>
>>  #include <drm/drm_print.h>
>>  #include <drm/drm_probe_helper.h>
>> =20
>> @@ -338,7 +339,7 @@ int udl_init(struct udl_device *udl)
>>  	if (ret)
>>  		goto err;
>> =20
>> -	ret =3D udl_fbdev_init(dev);
>> +	ret =3D drm_fbdev_generic_setup(dev, 16);
>=20
> I suggest you put this after drm_dev_register() in _probe() since fbdev=

> is a client, a user of the driver, not part of it as such.

Good point. I'll change it.

>=20
> Either way you choose:

Glad you like it :)

>=20
> Reviewed-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>

Thanks for the review.

Best regards
Thomas

>=20
> Btw, nice diffstat!
>=20
>>  	if (ret)
>>  		goto err;
>> =20
>> @@ -367,6 +368,4 @@ void udl_fini(struct drm_device *dev)
>> =20
>>  	if (udl->urbs.count)
>>  		udl_free_urb_list(dev);
>> -
>> -	udl_fbdev_cleanup(dev);
>>  }
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--1IOtx37RiYQz9L8B57LSRFxdKmUon48jm--

--MUZ0CICzXdQU7zjQFtQ8TsMo9EZyBJIyT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl3MJBAACgkQaA3BHVML
eiNOoggAtgNWfEKPliAot2UIOzJyX99OHZ9PFCQVDh39lyn6KiXDYWH4t/3hP2+2
GpC3gfqr3t6zL8oI/RUfRhiv1RiqIMRcndRCyWJitho4fI9jZqknyExN9tJnGJMp
JSlPSLRoRJcwCn7WNDA9GJ369N8KDk4tzBs3FJh67389B0G5gj9/DFxsMwfsoxHG
1aiAerjev/BVjGZEwguosmrzVySsgs6qvmYPtX5aGuNz/gkllnTxK2wipfLKKeE3
Rv8Kc2E2GGJgmvFh5CyJhEYoJBQk12BNx8mDA9PFKs69FJ3UwEPV5HmhvF/2fVCg
ir3SwkmpWDTzSCNJIIsfim32lCLR3g==
=Ve5e
-----END PGP SIGNATURE-----

--MUZ0CICzXdQU7zjQFtQ8TsMo9EZyBJIyT--
