From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Feb 2015 12:49:07 +0000
Subject: [PATCH 13/15] OMAPDSS: workaround for MFLAG + NV12 issue
Message-Id: <1424954949-12801-13-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

It was found that having two displays enabled and having an NV12 overlay
on one of the displays will cause underflows/synclosts. Debugging this
pointed to some issue with MFLAG.

It is unclear why this issue is happening, but it looks like there is a
HW bug related to MFLAG and FIFO management. Disabling MFLAG makes this
issue go away, but then we lose the benefit of MFLAG. Also forcing MFLAG
always on makes the issue go away.

Also, using certain values for MFLAG_START, MFLAG thresholds and PRELOAD
makes the issue go away, but there was no obvious logic to which values
work and which don't.

As a workaround until more information about this is found, force MFLAG
always on to make NV12 usable.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 6b056d0ce187..f4fc77d9d3bf 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -1328,8 +1328,18 @@ static void dispc_init_mflag(void)
 {
 	int i;
 
+	/*
+	 * HACK: NV12 color format and MFLAG seem to have problems working
+	 * together: using two displays, and having an NV12 overlay on one of
+	 * the displays will cause underflows/synclosts when MFLAG_CTRL=2.
+	 * Changing MFLAG thresholds and PRELOAD to certain values seem to
+	 * remove the errors, but there doesn't seem to be a clear logic on
+	 * which values work and which not.
+	 *
+	 * As a work-around, set force MFLAG to always on.
+	 */
 	dispc_write_reg(DISPC_GLOBAL_MFLAG_ATTRIBUTE,
-		(2 << 0) |	/* MFLAG_CTRL = enable */
+		(1 << 0) |	/* MFLAG_CTRL = force always on */
 		(0 << 2));	/* MFLAG_START = disable */
 
 	for (i = 0; i < dss_feat_get_num_ovls(); ++i) {
-- 
2.3.0

