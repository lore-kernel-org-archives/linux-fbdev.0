From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Thu, 28 Jun 2012 09:52:51 +0000
Subject: [PATCH 2/4] OMAPDSS: Add support for LCD3 channel
Message-Id: <3885e2f3e7dfee230facf9dbae5ea550c98f1d51.1340874806.git.cmahapatra@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1340874806.git.cmahapatra@ti.com>
In-Reply-To: <cover.1340874806.git.cmahapatra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

OMAP5 Display Subsystem (DSS) architecture comes with a additional LCD3 channel
with its own dedicated overlay manager. The current patch adds LCD3 channel and
basic register support for LCD3 channel. It adds register addresses for various
Display Controller (DISPC) registers like DISPC_DEFAULT_COLOR, DISPC_TIMING_H,
DISPC_DIVISORo, etc.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.h |   26 ++++++++++++++++++++++++++
 include/video/omapdss.h         |    1 +
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index f278080..420c980 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -118,6 +118,8 @@ static inline u16 DISPC_DEFAULT_COLOR(enum omap_channel channel)
 		return 0x0050;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03AC;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0814;
 	default:
 		BUG();
 		return 0;
@@ -133,6 +135,8 @@ static inline u16 DISPC_TRANS_COLOR(enum omap_channel channel)
 		return 0x0058;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03B0;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0818;
 	default:
 		BUG();
 		return 0;
@@ -149,6 +153,8 @@ static inline u16 DISPC_TIMING_H(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x0400;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0840;
 	default:
 		BUG();
 		return 0;
@@ -165,6 +171,8 @@ static inline u16 DISPC_TIMING_V(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x0404;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0844;
 	default:
 		BUG();
 		return 0;
@@ -181,6 +189,8 @@ static inline u16 DISPC_POL_FREQ(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x0408;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x083C;
 	default:
 		BUG();
 		return 0;
@@ -197,6 +207,8 @@ static inline u16 DISPC_DIVISORo(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x040C;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0838;
 	default:
 		BUG();
 		return 0;
@@ -213,6 +225,8 @@ static inline u16 DISPC_SIZE_MGR(enum omap_channel channel)
 		return 0x0078;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03CC;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0834;
 	default:
 		BUG();
 		return 0;
@@ -229,6 +243,8 @@ static inline u16 DISPC_DATA_CYCLE1(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03C0;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0828;
 	default:
 		BUG();
 		return 0;
@@ -245,6 +261,8 @@ static inline u16 DISPC_DATA_CYCLE2(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03C4;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x082C;
 	default:
 		BUG();
 		return 0;
@@ -261,6 +279,8 @@ static inline u16 DISPC_DATA_CYCLE3(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03C8;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0830;
 	default:
 		BUG();
 		return 0;
@@ -277,6 +297,8 @@ static inline u16 DISPC_CPR_COEF_R(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03BC;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0824;
 	default:
 		BUG();
 		return 0;
@@ -293,6 +315,8 @@ static inline u16 DISPC_CPR_COEF_G(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03B8;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x0820;
 	default:
 		BUG();
 		return 0;
@@ -309,6 +333,8 @@ static inline u16 DISPC_CPR_COEF_B(enum omap_channel channel)
 		return 0;
 	case OMAP_DSS_CHANNEL_LCD2:
 		return 0x03B4;
+	case OMAP_DSS_CHANNEL_LCD3:
+		return 0x081C;
 	default:
 		BUG();
 		return 0;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index c8e59b4..cf4f716 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -75,6 +75,7 @@ enum omap_channel {
 	OMAP_DSS_CHANNEL_LCD	= 0,
 	OMAP_DSS_CHANNEL_DIGIT	= 1,
 	OMAP_DSS_CHANNEL_LCD2	= 2,
+	OMAP_DSS_CHANNEL_LCD3	= 3,
 };
 
 enum omap_color_mode {
-- 
1.7.1

