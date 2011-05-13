From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 13 May 2011 15:54:44 +0000
Subject: [PATCH 0/5] mb862xxfb driver update for 2.6.40
Message-Id: <1305302089-7666-1-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch series extends the driver for Coral GDCs to support
such controller features as video layer L1 and I2C bus for video
decoder chips. First three patches are small fixes and improvements.

These patches can also be pulled from

  git://git.denx.de/linux-2.6-agust.git mb862xxfb-for-next

Anatolij Gustschin (5):
  video: mb862xxfb: correct fix.smem_len field initialization
  video: mb862xxfb: use pre-initialized configuration for PCI GDCs
  video: mb862xxfb: relocate register space to get contiguous vram
  video: mb862xx: add support for controller's I2C bus adapter
  video: mb862xxfb: add support for L1 displaying

 drivers/video/mb862xx/Makefile      |    2 +-
 drivers/video/mb862xx/mb862xx-i2c.c |  168 +++++++++++++++++++++++++++++++++++
 drivers/video/mb862xx/mb862xx_reg.h |   58 +++++++++++-
 drivers/video/mb862xx/mb862xxfb.c   |  150 +++++++++++++++++++++++++++++--
 drivers/video/mb862xx/mb862xxfb.h   |   30 ++++++
 5 files changed, 396 insertions(+), 12 deletions(-)
 create mode 100644 drivers/video/mb862xx/mb862xx-i2c.c

