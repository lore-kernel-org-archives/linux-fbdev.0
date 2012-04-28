From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Sat, 28 Apr 2012 10:18:03 +0000
Subject: [PATCH v2 0/4] video: add support for the AUO-K190X epd controllers
Message-Id: <201204281218.04180.heiko@sntech.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Second version of support for the Sipix epd controllers made by AUO.

Changes were made to the common code in patch 2, including fixing
the Kconfig options as suggested by Florian Tobias Schandinat and
fixing a possible runtime-pm mismatch if the deferred_io
callback was called without a prior call to first_io.

Heiko St=C3=BCbner (4):
  fb_defio: add first_io callback
  video: auo_k190x: add code shared by controller drivers
  video: auo_k190x: add driver for AUO-K1900 variant
  video: auo_k190x: add driver for AUO-K1901 variant

 drivers/video/Kconfig       |   33 ++
 drivers/video/Makefile      |    3 +
 drivers/video/auo_k1900fb.c |  198 ++++++++
 drivers/video/auo_k1901fb.c |  251 +++++++++++
 drivers/video/auo_k190x.c   | 1046 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/video/auo_k190x.h   |  129 ++++++
 drivers/video/fb_defio.c    |    4 +
 drivers/video/smscufx.c     |    2 +-
 drivers/video/udlfb.c       |    2 +-
 include/linux/fb.h          |    1 +
 include/video/auo_k190xfb.h |  106 +++++
 11 files changed, 1773 insertions(+), 2 deletions(-)
 create mode 100644 drivers/video/auo_k1900fb.c
 create mode 100644 drivers/video/auo_k1901fb.c
 create mode 100644 drivers/video/auo_k190x.c
 create mode 100644 drivers/video/auo_k190x.h
 create mode 100644 include/video/auo_k190xfb.h

--=20
1.7.5.4

