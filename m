From: Baruch Siach <baruch@tkos.co.il>
Date: Wed, 10 Feb 2010 07:25:17 +0000
Subject: [PATCH 0/3] mx25: framebuffer support
Message-Id: <cover.1265786237.git.baruch@tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This set of patches adds support for the i.MX25 LCD controller block using the 
imxfb driver. Platform code for the i.MX25 PDK board is also added.

Tested on the i.MX25 PDK.

Baruch Siach (3):
  imxfb: add support for i.MX25
  mx25: add platform support for imxfb
  mx25pdk: add LCD support

 arch/arm/mach-mx25/clock.c                  |   12 ++++++
 arch/arm/mach-mx25/devices.c                |   23 +++++++++++
 arch/arm/mach-mx25/devices.h                |    1 +
 arch/arm/mach-mx25/mx25pdk.c                |   55 +++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    2 +
 arch/arm/plat-mxc/include/mach/mx25.h       |    2 +
 drivers/video/Kconfig                       |    2 +-
 7 files changed, 96 insertions(+), 1 deletions(-)

