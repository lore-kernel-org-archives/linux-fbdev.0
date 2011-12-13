From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:45 +0000
Subject: [PATCH 50/57] fbdev: sh_mobile_meram: Remove unused sh_mobile_meram_icb_cfg fields
Message-Id: <1323784972-24205-51-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The marker_icb and cache_icb fields are not used anymore, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/video/sh_mobile_meram.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/video/sh_mobile_meram.h b/include/video/sh_mobile_meram.h
index ea96b5a..8ff98eb 100644
--- a/include/video/sh_mobile_meram.h
+++ b/include/video/sh_mobile_meram.h
@@ -26,8 +26,6 @@ struct sh_mobile_meram_info {
 
 /* icb config */
 struct sh_mobile_meram_icb_cfg {
-	unsigned int marker_icb;	/* ICB # for Marker ICB */
-	unsigned int cache_icb;		/* ICB # for Cache ICB */
 	unsigned int meram_size;	/* MERAM Buffer Size to use */
 };
 
-- 
1.7.3.4

