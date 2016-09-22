From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 22 Sep 2016 10:35:25 +0000
Subject: [PATCH v2 2/3] video: display_timing: Add flags to select the edge when the sync is driven
Message-Id: <20160922103526.24925-3-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160922103526.24925-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160922103526.24925-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh+dt@kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, airlied@linux.ie, thierry.reding@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org

The sync can be - and for some panels it must be - driven on different edge
then the data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
---
 include/video/display_timing.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/video/display_timing.h b/include/video/display_timing.h
index 28d9d0d566ca..3d289e990aca 100644
--- a/include/video/display_timing.h
+++ b/include/video/display_timing.h
@@ -28,6 +28,10 @@ enum display_flags {
 	DISPLAY_FLAGS_INTERLACED	= BIT(8),
 	DISPLAY_FLAGS_DOUBLESCAN	= BIT(9),
 	DISPLAY_FLAGS_DOUBLECLK		= BIT(10),
+	/* drive sync on pos. edge */
+	DISPLAY_FLAGS_SYNC_POSEDGE	= BIT(11),
+	/* drive sync on neg. edge */
+	DISPLAY_FLAGS_SYNC_NEGEDGE	= BIT(12),
 };
 
 /*
-- 
2.10.0

