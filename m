From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 27 Mar 2019 09:10:23 +0000
Subject: Re: [RFC][PATCH 00/11] DRM driver for fbdev devices
Message-Id: <0611651c-7fec-284b-d990-6fdbcf1f1b2a@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fNqgcQWzwnTwKkOdo3dkCyrymAeAFPDbw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326145320.GJ2665@phenom.ffwll.local>
In-Reply-To: <20190326145320.GJ2665@phenom.ffwll.local>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fNqgcQWzwnTwKkOdo3dkCyrymAeAFPDbw
Content-Type: multipart/mixed; boundary="HaHpGuDILkd4nbi0yF36DbCpZ3rTLviRF";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, b.zolnierkie@samsung.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Message-ID: <0611651c-7fec-284b-d990-6fdbcf1f1b2a@suse.de>
Subject: Re: [RFC][PATCH 00/11] DRM driver for fbdev devices
References: <20190326091744.11542-1-tzimmermann@suse.de>
 <20190326145320.GJ2665@phenom.ffwll.local>
In-Reply-To: <20190326145320.GJ2665@phenom.ffwll.local>

--HaHpGuDILkd4nbi0yF36DbCpZ3rTLviRF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

first of all, thanks for the detailed feedback.

Am 26.03.19 um 15:53 schrieb Daniel Vetter:
> On Tue, Mar 26, 2019 at 10:17:33AM +0100, Thomas Zimmermann wrote:
>> Hi,
>>
>> this RFC patch set implements fbdevdrm, a DRM driver on top of fbdev
>> drivers. I'd appreciate feedback on the code and the idea in general.
>>
>> The fbdev subsystem is considered legacy and will probably be removed =
at
>> some point. This would mean the loss of a signifanct number of drivers=
=2E
>> Some of the affected hardware is probably not in use any longer, but s=
ome
>> hardware is still around and provides good(-enough) framebuffers.
>>
>> OTOH, userspace programs that want to support a wide range of graphics=

>> hardware have to implement support for both DRM and fbdev interfaces. =
Such
>> software would benefit from a single interface.
>>
>> The fbdevdrm driver provides a way of running drivers for old and new
>> hardware from the DRM subsystem and interfaces.
>>
>> It's not intended to add new features or drivers to fbdev. Instead fbd=
evdrm
>> is supposed to be a template for converting fbdev drivers to DRM. It c=
ontains
>> a number of comments (labeled 'DRM porting note') that explain the req=
uired
>> steps. The license is fairly liberal to allow for combination with exi=
sting
>> fbdev code.
>>
>> I tested the current patch set with the following drivers: atyfb, aty1=
28fb,
>> matroxfb, pm2fb, s3fb, savagefb, sisfb, tdfxfb and tridentfb. I was ab=
le to
>> successfully start with fbcon enabled and then run weston or X.
>>
>> Thomas Zimmermann (11):
>>   drm/fbdevdrm: Add driver skeleton
>>   drm/fbdevdrm: Add fbdevdrm device
>>   drm/fbdevdrm: Add memory management
>>   drm/fbdevdrm: Add file operations
>>   drm/fbdevdrm: Add GEM and dumb interfaces
>>   drm/fbdevdrm: Add modesetting infrastructure
>>   drm/fbdevdrm: Add DRM <-> fbdev pixel-format conversion
>>   drm/fbdevdrm: Add mode conversion DRM <-> fbdev
>>   drm/fbdevdrm: Add primary plane
>>   drm/fbdevdrm: Add CRTC
>>   drm/fbdevdrm: Detect and validate display modes
>=20
> Looks surprisingly clean, at least from a quick read. Only big thing I
> noticed on the implementation side is that you probably want to use the=

> simple display helpers. At least that's a much better fit for simple
> display hw supported by these fbdev drivers.

I thought about using the simple-DRM helpers, but found that a full DRM
driver would be more helpful for porting over fbdev drivers. Unless
simple DRM is a hard requirement, I'd prefer to leave it this way.

For those devices that only support a single pipeline, the conversion to
simple DRM should then be mandatory during the porting process.

> What I'm not sure at all on is whether this is a good idea. It's a quic=
k
> way of supporting a few drivers we might need from fbdev. But I fear fo=
r
> long-term ecosystem health it'll be a loss: Much less motivation to por=
t
> the drivers to be native kms ones, and as a result, much less
> opportunities to extract helpers to make driver writing for such hw eas=
ier
> for everyone.
>=20
> And the latter is really important, if you look at all the work people
> have done to improve the modeset helpers. Nowadays we have some example=
s
> where the kms native port of an fbdev driver turned out to be 2-3x
> smaller.

I don't disagree with any of this. My intention is to simplify the
graphics stack *without* loosing support for all the old hardware. I see
fbdevdrm as help for porting drivers, or short-term solution for getting
old framebuffer to work.

> But I also see the benefit of making the fbdev->kms transition smoother=
=2E
> For discussion here's a pretty wild idea that we might want to consider=
:
>=20
> - move the ttm based gem code into a helper library like the cma gem
>   helpers. Only special piece we need to pass it is the fb_info structu=
re,
>   for that we can use the same hooks the cma helpers use to allow drive=
rs
>   to specify the right struct device to use for cma allocations. plus o=
fc
>   an init function for the memory manager and all that, which drivers c=
an
>   put into their driver private device structure
>=20
> - move the modeset compat code into a helper based on top of the simple=

>   display pipe helpers.=20
>=20
> - for each fbdev driver we care about:
>   1. create bare-bones kms driver
>   2. copypaste the entire fbdev driver code into the drm driver
>   3. hook up the above two helper libraries, remove the
>   register_framebuffer - I think we can still allocate the fb_info and =
all
>   that for transition
>   4. transition the driver over. If we have the helpers a bit split up
>   between display and buffer management side that should be a lot more
>   gradual, and with the fbdevdrm midlayer inserted in the middle.

I use the current approach because it does not require modifications to
DRM or fbdev. Not copying the fbdev driver code has the advantage that
any fix that goes into fbdev is also used by fbdevdrm.

OTOH, that has some problems. At least the event-reporting hooks appear
to be fragile. You mentioned that you have patches for replacing it. I'd
be happy to use something else. Filtering out generic and DRM-based
drivers is also not optimal.

Instead of adding the porting helpers to the DRM core, I'd suggest to
add them to fbdevdrm. Fbdevdrm would have to duplicate some of the fbdev
functionality and provide a replacement for register_framebuffer.

Porting would then mean to

 1) create a new DRM driver by copying fbdevdrm, and
 2) copy the fbdev driver code to the new DRM driver and rename the
function calls accordingly. At this point the new driver should already
work to some extend.
 3) Finally, do the refactoring and get it out of staging.

If the fbdev subsystem is ever going to be removed, the remaining
drivers could be moved under fbdevdrm and have their function calls
adapted. If anyone cares about a driver, it'd be available for
refactoring; otherwise it'd just sit there doing nothing. It's all
self-contained and doesn't pollute the DRM core.

> - Improve the other helpers we have as needed - there's probably room f=
or
>   a simple ttm version, inspired by all these simple display chips (e.g=
=2E
>   ast/cirrus/bochs/mga all solve similar problems like this).

Makes sense, but appears to be unrelated.

Best regards
Thomas

> - Treat any such drivers as CONFIG_STAGING until they've become fully
>   native, i.e. if no one bothers to convert them, we'll drop them again=
=2E
>=20
> The above is kinda similar in spirit to the transitional helpers we've
> used to upgrade the big drivers from legacy kms to atomic.
>=20
> Thoughts?
>=20
> Cheers, Daniel
>=20
>>
>>  drivers/gpu/drm/Kconfig                     |   2 +
>>  drivers/gpu/drm/Makefile                    |   1 +
>>  drivers/gpu/drm/fbdevdrm/Kconfig            |  13 +
>>  drivers/gpu/drm/fbdevdrm/Makefile           |  11 +
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c      | 276 ++++++++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h      |  58 ++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c  |  96 +++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h  |  55 ++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c     | 347 +++++++++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c  | 441 ++++++++++++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h  |  26 +
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c   | 195 +++++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h   |  53 ++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c | 746 +++++++++++++++++++=
+
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h |  38 +
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c | 498 +++++++++++++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h |  27 +
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c     | 202 ++++++
>>  drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h     |  35 +
>>  19 files changed, 3120 insertions(+)
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/Kconfig
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/Makefile
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c
>>  create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h
>>
>> --
>> 2.21.0
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--HaHpGuDILkd4nbi0yF36DbCpZ3rTLviRF--

--fNqgcQWzwnTwKkOdo3dkCyrymAeAFPDbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAlybPf8ACgkQaA3BHVML
eiMGmggAosnAC8MQbd80ZwAggwKHrCsaTLweSiBipppPJiYHixVk9ZLiDYEWBEpK
Ai3YIh8JjTO8nbcv0AS6QbgW5UfVOuRFuNh77dRujLy9x1KhNujbYzdrqDwlKTdI
mrCOob4E+1H37f2pVxWqG34zt7l/+dXSG7TUHVUlHWqTIt1CJ33aTQaMT2z1zcs1
bMx6V0IbVf5Z4aHLY0NkPfU125P4X5ACiOdi+KLjb4YuisZ6zH/yfLEVtxrMVrhU
bZqsbfIv1GJVXy5GntiU/TBOU6WVrPpPPHaYUAD94idSAsM+kNXE6axf7Knb5yPs
d/sZOg8WcdAgx5z4dpDnQZ/iW641wQ==
=3Ile
-----END PGP SIGNATURE-----

--fNqgcQWzwnTwKkOdo3dkCyrymAeAFPDbw--
