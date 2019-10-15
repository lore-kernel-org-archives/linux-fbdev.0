From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 15 Oct 2019 17:28:42 +0000
Subject: Re: [PATCH v2 00/15] DRM fbconv helpers for converting fbdev drivers
Message-Id: <5241e699-f66a-d212-03a5-bb736639e66b@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5VUqdQIYROeNHXTUMY64yOuiNULBt7IlO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
 <20191015143318.GP11828@phenom.ffwll.local>
In-Reply-To: <20191015143318.GP11828@phenom.ffwll.local>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, airlied@linux.ie, gregkh@linuxfoundation.org, michel@daenzer.net, corbet@lwn.net, malat@debian.org, dri-devel@lists.freedesktop.org, sean@poorly.run

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5VUqdQIYROeNHXTUMY64yOuiNULBt7IlO
Content-Type: multipart/mixed; boundary="vetiopZEuHfbchxGZNIHeDlrkz6zMaIOr";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: airlied@linux.ie, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com,
 ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net,
 corbet@lwn.net, gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Message-ID: <5241e699-f66a-d212-03a5-bb736639e66b@suse.de>
Subject: Re: [PATCH v2 00/15] DRM fbconv helpers for converting fbdev drivers
References: <20191014140416.28517-1-tzimmermann@suse.de>
 <20191015143318.GP11828@phenom.ffwll.local>
In-Reply-To: <20191015143318.GP11828@phenom.ffwll.local>

--vetiopZEuHfbchxGZNIHeDlrkz6zMaIOr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Daniel

Am 15.10.19 um 16:33 schrieb Daniel Vetter:
> Hi Thomas,
>=20
> On Mon, Oct 14, 2019 at 04:04:01PM +0200, Thomas Zimmermann wrote:
>> (was: DRM driver for fbdev devices)
>>
>> This is version 2 of the fbdev conversion helpers. It's more or less a=

>> rewrite of the original patchset.
>>
>> The fbdev subsystem is considered legacy and will probably be removed =
at
>> some point. This would mean the loss of a signifanct number of drivers=
=2E
>> Some of the affected hardware is not in use any longer, but some hardw=
are
>> is still around and provides good(-enough) framebuffers.
>>
>> The fbconv helpers allow for running the current DRM stack on top of f=
bdev
>> drivers. It's a set of functions that convert between fbdev interfaces=
 and
>> DRM interfaces. Based on SHMEM and simple KMS helpers, it only offers =
the
>> basic functionality of a framebuffer, but should be compatible with mo=
st
>> existing fbdev drivers.
>>
>> A DRM driver using fbconv helpers consists of
>>
>>   * DRM stub code that calls into fbconv helpers, and
>>   * the original fbdev driver code.
>>
>> The fbdev driver code has to be modified to register itself with the
>> stub driver instead of the fbdev core framework. A tutorial on how to =
use
>> the helpers is part of this patchset. The resulting driver hybrid can =
be
>> refactored into a first-class DRM driver. The fbconv helpers contain a=

>> number of comments, labeled 'DRM porting note', which explain the requ=
ired
>> steps.
>>
>> I tested the current patchset with the following drivers: atyfb, aty12=
8fb,
>> matroxfb, pm2fb, pm3fb, rivafb, s3fb, savagefb, sisfb, tdfxfb and trid=
entfb.
>> With each, I was able to successfully start with fbcon enabled, run we=
ston and
>> X11. The drivers are available at [1]. For reference, the patchset inc=
ludes
>> the Matrox stub driver.
>=20
> So I really don't want to rain on the parade here, since if you think t=
his
> is useful when converting fbdev drivers I'll buy that, and I'm all for
> getting more modern drivers into drm.
>=20
> But I have a bunch of concerns with the approach you're proposing here:=

>=20
> - we've tried staging for drm driver refactoring, it hurts. Separate tr=
ee
>   plus the quick pace in refactoring create lots of pains. And for smal=
l
>   drivers refacotoring before it's not buying you anything above
>   refactoring in your own personal tree. And for big drivers we're fair=
ly
>   lenient with merging drivers that aren't fully polished yet, if there=
's
>   a team serious enough with cleaning up the mess. I think even merging=

>   partial drivers directly under drivers/gpu (but behind CONFIG_BROKEN)=
 is
>   better than staging.

I mostly put this into staging, because it's the kind of code you'd
expect there.

> - we've had conversion helpers before (for the legacy kms -> atomic
>   upgrade). They constantly broke, pretty much every release when someo=
ne
>   wanted to use them they first had to fix them up again. I think havin=
g
>   those helpers is good, but better to just have them in some branch
>   somewhere where it's clear that they might not work anymore on latest=

>   upstream.
>=20
> - especially for some of these simple fbdev drivers I feel like just
>   typing a new driver from scratch might be simpler.
>=20
> A few more concerns specifically for your mga example:
>=20
> - We already have a mga driver. Might be better to integrate support fo=
r
>   older mgas into that than have a parallel driver.

Two colleagues of mine, Takashi and Egbert, send a patch that added
support for desktop G200s to mgag200. [1] But it was rejected because
the devices are two old and not relevant any longer. If that opinion has
changed in the meantime, I wouldn't mind adding support for desktop GPUs
to the driver.

> - Your helper is based on simple display pipe, and I think for these ol=
d
>   mga chips (especially the dual pipe mga 450 and 550) simple display p=
ipe
>   helper is more a hindering detour than actual help. From a quick read=

>   through the code (especially all the custom ioctls) you definitely wa=
nt
>   separate TV-out connector to expose all the tv mode properties (inste=
ad
>   of the custom ioctls).

Around the G100, there's something like a change in generation. Before,
devices had only a single output and less than 8 MiB of RAM. This works
well with GEM SHMEM and simple KMS. Afterwards, devices have 8 MiB or
more and multiple outputs. GEM VRAM and the full set of helpers fit this
much better. Maybe having 2 drivers that share common code (or 3 with
the Server Engine chipsets) makes most sense.

>=20
> - On the topic of ioctls, looks like we could add FBIOGET_VBLANK to our=

>   generic implementation in the fbdev helpers.
>=20
> So here's my alternative proposal:
>=20
> - You push this as a branch onto a gitlab repo (freedesktop.org or
>   wherever you feel like).
>=20
> - You add a gitlab CI target to autobuild the very nice kerneldoc you'v=
e
>   created. Feel free to also do this with anything else you're familiar=

>   with, it's just I know gitlab and it's real simple to get a few docs
>   autogenerated and published with it.
>=20
> - We add a todo.rst patch linking to your branch and the docs and a few=

>   lines on how to best convert an fbdev driver over to kms/atomic.

Yes we can do that.

Best regards
Thomas

[1] https://lists.freedesktop.org/archives/dri-devel/2017-July/147868.htm=
l

>=20
> And all the drivers would land the usual way, like any of the other
> drivers we've added to drivers/gpu/drm over the past few years.
>=20
> Thoughts?
>=20
> Cheers, Daniel
>>
>> v2:
>> 	* rename to fbconv helpers
>> 	* rewrite as helper library
>> 	* switch over to simple KMS helpers
>> 	* switch over to SHMEM
>> 	* add documentation
>>
>> [1] https://gitlab.freedesktop.org/tzimmermann/linux/commits/fbconv-pl=
us-drivers
>>
>> Thomas Zimmermann (15):
>>   fbdev: Export fb_check_foreignness()
>>   fbdev: Export FBPIXMAPSIZE
>>   drm/simple-kms-helper: Add mode_fixup() to simple display pipe
>>   drm: Add fbconv helper module
>>   drm/fbconv: Add DRM <-> fbdev pixel-format conversion
>>   drm/fbconv: Add mode conversion DRM <-> fbdev
>>   drm/fbconv: Add modesetting infrastructure
>>   drm/fbconv: Add plane-state check and update
>>   drm/fbconv: Mode-setting pipeline enable / disable
>>   drm/fbconv: Reimplement several fbdev interfaces
>>   drm/fbconv: Add helpers for init and cleanup of fb_info structures
>>   drm/fbconv: Add helper documentation
>>   staging: Add mgakms driver
>>   staging/mgakms: Import matroxfb driver source code
>>   staging/mgakms: Update matroxfb driver code for DRM
>>
>>  Documentation/gpu/drm-kms-helpers.rst     |   12 +
>>  Documentation/gpu/todo.rst                |   15 +
>>  drivers/gpu/drm/Kconfig                   |   11 +
>>  drivers/gpu/drm/Makefile                  |    1 +
>>  drivers/gpu/drm/drm_fbconv_helper.c       | 2126 +++++++++++++++++
>>  drivers/gpu/drm/drm_simple_kms_helper.c   |   15 +
>>  drivers/staging/Kconfig                   |    2 +
>>  drivers/staging/Makefile                  |    1 +
>>  drivers/staging/mgakms/Kconfig            |   18 +
>>  drivers/staging/mgakms/Makefile           |   17 +
>>  drivers/staging/mgakms/g450_pll.c         |  539 +++++
>>  drivers/staging/mgakms/g450_pll.h         |   13 +
>>  drivers/staging/mgakms/i2c-matroxfb.c     |  238 ++
>>  drivers/staging/mgakms/matroxfb_DAC1064.c | 1082 +++++++++
>>  drivers/staging/mgakms/matroxfb_DAC1064.h |  174 ++
>>  drivers/staging/mgakms/matroxfb_Ti3026.c  |  746 ++++++
>>  drivers/staging/mgakms/matroxfb_Ti3026.h  |   10 +
>>  drivers/staging/mgakms/matroxfb_accel.c   |  519 +++++
>>  drivers/staging/mgakms/matroxfb_accel.h   |    9 +
>>  drivers/staging/mgakms/matroxfb_base.c    | 2592 ++++++++++++++++++++=
+
>>  drivers/staging/mgakms/matroxfb_base.h    |  700 ++++++
>>  drivers/staging/mgakms/matroxfb_crtc2.h   |   35 +
>>  drivers/staging/mgakms/matroxfb_g450.c    |  640 +++++
>>  drivers/staging/mgakms/matroxfb_g450.h    |   10 +
>>  drivers/staging/mgakms/matroxfb_maven.h   |   21 +
>>  drivers/staging/mgakms/matroxfb_misc.c    |  815 +++++++
>>  drivers/staging/mgakms/matroxfb_misc.h    |   22 +
>>  drivers/staging/mgakms/mga_device.c       |   68 +
>>  drivers/staging/mgakms/mga_device.h       |   30 +
>>  drivers/staging/mgakms/mga_drv.c          |  129 +
>>  drivers/staging/mgakms/mga_drv.h          |   14 +
>>  drivers/video/fbdev/core/fbmem.c          |    5 +-
>>  include/drm/drm_fbconv_helper.h           |  150 ++
>>  include/drm/drm_simple_kms_helper.h       |   43 +
>>  include/linux/fb.h                        |    3 +
>>  35 files changed, 10822 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/gpu/drm/drm_fbconv_helper.c
>>  create mode 100644 drivers/staging/mgakms/Kconfig
>>  create mode 100644 drivers/staging/mgakms/Makefile
>>  create mode 100644 drivers/staging/mgakms/g450_pll.c
>>  create mode 100644 drivers/staging/mgakms/g450_pll.h
>>  create mode 100644 drivers/staging/mgakms/i2c-matroxfb.c
>>  create mode 100644 drivers/staging/mgakms/matroxfb_DAC1064.c
>>  create mode 100644 drivers/staging/mgakms/matroxfb_DAC1064.h
>>  create mode 100644 drivers/staging/mgakms/matroxfb_Ti3026.c
>>  create mode 100644 drivers/staging/mgakms/matroxfb_Ti3026.h
>>  create mode 100644 drivers/staging/mgakms/matroxfb_accel.c
>>  create mode 100644 drivers/staging/mgakms/matroxfb_accel.h
>>  create mode 100644 drivers/staging/mgakms/matroxfb_base.c
>>  create mode 100644 drivers/staging/mgakms/matroxfb_base.h
>>  create mode 100644 drivers/staging/mgakms/matroxfb_crtc2.h
>>  create mode 100644 drivers/staging/mgakms/matroxfb_g450.c
>>  create mode 100644 drivers/staging/mgakms/matroxfb_g450.h
>>  create mode 100644 drivers/staging/mgakms/matroxfb_maven.h
>>  create mode 100644 drivers/staging/mgakms/matroxfb_misc.c
>>  create mode 100644 drivers/staging/mgakms/matroxfb_misc.h
>>  create mode 100644 drivers/staging/mgakms/mga_device.c
>>  create mode 100644 drivers/staging/mgakms/mga_device.h
>>  create mode 100644 drivers/staging/mgakms/mga_drv.c
>>  create mode 100644 drivers/staging/mgakms/mga_drv.h
>>  create mode 100644 include/drm/drm_fbconv_helper.h
>>
>> --
>> 2.23.0
>>
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--vetiopZEuHfbchxGZNIHeDlrkz6zMaIOr--

--5VUqdQIYROeNHXTUMY64yOuiNULBt7IlO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl2mAcoACgkQaA3BHVML
eiOV9Af/UHqAiq+XxZfRBxD2KFdgxR5gFwI5RPyqr6oZGNstsfqJp6OFlvhlbO0H
pK69aUgAgAf5oS9HW9c8qkL6emPHt+iyGd23KwPkj9cChpVEpaj5XpHNH0xylthx
TCCANLBpMcZ7F7F7vPz4HiSACS0Ud6BBa5J48WpinZcLYz/OAA1oo873NdnoTKSI
SWBf79V+5db3T6tXcMp0N0tjLXBtWHH4EI9j8Ksv+I5AEh0NK2EdwHS0d+IZdpWS
J9uX5PA9J6k2hnCzV33weo7GRo1sqWWYx0SCQsbYtd5BrC8EsGBwFh1irW9eQALG
sjlKooKNzLgSMivU/cMAL9kb68htNg==
=l58t
-----END PGP SIGNATURE-----

--5VUqdQIYROeNHXTUMY64yOuiNULBt7IlO--
