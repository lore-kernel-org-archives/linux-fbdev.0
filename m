From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 11 Jul 2012 22:41:32 +0000
Subject: [GIT PULL] fbdev fixes for 3.5#2
Message-Id: <4FFE011C.7020902@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Linus,

please pull the fixes below.


Thanks,

Florian Tobias Schandinat


The following changes since commit b67989515defba7412acff01162e5bb1f0f5923a:

  video: s3c-fb: fix possible division by zero in s3c_fb_calc_pixclk (2012-06-13 17:34:16 +0000)

are available in the git repository at:

  git://github.com/schandinat/linux-2.6.git fbdev-fixes-for-3.5-2

for you to fetch changes up to 373b43652150c9342168c846a1efbd81438ea241:

  OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=n (2012-07-08 14:00:27 +0000)

----------------------------------------------------------------
fbdev fixes for 3.5

- two fixes for OMAPDSS by Tomi Valkeinen
  one to avoid warnings when runtime PM is not enabled
  one workaround to dependancy issues during suspend/resume

----------------------------------------------------------------
Tomi Valkeinen (2):
      OMAPDSS: Use PM notifiers for system suspend
      OMAPDSS: fix warnings if CONFIG_PM_RUNTIME=n

 drivers/video/omap2/dss/core.c  |   43 ++++++++++++++++++++++++--------------
 drivers/video/omap2/dss/dispc.c |    2 +-
 drivers/video/omap2/dss/dsi.c   |    2 +-
 drivers/video/omap2/dss/dss.c   |    2 +-
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 drivers/video/omap2/dss/rfbi.c  |    2 +-
 drivers/video/omap2/dss/venc.c  |    2 +-
 7 files changed, 33 insertions(+), 22 deletions(-)
