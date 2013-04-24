From: Markus Pargmann <mpa@pengutronix.de>
Date: Wed, 24 Apr 2013 13:39:09 +0000
Subject: [PATCH v5 0/2] video: imxfb DT support
Message-Id: <1366810751-26860-1-git-send-email-mpa@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

This series adds DT support for imxfb. Changes are listed in the notes section
of each patch.

Regards,

Markus



Christian Hemp (1):
      imxfb: Set alpha value of the framebuffer

Markus Pargmann (1):
      video: imxfb: Add DT support

 Documentation/devicetree/bindings/video/fsl,imx-fb.txt |  51 +++++++++++++
 drivers/video/Kconfig                                  |   2 +
 drivers/video/imxfb.c                                  | 229 +++++++++++++++++++++++++++++++++++++++++++++++---------
 include/linux/platform_data/video-imxfb.h              |   3 +
 4 files changed, 250 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,imx-fb.txt

