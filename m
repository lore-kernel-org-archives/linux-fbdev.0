From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Aug 2012 06:09:46 +0000
Subject: [PATCH 0/2] OMAPDSS: fixes for -rc
Message-Id: <1345529388-3509-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Florian,

Here are two small fixes for omapfb and omapdss. The first one fixes an old bug
that causes colors to be wrong on fb console. The other fixes SDI output that
got broken in the previous merge window.

 Tomi

Grazvydas Ignotas (1):
  OMAPFB: fix framebuffer console colors

Tomi Valkeinen (1):
  OMAPDSS: Fix SDI PLL locking

 drivers/video/omap2/dss/sdi.c            |   14 ++++++++++++++
 drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
1.7.9.5

