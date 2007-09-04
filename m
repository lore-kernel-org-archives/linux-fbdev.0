From: aherrman@arcor.de
Subject: [PATCH 3/4] radeonfb: fix setting of PPLL_REF_DIV for RV370 5B60
Date: Tue, 4 Sep 2007 13:00:00 +0200
Message-ID: <20070904110000.GG7320@devil>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754342AbXIDK6u@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

As observed with various Radeon X300: console goes blank
without fixing setting of PPLL_REF_DIV.

Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
---
 drivers/video/aty/radeon_base.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index f672c0c..71b0c17 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -1287,7 +1287,8 @@ static void radeon_write_pll_regs(struct radeonfb_info *rinfo, struct radeon_reg
 	if (rinfo->family == CHIP_FAMILY_R300 ||
 	    rinfo->family == CHIP_FAMILY_RS300 ||
 	    rinfo->family == CHIP_FAMILY_R350 ||
-	    rinfo->family == CHIP_FAMILY_RV350) {
+	    rinfo->family == CHIP_FAMILY_RV350 ||
+	    rinfo->family == CHIP_FAMILY_RV380 ) {
 		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {
 			/* When restoring console mode, use saved PPLL_REF_DIV
 			 * setting.
-- 
1.5.3
