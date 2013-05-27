From: Lucas Stach <l.stach@pengutronix.de>
Date: Mon, 27 May 2013 12:33:33 +0000
Subject: [PATCH 1/3] video: display_timing: add doubleclk flag
Message-Id: <1369658015-11743-1-git-send-email-l.stach@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, kernel@pengutronix.de, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 include/video/display_timing.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/video/display_timing.h b/include/video/display_timing.h
index 5d0259b..28d9d0d 100644
--- a/include/video/display_timing.h
+++ b/include/video/display_timing.h
@@ -27,6 +27,7 @@ enum display_flags {
 	DISPLAY_FLAGS_PIXDATA_NEGEDGE	= BIT(7),
 	DISPLAY_FLAGS_INTERLACED	= BIT(8),
 	DISPLAY_FLAGS_DOUBLESCAN	= BIT(9),
+	DISPLAY_FLAGS_DOUBLECLK		= BIT(10),
 };
 
 /*
-- 
1.7.10.4

