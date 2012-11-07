From: Archit Taneja <archit@ti.com>
Date: Wed, 07 Nov 2012 06:27:01 +0000
Subject: [PATCH 0/3] OMAPDSS: DISPC: Writeback fixes
Message-Id: <1352268905-31093-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Some issues were found in the DISPC driver when performing scaling with
writeback pipeline. This series fixes those issues.

Reference tree:
git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git 3.8/writeback_fixes_dispc

Archit Taneja (3):
  OMAPDSS: DISPC: Fix calc_scaling_44xx() bugs for writeback pipeline
  OMAPDSS: DISPC: Don't allow predecimation for writeback
  OMAPDSS: DISPC: Use output width and height to calculate row/pix inc
    for writeback

 drivers/video/omap2/dss/dispc.c |   39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

-- 
1.7.9.5

