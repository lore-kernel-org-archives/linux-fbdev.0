From: Daniel Morsing <daniel.morsing@gmail.com>
Date: Sat, 12 Feb 2011 17:02:08 +0000
Subject: [PATCH 0/2] Add recommended bpp for omap dss2 generic dpi panels
Message-Id: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomba@iki.fi>
Cc: Bryan Wu <bryan.wu@canonical.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>

This series adds a mechanism for specifying a recommended bpp for
generic dss2 dpi panels and adds a panel that uses this feature.

The panel added is the 4.3 inch display that is sold with the
Devkit8000.

Daniel Morsing (2):
  omap: dss2: Add recommended bpp option for generic dpi panels
  omap3: devkit8000: Add and use 4.3 inch display

 arch/arm/mach-omap2/board-devkit8000.c           |    2 +-
 drivers/video/omap2/displays/panel-generic-dpi.c |   41 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletions(-)

-- 
1.7.4

