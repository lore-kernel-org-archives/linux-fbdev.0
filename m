From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Sep 2015 12:19:12 +0000
Subject: [GIT PULL] fbdev changes for 4.3
Message-Id: <55ED80C0.4020800@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mFUi8iDuiqtg6NI3pfFA1hWqhAfpW2k1F"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--mFUi8iDuiqtg6NI3pfFA1hWqhAfpW2k1F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull fbdev changes for 4.3. Not much this time.


The following changes since commit 2c6625cd545bdd66acff14f3394865d43920a5=
c7:

  Linux 4.2-rc7 (2015-08-16 16:34:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-4.3

for you to fetch changes up to 57817e619a215588739f3f644986c78b586b541b:

  video: fbdev: atmel_lcdfb: remove useless include (2015-09-02 14:24:51 =
+0300)

----------------------------------------------------------------
fbdev changes for 4.3

* Minor fixes and cleanups

----------------------------------------------------------------
Alexandre Belloni (1):
      video: fbdev: atmel_lcdfb: remove useless include

Alexey Klimov (1):
      fbdev: udlfb: remove unneeded initialization in few places

Dan Carpenter (1):
      fbdev: fix snprintf() limit in show_bl_curve()

Geert Uytterhoeven (1):
      fbdev: Allow compile test of GPIO consumers if !GPIOLIB

Julia Lawall (1):
      fbdev: ssd1307fb: fix error return code

Krzysztof Kozlowski (3):
      video: fbdev: Drop owner assignment from i2c_driver
      video: fbdev: Drop owner assignment from platform_driver
      video: fbdev: s3c-fb: Constify platform_device_id

Marcin Chojnacki (1):
      fbdev: remove unnecessary memset in vfb

Nicolai Stange (1):
      framebuffer: disable vgacon on microblaze arch

Tomi Valkeinen (2):
      fbdev: fix cea_modes array size
      video: fbdev: atmel: fix warning for const return value

Vaishali Thakkar (1):
      video: fbdev: pxa168fb: Use devm_clk_get

 drivers/video/console/Kconfig                           |  2 +-
 drivers/video/fbdev/Kconfig                             |  2 +-
 drivers/video/fbdev/atmel_lcdfb.c                       |  3 +--
 drivers/video/fbdev/core/fbmon.c                        |  4 ++--
 drivers/video/fbdev/core/fbsysfs.c                      |  2 +-
 drivers/video/fbdev/core/modedb.c                       |  2 +-
 drivers/video/fbdev/omap2/displays-new/encoder-opa362.c |  1 -
 drivers/video/fbdev/pxa168fb.c                          | 14 ++++-------=
---
 drivers/video/fbdev/s3c-fb.c                            |  2 +-
 drivers/video/fbdev/ssd1307fb.c                         |  6 +++---
 drivers/video/fbdev/udlfb.c                             | 10 ++++------
 drivers/video/fbdev/vfb.c                               | 17 ++++++++---=
------
 include/linux/fb.h                                      |  2 +-
 13 files changed, 28 insertions(+), 39 deletions(-)


--mFUi8iDuiqtg6NI3pfFA1hWqhAfpW2k1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV7YDAAAoJEPo9qoy8lh71xwQQAKzXVcYgwUc5YuhkRZ69xqPU
OCaveb9SAFU5zoTKpdq/vm3Uc9u8OwQRI2yuO4TOFBg3gkACQkBvBChd9ZEcDH6V
Jbylb3NhzXBQCl+zd/y10EsxB4So66vlguioOQLQKYNQmK6H6JDCK+xIOcLA+2yC
5Hd6aKYhFA/NCECDg+x6cuj4osHTyyfCG1mKvE4LNaeODrqpGwzSXa83qSRfcNK8
KBForeyUUoaeckupUCuIJIXVwIbf8nn1MNgBFOXb+RGN2V4E7kpJB+BaXYPCAtJp
j3xJU3TO2BnVUB5Lr6dzF2eLE6T7QMQNtPDerOvAUXAejrEG/uJZjk4x8K22cnn/
X2IgCtqPZXGDRsfQSHrAFrxwaATOPRNE3jTvIOTCKbW4x8RG3qRKvTjjD9EFjUGV
D7voaUfWAzP8YagP4HWBXijUckj68VAxHmgxTuRQbm83l5qWu0E9BPbEuHyCCk2H
ivgO0ASoNKab+ZUoYQB2uvL7UjnUtDf2+K45lYDPrcAxeWHW9v4hbGxsMPt2OQAV
qYk67DX9/ju6IP1p0BRh5CAxnDFloRu+tRoKwcGMpYX0mrGWIBzbhIslFVC9lBMr
J0g6lXrCEeNXTFp/LHWtP8QcOMzyNU67D7kwSl70RCejfLZPr/F+KYWQocLTe5j6
TDUJy8Pg2/iQRvFpXQPL
=lhAr
-----END PGP SIGNATURE-----

--mFUi8iDuiqtg6NI3pfFA1hWqhAfpW2k1F--
