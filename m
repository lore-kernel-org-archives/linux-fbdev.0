From: Archit Taneja <archit@ti.com>
Date: Wed, 07 Nov 2012 09:29:21 +0000
Subject: [PATCH 0/3] OMAPDSS: APPLY: Misc Fixes
Message-Id: <1352279844-10494-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <n>
In-Reply-To: <n>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This series resolves a few minor issues with APPLY. Tested on a 4430sdp, checked
switching overlays between DSI command mode and HDMI displays for any unexpected
behavior.

Reference tree:
git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 3.8/apply_fixes

Archit Taneja (3):
  OMAPDSS: APPLY: Don't treat an overlay's channel out as shadow bits
  OMAPDSS: APPLY: Remove unnecessary variable in dss_apply_irq_handler
  OMAPDSS: APPLY: Remove unnecessary call to mg_clear_shadow_dirty

 drivers/video/omap2/dss/apply.c |   48 +++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

-- 
1.7.9.5

