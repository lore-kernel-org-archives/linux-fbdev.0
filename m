From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 29 Feb 2012 08:48:20 +0000
Subject: [PATCH 0/2] OMAPDSS: small fixes for 3.3 rc
Message-Id: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Two small fixes for omapdss.

Florian, if the patches are ok, I guess it's easier if you just apply these
patches from email, instead of me sending a pull request?

 Tomi

Tomi Valkeinen (2):
  OMAPDSS: panel-dvi: Add Kconfig dependency on I2C
  OMAPDSS: APPLY: make ovl_enable/disable synchronous

 drivers/video/omap2/displays/Kconfig |    2 +-
 drivers/video/omap2/dss/apply.c      |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

-- 
1.7.4.1

