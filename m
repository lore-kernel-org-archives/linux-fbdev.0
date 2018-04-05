From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Thu, 05 Apr 2018 17:54:00 +0000
Subject: [PATCH 00/16] Make all drivers under drivers/media to build with COMPILE_TEST
Message-Id: <cover.1522949748.git.mchehab@s-opensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, dri-devel@lists.freedesktop.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, linux-samsung-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski <krzk@kernel.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Kukjin Kim <kgene@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Geliang Tang <geliangtang@gmail.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-a


The current media policy has been for a while to only accept new drivers 
that compile with COMPILE_TEST.

However, there are still several drivers under drivers/media that 
doesn't build with COMPILE_TEST.

So, this series makes the existing ones also compatible with it.

Not building with COMPILE_TEST is a bad thing, for several reasons.

The main ones is that:

1) the licence the Kernel community has for Coverity only builds for 
   x86. So, drivers that don't build on such archtecture were likely 
   never tested by it.

2) That affects my per-patch handling process, with should be quick 
   enough to not delay my patch handling process. So, I only build for one 
   architecture (i386).

3) When appliying a patch, I always run two static code analyzers (W=1, 
   smatch and sparse). Those drivers weren't checked by me. At the end 
   of the day, that leads to a lower quality check for the drivers that 
   don't build on i386.

There are two situations on this patch series that proof the lower 
quality of those drivers:

- There is a case of a driver that was added broken in 2013. Only two 
  years later, someone noticed and "fixed" it by markin it as BROKEN!

- 5 patches in this series (about 1/3) are just to fix build issues on 
  those drivers, most of them due to gcc warnings.


Mauro Carvalho Chehab (16):
  omap: omap-iommu.h: allow building drivers with COMPILE_TEST
  media: omap3isp: allow it to build with COMPILE_TEST
  media: omap3isp/isp: remove an unused static var
  media: fsl-viu: mark static functions as such
  media: fsl-viu: allow building it with COMPILE_TEST
  media: cec_gpio: allow building CEC_GPIO with COMPILE_TEST
  media: exymos4-is: allow compile test for EXYNOS FIMC-LITE
  media: mmp-camera.h: add missing platform data
  media: marvel-ccic: re-enable mmp-driver build
  media: mmp-driver: make two functions static
  media: davinci: allow building isif code
  media: davinci: allow build vpbe_display with COMPILE_TEST
  media: vpbe_venc: don't store return codes if they won't be used
  media: davinci: get rid of lots of kernel-doc warnings
  media: omapfb_dss.h: add stubs to build with COMPILE_TEST
  media: omap: allow building it with COMPILE_TEST

 drivers/media/platform/Kconfig                   | 12 +++---
 drivers/media/platform/davinci/Kconfig           |  6 ++-
 drivers/media/platform/davinci/isif.c            |  2 -
 drivers/media/platform/davinci/vpbe.c            | 38 +++++++++--------
 drivers/media/platform/davinci/vpbe_display.c    | 21 +++++----
 drivers/media/platform/davinci/vpbe_osd.c        | 16 ++++---
 drivers/media/platform/davinci/vpbe_venc.c       |  9 ++--
 drivers/media/platform/exynos4-is/Kconfig        |  4 +-
 drivers/media/platform/fsl-viu.c                 | 20 ++++++---
 drivers/media/platform/marvell-ccic/Kconfig      |  5 ++-
 drivers/media/platform/marvell-ccic/mmp-driver.c |  4 +-
 drivers/media/platform/omap/Kconfig              |  6 +--
 drivers/media/platform/omap3isp/isp.c            | 14 +++---
 include/linux/omap-iommu.h                       |  5 +++
 include/linux/platform_data/media/mmp-camera.h   | 19 +++++++++
 include/video/omapfb_dss.h                       | 54 +++++++++++++++++++++++-
 16 files changed, 162 insertions(+), 73 deletions(-)

-- 
2.14.3


