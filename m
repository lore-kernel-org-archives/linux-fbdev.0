From: Anatolij Gustschin <agust@denx.de>
Date: Tue, 24 May 2011 15:14:29 +0000
Subject: Re: [PATCH 0/5] mb862xxfb driver update for 2.6.40
Message-Id: <20110524171429.1568af56@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305302089-7666-1-git-send-email-agust@denx.de>
In-Reply-To: <1305302089-7666-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, 13 May 2011 17:54:44 +0200
Anatolij Gustschin <agust@denx.de> wrote:

> This patch series extends the driver for Coral GDCs to support
> such controller features as video layer L1 and I2C bus for video
> decoder chips. First three patches are small fixes and improvements.

Updated patches addressing comments can be pulled now. I rebased
them to apply on top of current fbdev-2.6 git tree.

The following changes since commit af1ce6b2fad7d572aef040d61a935da28a861853:

  video: s3c-fb: correct transparency checking in 32bpp (2011-05-24 18:04:37 +0900)

are available in the git repository at:
  git://git.denx.de/linux-2.6-agust.git mb862xxfb-for-next

Anatolij Gustschin (5):
      video: mb862xxfb: correct fix.smem_len field initialization
      video: mb862xxfb: use pre-initialized configuration for PCI GDCs
      video: mb862xxfb: relocate register space to get contiguous vram
      video: mb862xx: add support for controller's I2C bus adapter
      video: mb862xxfb: add support for L1 displaying

 drivers/video/Kconfig                              |    9 +
 drivers/video/mb862xx/Makefile                     |    5 +-
 drivers/video/mb862xx/mb862xx-i2c.c                |  177 ++++++++++++++++++++
 drivers/video/mb862xx/mb862xx_reg.h                |   58 ++++++-
 drivers/video/mb862xx/mb862xxfb.h                  |   36 ++++
 .../video/mb862xx/{mb862xxfb.c => mb862xxfbdrv.c}  |  152 ++++++++++++++++-
 6 files changed, 425 insertions(+), 12 deletions(-)
 create mode 100644 drivers/video/mb862xx/mb862xx-i2c.c
 rename drivers/video/mb862xx/{mb862xxfb.c => mb862xxfbdrv.c} (86%)

Thanks,
Anatolij
