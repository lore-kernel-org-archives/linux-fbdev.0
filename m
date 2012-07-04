From: Archit Taneja <archit@ti.com>
Date: Wed, 04 Jul 2012 12:55:47 +0000
Subject: [PATCH 0/2] OMAPDSS: PM runtime fixes for 3.5-rc
Message-Id: <1341405829-16964-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: tomi.valkeinen@ti.com, jaswinder.singh@linaro.org, jw@terrafix.co.uk, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Hi Florian,

These are 2 fixes which Tomi had intended to push for the coming rcs. He is
currently on vacation and asked me to post the patches on his behalf.

The first patch ensures that system suspend doesn't break on OMAP if DSS is
enabled. The second patch prevents some warning backtraces when the kernel is
not built with PM runtime.

Could you please queue these for the upcoming rc?

Thanks,
Archit

Tomi Valkeinen (2):
  OMAPDSS: Use PM notifiers for system suspend
  OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=n

 drivers/video/omap2/dss/core.c  |   45 +++++++++++++++++++++++++--------------
 drivers/video/omap2/dss/dispc.c |    2 +-
 drivers/video/omap2/dss/dsi.c   |    2 +-
 drivers/video/omap2/dss/dss.c   |    2 +-
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 drivers/video/omap2/dss/rfbi.c  |    2 +-
 drivers/video/omap2/dss/venc.c  |    2 +-
 7 files changed, 35 insertions(+), 22 deletions(-)

-- 
1.7.9.5

