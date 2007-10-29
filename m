From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Silence radeon_pm warning
Date: Mon, 29 Oct 2007 13:59:11 +1100
Message-ID: <20071029135911.ba1bfee2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756626AbXJ2C7X@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

drivers/video/aty/radeon_pm.c:30: warning: 'radeon_reinitialize_M10' declared 'static' but never defined

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/video/aty/radeon_pm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index be1d57b..f989836 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -27,7 +27,9 @@
 
 #include "ati_ids.h"
 
+#ifdef CONFIG_PM
 static void radeon_reinitialize_M10(struct radeonfb_info *rinfo);
+#endif
 
 /*
  * Workarounds for bugs in PC laptops:
-- 
1.5.3.4
