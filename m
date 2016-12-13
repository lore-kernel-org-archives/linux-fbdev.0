From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Tue, 13 Dec 2016 15:08:09 +0000
Subject: [PATCH 0/4] video/exynos/cec: add HDMI state notifier & use in s5p-cec
Message-Id: <20161213150813.37966-1-hverkuil@xs4all.nl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, Javier Martinez Canillas <javier@osg.samsung.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

From: Hans Verkuil <hans.verkuil@cisco.com>

This patch series adds the HDMI notifier code, based on Russell's code:

https://patchwork.kernel.org/patch/9277043/

It adds support for it to the exynos_hdmi drm driver, adds support for
it to the CEC framework and finally adds support to the s5p-cec driver,
which now can be moved out of staging.

Tested with my Odroid U3 exynos4 devboard.

Comments are welcome. I'd like to get this in for the 4.11 kernel as
this is a missing piece needed to integrate CEC drivers.

Benjamin, can you look at doing the same notifier integration for your
st-cec driver as is done for s5p-cec? It would be good to be able to
move st-cec out of staging at the same time.

Regards,

	Hans

Hans Verkuil (4):
  video: add HDMI state notifier support
  exynos_hdmi: add HDMI notifier support
  cec: integrate HDMI notifier support
  s5p-cec: add hdmi-notifier support, move out of staging

 .../devicetree/bindings/media/s5p-cec.txt          |   2 +
 arch/arm/boot/dts/exynos4.dtsi                     |   1 +
 drivers/gpu/drm/exynos/Kconfig                     |   1 +
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  24 +++-
 drivers/media/cec/cec-core.c                       |  50 ++++++++
 drivers/media/platform/Kconfig                     |  18 +++
 drivers/media/platform/Makefile                    |   1 +
 .../media => media/platform}/s5p-cec/Makefile      |   0
 .../platform}/s5p-cec/exynos_hdmi_cec.h            |   0
 .../platform}/s5p-cec/exynos_hdmi_cecctrl.c        |   0
 .../media => media/platform}/s5p-cec/regs-cec.h    |   0
 .../media => media/platform}/s5p-cec/s5p_cec.c     |  35 +++++-
 .../media => media/platform}/s5p-cec/s5p_cec.h     |   3 +
 drivers/staging/media/Kconfig                      |   2 -
 drivers/staging/media/Makefile                     |   1 -
 drivers/staging/media/s5p-cec/Kconfig              |   9 --
 drivers/staging/media/s5p-cec/TODO                 |   7 --
 drivers/video/Kconfig                              |   3 +
 drivers/video/Makefile                             |   1 +
 drivers/video/hdmi-notifier.c                      | 134 +++++++++++++++++++++
 include/linux/hdmi-notifier.h                      | 109 +++++++++++++++++
 include/media/cec.h                                |  15 +++
 22 files changed, 389 insertions(+), 27 deletions(-)
 rename drivers/{staging/media => media/platform}/s5p-cec/Makefile (100%)
 rename drivers/{staging/media => media/platform}/s5p-cec/exynos_hdmi_cec.h (100%)
 rename drivers/{staging/media => media/platform}/s5p-cec/exynos_hdmi_cecctrl.c (100%)
 rename drivers/{staging/media => media/platform}/s5p-cec/regs-cec.h (100%)
 rename drivers/{staging/media => media/platform}/s5p-cec/s5p_cec.c (89%)
 rename drivers/{staging/media => media/platform}/s5p-cec/s5p_cec.h (97%)
 delete mode 100644 drivers/staging/media/s5p-cec/Kconfig
 delete mode 100644 drivers/staging/media/s5p-cec/TODO
 create mode 100644 drivers/video/hdmi-notifier.c
 create mode 100644 include/linux/hdmi-notifier.h

-- 
2.10.2

