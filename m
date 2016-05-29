From: Rongrong Zou <zourongrong@gmail.com>
Date: Sun, 29 May 2016 09:40:48 +0000
Subject: [path v2 0/7] Add DRM driver for Hisilicon Hibmc
Message-Id: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zourongrong@huawei.com, airlied@linux.ie, emil.l.velikov@gmail.com, lijianhua@huawei.com, xinliang.liu@linaro.org
Cc: dri-devel@lists.freedesktop.org, guohanjun@huawei.com, majun258@huawei.com, linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

This patch set adds a new drm driver for Hisilicon Hibmc. Hibmc is a
base board management controller, usually it is used on server for
Out-of-band management purpose. In this patch set, we just support basic
function for Hibmc display subsystem. Hibmc display subsystem is connected
to host CPU by PCIe as blow:

+----------+       +----------+
|          | PCIe  |  Hibmc   |
|host CPU( |<----->| display  |
|arm64,x86)|       |subsystem |
+----------+       +----------+

Hardware Detail for Hibmc display subsystem
-----------

  The display subsystem of Hibmc is show as bellow:
  +----+      +----+      +----+     +--------+
  |    |      |    |      |    |     |        |
  | FB |----->| DE |----->|VDAC|---->|external|
  |    |      |    |      |    |     | VGA    |
  +----+      +----+      +----+     +--------+

  -DE(Display Engine) is the display controller.
  -VDAC(Video Digital-to-Analog converter) converts the RGB diaital data
  stream from DE to VGA analog signals.

Change History
------------

Changes in v2:
  -Remove self-defined macros for bit operations.
  -Remove unused register.
  -Replace those deprecated functions with new version of them.
  -use drm_connector_register_all() to register connector after
   drm_dev_register().

The patch v1 is at
https://lists.freedesktop.org/archives/dri-devel/2016-February/101921.html
Sorry for too late sending.


Rongrong Zou (7):
  idrm/hisilicon/hibmc: Add hisilicon hibmc drm master driver
  drm/hisilicon/hibmc: Add plane for DE
  drm/hisilicon/hibmc: Add crtc for DE
  drm/hisilicon/hibmc: Add encoder for VDAC
  drm/hisilicon/hibmc: Add connector for VDAC
  drm/hisilicon/hibmc: Add support for frame buffer
  drm/hisilicon/hibmc: Add maintainer for Hibmc DRM

 MAINTAINERS                                       |   7 +
 drivers/gpu/drm/hisilicon/Kconfig                 |   1 +
 drivers/gpu/drm/hisilicon/Makefile                |   3 +-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig           |  13 +
 drivers/gpu/drm/hisilicon/hibmc/Makefile          |   4 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 477 ++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h    |  29 ++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 399 ++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  64 +++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 286 +++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c |  91 +++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h |  28 ++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h  | 214 ++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 174 ++++++++
 14 files changed, 1789 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/Kconfig
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/Makefile
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.c
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_power.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c

-- 
1.9.1

