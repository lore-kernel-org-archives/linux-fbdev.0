From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 13 Nov 2019 15:48:20 +0000
Subject: Re: [PATCH v4 1/3] drm/udl: Replace fbdev code with generic emulation
Message-Id: <5398d88a-bb4a-7f8f-f043-a101911940aa@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZQ6pXZQRbgjVW9F6dCLaI2xDfw1j2uWHu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191113115233.18483-1-tzimmermann@suse.de>
 <20191113115233.18483-2-tzimmermann@suse.de>
 <7c9289a6-1a4e-e0d3-ce9e-3f5d6305da69@tronnes.org>
 <c2d1d12d-d90e-f6f6-9608-9955e63a8bec@suse.de>
In-Reply-To: <c2d1d12d-d90e-f6f6-9608-9955e63a8bec@suse.de>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZQ6pXZQRbgjVW9F6dCLaI2xDfw1j2uWHu
Content-Type: multipart/mixed; boundary="HJTtoV33BLx1rsgTppA8uUGQFUTEeDIXM";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, airlied@redhat.com,
 sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com,
 kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <5398d88a-bb4a-7f8f-f043-a101911940aa@suse.de>
Subject: Re: [PATCH v4 1/3] drm/udl: Replace fbdev code with generic emulation
References: <20191113115233.18483-1-tzimmermann@suse.de>
 <20191113115233.18483-2-tzimmermann@suse.de>
 <7c9289a6-1a4e-e0d3-ce9e-3f5d6305da69@tronnes.org>
 <c2d1d12d-d90e-f6f6-9608-9955e63a8bec@suse.de>
In-Reply-To: <c2d1d12d-d90e-f6f6-9608-9955e63a8bec@suse.de>

--HJTtoV33BLx1rsgTppA8uUGQFUTEeDIXM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


Am 13.11.19 um 16:41 schrieb Thomas Zimmermann:

>> Either way you choose:
>=20
> Glad you like it :)
>=20

more like this

>>
>> Btw, nice diffstat!

Glad you like it :)

>>
>>>  	if (ret)
>>>  		goto err;
>>> =20
>>> @@ -367,6 +368,4 @@ void udl_fini(struct drm_device *dev)
>>> =20
>>>  	if (udl->urbs.count)
>>>  		udl_free_urb_list(dev);
>>> -
>>> -	udl_fbdev_cleanup(dev);
>>>  }
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--HJTtoV33BLx1rsgTppA8uUGQFUTEeDIXM--

--ZQ6pXZQRbgjVW9F6dCLaI2xDfw1j2uWHu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl3MJcQACgkQaA3BHVML
eiNG6Qf/epNWFMYvFoLWFEdBRojEqVCU3W7GD95cNBp25auTYxjmbdeB4dhasdMJ
vG7gIxe+uRaOSiN5sEDSpenMw3gGUhMVbFwmaQUapxU4THVpdSKB2X/d7iFFOtbP
ECFxsfAHRSrb7xzTZwoPNsnTR8ptgH++uok/Mh3V+PfgqGqjUaOVHYhZvVtPuMGf
TF296DjD0hPBuvVvXsSQ9S+vuJeCHsBw6vVHr/peP8hx6/pForieSf3G/MvxkBYV
M10qhmgQ5mI9MP+9qsP1OiUF2wPentGzQsxA0r1mt6TRH8Taqm7vSNCRdrHVG8Gz
nhGkHuxLErXgN3hG0y1hXKbjEdG+lw==
=Ol7h
-----END PGP SIGNATURE-----

--ZQ6pXZQRbgjVW9F6dCLaI2xDfw1j2uWHu--
