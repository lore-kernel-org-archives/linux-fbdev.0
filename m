From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Feb 2015 12:49:01 +0000
Subject: [PATCH 07/15] OMAPDSS: change signal_level & signal_edge enum values
Message-Id: <1424954949-12801-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

At the moment the enum values for ACTIVE_HIGH and RISING_EDGE are 0, and
ACTIVE_LOW and FALLING_EDGE are 1, to match the values programmed to HW.
The previous patch removed this dependency.

Swap the enum values the other way around. This doesn't change the
behavior in any way, but makes it easier to debug as value of '1' means
HIGH or RISING.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 7414e4a97508..45a230190720 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -129,13 +129,13 @@ enum omap_rfbi_te_mode {
 };
 
 enum omap_dss_signal_level {
-	OMAPDSS_SIG_ACTIVE_HIGH	= 0,
-	OMAPDSS_SIG_ACTIVE_LOW	= 1,
+	OMAPDSS_SIG_ACTIVE_LOW,
+	OMAPDSS_SIG_ACTIVE_HIGH,
 };
 
 enum omap_dss_signal_edge {
-	OMAPDSS_DRIVE_SIG_RISING_EDGE,
 	OMAPDSS_DRIVE_SIG_FALLING_EDGE,
+	OMAPDSS_DRIVE_SIG_RISING_EDGE,
 };
 
 enum omap_dss_venc_type {
-- 
2.3.0

