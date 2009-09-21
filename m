From: Tommi Rantala <tt.rantala@gmail.com>
Subject: [PATCH] omapfb: Blizzard: fix pointer to be const
Date: Mon, 21 Sep 2009 15:47:22 +0300
Message-ID: <1253537242-5300-1-git-send-email-tt.rantala@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Cc: Imre Deak <imre.deak@nokia.com>, Tony Lindgren <tony@atomide.com>, Siarhei Siamashka <siarhei.siamashka@nokia.com>, Rodrigo Vivi <rodrigo.vivi@openbossa.org>, Tommi Rantala <tt.rantala@gmail.com>

Fixes a compiler warning:
warning: assignment discards qualifiers from pointer target type

Signed-off-by: Tommi Rantala <tt.rantala@gmail.com>
---
 drivers/video/omap/blizzard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index d5e5955..ce28be6 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -191,7 +191,7 @@ struct blizzard_struct {
 
 	struct omapfb_device	*fbdev;
 	struct lcd_ctrl_extif	*extif;
-	struct lcd_ctrl		*int_ctrl;
+	const struct lcd_ctrl	*int_ctrl;
 
 	void			(*power_up)(struct device *dev);
 	void			(*power_down)(struct device *dev);
-- 
1.5.6.5

