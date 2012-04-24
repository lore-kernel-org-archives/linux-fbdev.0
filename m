From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Apr 2012 12:44:16 +0000
Subject: [PULL for v3.5] fb: exynos: Fix MIPI/DSI front/back porch settings
Message-Id: <4788368.X6fyZNtHh2@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

Could you please pull the following fix ?

The following changes since commit d313a86d2efb2c5568832389663322e93e291c59:

  i.MX28: Shut down the LCD controller to avoid BootROM sampling bug 
(2012-04-21 21:53:12 +0000)

are available in the git repository at:
  git://linuxtv.org/pinchartl/fbdev.git fixes

Laurent Pinchart (1):
      fb: exynos: Fix MIPI/DSI front/back porch settings

 drivers/video/exynos/exynos_mipi_dsi_common.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

-- 
Regards,

Laurent Pinchart

