From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 27 Mar 2019 14:46:08 +0000
Subject: Re: [RFC][PATCH 00/11] DRM driver for fbdev devices
Message-Id: <c86b8c56-0635-9ff9-3677-5c6446328816@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YVt7IcvoerG6hDvK0diM2fCH6ut9g55TV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326145320.GJ2665@phenom.ffwll.local>
 <0611651c-7fec-284b-d990-6fdbcf1f1b2a@suse.de>
 <CAKMK7uGOhAP0EjoKwLf+HUyoNX0Li5NL6dBw4+ir9Ae704pHkA@mail.gmail.com>
In-Reply-To: <CAKMK7uGOhAP0EjoKwLf+HUyoNX0Li5NL6dBw4+ir9Ae704pHkA@mail.gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@linux.ie>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YVt7IcvoerG6hDvK0diM2fCH6ut9g55TV
Content-Type: multipart/mixed; boundary="Sg1GBnU7XInAOU8ILALUtitF7395syf8p";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@linux.ie>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c86b8c56-0635-9ff9-3677-5c6446328816@suse.de>
Subject: Re: [RFC][PATCH 00/11] DRM driver for fbdev devices
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326145320.GJ2665@phenom.ffwll.local>
 <0611651c-7fec-284b-d990-6fdbcf1f1b2a@suse.de>
 <CAKMK7uGOhAP0EjoKwLf+HUyoNX0Li5NL6dBw4+ir9Ae704pHkA@mail.gmail.com>
In-Reply-To: <CAKMK7uGOhAP0EjoKwLf+HUyoNX0Li5NL6dBw4+ir9Ae704pHkA@mail.gmail.com>

--Sg1GBnU7XInAOU8ILALUtitF7395syf8p
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 27.03.19 um 10:41 schrieb Daniel Vetter:
>> I use the current approach because it does not require modifications t=
o
>> DRM or fbdev. Not copying the fbdev driver code has the advantage that=

>> any fix that goes into fbdev is also used by fbdevdrm.
>>
>> OTOH, that has some problems. At least the event-reporting hooks appea=
r
>> to be fragile. You mentioned that you have patches for replacing it. I=
'd
>> be happy to use something else. Filtering out generic and DRM-based
>> drivers is also not optimal.
>>
>> Instead of adding the porting helpers to the DRM core, I'd suggest to
>> add them to fbdevdrm. Fbdevdrm would have to duplicate some of the fbd=
ev
>> functionality and provide a replacement for register_framebuffer.
>>
>> Porting would then mean to
>>
>>  1) create a new DRM driver by copying fbdevdrm, and
>>  2) copy the fbdev driver code to the new DRM driver and rename the
>> function calls accordingly. At this point the new driver should alread=
y
>> work to some extend.
>>  3) Finally, do the refactoring and get it out of staging.
>=20
> Maybe the idea behind helpers isn't fully clear:
>=20
> https://blog.ffwll.ch/2016/12/midlayers-once-more-with-feeling.html
>=20
> The idea with helpers is essentially to have all the flexibility of
> copypasting (you can refactor as you see fit), without having to
> actually copypaste a lot of the code. That's why I think an fbdevdrm
> helper suits, at least as long as we're actively transitioning. Worked
> fairly well for the atomic transition at least.

That's not really a problem from my side, but maybe we misunderstood
each other.

Modeling fbdevdrm after CMA helpers or simple drm would put it next to
central DRM core and helper modules. That seems like an odd place for
transitional helper functions that are supposed to be replaced by the
actual DRM helpers.

I don't want some kind of abstraction layer. I'm proposing a design like
tinydrm, where a separate module offers helpers for fbdev drivers that
are about to be converted.

The difference might not be that significant, but just a question of
were the code is located.


>>> - Improve the other helpers we have as needed - there's probably room=
 for
>>>   a simple ttm version, inspired by all these simple display chips (e=
=2Eg.
>>>   ast/cirrus/bochs/mga all solve similar problems like this).
>>
>> Makes sense, but appears to be unrelated.
>=20
> It's the main reason to have drivers in upstream - sharing code and
> infrastructure.

I meant that creating 'simple TTM' is unrelated to fbdevdrm. It would
make sense in any case.

Best regards
Thomas

At least for me the main benefit in porting a bunch
> more fbdev drivers over isn't the old hw support (that hw is quietly
> dying anyway, we just have to wait). But improving support for new hw
> that fills similar niches, and making it easier for everyone else. Ofc
> I'm not going to stop anyone who's going to do all the porting work,
> but we can't realistically require it (e.g. legacy kms drivers also
> don't support atomic, since simply not possible without rewriting the
> driver).
>=20
> Cheers, Daniel
>>
>> Best regards
>> Thomas
>>
>>> - Treat any such drivers as CONFIG_STAGING until they've become fully=

>>>   native, i.e. if no one bothers to convert them, we'll drop them aga=
in.
>>>
>>> The above is kinda similar in spirit to the transitional helpers we'v=
e
>>> used to upgrade the big drivers from legacy kms to atomic.
>>>
>>> Thoughts?
>>>
>>> Cheers, Daniel
>>>
>>>>
>>>>  drivers/gpu/drm/Kconfig                     |   2 +
>>>>  drivers/gpu/drm/Makefile                    |   1 +
>>>>  drivers/gpu/drm/fbdevdrm/Kconfig            |  13 +
>>>>  drivers/gpu/drm/fbdevdrm/Makefile           |  11 +
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c      | 276 ++++++++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h      |  58 ++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c  |  96 +++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h  |  55 ++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c     | 347 +++++++++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c  | 441 ++++++++++++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h  |  26 +
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c   | 195 +++++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h   |  53 ++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c | 746 +++++++++++++++++=
+++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h |  38 +
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c | 498 +++++++++++++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h |  27 +
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c     | 202 ++++++
>>>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h     |  35 +
>>>>  19 files changed, 3120 insertions(+)
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/Kconfig
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/Makefile
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c
>>>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h
>>>>
>>>> --
>>>> 2.21.0
>>>>
>>>
>>
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
>> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
>> HRB 21284 (AG N=C3=BCrnberg)
>>
>=20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--Sg1GBnU7XInAOU8ILALUtitF7395syf8p--

--YVt7IcvoerG6hDvK0diM2fCH6ut9g55TV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlybjLAACgkQaA3BHVML
eiM/ZwgAlSDwnxg8J2jAoGL7fCUONEkD7iFM7Awt/o9fHq71Xzn4J+r0sRwmUyG6
0pWuLRja7iKWmOCSw5z3Y9ydVrqdFEEwR8WLLRVycGVjZJw0JUosGvgFGhUArZKa
oZP9OMYhFDdjUkzt3l+eolzC5MIDrM/xa+z+/NCUp0/YpgCDjxB59IbAOHumQNKB
oShi3MjeMM9En6yNQcHWjkWWtSnI314yMJchQnmISkFVPh/pCtNgeucgP4dh8XsP
whWMbwK0JsQYpOSdnkxispuUUP7ChsJXzQpE1o42BHiMhTVrKYBXrHwTknozr9rV
kfqE2RafV0XDStvQH30nDr0h6N6kMw==
=2NZj
-----END PGP SIGNATURE-----

--YVt7IcvoerG6hDvK0diM2fCH6ut9g55TV--
