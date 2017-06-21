From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Wed, 21 Jun 2017 08:08:05 +0000
Subject: [PATCH RESEND 0/7] Introduce MEDIA_VERSION to end KENREL_VERSION abuse in media
Message-Id: <20170621080812.6817-1-jthumshirn@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Johannes Thumshirn <jthumshirn@suse.de>

Currently the media subsystem has a very creative abuse of the
KERNEL_VERSION macro to encode an arbitrary version triplet for media
drivers and device hardware revisions.

This series introduces a new macro called MEDIA_REVISION which encodes
a version triplet like KERNEL_VERSION does, but clearly has media
centric semantics and doesn't fool someone into thinking specific
parts are defined for a specific kernel version only like in out of
tree drivers.

Johannes Thumshirn (7):
  [media] media: introduce MEDIA_REVISION macro
  video: fbdev: don't use KERNEL_VERSION macro for MEDIA_REVISION
  [media] media: document the use of MEDIA_REVISION instead of
    KERNEL_VERSION
  [media] cx25821: use MEDIA_REVISION instead of KERNEL_VERSION
  [media] media: s3c-camif: Use MEDIA_REVISON instead of KERNEL_VERSION
  [media] media: bcm2048: use MEDIA_REVISION isntead of KERNEL_VERSION
  staging/atomisp: use MEDIA_VERSION instead of KERNEL_VERSION

 Documentation/media/uapi/cec/cec-ioc-adap-g-caps.rst        | 2 +-
 Documentation/media/uapi/mediactl/media-ioc-device-info.rst | 4 ++--
 Documentation/media/uapi/v4l/vidioc-querycap.rst            | 6 +++---
 drivers/media/pci/cx25821/cx25821.h                         | 2 +-
 drivers/media/platform/s3c-camif/camif-core.c               | 2 +-
 drivers/staging/media/atomisp/include/linux/atomisp.h       | 6 +++---
 drivers/staging/media/bcm2048/radio-bcm2048.c               | 2 +-
 drivers/video/fbdev/matrox/matroxfb_base.c                  | 3 ++-
 include/media/media-device.h                                | 5 ++---
 include/uapi/linux/media.h                                  | 4 +++-
 10 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.12.3

